Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FF8C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD0F2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565976540;
	bh=RZqpkIs7/ptyy0GiRGmHT1P1VJZS6AOQSoOoA422d3Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=eeT7keOaqY8z/PePwYEx3M4Muo6lsr34HseBLkqEGziUmIY1jC3k80nmE84SYLv+M
	 wW8sVd62c/jbiOBN/LUHBKVB790qlkTtko3vusvy70jAQKHo9tYNEIC1rckOqs+fu0
	 cFmJbxk2N1uToOfFZgCZE4Hb9z+3Igd81eZqMEvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfHPR27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfHPR27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:28:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8F442086C;
        Fri, 16 Aug 2019 17:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565976537;
        bh=RZqpkIs7/ptyy0GiRGmHT1P1VJZS6AOQSoOoA422d3Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YYa9oqIwha79tDSl3rBd2CR5ZHcJPtExeJ9KOt+XDN6XipKZoJv1/qupsIZHWBbkw
         RnczA81PXrKCeUvMUGkbplGxMk5ewGozYho3wsUEtcN9z/HtEJD0TRUBzWbW8GGYyV
         fbthAqN82QXLv/bVV9RdnaWClPt3ZUpIq1CKm/PY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190813214147.34394-1-sboyd@kernel.org>
References: <20190813214147.34394-1-sboyd@kernel.org>
Subject: Re: [PATCH v2] clk: Fix falling back to legacy parent string matching
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:28:56 -0700
Message-Id: <20190816172857.C8F442086C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-13 14:41:47)
> Calls to clk_core_get() will return ERR_PTR(-EINVAL) if we've started
> migrating a clk driver to use the DT based style of specifying parents
> but we haven't made any DT updates yet. This happens when we pass a
> non-NULL value as the 'name' argument of of_parse_clkspec(). That
> function returns -EINVAL in such a situation, instead of -ENOENT like we
> expected. The return value comes back up to clk_core_fill_parent_index()
> which proceeds to skip calling clk_core_lookup() because the error
> pointer isn't equal to -ENOENT, it's -EINVAL.
>=20
> Furthermore, we blindly overwrite the error pointer returned by
> clk_core_get() with NULL when there isn't a legacy .name member
> specified in the parent map. This isn't too bad right now because we
> don't really care to differentiate NULL from an error, but in the future
> we should only try to do a legacy lookup if we know we might find
> something. This way DT lookups that fail don't try to lookup based on
> strings when there isn't any string to match, hiding the error from DT
> parsing.
>=20
> Fix both these problems so that clk provider drivers can use the new
> style of parent mapping without having to also update their DT at the
> same time. This patch is based on an earlier patch from Taniya Das which
> checked for -EINVAL in addition to -ENOENT return values from
> clk_core_get().
>=20
> Fixes: 601b6e93304a ("clk: Allow parents to be specified via clkspec inde=
x")
> Cc: Taniya Das <tdas@codeaurora.org>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Reported-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-fixes

