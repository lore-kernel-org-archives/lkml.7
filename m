Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC222C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E5420872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW26zFov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbfDQUy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:54:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45014 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQUyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:54:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so23726469ljg.11;
        Wed, 17 Apr 2019 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jOazqB4a1qHluXy5YdfotZ4GPcCIHAHzl2D8nOrqdhk=;
        b=LW26zFovQqB5i5CcmLn7ouL5gxRODqi+/7Hr3mamwZp7XjcN0+TPMVCdvor3KKk7XZ
         +oX7bWja/Ypf8GzmWh5pxH7ObCi4yE6u8gZG+5bk8dWuVQpb2MpBrp7C13YWInPE1fPd
         cOwa9lYhOZxzTFHc8vBV/tXcYBodAJ2jiuhQ2Aa/WkTRKFCk5UsHSXN0pEGdShxcKLmy
         TteDqbe100zZ+BYJW4Yv773sE2pv7cbsAk1yiidNtGxAWa4TtG2CUw4RY7428BuErs4A
         N64i6Bd++mDznwXeZU8+/mnX7vWcH3REIDpjo9OjCG7FOYbQoD/GGD7YYkn7Gvk/xDCU
         nbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jOazqB4a1qHluXy5YdfotZ4GPcCIHAHzl2D8nOrqdhk=;
        b=OjqUT3YCSpmXAMoKALQG2c53Urjj0P0cEUBs07RY4UhxRl/FnNmXlabwmy4HfMEtal
         OxpvFkXzt1Kv63YEwrgFe+NYAD/YrjjyHn0e99ZX7FqpD7x53QqA0s7aHpJdf/iyZvoZ
         PaHOB8U4NrjG1FDOk57zQqAZuS212Dosv6S0fBV1xt2hjSRKp3wPEcdxCWek9nNV588a
         dU5ORs5K7gl5HxBvIDZf3hDMN1d+YG/lfe9S8i3dWXXBXROtwSz/QjhA7Dqp+OJlpZc8
         R2KYIeFnJm5ADKQ610mtZxtrioBbGJb9RaXgQ9x/55Ttp4deV672Hd/KILW7NEei2Bxb
         TByg==
X-Gm-Message-State: APjAAAXviK7rEWRAA1ihiT4mtwgLFfzp/FsXyCaLboJo940xDb30unLz
        Gxo8GGINiQE138o3xGvjhm7pu7d2
X-Google-Smtp-Source: APXvYqyrC8kO+Q1M8Zw9uXCCBMAuyWmF5JcidXM5S4du0OXFmjtMqU++KeZy6YhSsH0e79h8ttxw3Q==
X-Received: by 2002:a2e:8648:: with SMTP id i8mr5852863ljj.166.1555534492751;
        Wed, 17 Apr 2019 13:54:52 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:54:52 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 01/26] ALSA: line6: Avoid polluting led_* namespace
Date:   Wed, 17 Apr 2019 22:54:14 +0200
Message-Id: <20190417205439.17685-2-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

led_colors clashes with the array of the same name being added
to the LED class. Do the following amendments to fix this issue
and the other prospective one.

led_colors -> toneport_led_colors
led_init_vals -> toneport_led_init_vals

Fixes: f44edd7b2bbed ("ALSA: line6/toneport: Implement LED controls via LED class")
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 sound/usb/line6/toneport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index f47ba94e6f4a..56875526b182 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -291,8 +291,8 @@ static bool toneport_has_led(struct usb_line6_toneport *toneport)
 	}
 }
 
-static const char * const led_colors[2] = { "red", "green" };
-static const int led_init_vals[2] = { 0x00, 0x26 };
+static const char * const toneport_led_colors[2] = { "red", "green" };
+static const int toneport_led_init_vals[2] = { 0x00, 0x26 };
 
 static void toneport_update_led(struct usb_line6_toneport *toneport)
 {
@@ -320,9 +320,9 @@ static int toneport_init_leds(struct usb_line6_toneport *toneport)
 
 		led->toneport = toneport;
 		snprintf(led->name, sizeof(led->name), "%s::%s",
-			 dev_name(dev), led_colors[i]);
+			 dev_name(dev), toneport_led_colors[i]);
 		leddev->name = led->name;
-		leddev->brightness = led_init_vals[i];
+		leddev->brightness = toneport_led_init_vals[i];
 		leddev->max_brightness = 0x26;
 		leddev->brightness_set = toneport_led_brightness_set;
 		err = led_classdev_register(dev, leddev);
-- 
2.11.0

