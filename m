Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF44C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20943206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="hP+2x3Rw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FGozJWtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfL2C73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 21:59:29 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36429 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbfL2C71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 21:59:27 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 87E91537;
        Sat, 28 Dec 2019 21:59:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 28 Dec 2019 21:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=FlxbmteQj2WfnOCq43+POyjgaR
        NNd4vGvnrLYbVa018=; b=hP+2x3RwHA3UR0joBco7hsH26HJmyEJjWlsrO+4jbn
        73sPMUwMW7N27SwXqYlUT7YjbWmyLyghXRwZeTNkaGZOqc1eiEJSxdX5scMblEay
        lPj0wf09y79VAwkO7Non2mY2yTMnvsCbFgL+OH5nnmKfhVCkFNPOAVAgXOzUbmRG
        J/bbkGhQUDaw65YxxuSZFOUkiX+J43Jl7wWgQCRppJAQnE36qAPmchd79Ae/9jcQ
        CpQ0/9+NJ6MhcDN9IzuINTq3pduFZlzYnXhA0SRxWN4/NnMPtmtqxbFLwtnZHzGE
        C/cx+JrUbCJ+akp4eypRAlZJGkzxpEDC/JGaaY60Uj9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FlxbmteQj2WfnOCq4
        3+POyjgaRNNd4vGvnrLYbVa018=; b=FGozJWtQof7jiY8CiORe8lHSAX4MqcFsB
        yXh4D1JovsDfDSYUwVSfi+EK2bC1rXPABSe6OWtvaBzkiHZJVi9aepajnn7WhRBL
        rIOvyp9S2CH2K8ttx4SSQQ1e3Ge93EbimH7CtSw0Gc5xQ3RweaVWfQjRMt1d/V+7
        LFxbAjz54X1by8HJda6zUL4ci5F6ni/X9UuBTo5Oz4AcZnH0bUOWJVJEQnRqRgYi
        GN18Z3j7mK8CsKu5YFOiD0wVVqPOytHioefz3ZLuoylt85Zmpxmq3V2TgWCvYiVG
        oSRh+Byd19Mtccg+lLUBVYThhhpLf1cT/PZiYmQdhPFOCPcd4qrIA==
X-ME-Sender: <xms:ixYIXljUarw-Gh-lyibCkYHK5EKjk9vYGa2R-0SO4kpC1He6I0QRnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdefuddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucffohhmrg
    hinhepghhithhhuhgsrdgtohhmnecukfhppeejtddrudefhedrudegkedrudehudenucfr
    rghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrghenuc
    evlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ixYIXr7hUahlrmd6LV4tZ66SzIHFT4r--_GGVqgqR06B3VCk_gRuQQ>
    <xmx:ixYIXpsOliV2fm9ITGyqHjIpd2PJ2Iahm7QK9I4no4RQsowzSaVd1A>
    <xmx:ixYIXozCUEblDR0G-Ysnq6vah39iSvK5cWQZXwi5So_hQycbFTzNiQ>
    <xmx:jRYIXleAogyinq1v7lZxBcr2Wrj5dGTYic4K7xrtHW5k58HAtChB9Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 75C793060938;
        Sat, 28 Dec 2019 21:59:23 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/3] A64/H3/H6 R_CCU clock fixes
Date:   Sat, 28 Dec 2019 20:59:19 -0600
Message-Id: <20191229025922.46899-1-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was examining the H6 BSP clock driver[1] for guidance when porting an
AR100 firmware[2] to the H6 SoC. I found some inconsistencies between
that code and the sunxi-ng driver.

I don't have a good way to verify the first patch. Someone with an
oscilloscope could set the divider and check the I2C/RSB frequency.

Patch 2 should have no functional change.

Patch 3 was verified by benchmarking. Details are in the commit message.

[1]: https://github.com/Allwinner-Homlet/H6-BSP4.9-linux
[2]: https://github.com/crust-firmware/crust

Samuel Holland (3):
  clk: sunxi-ng: sun8i-r: Fix divider on APB0 clock
  clk: sunxi-ng: h6-r: Simplify R_APB1 clock definition
  clk: sunxi-ng: h6-r: Fix AR100/R_APB2 parent order

 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 16 +++-------------
 drivers/clk/sunxi-ng/ccu-sun8i-r.c     | 21 +++------------------
 2 files changed, 6 insertions(+), 31 deletions(-)

-- 
2.23.0

