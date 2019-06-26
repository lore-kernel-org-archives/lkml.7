Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB00AC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B0D20645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IZqNG4Ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfFZJGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:06:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35962 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFZJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:06:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so1795558wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYe7DDXQIL9cgrU/J6+VemHeiSBNByBQZKqrYUm/eeo=;
        b=IZqNG4EfbttnhxMV2QVAFvrf6vu4GQ9PI6Nso+6ApbR26KHmMJbjaKClJPn6E8EwzJ
         M4fiqHw1Kc8wiwFms+DATHH4T1c7EAfmdHOUTPBhj2rHWElIVkFxfquftNP5Nyms1LT0
         EWDBVhaDfz0DV/O6jLwx8U0GE+3sDgHtyor0/ME4mLv8QB1t2ky7GYK+aqkrJLqFF4pW
         RO+vFGcHywf+f/8/D20FUSQVt/4koC5zevXCTdGVlvsj/AGDz3q/VCY6OfcibA0kbKEA
         zm59NkZUXbwHy3ni+n8VHieAyW4eC40UXpewg7qRbE710/pLNgOsVHZn8yZx8SyfNCjd
         boJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYe7DDXQIL9cgrU/J6+VemHeiSBNByBQZKqrYUm/eeo=;
        b=Z8RSJDyE/MdDrhNDXFWxncYjw3t0nNlCh06nSh/sdCr3WTrQHGH80zT3zNreNchyse
         SWwVHT8leQsZUPSRgR4OsKRJs2AQKzu0TG6U9YJnHQBgZ3HOVs83gKzbOOPJjrveVsKC
         Kcpy/9ZCQAB6/nAeKG6hXYOI6Jss9PXh1HZ07x0pakw1/LMFonI38KJRhMpBBHZ6DAUn
         rh9c2R634UKmxaRODwoQW2Mej8rP8xlLlB4CVoHudY3kvC2d8LcBfpzZiBUV+JhejVtK
         QsJQV5XIGaFI7hbaKUHlscneUECaYOw/z8d5dgETrgX9q7HHuOC7ZegtGfDQrHQ7uced
         N3VQ==
X-Gm-Message-State: APjAAAVbnEkpHUERMlOPvGQ1wtQY+tmhuPeaXdDtdVAoFEBHAcgfBf2T
        HCyWarTmUPSe1/UcTir6VT83Rg==
X-Google-Smtp-Source: APXvYqyxjpfHTQzVG2c8KK9cmuSDK8HOXSqc8Faf7OuNvUlQtReJFxvDWffzUoHhiuLi3+ZLFL0ilg==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr2744391wro.36.1561539997693;
        Wed, 26 Jun 2019 02:06:37 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o6sm1925797wmc.46.2019.06.26.02.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 02:06:36 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT v2 01/14] pinctrl: meson-g12a: add pwm_a on GPIOE_2 pinmux
Date:   Wed, 26 Jun 2019 11:06:19 +0200
Message-Id: <20190626090632.7540-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626090632.7540-1-narmstrong@baylibre.com>
References: <20190626090632.7540-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing pinmux for the pwm_a function on the GPIOE_2 pin.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-g12a.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index 3475cd7bd2af..582665fd362a 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -801,6 +801,9 @@ static const unsigned int remote_ao_input_pins[]	= { GPIOAO_5 };
 /* ir_out */
 static const unsigned int remote_ao_out_pins[]		= { GPIOAO_4 };
 
+/* pwm_a_e */
+static const unsigned int pwm_a_e_pins[]		= { GPIOE_2 };
+
 /* pwm_ao_a */
 static const unsigned int pwm_ao_a_pins[]		= { GPIOAO_11 };
 static const unsigned int pwm_ao_a_hiz_pins[]		= { GPIOAO_11 };
@@ -888,6 +891,7 @@ static struct meson_pmx_group meson_g12a_aobus_groups[] = {
 	GROUP(i2c_ao_slave_sda,		3),
 	GROUP(remote_ao_input,		1),
 	GROUP(remote_ao_out,		1),
+	GROUP(pwm_a_e,			3),
 	GROUP(pwm_ao_a,			3),
 	GROUP(pwm_ao_a_hiz,		2),
 	GROUP(pwm_ao_b,			3),
@@ -1192,6 +1196,10 @@ static const char * const remote_ao_out_groups[] = {
 	"remote_ao_out",
 };
 
+static const char * const pwm_a_e_groups[] = {
+	"pwm_a_e",
+};
+
 static const char * const pwm_ao_a_groups[] = {
 	"pwm_ao_a", "pwm_ao_a_hiz",
 };
@@ -1290,6 +1298,7 @@ static struct meson_pmx_func meson_g12a_aobus_functions[] = {
 	FUNCTION(i2c_ao_slave),
 	FUNCTION(remote_ao_input),
 	FUNCTION(remote_ao_out),
+	FUNCTION(pwm_a_e),
 	FUNCTION(pwm_ao_a),
 	FUNCTION(pwm_ao_b),
 	FUNCTION(pwm_ao_c),
-- 
2.21.0

