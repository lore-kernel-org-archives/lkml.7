Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C857BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9890D20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568741066;
	bh=0Art3gK5c5hrrmdkefySZA9KIDlpcFErLejaCZZ3HNQ=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=GGA+gyzK39XpDbHpL0JLoLwqeqlZqvSQEww5seiFKgqRkRJXYb40SRT/w2Qu6o9pL
	 1CGEU0OLD/GzumZlPb9ThTVh+hSNCriGkVPdf9XdVJw4hYGJ718Gvi5oNsboPchHuX
	 F6qdygN6/KbyG5NfW1QMBzbv7xPZjXce8vG/VghY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfIQRY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731017AbfIQRYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:24:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF5C214AF;
        Tue, 17 Sep 2019 17:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568741064;
        bh=0Art3gK5c5hrrmdkefySZA9KIDlpcFErLejaCZZ3HNQ=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=em7sPNUKhN2YtBZAccWyaW84ugOmDBd44dgaqa3DPFMDDswhXf+jkie+X+DUwGeHn
         7uZ7J4xpEJ8tMQWLoJhR2hyFJTo25beYciFNAzBcAKaJIRp9OXjmbEPARlQZ+ifCq7
         9x/PaCVHDg5vmJcRQBsdrUESWoT4FbbUhnnX8wRg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190828181959.204401-1-sboyd@kernel.org>
References: <20190828181959.204401-1-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] clk: Evict unregistered clks from parent caches
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 10:24:23 -0700
Message-Id: <20190917172424.AAF5C214AF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-28 11:19:59)
> We leave a dangling pointer in each clk_core::parents array that has an
> unregistered clk as a potential parent when that clk_core pointer is
> freed by clk{_hw}_unregister(). It is impossible for the true parent of
> a clk to be set with clk_set_parent() once the dangling pointer is left
> in the cache because we compare parent pointers in
> clk_fetch_parent_index() instead of checking for a matching clk name or
> clk_hw pointer.
>=20
> Before commit ede77858473a ("clk: Remove global clk traversal on fetch
> parent index"), we would check clk_hw pointers, which has a higher
> chance of being the same between registration and unregistration, but it
> can still be allocated and freed by the clk provider. In fact, this has
> been a long standing problem since commit da0f0b2c3ad2 ("clk: Correct
> lookup logic in clk_fetch_parent_index()") where we stopped trying to
> compare clk names and skipped over entries in the cache that weren't
> NULL.
>=20
> There are good (performance) reasons to not do the global tree lookup in
> cases where the cache holds dangling pointers to parents that have been
> unregistered. Let's take the performance hit on the uncommon
> registration path instead. Loop through all the clk_core::parents arrays
> when a clk is unregistered and set the entry to NULL when the parent
> cache entry and clk being unregistered are the same pointer. This will
> fix this problem and avoid the overhead for the "normal" case.
>=20
> Based on a patch by Bjorn Andersson.
>=20
> Fixes: da0f0b2c3ad2 ("clk: Correct lookup logic in clk_fetch_parent_index=
()")
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

