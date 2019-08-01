Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBDEC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9B62087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfHAPrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:47:08 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:38816 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730219AbfHAPrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:47:06 -0400
Received: from dslb-094-223-182-030.094.223.pools.vodafone-ip.de ([94.223.182.30] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1htDIE-0008SJ-Ee; Thu, 01 Aug 2019 17:47:02 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/8] ARM: dts: eukrea-mbimxsd27: native-mode is part of display-timings
Date:   Thu,  1 Aug 2019 17:46:23 +0200
Message-Id: <20190801154628.1624-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190801154628.1624-1-martin@kaiser.cx>
References: <20190801154628.1624-1-martin@kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the native-mode property inside the display-timings node.

According to
Documentation/devicetree/bindings/display/panel/display-timing.txt.
native-mode is a property of the display-timings node.

If it's located outside of display-timings, the native-mode setting is
ignored and the first display timing is used (which is a problem only if
someone adds another display timing).

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
index 84fc8df4be7c..9c3ec82ec7e5 100644
--- a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
+++ b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
@@ -11,11 +11,11 @@
 
 	display0: CMO-QVGA {
 		model = "CMO-QVGA";
-		native-mode = <&timing0>;
 		bits-per-pixel = <16>;
 		fsl,pcr = <0xfad08b80>;
 
 		display-timings {
+			native-mode = <&timing0>;
 			timing0: 320x240 {
 				clock-frequency = <6500000>;
 				hactive = <320>;
-- 
2.11.0

