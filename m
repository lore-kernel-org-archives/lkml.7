Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A4AC3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE402171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565976653;
	bh=w4zayQbudQGRG3Pn2pTvc40NebkNZTkjsZKFGSESKl8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=WVwLhDoiBaFJaB/qHK6l7NKzGxQO+fAbMVFfHv2p8kBuhLmNeEdjsf7BJjw9odq3w
	 7xjVqGtolhDJqcbgjH/5dU0aGkQBCKeuuVehetf5mrez9DIUXwHYG6StOLwVRUImxu
	 bdESlq83urUDXlgMIIbiZOePLjSvy2hF14jjr4Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfHPRaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfHPRav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:30:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D03C2086C;
        Fri, 16 Aug 2019 17:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565976650;
        bh=w4zayQbudQGRG3Pn2pTvc40NebkNZTkjsZKFGSESKl8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PuZbq6mNZlFjsKq9UdZ34gRKiZzR+vq1+CEGdZFnkIqYPv8qjqTL3WJ8vcE8Ldg7v
         wTRDveUPyUkObUtoO8i5rgLxw7yH3a8kPnCRiC1ys7xfesprL9mvx13K9LzMMWMwNv
         vjR8yKqEbgqqoaNN+KLdK1j3sea3dC5P/e83vfrI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815223155.21384-1-martin.blumenstingl@googlemail.com>
References: <20190815223155.21384-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH RFC v1] clk: Fix potential NULL dereference in clk_fetch_parent_index()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:30:49 -0700
Message-Id: <20190816173050.9D03C2086C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2019-08-15 15:31:55)
> Don't compare the parent clock name with a NULL name in the
> clk_parent_map. This prevents a kernel crash when passing NULL
> core->parents[i].name to strcmp().
>=20
> An example which triggered this is a mux clock with four parents when
> each of them is referenced in the clock driver using
> clk_parent_data.fw_name and then calling clk_set_parent(clk, 3rd_parent)
> on this mux.
> In this case the first parent is also the HW default so
> core->parents[i].hw is populated when the clock is registered. Calling
> clk_set_parent(clk, 3rd_parent) will then go through all parents and
> skip the first parent because it's hw pointer doesn't match. For the
> second parent no hw pointer is cached yet and clk_core_get(core, 1)
> returns a non-matching pointer (which is correct because we are comparing
> the second with the third parent). Comparing the result of
> clk_core_get(core, 2) with the requested parent gives a match. However
> we don't reach this point because right after the clk_core_get(core, 1)
> mismatch the old code tried to !strcmp(parent->name, NULL) (where the
> second argument is actually core->parents[i].name, but that was never
> populated by the clock driver).
>=20
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Applied to clk-fixes

