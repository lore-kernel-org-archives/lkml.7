Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F972C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F4320830
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=koncepto.io header.i=@koncepto.io header.b="Bm1kPOXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfCBWmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 17:42:09 -0500
Received: from koncepto.io ([195.154.119.111]:44462 "EHLO koncepto.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbfCBWmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 17:42:09 -0500
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Mar 2019 17:42:07 EST
Received: from localhost.localdomain (lfbn-bor-1-173-101.w90-50.abo.wanadoo.fr [90.50.253.101])
        by koncepto.io (Postfix) with ESMTPSA id 0A0106004C;
        Sat,  2 Mar 2019 23:32:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=koncepto.io;
        s=default; t=1551565959;
        bh=CmZCHG/PxSnvM+2CrYgEdcN5326R03pij0J9RgI4RJY=;
        h=From:To:Cc:Subject:Date:From;
        b=Bm1kPOXROGXwOLFZpfctU/C6qEZD193WtPHBfcuA9IrOwNkt2IrUXoPYK0VBFsjcH
         4ksEYZyk7Ne1OqksHc3y+F9djPXH5CvB0GNU3+VCuCuxE0uTHzErYshcSuCLc37+b/
         SOTw5KArmZyEmKjp6H4twt9cCSc3Sk0uZTZlgh2aw1eJXejmI+45eP6GWaUbdFDJAa
         Cl81Ej5F3UNtJ0Ok4L5dTlbmTtSdwaHhPYEWR0MO+mEovsqWxS45ipr9kndehZQg/W
         1EnVEVt39zEnBWBVQ/w7sIQoJeP7PvYCRHRO9HA2n/6qXF7S7+81T6E1SDz19T7wIZ
         C6JOTnHP60BOw==
From:   Pierre-Jean Texier <pjtexier@koncepto.io>
Cc:     Pierre-Jean Texier <pjtexier@koncepto.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx7s-warp: PMIC swbst boot-on/always-on
Date:   Sat,  2 Mar 2019 23:32:29 +0100
Message-Id: <1551565949-13843-1-git-send-email-pjtexier@koncepto.io>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMIC swbst regulator is used for the MikroBUS socket (pin +5V).

We have to set the regulator to "boot-on" and "always-on"
to output a voltage of 5V on this socket.

Signed-off-by: Pierre-Jean Texier <pjtexier@koncepto.io>
---
 arch/arm/boot/dts/imx7s-warp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 23431fa..b1e9562 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -121,6 +121,8 @@
 			swbst_reg: swbst {
 				regulator-min-microvolt = <5000000>;
 				regulator-max-microvolt = <5150000>;
+				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			snvs_reg: vsnvs {
-- 
2.7.4

