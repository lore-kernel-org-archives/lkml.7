Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B18C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A985F218B8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DgNS5ixr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbfHHIB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:01:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44295 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbfHHIBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:01:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so93903525wrf.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vF1D4ziTGh7E6yjRLQ/d3L84V5Gio+kElGO9NUrx4Pk=;
        b=DgNS5ixrZp/5vInKyiSdL2c4KC6mFHmp/eEk4aheh1km4HVyaWFJatQavM/3DEQ5gO
         IQ/vslc/d09rfuHc0EH0jpptZwQCViSvvqJwnk4YFSJ24sLBsQXhuLY5qUHFPex2S2aZ
         yw6I9ar5EG1MfChGaXYGs+aM3Jidu4DavXgOU+CiJxyipMKIS4GOHbb4lc6FJ833OsUL
         V9sNpS2tjUV3d+y16FFuez8a1rXgT3E5YbOSJEEhi4CVkBvVLCp3LTVqWtLUpjzJPa9w
         LKu6LhX9N8HEMe9+bO58MyWkC2yUqvwfqLOvWpwZlr0ykpSWbgMsPufNoeMVfb4d/O74
         6+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vF1D4ziTGh7E6yjRLQ/d3L84V5Gio+kElGO9NUrx4Pk=;
        b=o737ZT7RuLL8UvrrthzfPFztCVkALtyt9owA6eY4ynvg06LAf+/mehDt8lNhatVhro
         tFFkPu1qsJQ3gvs20nNhNhpU8hRgL2Wx3+vfPBEg1URckx2UY+cF+todDRj6Iu5oMeRI
         i6u9r4gC7AeJDPu/ARFd3uW8SGMoqGSpwoa0B/Eew/UUpUJNXI9FCF3RdbNNjP5V53RA
         1qOyxNYWomhh+vRqjqtjl4BjG5R5CeQYi09dhDExDb05Yw/1GRvco5K2Sh3oP9sKGfg+
         Fx8lS4+6OGVaIomPg+L2DbJHSGwJ5wls5San4BGCmhdgkNU2UbfJWbI3edh9+kY66FL0
         vNaQ==
X-Gm-Message-State: APjAAAXqa/pPiL3j1dYpLgyxhroCpD/QfUGp3TkzEArK/dOr1cotU9K+
        qQpKMz38JYrpm/x/YFIrzV2YQg==
X-Google-Smtp-Source: APXvYqxwvj0mI6/5K10kcHJ0g11StV92HMITzIKYusIWHElo+iJZA0zvsATCGtQWrHg8FGv6brdh4g==
X-Received: by 2002:a05:6000:1085:: with SMTP id y5mr7497131wrw.285.1565251313886;
        Thu, 08 Aug 2019 01:01:53 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id o7sm59383332wru.58.2019.08.08.01.01.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 01:01:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kbuild test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH][next] hwmon: pmbus: ucd9000: remove unneeded include
Date:   Thu,  8 Aug 2019 10:01:44 +0200
Message-Id: <20190808080144.6183-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Build bot reports the following build issue after commit 9091373ab7ea
("gpio: remove less important #ifdef around declarations):

   In file included from drivers/hwmon/pmbus/ucd9000.c:19:0:
>> include/linux/gpio/driver.h:576:1: error: redefinition of 'gpiochip_add_pin_range'
    gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/hwmon/pmbus/ucd9000.c:18:0:
   include/linux/gpio.h:245:1: note: previous definition of 'gpiochip_add_pin_range' was here
    gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/hwmon/pmbus/ucd9000.c:19:0:
>> include/linux/gpio/driver.h:583:1: error: redefinition of 'gpiochip_add_pingroup_range'
    gpiochip_add_pingroup_range(struct gpio_chip *chip,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/hwmon/pmbus/ucd9000.c:18:0:
   include/linux/gpio.h:254:1: note: previous definition of 'gpiochip_add_pingroup_range' was here
    gpiochip_add_pingroup_range(struct gpio_chip *chip,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/hwmon/pmbus/ucd9000.c:19:0:
>> include/linux/gpio/driver.h:591:1: error: redefinition of 'gpiochip_remove_pin_ranges'
    gpiochip_remove_pin_ranges(struct gpio_chip *chip)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/hwmon/pmbus/ucd9000.c:18:0:
   include/linux/gpio.h:263:1: note: previous definition of 'gpiochip_remove_pin_ranges' was here
    gpiochip_remove_pin_ranges(struct gpio_chip *chip)

This is caused by conflicting defines from linux/gpio.h and
linux/gpio/driver.h. Drivers should not include both the legacy and
the new API headers. This driver doesn't even use linux/gpio.h so
remove it.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hwmon/pmbus/ucd9000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index c846759bc1c0..a9229c6b0e84 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/pmbus.h>
-#include <linux/gpio.h>
 #include <linux/gpio/driver.h>
 #include "pmbus.h"
 
-- 
2.21.0

