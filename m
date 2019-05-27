Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99996C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7382075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yCOHiHpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE0IXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:23:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43502 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfE0IXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:23:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id l17so7582066wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOz0LP9XTs5tIMlVAfAa4sEOphJ8DfIzZ/dQTkiG5RA=;
        b=yCOHiHplnwXVnVvgMMq+WTfd08hSzLEbtyehNusK+SmHiWfDcF6ZStaxb8s2aBbO4o
         0jobPG9WnWr65/a3rnnbaVi1mY2Cieh8lvmaoHAne1acn2J5r3eWXWRQ7Y3uI2osJAHS
         6AfXeQgdAuFHiCOlaeZNIzOGgF7oReiIEv0MkVz1xnP1mrbWN9eEyEG21OnWSa8bnec2
         2FeJ9hwiAE+UmtVEHiTjsynANIMSa0JDRo7IPW3LALW1ghlKsl22/Q8SuXoP/N/Mpmjs
         S1aKHRA5p3ViE5aYVrN8/UqTt2smTAJhQsBdz5ppWpsjjY/VR1svGx10haDUnYkMtw9D
         TeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOz0LP9XTs5tIMlVAfAa4sEOphJ8DfIzZ/dQTkiG5RA=;
        b=W2FSxsBtTCmeoRtA2eaJTCMD/Sbi1262lH/1ZIgNLRG1RNQheoob8MtuwKx88O4ose
         VmymnHSW2fjt9Y0CZ/QE172JuO4tve10PeUay+piezZvwQ5d57RgTyiRk08Grs5lISPA
         SfhV/2s+7CccoJyCKng2XBEcKQyhVGPRVTaXcSSNNXOHbgOVED+IIZTIw3qviUa5TwA/
         L2cVRSXHVm1Tsz2tMkIfH1ENgEpfj4Wqn7aa7IhFNlpUD7xg1WHy2BjPFJe6kFVQKZMN
         /IldqSCN7AzeaU33bkULG5Fr6rxpw95E+a7gv6HTc2S/f9bAgm4otTRhwba6wx99O+49
         RuDw==
X-Gm-Message-State: APjAAAWBDtr2drb/Atc2mfjHY6JIbfNwdtx1dVtalTN/ztkHUJ5krSY1
        CRffAu43ftKVdHFr9dlY5q25yQ==
X-Google-Smtp-Source: APXvYqyNYn3rnNZSWnBrcaeR6u4YqpqZBBBFmyW5rVTM0Wa8Fwkb1DC+23nrCA0lXM+xg4r3l/IWBA==
X-Received: by 2002:adf:cf03:: with SMTP id o3mr10091252wrj.5.1558945387586;
        Mon, 27 May 2019 01:23:07 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id n5sm14482754wrj.27.2019.05.27.01.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 01:23:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v5 3/5] ARM: dts: da850-lcdk: enable cpufreq
Date:   Mon, 27 May 2019 10:22:57 +0200
Message-Id: <20190527082259.29237-4-brgl@bgdev.pl>
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

Add a fixed regulator for the da850-lcdk board along with board-specific
CPU configuration.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 26f453dc8370..b36d5e36bcf1 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -155,12 +155,48 @@
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
+/*
+ * LCDK has a fixed CVDD of 1.3V, so only operating points >= 300MHz are
+ * valid. Unfortunately due to a problem with the DA8XX OHCI controller, we
+ * can't enable more than one OPP by default, since the controller sometimes
+ * becomes unresponsive after a transition. Fix the frequency at 456 MHz.
+ */
+
+&opp_100 {
+	status = "disabled";
+};
+
+&opp_200 {
+	status = "disabled";
+};
+
+&opp_300 {
+	status = "disabled";
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

