Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027E4C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79BB2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8is5qvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfFZOrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56311 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfFZOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so2399319wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hAqxSgIO55AtglPI4y9BMkAp6zehdCTsbn3850+kcK0=;
        b=I8is5qvOAbLHl5EvFgLyy6VfBkaCh78I963eZv4LlCwEHuFftdH5VYymmJ56ufEkH7
         Ne5caOrsKs50/vTXTnqXhvRQ8AUKSbinHooiUBjR2biuImVAaklvSvFYlLPkttdKfpv2
         9htGRaVoWfz8COa8Bk4aACr9vxKAAKfEy5m5QPGkbqsmZTPwuO7srXB7vnd63Gm2ZZ5e
         Vi/8EPpMOaQ1sa5w7FrdM7OAsrKDHagF/xIW1pI+SC6Z8N/+2gOX310++nbDMowMXr1C
         fn1OMkHe8nMTwefqtH0RM3BdzsblLHSz1HK2ZzmLY90un4jLlWYuEeiNmbMrK9SLx4hG
         XASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hAqxSgIO55AtglPI4y9BMkAp6zehdCTsbn3850+kcK0=;
        b=gTwQpXPb83b8INZB/Tmo548qdeGh56u2Nanl05iVcvw7l+HFqw5SCek+8D6oX4Yzb6
         v7zDVXrlNVowZk031zxbrOKMcpmGX3wYyJQ1ns/nfr6zlgjSf3K2UWFEyHlHa/sbPVds
         muSDbnbQzYMAXlJTm7MgvIQN9JeSJC/xgOomOyuiALns5XJD6jeuG7g8T5DwHi/X4YgL
         0sl7kqPhMOWRwyPo9GCwWTa/Ij77F6dQUuSwFPZ9Lo4udAJldFtnkKBUnYDKIs22bDIU
         Qh4/ZERKE2cmNlFBInfsc9UVBSC28464UcoQOxz057nH4tsE882AZIHETG22HCIcFqMs
         ITmA==
X-Gm-Message-State: APjAAAWFMO335Ts6xPASfhNwpBrgiH4o3TJhwzPwWGVRA6FpGgk430O8
        gRvuM1ZloiDGWuiUO945lyuG+g==
X-Google-Smtp-Source: APXvYqzFn1J2DobNkC71K50j6OXadDRPvFyrzJW3kirwyhVhH9CJnQFidK8oV7luu39N/S+p3lh2+A==
X-Received: by 2002:a1c:c145:: with SMTP id r66mr2995522wmf.139.1561560432149;
        Wed, 26 Jun 2019 07:47:12 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support)
Subject: [PATCH 01/25] clocksource/drivers/timer-meson6: Update with SPDX Licence identifier
Date:   Wed, 26 Jun 2019 16:46:27 +0200
Message-Id: <20190626144651.16742-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

Comply with the licensing rules defined in the documentation.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-meson6.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-meson6.c b/drivers/clocksource/timer-meson6.c
index 84bd9479c3f8..9e8b467c71da 100644
--- a/drivers/clocksource/timer-meson6.c
+++ b/drivers/clocksource/timer-meson6.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson6 SoCs timer handling.
  *
  * Copyright (C) 2014 Carlo Caione <carlo@caione.org>
  *
  * Based on code from Amlogic, Inc
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/bitfield.h>
-- 
2.17.1

