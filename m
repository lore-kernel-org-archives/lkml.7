Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D165EC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7CC2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDIShM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:37:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:40624 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDIShM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:37:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 11:37:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,330,1549958400"; 
   d="scan'208";a="141403355"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga007.fm.intel.com with ESMTP; 09 Apr 2019 11:37:11 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 2/6] dt-bindings, firmware: add Intel Stratix10 remote system update binding
Date:   Tue,  9 Apr 2019 13:45:58 -0500
Message-Id: <1554835562-25056-3-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554835562-25056-1-git-send-email-richard.gong@linux.intel.com>
References: <1554835562-25056-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add a device tree binding for the Intel Stratix10 remote system
update (RSU) driver

Signed-off-by: Richard Gong <richard.gong@intel.com>
Reviewed-by: Alan Tull <atull@kernel.org>
---
 .../bindings/firmware/intel,stratix10-rsu.txt      | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-rsu.txt

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-rsu.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-rsu.txt
new file mode 100644
index 0000000..b6250eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-rsu.txt
@@ -0,0 +1,31 @@
+Intel Remote System Update Driver for Stratix10 SoC
+============================================
+The Intel Remote System Update (RSU) driver exposes interfaces
+accessed through the Intel Service Layer to user space via sysfs
+interface. The RSU interfaces report and control some of the optional
+RSU features on Intel Stratix 10 SoC.
+
+The RSU feature provides a way for customers to update the boot
+configuration of a Intel Stratix 10 SoC device with significantly reduced
+risk of corrupting the bitstream storage and bricking the system.
+
+Required properties:
+-------------------
+The rsu node has the following mandatory properties, must be located under
+the firmware/svc node.
+
+- compatible: "intel,stratix10-rsu"
+
+Example:
+-------
+	firmware {
+		svc {
+			compatible = "intel,stratix10-svc";
+			method = "smc";
+			memory-region = <&service_reserved>;
+
+			rsu: rsu {
+				compatible = "intel,stratix10-rsu";
+			};
+		};
+	};
-- 
2.7.4

