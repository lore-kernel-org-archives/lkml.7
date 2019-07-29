Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9FCC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5A621655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b1XehoO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbfG2M6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:58:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55094 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfG2M6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:58:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so53734523wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 05:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zgZeKxOrrqWjvML06wf3e+bjI2MpHSypq9WO6/xcbOs=;
        b=b1XehoO/Qpmy7h8cLHnGcdHcn9QNU8V3wbMeh5Y369UoTvBxlEztW/B0FnchCtEz0n
         /+CeTaNXTliBGVc2tSMxeqCTBExvzxi/MEHNO7z2CUzZcG+aWMVZks5jUnaU2BXC1jtC
         kLk3c8CUtdhzWSYqaVZlIyp9o7fOKEY5wtus/rr/VtRIxVbcHNHYSBLKEh/6uIyu6Q/n
         HMEHmDVr1rajNjGuzjX5GUcyUfpJvkXLXq2EiYCxmQOMgEp9xw6pXWeXBVwoG6FM6TG/
         FSKsZnB0IkvpuLV2T5LvNjCCtUnpVSQB3xy4FpkI0KiYQ2HoT0VDp7b9X3tsoK6vMZ1+
         0c2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zgZeKxOrrqWjvML06wf3e+bjI2MpHSypq9WO6/xcbOs=;
        b=DKpgQwDMTeWBNPLOVD8a/Jmq1muCX70bK0CZF/L5gN+dWMkvu2jetW7tnLVXe0LLNe
         e59CaQOQ7qLPNGuF+xolE/9fwS5Qp5de/NNAVOEvpovJp6tbgeLYP71dfjtZpkNBlzWA
         7kLtc78WaiMCJQchDmZVfn2lVJDkv16ZAqm66wyhP9Y7F/n+fR8UlU14AeV7mKqpdFil
         YbU3vzz70elAPswyeOJzEQDVZP+psFVYVvswOMXGnjYVRI9f5uEbDCEHY5+HfJixcP8n
         9KBryQOZ5/BwhnoqtD7xM4noHHNskV3K/7JkuzHb3JqOjCTPRFw5Os2JCyMiBcg5dpjo
         IfAw==
X-Gm-Message-State: APjAAAVUKGGKUi2ccj4CI1hr8z/S3504fX1YRJBN1rHw7w6rPkhD2mSO
        0EBxbZbLtBzwMYWtu+67E/mD3g==
X-Google-Smtp-Source: APXvYqxTYhDqa6nBd6gkMoZq4dBfgw47+AH3bqKhNvPMkWAuzMonrOkTE6yj1F3cKty7qTwSwxAGDQ==
X-Received: by 2002:a1c:618a:: with SMTP id v132mr34306997wmb.17.1564405132425;
        Mon, 29 Jul 2019 05:58:52 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g19sm115217270wrb.52.2019.07.29.05.58.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 05:58:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linus.walleij@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] pinctrl: meson-g12a: add pwm_a on GPIOE_2 pinmux
Date:   Mon, 29 Jul 2019 14:58:38 +0200
Message-Id: <20190729125838.6498-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing pinmux for the pwm_a function on the GPIOE_2 pin.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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
2.22.0

