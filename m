Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FEACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E141B20640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfJUOg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:36:57 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:30511 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729084AbfJUOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:36:54 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Oct 2019 20:00:46 +0530
IronPort-SDR: Ri63J7Aw6uMGMaKnhSMcHacbpjjmbEpNbp0lA+lRpSBZWZ+fEZRN+FwrTUBPe5zbbvdVs6pezi
 Bol0g/ndn7RC3f5YJj9VOayAvWmO02jMVft7VRJi4i97g9eN98k3DYNhXvPYBOQNqy1T2+HfeN
 m6J+5J2ZwWEeAKy/Ndfc5ZVSHRXL2OvDPBi16Y/2eNOeih5HSQ76aixS/BKaQA+m8a/lQg2n1A
 PHl/QA2x8v+pThueahwQTiyressiIZxkmPy5kWba/9cW+P6bVrNxQu8HU5CadjbUVblkUIgIQ+
 fhDmDQWWem2W8teNFvrXGSzX
Received: from rampraka-linux.qualcomm.com ([10.206.25.221])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Oct 2019 20:00:45 +0530
Received: by rampraka-linux.qualcomm.com (Postfix, from userid 2305851)
        id 84EA9329D; Mon, 21 Oct 2019 20:00:44 +0530 (IST)
From:   Ram Prakash Gupta <rampraka@codeaurora.org>
To:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, rampraka@codeaurora.org,
        vbadigan@codeaurora.org, cang@codeaurora.org, ppvk@codeaurora.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC 6/6] dt-bindings: mmc: sdhci-msm: Add clk scaling dt parameters
Date:   Mon, 21 Oct 2019 19:59:37 +0530
Message-Id: <1571668177-3766-7-git-send-email-rampraka@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding clk scaling dt parameters.

Signed-off-by: Ram Prakash Gupta <rampraka@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index da4edb1..afaf88d 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -39,6 +39,21 @@ Required properties:
 	"cal"	- reference clock for RCLK delay calibration (optional)
 	"sleep"	- sleep clock for RCLK delay calibration (optional)
 
+Optional properties:
+- devfreq,freq-table - specifies supported frequencies for clock scaling.
+	Clock scaling logic shall toggle between these frequencies based
+	on card load. In case the defined frequencies are over or below
+	the supported card frequencies, they will be overridden
+	during card init. In case this entry is not supplied,
+	the driver will construct one based on the card
+	supported max and min frequencies.
+	The frequencies must be ordered from lowest to highest.
+
+- scaling-lower-bus-speed-mode - Few hosts can support DDR52 mode at the
+	same lower system voltage corner as high-speed mode. In such
+	cases, it is always better to put it in DDR  mode which will
+	improve the performance without any power impact.
+
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -56,6 +71,10 @@ Example:
 
 		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
 		clock-names = "core", "iface";
+
+		devfreq,freq-table = <50000000 200000000>;
+		scaling-lower-bus-speed-mode = "DDR52"
+
 	};
 
 	sdhc_2: sdhci@f98a4900 {
-- 
1.9.1

