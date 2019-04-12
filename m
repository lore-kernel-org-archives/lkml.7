Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BDC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3D32084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="igurN2Kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDLNov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:44:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37065 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfDLNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:44:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so11111333wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QOXUKZkvFQxUt7MqaN8caWLun1illfZzVTzLRf9gkvQ=;
        b=igurN2KdBs8EB+dlTzcTk+Q6/HguDgWFYJ0N0NHlBjURmw/HrQRmL0qL6LC2hJpnmo
         ACnWlMXmXgJbNgMaIgYh0sbAk8ezDT7MqWoRH1wKsAJ8riP8J8FTnFMS/K7edgHE8rPs
         qvhS4EL06avOK1JREXKbaGFDldVqszktxIvK3H0BH0890qkWWm7gw2SZveL97jXIEFHW
         J5CBKaFaSxiusnAg4fxQ59x27O8FSUtyKQhIN4dzussLGGZKq8AmdMc/TKkr7VdDyYE2
         LonejBOdF5nhkeMogT6d0+n5v5l5QebSxD4rNhWpCCKaaLxgZNFHgezyw+/A+SzD8HMo
         VJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOXUKZkvFQxUt7MqaN8caWLun1illfZzVTzLRf9gkvQ=;
        b=nZZvq81oWdFDRJgC7YuRK7S12/3qZQlINQxSR3QE5GXf8sOKdaOXhGt6WuhZ9/fHoQ
         Y6LtnJqSPqP4Zgx9CWTQ7exLhaY7RxbZOGjcnixedlKwUYeqhJUgHS6fc7jXQvjc5PAh
         qlal9WIp/O3XFGdyR87W4Ga86xZkPxr1wHJ5yRiLJcJBgR1ByYf/3l8BaOsd+3MoimHl
         5D0fO928lEgXLQ9/xVGS4UddJcdLzD9EsCy/bxdRWoek9VpDOvq75jMYk9iIMtoDc35Q
         DO3kWjWxpx2PFU7M1L7cUD5WRAwH0Ia2nezRD+/09kINvXFpLp2fpkBo/qzAscrUyonY
         DKgQ==
X-Gm-Message-State: APjAAAX9UrR+1R9qhECKagWWijSfhbVbdS+0CbqH9ZKzOZ2Jb6AYsYK/
        d/7TfL1XJ0BaUT9h4rQrPDo/gg==
X-Google-Smtp-Source: APXvYqwxBqUCYMQJgYUzHgiXZZJpStafZyPC2exix6tw5Z7XWvlxz/XiWSxaUbVi6bLEb6TVcnd2fA==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr11424574wmi.69.1555076685549;
        Fri, 12 Apr 2019 06:44:45 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-35-248.w90-86.abo.wanadoo.fr. [90.86.90.248])
        by smtp.gmail.com with ESMTPSA id s18sm9964672wmc.41.2019.04.12.06.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:44:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 3/5] ARM: dts: da850-lcdk: enable cpufreq
Date:   Fri, 12 Apr 2019 15:44:35 +0200
Message-Id: <20190412134437.14864-4-brgl@bgdev.pl>
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

Add a fixed regulator for the da850-lcdk board along with board-specific
CPU configuration.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 26f453dc8370..f29ed9010812 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -155,12 +155,43 @@
 			};
 		};
 	};
+
+	cvdd: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "cvdd";
+		regulator-min-microvolt = <1300000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &ref_clk {
 	clock-frequency = <24000000>;
 };
 
+&cpu {
+	cpu-supply = <&cvdd>;
+};
+
+/* LCDK has a fixed CVDD of 1.3V, so only op points >= 300MHz are valid */
+
+&opp_100 {
+	status = "disabled";
+};
+
+&opp_200 {
+	status = "disabled";
+};
+
+&opp_375 {
+	status = "okay";
+};
+
+&opp_456 {
+	status = "okay";
+};
+
 &pmx_core {
 	status = "okay";
 
-- 
2.21.0

