Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695F7C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 15:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FB82064A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 15:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="RUn0wUIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfGMPs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 11:48:58 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:41512 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfGMPs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 11:48:58 -0400
Received: from localhost.localdomain (80-123-55-184.adsl.highway.telekom.at [80.123.55.184])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9D810C01AE;
        Sat, 13 Jul 2019 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1563032936; bh=VSHu3v+OVsPMLdoN+xclQVva8pOG9Vg0Z9Vj3ic1jvk=;
        h=From:To:Cc:Subject:Date;
        b=RUn0wUIkGpgGgNHmytAugA2b4rdAo5iLAuYearxVpAmfLIegWbBwWGG3EYsOXhvj5
         zq4yCzWYLaA1h7cOM7/ea46QvGBINFfdwiAtNMLvasC28Zx12to6gZp/FilnC8dUIK
         TVXkUGbZGlP3veCfyB8cc7onirFvr12OkR/gs9hA=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~martijnbraam/pmos-upstream@lists.sr.ht,
        Luca Weiss <luca@z3ntu.xyz>,
        Brian Masney <masneyb@onstation.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: msm8974-FP2: add reboot-mode node
Date:   Sat, 13 Jul 2019 17:48:06 +0200
Message-Id: <20190713154805.17159-1-luca@z3ntu.xyz>
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

Reviewed-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes v1 -> v2:
- Move the majority of the node into the board dts, just keep the magic
  values in the device-specific dts.

 arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts | 10 ++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi              | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
index 643c57f84818..ff4a3e0aa746 100644
--- a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
@@ -338,6 +338,16 @@
 			};
 		};
 	};
+
+	imem@fe805000 {
+		status = "okay";
+
+		reboot-mode {
+			mode-normal	= <0x77665501>;
+			mode-bootloader	= <0x77665500>;
+			mode-recovery	= <0x77665502>;
+		};
+	};
 };
 
 &spmi_bus {
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 45b5c8ef0374..1927430bded7 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1085,6 +1085,17 @@
 				};
 			};
 		};
+
+		imem@fe805000 {
+			status = "disabled";
+			compatible = "syscon", "simple-mfd";
+			reg = <0xfe805000 0x1000>;
+
+			reboot-mode {
+				compatible = "syscon-reboot-mode";
+				offset = <0x65c>;
+			};
+		};
 	};
 
 	smd {
-- 
2.22.0

