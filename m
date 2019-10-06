Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD9ECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0581E20862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clHOGBVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfJFQdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 12:33:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45800 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfJFQds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:33:48 -0400
Received: by mail-io1-f66.google.com with SMTP id c25so23511897iot.12;
        Sun, 06 Oct 2019 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VUjrbF/uEuOcH1i2arhwnD6g8A6OiWpt51euLUY1vEA=;
        b=clHOGBVJAGjrLSMhCDZMvTwKo4205fmRw8FPkUNv4/dVMRT6izUO0PvtBCNjor4mJO
         e0F0oqMPS5HKyWiQeSd4Dy4aryApBR4oYr4QYl2J6jcqKK/lmO3hu54tYH7xnTHX0IZO
         P75Jj7+dVjBO4L4AHqUuW+7rhshlWkEo7h0um+n4F9dkMV5rKi6moVghPotPs0K9+2EY
         EQts6B/TJobYPiVZPzRCkASl0WSWfcpbCWH2wg4K/St6wl5uXCQEM/XI/0rwMHI8zevw
         TNa7q6dY38nLYICwJrnsfeCcsyPmWh5zrlyT+xgAKV8QQtXeJ9ZrmPyzG6lOdnQaHDh6
         OAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VUjrbF/uEuOcH1i2arhwnD6g8A6OiWpt51euLUY1vEA=;
        b=E1dK+s05odg6gkOqeYmkkoeBYFxOn5WpeK2vWjfznxUELPRhNAJaFo6tlkS29EJ+Bc
         +h2YC4l/ujILITpkmw0VsGeNpHbdUvF8GIn/ltpFroKZR5Fpnx9QQF27vLYjYHe+bfSk
         7X80BGQFaVMTNSOAZpACkzhwk6iiBBnr//Zrs809OhmEdUKKF8M2+YXB9sx+vhon5QTo
         rHZnTiUa/z864BsZGqx0msoBFtErvJA0oBgo0lRKTFRTiPrkBYZNhLTEivBY2hD0qQLh
         5eVfwQqIAUNtYQ/8Q3S8FxaBOhs+EpUhsM35wjqXR5x7fpa+lyOk2aBjbPrNd7gfBa/L
         DTTA==
X-Gm-Message-State: APjAAAVqizR2CguL/7h/1LAXQnUwtA58BgCl4lInxGyesGAtuMbZY/1Z
        oSVzTYIfixyRbH56W/kiTkaltE0Glj8=
X-Google-Smtp-Source: APXvYqyrxAVUmlNlrI0JWtMICjshpqQy4bckLPHR8KHjruugJbnMbITMhRCjIMnL01Esftfxb/CTLw==
X-Received: by 2002:a5d:860f:: with SMTP id f15mr13103304iol.27.1570379627354;
        Sun, 06 Oct 2019 09:33:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id s11sm4471795ioc.79.2019.10.06.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 09:33:46 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vignesh R <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] serial: mctrl_gpio: Check for NULL pointer
Date:   Sun,  6 Oct 2019 11:33:11 -0500
Message-Id: <20191006163314.23191-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using mctrl_gpio_to_gpiod, it dereferences gpios into a single
requested GPIO.  This dereferencing can break if gpios is NULL,
so this patch adds a NULL check before dereferencing it.  If
gpios is NULL, this function will also return NULL.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  This patch is new to the V2 of this series, so patch 2/2 can 
     work without risking a NULL dereference
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index d9074303c88e..fb4781292d40 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -66,6 +66,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
 struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
 				      enum mctrl_gpio_idx gidx)
 {
+	if (gpios == NULL)
+		return NULL;
+
 	return gpios->gpio[gidx];
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
-- 
2.17.1

