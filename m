Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53037C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CB6217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555619660;
	bh=HiYMyuF2OM3FgJZMk6YRr/+ImxvjK6FMr6wB2n4Iu/c=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=GVlPhwRfChUROJ7nuBUjPgf6BeTW/BdxVvRXMV/sualrvTeFYqmELGkC4PlisNkHn
	 4jV8x1aRwtPZzh5vRmpHTAwhX0fhmvY7W4FxnXeLGuzYg2EDQnfx+gPLoXWz/vi9Ot
	 hB+pDbQso4kkQc4p6pxUDdcaFpmDq8sU3Srtf+6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390157AbfDRUeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbfDRUeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:34:18 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE31214C6;
        Thu, 18 Apr 2019 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555619657;
        bh=HiYMyuF2OM3FgJZMk6YRr/+ImxvjK6FMr6wB2n4Iu/c=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=gvDJbleQxIoLO/m0JRqSMLq3CtLv1BTfn2HkM76du0H2y3zD5ZtXFCJZ6fI6oRnbD
         fDAlZXgPfVMkwqnFHi31cKJM4cVSu2n1hQqnLo4wR3D7v/vcr+1tn2XlBn66Q9d9ip
         FlqCoQ77ypE+Me0uk2Hu8e35WJcyoSS29bipvgCs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190412183150.102131-2-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org> <20190412183150.102131-2-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/9] clkdev: Hold clocks_mutex while iterating clocks list
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Message-ID: <155561965658.15276.12512792107221989677@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 18 Apr 2019 13:34:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-04-12 11:31:42)
> We recently introduced a change to support devm clk lookups. That change
> introduced a code-path that used clk_find() without holding the
> 'clocks_mutex'. Unfortunately, clk_find() iterates over the 'clocks'
> list and so we need to prevent the list from being modified at the same
> time. Do this by holding the mutex and checking to make sure it's held
> while iterating the list.
>=20
> Note, we don't really care if the lookup is freed after we find it with
> clk_find() because we're just doing a pointer comparison, but if we did
> care we would need to keep holding the mutex while we dereference the
> clk_lookup pointer.
>=20
> Fixes: 3eee6c7d119c ("clkdev: add managed clkdev lookup registration")
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-fixes

