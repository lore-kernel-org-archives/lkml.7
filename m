Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8075C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D9120872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkXLDd0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfDQUzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45349 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733266AbfDQUzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so23718702ljd.12;
        Wed, 17 Apr 2019 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fh0BdMkifkL2qW090iE4588zYmgN5ZXLIkVPva8JzLE=;
        b=kkXLDd0WtHave2DtYpb3sU/K3dILO+Gb66dFj5Js0+rNeA/q7VMMSXuZ3Aq/bjrMCy
         5KnZoskDox/CzMK5iVvjS/nGUk1N/XXpxsWcWnK/Ho8nfzj+139sHTMMHvULbCjeDmhA
         l2NurKOaIGxTwT1uqRzRU4EgPiCI4DDwocgcRa3HiATM/YC3M3tbfLatixZMTyaSPH92
         Boy+hktPTL5WPBBEd+GvWtAsYQLtKSgz1nhKKaZ80BcLXFt4j+TdBAiaWKjaxtqPWgp3
         i7yd5rmHWRaHjGcBsUeoLpLRwLK5IrU+jEDN5BSbQrHF/H1nbvbja+FEPBCD1BUUIF08
         E5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fh0BdMkifkL2qW090iE4588zYmgN5ZXLIkVPva8JzLE=;
        b=rOmH/5lqHUCVSx1+8hje6snmlv0H/b2bOz7sWZVcjYlGFDDKOyxcOttenZ714XbrJf
         G9C6Wna7f52zKea941pPa9l6XauAqlmpAOkatClsHj9ZECYGEo5QfOU1yNNcyn2cXI6N
         AsSgowxCHBbrbiihUdoalWaZYRwwpTebzUjyihkTEkZKvasnCzf4xdujl2XC7cqgHHin
         2rrMSncFUKj+OkoJy8lbJ7APtH+YNQY46FZJ/vfwuEkmoQm4UywGUE+4X4YUDKJ7NFg+
         XQaTkYH5ZzVI/9F/6VeDC5iR//ejBnbsIVMaFq3XeeFwQnYGPBleZN8CCxhenMAyupGg
         K0rw==
X-Gm-Message-State: APjAAAUEiCq/CN9Pfa8r1vaN3ElGeS5mpEwZRd3yQQVyh1rCY7Y9pEnL
        R0uY2bDeQmkezAv4N57QoddYBJjJP0s=
X-Google-Smtp-Source: APXvYqzxvfp7h4OF+lXz5lFugHZ9E3tUGq5e+c+HuhPv3DfkOMUHxvlV/BYc0BSD0q69br2QoRfLLA==
X-Received: by 2002:a2e:8ece:: with SMTP id e14mr32337839ljl.66.1555534499854;
        Wed, 17 Apr 2019 13:54:59 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:54:59 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH v4 04/26] dt-bindings: leds: Add LED_COLOR_ID definitions
Date:   Wed, 17 Apr 2019 22:54:17 +0200
Message-Id: <20190417205439.17685-5-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common LED color identifiers.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
---
 include/dt-bindings/leds/common.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index da0539490cea..d8c8c38700bd 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -56,4 +56,15 @@
 #define LED_FUNCTION_WLAN "wlan"
 #define LED_FUNCTION_WPS "wps"
 
+/* Standard LED colors */
+#define LED_COLOR_ID_WHITE	0
+#define LED_COLOR_ID_RED	1
+#define LED_COLOR_ID_GREEN	2
+#define LED_COLOR_ID_BLUE	3
+#define LED_COLOR_ID_AMBER	4
+#define LED_COLOR_ID_VIOLET	5
+#define LED_COLOR_ID_YELLOW	6
+#define LED_COLOR_ID_IR		7
+#define LED_COLOR_ID_COUNT	8
+
 #endif /* __DT_BINDINGS_LEDS_H */
-- 
2.11.0

