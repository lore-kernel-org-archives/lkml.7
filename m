Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91396C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B722075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FjKzq8TT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfE0IXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:23:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55454 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfE0IXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:23:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id u78so2344347wmu.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omOq/JzjjXBt1z2M772CdUZvGc6HDPhhwS/eGDptw3A=;
        b=FjKzq8TTsoWBgk4mu/GDTvAuxM4Ls9tSWI59jJoe94tDs04gg232DMCf7Famp8QO8n
         Q4bhi/UIAPZWtSFFKuOZWLO2L6/3Avml1T1cC1PzDoJEp1BRI59efpkNpxpZqzNXf58+
         YO7oKuX8xQbAwyUxYYgjmAOiwM1KquVzHlwGJKE70/gbbZkaYzzgEYiuL2Se+dLTDxQU
         nZx8C0MO2Bu6Sb5lyHjVa5yNyS+Sx6AG1sIqr83JIH57MsLdVsOGPYawcRofquMgfpYe
         6jy1oJQf/VNyjXNawFP45wi44yarrcenhxefteVfHS6Uh7laif+nPQWBGsw5cAE9LaWL
         URDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omOq/JzjjXBt1z2M772CdUZvGc6HDPhhwS/eGDptw3A=;
        b=NlleGymsv1hndr7ufwtwRJ952/Y1nSZJSEQz1ezf/6XVAoTHLqC3NhxNUpaMFZHoaY
         jnZj8V7Y4rjlD27fXU20gtMAUNqeme65umONDiDoq0EFoOALPCMrPDTocXFb1wtd7ZMH
         C/USotXTQeAHnzwsy2cxQfHBrpxViaGfOFhAa641HEm4JfIUKEgS8zfz4e31+ZgF2PBg
         vUFYONOfCpsy6aBbNJ2I7CES0s47W6BcUrfW1IMWcDPu8cwSqGL1rlVm+fbNdDcJQF7Q
         poVtctNtsSiwRM47XG3WbDix/F3KESkXT6+6XqCTigqUgYh2TKVlTzFAwtJq1M6ZrmiZ
         H+XA==
X-Gm-Message-State: APjAAAWhTjbS5/Joayj5eolAVtbj5rz6ounRa6I7D/pp3+1mb8zkVLAm
        VYdW6X/4ue+Bmsfc58e0S3JQ6A==
X-Google-Smtp-Source: APXvYqw5I9nI20nY+Mj14/1S+PWhVrqS9ssbcSuJLzY6vmxi0EmMFZ4YTlP7p1LnQstfSNZWxPv2Vg==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr24735522wmh.138.1558945388585;
        Mon, 27 May 2019 01:23:08 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id n5sm14482754wrj.27.2019.05.27.01.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 01:23:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v5 4/5] ARM: dts: da850-evm: enable cpufreq
Date:   Mon, 27 May 2019 10:22:58 +0200
Message-Id: <20190527082259.29237-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527082259.29237-1-brgl@bgdev.pl>
References: <20190527082259.29237-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
tps65070 pmic with configurable output voltage. By default da850-evm
boards support frequencies up to 375MHz so enable this operating
point.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/boot/dts/da850-evm.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f04bc3e15332..f94bb38fdad9 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -191,6 +191,19 @@
 	};
 };
 
+&cpu {
+	cpu-supply = <&vdcdc3_reg>;
+};
+
+/*
+ * The standard da850-evm kits and SOM's are 375MHz so enable this operating
+ * point by default. Higher frequencies must be enabled for custom boards with
+ * other variants of the SoC.
+ */
+&opp_375 {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.21.0

