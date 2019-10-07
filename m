Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80ECC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D24321721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuq8L5e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfJGNRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:17:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36686 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGNRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:17:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so8218492pgk.3;
        Mon, 07 Oct 2019 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KoaZxzLVm/DwefngcDmoS+KKvyssprZYYbYsX24hxTA=;
        b=fuq8L5e8HT5X5j5AtOK4CFur/2UqrGH8CyIA/PG4EG4QYDarWYNEvGf6D3BzesNav9
         ZgRBRvgF6dkQp5IioSG+FFLw5bWQR2+dFhqrdD09l2NvpGnH3aIY7s5CG2WSU2rZhFtw
         LDArsDCvRAVINmC3xzbXglsRf2yRyMoDOq3uq2w4t3TZXl9iqEqqnWCSzGRPBFvFxiE8
         dqB+UAbnJhwH5osdIri6HrZuROnQk36NSrsebN6r60EvqVetqIx7aRPp+SIWt0c3BJV/
         KVDAFY13Ci5eDCgobHwIN2YnNgUKZkujuk7bViJN2cviZQxgdmvrtlmAwXA1qvbz3O58
         IUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KoaZxzLVm/DwefngcDmoS+KKvyssprZYYbYsX24hxTA=;
        b=ks4NXJOqZ6HpxvZn0DPdpE+cGfiyK9uXEK/lWs9gmXtxuTbTsx6cjuEbiOSb4faSP9
         R5DCZbPq1tGlb3joUTUcGXdg+Grc4HSS//Ytgm1KLjZZ4D1xxr9L+vqMI3+u0tZuKsQk
         g7NIeKNkj2gPE8tutxeJ9s9KLQgUPUKINpwDmBojDHxDFsR50hQP8OJiQUjNL6kgpoaW
         aIAwuzFbJaeq1PKDroa7j4HnUBNlIil5JQfFraU0vhNFf8ahasIBNOWm2HSZKpfgl4fI
         NBeAaQTPmcaidHedOEZBMUkxn+N6D2dKEwxDGiwzcfvd6BslD5vZMt1dO9FRMhMamtP7
         QcDA==
X-Gm-Message-State: APjAAAVshPX+XSXUT/2lHyYW6W+3vOKPE/FjTjwyh6cb7beqva0FcIoy
        W1t9TnR9aAfNSdtvzF75YQQ=
X-Google-Smtp-Source: APXvYqx797i05121y81HVrKKU0fXm5V5dGZoKCAXND16sYYS7D7G9dCUXRYLbrJW45fVkM4bXjS7mQ==
X-Received: by 2002:a17:90a:2687:: with SMTP id m7mr32683118pje.25.1570454240627;
        Mon, 07 Oct 2019 06:17:20 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.138])
        by smtp.gmail.com with ESMTPSA id r186sm16938650pfr.40.2019.10.07.06.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:17:20 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 3/5] arm64: dts: meson: Add missing regulator linked to VDDAO_3V3 regulator to FLASH_VDD
Date:   Mon,  7 Oct 2019 13:16:47 +0000
Message-Id: <20191007131649.1768-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007131649.1768-1-linux.amoon@gmail.com>
References: <20191007131649.1768-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics add missing VDDAO_3V3 power supply to FLASH_VDD
regulator. Also add TFLASH_VDD_EN signal name to gpio pin.

Fixes: c35f6dc5c377 (arm64: dts: meson: Add minimal support for Odroid-N2)
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 66262a6ab3fe..6bd23a1e7e1d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -51,9 +51,12 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
+		/* TFLASH_VDD_EN */
 		gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
+		/* U18 FC8731-09VF05NRR */
+		vin-supply = <&vddao_3v3>;
 	};
 
 	tf_io: gpio-regulator-tf_io {
-- 
2.23.0

