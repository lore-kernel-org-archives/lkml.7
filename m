Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2321FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48AF206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kzR+HTfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbfGaMO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:14:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34281 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbfGaMOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:14:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so1170808wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/dy6tDwrDZyQwCbBNtI3rvHog6QhVWeb1hPHlqbhReg=;
        b=kzR+HTfyhqOF5B0psynwHitDS5M5lgyvesQmRWyJVlV9jqMOaUnE+AVFRXp1M4H1Yu
         xn4FMMwB3LiyZTWnm4rZ0nOG2r4OZqBi18gRFUqxrC9weYcDY1E0FavjRHhW5pTtUjuu
         gxUa5C1VfZtk9MXIbl82EBNGyUinA5CXVo/4O4u9V33NHCjscxUt0eSYo2B6krLA3bk1
         vKc85SttiGAvhvj2dTxKNq2vUcVJzUvA8dKoZlBzDKrMIJZL7WArbqHaQSRLTi/lwxCi
         m7RAxchFhPRZBW/pEkGuLftOLhfeEP3DBP283XWvwLO7iAb1GllGbdMntPm9eOZWUx1o
         hrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/dy6tDwrDZyQwCbBNtI3rvHog6QhVWeb1hPHlqbhReg=;
        b=diLR+S4L16WYsxKObVB2BpGoKAO21O8ApD2hGzUcjS2EPuHeVc4Yfy6Lj+GuUyhBYo
         NZbCO/c2WkNqUhB99upqzvDWkYE+D0jej6686vkGJpOaqxBbd1YOHP5p81kSTkoTNNua
         SYMBzuG4lw9lBH5rMNp284Qu3EoSlGkEmYLGJphdcjT0pTsKAKZgJqvlkBz9puIFX9zL
         4xXFIqp1RbV1N+51wmY22LSa7X7u4sf8pawfvdySWocAAtg9dzQgocLhhN+r2ADlxFqG
         R+9+hWOFj+eL3G0aVV3p0GCerGVJ4c2n72Qnl1IQ3CDGDN7eoUYvQ2LgRg8nAaaIifFZ
         fsRw==
X-Gm-Message-State: APjAAAWiZCiM/h8g1//Cewe4YysX6FWXplVFEX9Oz9QknuBWtcuTFsm/
        LguaJr3XcWrJXAzeC6nLbBfU5A==
X-Google-Smtp-Source: APXvYqwiXLefKrRh2int86J1ClmPTnKB6ds2eofOnlZxzgE2XsT6NJ7qlB851jUxzNz+12Fsd6Bh7w==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr114572270wma.90.1564575259044;
        Wed, 31 Jul 2019 05:14:19 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:18 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] MAINTAINERS: add entry for Amlogic Thermal driver
Date:   Wed, 31 Jul 2019 14:14:09 +0200
Message-Id: <20190731121409.17285-7-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731121409.17285-1-glaroque@baylibre.com>
References: <20190731121409.17285-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for Amlogic Thermal driver.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb2b12f75c37..299f27d11058 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15910,6 +15910,15 @@ F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
 F:	drivers/thermal/cpu_cooling.c
 F:	include/linux/cpu_cooling.h
 
+THERMAL DRIVER FOR AMLOGIC SOCS
+M:	Guillaume La Roque <glaroque@baylibre.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-amlogic@lists.infradead.org
+W:	http://linux-meson.com/
+S:	Supported
+F:	drivers/thermal/amlogic_thermal.c
+F:	Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+
 THINKPAD ACPI EXTRAS DRIVER
 M:	Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
 L:	ibm-acpi-devel@lists.sourceforge.net
-- 
2.17.1

