Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD7BC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAB5218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BfR6JOAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDLNoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:44:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36716 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfDLNoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:44:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so11116354wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6d+R1BA43CR6//FSBQc7Q2qw1KEWApHiN8cbRKfTm8=;
        b=BfR6JOAwcm1xXWDiBBXfqWQKW2hWPkEZ6I+Z4omSIJa93xErRX1OGhfPNHv7TwfBo3
         T1vjFqi1VCjbYYiNuhjxQds810V+O8I3KNa9vhowL48wEJL3Ql1OAfPq1iBXDa2kvTTf
         WcKCVMFdS+dQN4ZzR1r8dSDd1Hxl/fzEJ5DEpJxjSWceoPSgIJ1XacX52XgTIsidYxqk
         8hTPba/0bPjUlhJfmEwwGhVCKClyA5yXkuEk/f/TeInkGNldA01M+qX+9Ci7BSUu1Vty
         wQgip4Cv8IvI2pzVfUFv8LZk8rA0jskm5lN+vHYnKHC5UdU+WOmVeBjtioGG6Z00RgN0
         3sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6d+R1BA43CR6//FSBQc7Q2qw1KEWApHiN8cbRKfTm8=;
        b=RtahQtApVIVNygW7VGjc/Vt0d94skk+MjvCxqtoO8NjiZ9qfj3SugsvooSjxIeGeIx
         G3ddBrOO8srS3SHi2U0C80lM8fKYJwo8Td9ImB4QdR8d3gwjIAnAADTVXuHbzmU6x3KM
         SODGpGJbmXTUYMH50q4+Y1ckdg8nezh6VwZSTkC7H35IjZVidXk2mpbOzaGSMrjf99aT
         fdVQkQLbSud2dKIbIOL6qo7So9cCHnWupI7yH6+yc6stZeHeqs3J0/TVYbj3Apxl1nH9
         hlFJollD4waUjcfomqRmKvWGWctz2Fml1cTNp3Dzo1yp1XfnyuCG0L+ZnCjgorQeVRcL
         mm2g==
X-Gm-Message-State: APjAAAVLwQdslId8TjKYmI1qmf1X7xJUstyFoXVavTWyvAknVHdOYW5p
        OK56mZmAg+KtYru3FTEtvEXdqaddHVw=
X-Google-Smtp-Source: APXvYqylpz4bUEL56vKD8TxdlLW7kVe+d4sJzsrFP8/rS6lg0ggd+OIMt9oLAy66UvdyNpFNfdqHtA==
X-Received: by 2002:a1c:c254:: with SMTP id s81mr10619117wmf.55.1555076683228;
        Fri, 12 Apr 2019 06:44:43 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-35-248.w90-86.abo.wanadoo.fr. [90.86.90.248])
        by smtp.gmail.com with ESMTPSA id s18sm9964672wmc.41.2019.04.12.06.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:44:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 1/5] ARM: dts: da850: add cpu node and operating points to DT
Date:   Fri, 12 Apr 2019 15:44:33 +0200
Message-Id: <20190412134437.14864-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412134437.14864-1-brgl@bgdev.pl>
References: <20190412134437.14864-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

This adds a cpu node and operating points to the common da850.dtsi file.

All operating points above 300MHz are disabled by default.

Regulators need to be hooked up on a per-board basis.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 559659b399d0..0c9a8e78f748 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -20,6 +20,56 @@
 		reg = <0xc0000000 0x0>;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu: cpu@0 {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+			reg = <0>;
+			clocks = <&psc0 14>;
+			operating-points-v2 = <&opp_table>;
+		};
+	};
+
+	opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp_100: opp100-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1000000 950000 1050000>;
+		};
+
+		opp_200: opp110-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1100000 1050000 1160000>;
+		};
+
+		opp_300: opp120-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1200000 1140000 1320000>;
+		};
+
+		/*
+		 * Original silicon was 300MHz max, so higher frequencies
+		 * need to be enabled on a per-board basis if the chip is
+		 * capable.
+		 */
+
+		opp_375: opp120-375000000 {
+			status = "disabled";
+			opp-hz = /bits/ 64 <375000000>;
+			opp-microvolt = <1200000 1140000 1320000>;
+		};
+
+		opp_456: opp130-456000000 {
+			status = "disabled";
+			opp-hz = /bits/ 64 <456000000>;
+			opp-microvolt = <1300000 1250000 1350000>;
+		};
+	};
+
 	arm {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.21.0

