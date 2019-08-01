Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A04CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE04C20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfHAPrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:47:11 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:38880 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730963AbfHAPrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:47:08 -0400
Received: from dslb-094-223-182-030.094.223.pools.vodafone-ip.de ([94.223.182.30] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1htDIF-0008SJ-TO; Thu, 01 Aug 2019 17:47:04 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/8] ARM: dts: mbimxsd25: native-mode is part of display-timings
Date:   Thu,  1 Aug 2019 17:46:24 +0200
Message-Id: <20190801154628.1624-5-martin@kaiser.cx>
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
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index dbecd6d2cfc4..7d4301b22b90 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -14,8 +14,8 @@
 		bits-per-pixel = <16>;
 		fsl,pcr = <0xcad08b80>;
 		bus-width = <18>;
-		native-mode = <&qvga_timings>;
 		display-timings {
+			native-mode = <&qvga_timings>;
 			qvga_timings: 320x240 {
 				clock-frequency = <6500000>;
 				hactive = <320>;
-- 
2.11.0

