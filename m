Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BDFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9CF20652
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mDG1Kl9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbfDQP1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:27:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39535 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbfDQP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:27:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so4090627wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOz0LP9XTs5tIMlVAfAa4sEOphJ8DfIzZ/dQTkiG5RA=;
        b=mDG1Kl9KwuTf5PheHGIRdskHKphrJ6F1orDecmkTLs0uCVQdsfhQ2avwKMTlqUHnKW
         IwizOkno4Rogcf9Y/Ei4Ii6e80Q2wtZnvlinLa4yRjw5rYfp0cNA8Qei4t67SvtZ4k2Y
         vlKAUB0oeZJj3//ehKpHbAcsh6Z7eMuC1kAokmePvzsT/5x6lqPgxl8Ar+6Q3WyRoqx6
         +m9ZxSdrf5DKIuLfGtR6h/YCmH2T0nevWJmo0DSps5jOuneZPibmMZENExDjbchJHr0G
         ovnsKJJ9m0jp9iQNJGCLm2FT0zLfGlFeEzKVynKqgr6VSqBsIILuOEPjfO2UrqkJ3ZHo
         4Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOz0LP9XTs5tIMlVAfAa4sEOphJ8DfIzZ/dQTkiG5RA=;
        b=s0TjO5To8XdyYpS3sH3XOQo0OkYFnbxyrsPjJ6j7c0aUOGwIxZLfTuoNmD6uOpDmoY
         4/RTHCZsv9k+nYpAbUW5CJOZ2QugGPJV1xehPYr74SeWel8ae7HpY/G17b3abzECH7iq
         Js5Y4VfRlWlJRQpfsqVKIhrt/0yLE8C0F3JSRQ7QheT0OFJteH/SuOQwMxaKmHNFIf0X
         ajirF01O7IhKx/B+Ay3wmpaCW/mxzc0xHvnIjySyFEV9wEnmR6SDEsEAAH7WNg/kQhF4
         dyWLK/Il9aLU1S2H+fjw9gIzKlbbn2YuzMn2SmjSe8k75OIpxZ0xXkWmMARJMocQ0CHo
         H3Aw==
X-Gm-Message-State: APjAAAVOuCriBsmwPvi3G0b9ApZuRljDnJj4mSP9ChQcKJRkQVb/nBNx
        YzT7jt55fpS1cBXnRFbZzACYLF9L6Fw=
X-Google-Smtp-Source: APXvYqyyo8pBlRcaxYTG7zAb3/WrfptkaRTirKrv7PVgDj8B+E0zSxoYFxM5+RymuxS6V6NJO97tQA==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr31604646wmc.51.1555514829783;
        Wed, 17 Apr 2019 08:27:09 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-15-216.w90-86.abo.wanadoo.fr. [90.86.218.216])
        by smtp.gmail.com with ESMTPSA id v16sm75478817wru.76.2019.04.17.08.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 08:27:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 3/5] ARM: dts: da850-lcdk: enable cpufreq
Date:   Wed, 17 Apr 2019 17:26:59 +0200
Message-Id: <20190417152701.23391-4-brgl@bgdev.pl>
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

