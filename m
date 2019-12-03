Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2DEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F203206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ekUTd1xt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ht/pNLsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfLCMDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:03:34 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41259 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfLCMDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:03:33 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 453B4223CA;
        Tue,  3 Dec 2019 07:03:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=GwW2ZPokeQOuM
        x+qEgChoiysoCIuDajacTWg+pdJvas=; b=ekUTd1xt56OIqNoNCpcmvBQxYPntc
        eE1s4rwx+v4BSTs1ToM9PxpacFP2xBnhzA/jRkjY2vCRPuDmlBzeyqZOZNlU1env
        75hSXMWoGO/KT9lvIB1M16Y9NKiC6zHZFDhsMm7LehBRSz8KJqE2U8kXKy/DK2mz
        /MpJYY/F3JL9kg7mmYLhiwjHdjWGek5RlDDhPfMmHsUi3AvgWDUWUPvVPewiGpQs
        sFBWPTTwgjKLXVzibeh/K1DBMbQyJCr5ThKlq3ILi/J48+Q0i8F0n49tTncmloT4
        jGyxZfzzJkug0tL0p6/ApzzxunN0HuLJnTdRmGWOgj0b27dqXArgKkoiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=GwW2ZPokeQOuMx+qEgChoiysoCIuDajacTWg+pdJvas=; b=ht/pNLsZ
        k/5XPCDc1YA+RXLQyl1IuaWQy5XmJL5jp4BO9qqbb/xzntE/5ceJ3+eIv8SFVNL6
        9E4Xq5hVQo7BlKEfLjoTu/gCSPavVfhKkV5XYjXpO95DwJ6v5gl2mvrhLoXH/jnq
        kby1X7ltx8LafS+6p17L+NeesrELZ6U1jAQqHr9EG6naHjbOxKAFXUH5wdeBRhJW
        s5s6GHUErFz6RjcXTHhwRJAn/HAlvx1Nn5S0SDcPLsRpWnH7mtvAjF9Cad0RIK54
        2nr5xI2riyliU2Q+WXEUoCte3mO4kw68wnzitUKhfIjx9c49Kpsva2B7WVDO3qoR
        T4pWvvMBGRAU+A==
X-ME-Sender: <xms:FE_mXXmrpuvc96CcaaQ_m6sc53j98lW4e7qMbGPbtPCi8UIsemda2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecukfhppeduudekrddvuddurdelvddrudefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
    vgepuddu
X-ME-Proxy: <xmx:FE_mXWo3tCS9G8LOecLk-8lyx99qNAaxW_Pnt2Wo3Gjnt4me9VhIcw>
    <xmx:FE_mXU8CGsdSNA7Lth8ckQhiQ6ms9Q5jBkeTsuzMF0WZH-inKI-ctQ>
    <xmx:FE_mXS3ZhMT_WfbF1GH8ja41mlm2746EeXblfe1xCd0-3hGWphpUfw>
    <xmx:FE_mXbPxISBTIvh9cu-_o_h9ybAcVmkN2vT2KlcZ8v9Da-qE2-PEeA>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7035230600AA;
        Tue,  3 Dec 2019 07:03:29 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] ARM: dts: aspeed-g6: Cleanup watchdog unit address
Date:   Tue,  3 Dec 2019 22:34:14 +1030
Message-Id: <eaf3a37fefaa6f05ef7e4b6bb2c41be84c27316f.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/arm/boot/dts/aspeed-g6.dtsi:204.28-208.6: Warning (simple_bus_reg): /ahb/apb/watchdog@1e7850C0: simple-bus unit address format error, expected "1e7850c0"

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 5f6142d99eeb..ffe0d76c5ac0 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -385,7 +385,7 @@
 				status = "disabled";
 			};
 
-			wdt4: watchdog@1e7850C0 {
+			wdt4: watchdog@1e7850c0 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e7850C0 0x40>;
 				status = "disabled";
-- 
git-series 0.9.1
