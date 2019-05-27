Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4DBC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968BA2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U+t0G69t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfE0IXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:23:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39496 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfE0IXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:23:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id e2so7216568wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6d+R1BA43CR6//FSBQc7Q2qw1KEWApHiN8cbRKfTm8=;
        b=U+t0G69tazaJ32d2puFLX2n6t/xlReiVuHNX4sFtUMV9oIyiOxHwLAhcmjzB2AVWaE
         T94F/JIsMwMg/rb4bJVNBZ1Othe430BVUN9UuhhR5hzbmFSVm40NCAHqKy+gftpX/JCn
         sZZDjRjXR4i/kXjf3/hKX7G+o/yxJC5f2Se2UJqw0f5q0nQ8mmbtRWcQ6Sl3ZjkJubLi
         3UpX49E8IeBm/UdoJHMSa4gbHFWMaJv/vHcqwtm1jyE3SelX+BIzzhmQGYvXulP3J5+a
         bNToEtbwYVJo8WDN9DAOnzSUwWxX8qFIzLaUS2/cFCeNNvWPzSdijxLXfJh95qFMM3mu
         5Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6d+R1BA43CR6//FSBQc7Q2qw1KEWApHiN8cbRKfTm8=;
        b=DTV/ZCauv5qWwjF1EwdH6ETC6JIKMM2aXBaj91B8xyRQDFaGVCBp9gVEFbJ3dfYsYC
         yLppR2yL21iw2WnaEFp2xKHD9lWqERtbwqmQQywtEumn/NC2Qz3HQ90yGII6N3ktVcT9
         awq5a3cK0R0FVgSiqEnOyf13h+omAmBpQrbNGe7vcAwY9RjpaaIb+ujV9OUnFypZ7bOZ
         pan22BsiNac6/aOxsRgcLIPn0biRXqwKzwy3rs0FivlFQc1ScuxVeEBEAGRxoXdkO/Bf
         p3DE8rgUbYSRenQa2mOGa9RYeRZom6UbKrLkj0YX6HJsxMver45OZWfBVIQaaD6oOm77
         uMHg==
X-Gm-Message-State: APjAAAU6C7XOB783IxkkKaUVNgbh4ArZovYlBxzspRPECYmv3xEjmedv
        LyHlv7rF92Mgzsby2oYWK0ukrQ==
X-Google-Smtp-Source: APXvYqzl7Ctp82OmJEPm9ozlpt0egzfmyn5NVaZzUenfXA7KGk3WcpuMLjltC4b3IBRcqSYjl87k0A==
X-Received: by 2002:a5d:400b:: with SMTP id n11mr23418939wrp.123.1558945385008;
        Mon, 27 May 2019 01:23:05 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id n5sm14482754wrj.27.2019.05.27.01.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 01:23:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v5 1/5] ARM: dts: da850: add cpu node and operating points to DT
Date:   Mon, 27 May 2019 10:22:55 +0200
Message-Id: <20190527082259.29237-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527082259.29237-1-brgl@bgdev.pl>
References: <20190527082259.29237-1-brgl@bgdev.pl>
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

