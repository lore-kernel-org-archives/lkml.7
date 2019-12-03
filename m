Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB48C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457A206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="m5T5qZmf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v5t+Q25A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLCMDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:03:17 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38173 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbfLCMDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:03:16 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C9A1223CA;
        Tue,  3 Dec 2019 07:03:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=DGJozeGcc7zi+
        9ieiObmxaR/yTCxk8WMksJfUp/Tyao=; b=m5T5qZmfLcPA0mavShTGN0DsbMADV
        MPJbsV/FVhQsmfG0HvjEs7vAwwpg6xRn/pgzQkEBy/1XUNqWo4lSTxPYqSLKw4dY
        ob4ua0CA1X2eWO567mK6xf9z5GOaqtXTpkZcR9nfRn8MyLugUtQIlNqyg/XOctXH
        pDf5ZQcKO/8pJWy8Aa7X6IMWCMcRRbQoV+KQuqrg951fMK/BRHFIwOPMbwsZMfj8
        8rDLMSD1T8nIREaSKkX8jrlXuaBwbbIayYpPpfCogxyx0rm88EnyfUgpOKzLj6UC
        RQyLDp6hV66C3aNGWew6anGsqf8sBBIMRKuKGCOJLwsIYllG7aoLGrK/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=DGJozeGcc7zi+9ieiObmxaR/yTCxk8WMksJfUp/Tyao=; b=v5t+Q25A
        M4DXfcf2F/XlOfz+IKVfiFQBH0kmYv3O5LTOeTDcHftTxN2jWAAsTeP3Ejj0ebPV
        C2IOE6wb4x0v0HZ6TEp+wc5AJYbGlx15VJkxKx6mkiCCzH9V5q1PArW8gFK5Mave
        ZFbGhyfW1ryV9ESRyzg/QLalncPMOysVOuvPSHJaVS7jugJldtDRoYG+binIce3b
        gySqtZSmnH765M0DLOtAZJ2soe1dAmmsQrRIffutf9WY0O5ePGm6rnRPcwZaa3hY
        Z074z5x2zfnZVq0h3RGUNKJ+BEUO25sFIEIdeGxk92uKENEVkdkP4SbFHe62+THO
        bNfw9PUdNToxjg==
X-ME-Sender: <xms:Ak_mXSpVM-lfLMA6g6QGvc-BQciflK2U4AwPZAycyjgmcGMoOW8FWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecukfhppeduudekrddvuddurdelvddrudefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
    vgepie
X-ME-Proxy: <xmx:A0_mXcXOuWRxD53R8sTvfxDgJxS0u3NJVBbzl5Ym5rauxA8n29cNwQ>
    <xmx:A0_mXR5hxuJA3lilqepPY_PSAhND2eCd512955ipnpszP0JuGdutZQ>
    <xmx:A0_mXS2ViiOG2IgsS-he5FV_Cvzh_DhQ7Ajv51_3dFy9gpIkl-APRA>
    <xmx:A0_mXR5xRlUOIg3dgd_hBf289XiZzFxbbTLnCDMSnu4WFVJ0XS-3Uw>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id CE7C430600D2;
        Tue,  3 Dec 2019 07:03:11 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Adriana Kobylak <anoo@us.ibm.com>
Subject: [PATCH 08/14] ARM: dts: swift: Cleanup gpio-keys-polled properties
Date:   Tue,  3 Dec 2019 22:34:09 +1030
Message-Id: <78ea3e17108c7c8fded921f5673777fc415cd66e.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtbs_check gave the following warning:

    Warning (avoid_unnecessary_addr_size): /gpio-keys-polled: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Cc: Adriana Kobylak <anoo@us.ibm.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
index 0831bc1f5a4c..555d79405884 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
@@ -82,8 +82,6 @@
 
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <1000>;
 
 		scm0-presence {
-- 
git-series 0.9.1
