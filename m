Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB789C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00DB20821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YcSp7kuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbfDQP1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:27:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34955 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbfDQP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:27:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id o12so3075406wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkvoQ7ZQRviI68t1GQUcpGSIR6wTw9yWovYigsGIRFY=;
        b=YcSp7kuD32UTI4BBP89LMZJeykAOVqJqnmHznrmUGpItFZY5iiYkIC8LnQDQ2y/1QT
         iHLxFDGn/MG0J8cQqqtOjiUiIkOf17KkSWO92L/O3egnJp4lCLqk4+1pLRCT1IPS3kfp
         //st0C6of9T5nkSx+GGbtsicSIOYHGEY/T/SrvmikL5IaVwEET4PQoQneFaJST4qQGUO
         SyCKRNOLFbRiu5ERBVotGvg84HaJbQFPFEZ1V3coLQ9bdRN6BU1Y4oxtJ6ClNRvxgJ7A
         3SzTov5Jve+gVfRfaNqsnpV9yW2cJWIj5uebjJRW06oRyPu/X/AgkrkYrCNOZ70XjS/5
         1YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkvoQ7ZQRviI68t1GQUcpGSIR6wTw9yWovYigsGIRFY=;
        b=eFep/lD3HLRAmSft0ba+l1cP061+ZKsUp7TXeCvOk6KfRvhL8sVcDyRX18REmOz1gi
         G1JMo0N0r6O1eRTjNLiKxsAXydZAFGLdINal9LiSh+gArkhAlYT1LYlxlNJHxaCYvAmV
         8sXzFfy2+WvDjAwrbkrWA0ZBf+UZBuYg0WaMXgQtPPginKMqER7wYWBoj8MX8Z5bJNeS
         30YIBI6Z5yPyV4aN+INWu6XuhJA7NP8iT9Cl66ROpcp0zLa/jVpdn3Hpp72DVprHh0kA
         ET1NklPe0Rk/FUA7Qin/IPV6xCTI+KvQ/9nUTXNm30YsfeKEI5ZMUS0eJvsS/nh0UB6t
         0w/A==
X-Gm-Message-State: APjAAAX6dLaVF7xcLNxIRST2GnGnY7FfqGl1WI0/m3iKqwKoJg+tVx5Q
        wHH3Vb7NYSU61QoRx6ycgA02gg==
X-Google-Smtp-Source: APXvYqw1zz8Kg0HRUMC5W2QdugP2J0Qooo78aN2tCiRc3HXRVVt+ub+YBGaSXFXBxi5zjySzdlMy4g==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr5196099wru.36.1555514828591;
        Wed, 17 Apr 2019 08:27:08 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-15-216.w90-86.abo.wanadoo.fr. [90.86.218.216])
        by smtp.gmail.com with ESMTPSA id v16sm75478817wru.76.2019.04.17.08.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 08:27:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 2/5] ARM: dts: da850-lego-ev3: enable cpufreq
Date:   Wed, 17 Apr 2019 17:26:58 +0200
Message-Id: <20190417152701.23391-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417152701.23391-1-brgl@bgdev.pl>
References: <20190417152701.23391-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

Add a fixed regulator for the LEGO EV3 board along with board-specific
CPU configuration.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index 66fcadf0ba91..553717f84483 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -125,6 +125,15 @@
 		amp-supply = <&amp>;
 	};
 
+	cvdd: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "cvdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	/*
 	 * This is a 5V current limiting regulator that is shared by USB,
 	 * the sensor (input) ports, the motor (output) ports and the A/DC.
@@ -204,6 +213,27 @@
 	clock-frequency = <24000000>;
 };
 
+&cpu {
+	cpu-supply = <&cvdd>;
+};
+
+/* since we have a fixed regulator, we can't run at these points */
+&opp_100 {
+	status = "disabled";
+};
+
+&opp_200 {
+	status = "disabled";
+};
+
+/*
+ * The SoC is actually the 456MHz version, but because of the fixed regulator
+ * This is the fastest we can go.
+ */
+&opp_375 {
+	status = "okay";
+};
+
 &pmx_core {
 	status = "okay";
 
-- 
2.21.0

