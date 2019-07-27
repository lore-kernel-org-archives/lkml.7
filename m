Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD316C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53C7208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VLfAIH5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbfG0TrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 15:47:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37984 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388155AbfG0TrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:47:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so28881676wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u4zxzrsUGYajoD9B2Tdkb88ZiEEyjMTr1V8RPdE+1UY=;
        b=VLfAIH5SbHDQJcWnj5H522i2JcJ07BE+Zogzg/hd67JVrtQ/SMrYJZcfbNkZ2UQn11
         990VWKwTTuOrjBF318IiUVbLdDT5wu/CkI5NegXtPCqDvW7C5ZZPwIZp3QI7b0cixVNL
         1DJOL0s3HhdLycXuchIAIxwKy9Izek+IjPMrTFqle86YmZuBFaj8QkzS5hMjnUeZRX4x
         Wzupss3SpHykXFCouwWrO6cOydH6MlRZ6HfnuB+FI8xYP/q0yoNexz5Iny0FwGoNXvs9
         JLq5FFJHF0wXXz+QrWFGPfQltGm0HB6Ch7+5CvNbG7OXR+TrctVdnqJuzi226oAfXu/g
         8JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u4zxzrsUGYajoD9B2Tdkb88ZiEEyjMTr1V8RPdE+1UY=;
        b=VE/6txcdpg6Zq2EwVrmNYiFMjk/s15v88YEfRvYGjDT8/mywr6+6PiOpp1J32n/X9o
         WzvJrm8/InrzWqWK1MUO5nHkzrI2wiFdcdiD2LAXyBxTkxGzqE0E6zE0dXKpuQ9BOiG+
         SlyuTIqzmD6bVo3depKsT9AY2tEgYMMl9oBLL/wgczhBwa+CHRezcoQ9DsciIi2etij2
         YajZRyeQ93ZTPIkQyBd30I+jCTMQjmxNMyuqPFbn7FK1cdCxMdNGq4BST3SfabmSblZH
         wA8pheFATxy+c6SRyF2cQZbfsFpAnkTTtUIF2H9Mksovt9YGHP6iw3+sMPKCkJ/nypVS
         JbVA==
X-Gm-Message-State: APjAAAWtmhGkn5EpTfop0LVgGuyKunamvM2m9giHojiP8lKkexpzCmpO
        lm6L/0yN13Ek8TnoHwGuOZY=
X-Google-Smtp-Source: APXvYqykfdQYXHJvMHLdBsllsqHbIXy+FoSsDdN0ix235Vwv3c8pZV4WMrJhL5yfUaEeSHpjmVRfvQ==
X-Received: by 2002:a1c:b706:: with SMTP id h6mr88410051wmf.119.1564256828803;
        Sat, 27 Jul 2019 12:47:08 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C65C00B418D0F4A25A19EC.dip0.t-ipconnect.de. [2003:f1:33c6:5c00:b418:d0f4:a25a:19ec])
        by smtp.googlemail.com with ESMTPSA id c4sm44651726wrt.86.2019.07.27.12.47.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 12:47:08 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux.amoon@gmail.com, ottuzzi@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] ARM: dts: meson8b: add the nvmem cell with the board's MAC address
Date:   Sat, 27 Jul 2019 21:46:46 +0200
Message-Id: <20190727194647.15355-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190727194647.15355-1-martin.blumenstingl@googlemail.com>
References: <20190727194647.15355-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic's BSP kernel defines that all boards with a MAC address stored
in the eFuse have it at offset 0x1b4. It is up to the board to
decide whether to use this MAC address or not:
- Odroid-C1 uses the MAC address from the eFuse
- EC-100 seems to read the MAC address from eMMC

Add the nvmem cell which describes the Ethernet MAC address. Don't
assign it to the Ethernet controller, because depending on the board the
actual MAC address may be read from somewhere else.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 30fca9bb4bbe..c7de58b71d08 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -402,6 +402,10 @@
 	clocks = <&clkc CLKID_EFUSE>;
 	clock-names = "core";
 
+	ethernet_mac_address: mac@1b4 {
+		reg = <0x1b4 0x6>;
+	};
+
 	temperature_calib: calib@1f4 {
 		/* only the upper two bytes are relevant */
 		reg = <0x1f4 0x4>;
-- 
2.22.0

