Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0653C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E79F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="R+dKQLrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDKMmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:42:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42780 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfDKMmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:42:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so7131039wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rqBaQ01/7esi3Y1PCSfQp5AXapGfI8BTtbQSCn74yu4=;
        b=R+dKQLrcQw3nhXB4aKtEe1Pbon4DQHqBj3S4Ven5sBftYMBFJpoy85ZazRag2yIj84
         C58x5jrzmzBfEjWBqhtMrZNOempszw60b/qqeeWZ8ccvebIW1CFpqeaMtfoaVFiljIB7
         o03OhO2OqGKzecpNN9FdA3pHm0JUfTewm3BgXinI9dWxSaJWmPOHciisPDwQEYKjhVKi
         20EJQ/h2tRnuWB3J4cddfjMn1rfTL+3GhSPsORZAcoCtp+CViupnqngcVrySn1KZiQk1
         C6QOp59hd2/sFSVUuLLD/rqlFgtRmdkLiXJUF4dqeu0hd56ugatTkmj5bVVcDWSgo+Hu
         09Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqBaQ01/7esi3Y1PCSfQp5AXapGfI8BTtbQSCn74yu4=;
        b=pGPc8pb1kdmuSn+Z6OX/hr1y2jLvPDX8ZGCP/QuP9LCyq5EPT41QxQ5oMu5/h6vGhi
         clI/fx1esQi4/Wnw+WJTl2aJMf9MZz8794Fttj3WdO4GLTsxB5fbFW50f7fvPtdPIXkA
         lliJQQVN0QYnuKQ1L5j9hJrxtp9PRW6IgtLcg9SvFVxujf++6KFPrMpbOHW6Jpkoa5G9
         D2AE/g0CdoObbM3uLlL+34lNDmUem01spQTsqZtbuLVZQrCVuPGonztodtm+KJ+XuDN+
         nBVgSxozQMTeHUq3as7UE1ftkp9bHoyc+z3vkNBxOuunum/VJJhU+tmQHpX9xtPIjYmu
         6g0A==
X-Gm-Message-State: APjAAAXopIbGUK1/FGLO7XVuoh4jqgPpqisoj41hKwzRr4RCe5ox+/ah
        WlQzNzK+6iXhrkvbJ/PX4sR/4Q==
X-Google-Smtp-Source: APXvYqz/WXxfDjLP9+VmGnXMmKbs4NZfa0anrCe5eUR8WI+tf+Z4wYzEBBaHHFvu1tVtnzPTTvzQMw==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr13834183wrx.76.1554986556576;
        Thu, 11 Apr 2019 05:42:36 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id d4sm32894510wrv.42.2019.04.11.05.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 05:42:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v9 11/11] MAINTAINERS: add an entry for max77650 mfd driver
Date:   Thu, 11 Apr 2019 14:42:12 +0200
Message-Id: <20190411124212.7612-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411124212.7612-1-brgl@bgdev.pl>
References: <20190411124212.7612-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I plan on extending this set of drivers so add myself as maintainer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2359e12e4c41..ab4e8c30a4de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9407,6 +9407,20 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAXIM MAX77650 PMIC MFD DRIVER
+M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/*max77650.txt
+F:	Documentation/devicetree/bindings/*/max77650*.txt
+F:	include/linux/mfd/max77650.h
+F:	drivers/mfd/max77650.c
+F:	drivers/regulator/max77650-regulator.c
+F:	drivers/power/supply/max77650-charger.c
+F:	drivers/input/misc/max77650-onkey.c
+F:	drivers/leds/leds-max77650.c
+F:	drivers/gpio/gpio-max77650.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.21.0

