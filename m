Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13A3C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD02206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfG2OXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:23:50 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:39858 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfG2OXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:23:50 -0400
Received: from [46.114.3.104] (helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1hs6Yw-0005cy-4j; Mon, 29 Jul 2019 16:23:42 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] ARM: dts: imx25-pdk: native-mode is part of display-timings
Date:   Mon, 29 Jul 2019 16:23:16 +0200
Message-Id: <20190729142316.21900-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.11.0
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

Dear all,

I found this issue on a similar board when I tried to define two
variants that use different displays. I had two display timings and
ended up using the wrong one because native-mode was ignored outside of
display-timings.

Thanks for reviewing the patch,

   Martin

 arch/arm/boot/dts/imx25-pdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index f8544a9e4633..05cccd12624c 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -76,8 +76,8 @@
 		bits-per-pixel = <16>;
 		fsl,pcr = <0xfa208b80>;
 		bus-width = <18>;
-		native-mode = <&wvga_timings>;
 		display-timings {
+			native-mode = <&wvga_timings>;
 			wvga_timings: 640x480 {
 				hactive = <640>;
 				vactive = <480>;
-- 
2.11.0

