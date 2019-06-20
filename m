Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDABC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73C12070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="NXwWPSsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFTW7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 18:59:38 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:42164 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfFTW7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 18:59:38 -0400
Received: from localhost.localdomain (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 66645C2A9C;
        Thu, 20 Jun 2019 22:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1561071575; bh=FTGmDnKKypvtndUTsH4/yLMEt9oBVapsz5XGfmtXkW8=;
        h=From:To:Cc:Subject:Date;
        b=NXwWPSsFM6BHazsoRnGmTpS4FSl0Jj8sJIkZRKLbACrzEZxIOj8rEywV6txjwcpWt
         OpZ66lqWMS65jcJZgjHGN1rDHvWrzPMqcleTxLfhjtUMSYL21QTPv63wRxuurvZSIT
         j/Fap4/+l/w/BCLgTRfxs2z95cnbYkC+ffC7FoPI=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~martijnbraam/pmos-upstream@lists.sr.ht,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: msm8974-FP2: add reboot-mode node
Date:   Fri, 21 Jun 2019 00:58:24 +0200
Message-Id: <20190620225824.2845-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables userspace to signal the bootloader to go into the
bootloader or recovery mode.

The magic values can be found in both the downstream kernel and the LK
kernel (bootloader).

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Sidenote: Why are there no userspace tools to be found that support
this? Anyways, we have one now in postmarketOS :)

 arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
index 643c57f84818..f86736a6d77e 100644
--- a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
@@ -338,6 +338,20 @@
 			};
 		};
 	};
+
+	imem@fe805000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0xfe805000 0x1000>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x65c>;
+
+			mode-normal	= <0x77665501>;
+			mode-bootloader	= <0x77665500>;
+			mode-recovery	= <0x77665502>;
+		};
+	};
 };
 
 &spmi_bus {
-- 
2.22.0

