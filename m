Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84052C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5962521721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="I0yVlab7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EyrNzdzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfJHEvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 00:51:44 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:33517 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729786AbfJHEvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 00:51:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 996865B6F;
        Tue,  8 Oct 2019 00:41:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 08 Oct 2019 00:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=3eKFGQjeBCJWh
        5YpK75JaEOME4RWXnAljsCABlFoAJo=; b=I0yVlab7s8e4kTQMsNb5XGINFKICJ
        WeI0yn7+XVEawx3vq/OcER2JAgdDu0Y2wx/sWnjCF/ubuLsYQqTCRMmWwMrApytB
        AuP9156QQTsrYwU8Zulpp2vTYozsZJ8cKBL8PbeOQM6dNPrqcFhavgB8VHxJrjwO
        IrOMyoh2BQ8dgZCGMGb+nNbEe3cKHzz5EQE/8DtHO3+STZyVHRGLr+p105NlzngW
        9T9tafeXwOThgIbCtFr7l+RwvEyhrt9267m1G03mdaeRbpQMopjDHmxMNWXW+/aE
        xXqOI4U3I1KwGFqPnyg9mW/NwlPU2qxHJ00bQeysPbWAoKzjhiWd5CcIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=3eKFGQjeBCJWh5YpK75JaEOME4RWXnAljsCABlFoAJo=; b=EyrNzdzY
        TekI7KTRWA4vmeNx4YrMtoMjY9990YI26RxKZb88h04TKOblzOwJXWTOGhMtALVc
        LFmJvbN5qGEpedDTwMSlRLBl3tF22qVnmDKGtV8Oo+xpCRfZGpUMVlEAFnUCijG7
        2E9cDZxna8MzGOmtbqzqNnea2iVadRAQ7SP6ZoNzgkh7Y0r9gRauWzazD+4szj5Z
        71UGbdH7F5XrEHKnhfabtp2iXrPGcSvFrNmSoMEOjiDYD+hKJSEwH0SQ81WOODwa
        YTZ83T5L/V2SS6lD8L+/XWZtJr0QsCY+qhNaYLgZ4fK7s/48xDmgPlfoJRBTKMaj
        gSz6VIcDn9ho4A==
X-ME-Sender: <xms:hxOcXd8cMI7LMNA3NJXmVqRA_2Oj5NRUOW3nLkSZPawqdIZOa7xBgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheekgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgif
    ucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtddvrd
    ekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpeeh
X-ME-Proxy: <xmx:hxOcXWYe4QxphufRtURJ5hh_wSZxH0UVAhZoyWu1HOv85lumsfLqYg>
    <xmx:hxOcXX2xIQMrpRFuiCVqjS8Xda5M7dNkXS1RUgm_dEbXQ-OjH1cMXg>
    <xmx:hxOcXeVThd0QOALoPvcz6zt2JaSqgb-MhySZMaeVt5lGguz2Iz-RRw>
    <xmx:hxOcXVL-gF83_Ms8VuYh8ZUMZ6BjP6rsMj4EMziHv8YmoMiqB8QwHQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id E960A80061;
        Tue,  8 Oct 2019 00:41:39 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-gpio@vger.kernel.org
Cc:     Johnny Huang <johnny_huang@aspeedtech.com>,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ryanchen.aspeed@gmail.com
Subject: [PATCH 6/7] pinctrl: aspeed-g6: Fix UART13 group pinmux
Date:   Tue,  8 Oct 2019 15:11:52 +1030
Message-Id: <20191008044153.12734-7-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008044153.12734-1-andrew@aj.id.au>
References: <20191008044153.12734-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johnny Huang <johnny_huang@aspeedtech.com>

When UART13G1 is set the pinmux configuration in SCU4B8 for UART13G0
should be cleared.

Fixes: 58dc52ad00a0 ("pinctrl: aspeed: Add AST2600 pinmux support")
Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
[AJ: Tweak commit message]
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 68b066594461..dc17cf3d3549 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -1262,13 +1262,13 @@ GROUP_DECL(SPI1, AB11, AC11, AA11);
 #define AD11 206
 SIG_EXPR_LIST_DECL_SEMG(AD11, SPI1DQ2, QSPI1, SPI1, SIG_DESC_SET(SCU438, 14));
 SIG_EXPR_LIST_DECL_SEMG(AD11, TXD13, UART13G1, UART13,
-			SIG_DESC_SET(SCU438, 14));
+			SIG_DESC_CLEAR(SCU4B8, 2), SIG_DESC_SET(SCU4D8, 14));
 PIN_DECL_2(AD11, GPIOZ6, SPI1DQ2, TXD13);
 
 #define AF10 207
 SIG_EXPR_LIST_DECL_SEMG(AF10, SPI1DQ3, QSPI1, SPI1, SIG_DESC_SET(SCU438, 15));
 SIG_EXPR_LIST_DECL_SEMG(AF10, RXD13, UART13G1, UART13,
-			SIG_DESC_SET(SCU438, 15));
+			SIG_DESC_CLEAR(SCU4B8, 3), SIG_DESC_SET(SCU4D8, 15));
 PIN_DECL_2(AF10, GPIOZ7, SPI1DQ3, RXD13);
 
 GROUP_DECL(QSPI1, AB11, AC11, AA11, AD11, AF10);
-- 
2.20.1

