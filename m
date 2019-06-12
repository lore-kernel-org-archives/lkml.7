Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66111C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B01206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364854;
	bh=D/3abyK+MsfwvILJX7+PKM5ED3o6+bVmiQ7zMdhrOuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oH8u5I4gAzU0ZQ2NNfo4Gr/l5KzOtvDqm9Q41sA0Kz5enIjgVbYwLVT1QiEKlW9GN
	 KHx7w/cBxNjQRXKJiwTjiEcWkL1iN7cCZaEPDx3HI6TcOshA0/c8I61Pr9JDuTSCDc
	 pm0wiTEqPdyxT2S1x3WKbD1cp/RVEPVjHF4IhWTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403779AbfFLSks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:40:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfFLSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0RyZZifw7KwrAHs9QnFh7RMl/HPFSG97sdqSzSvqhbE=; b=Sii7penASN8vd9m7vyRpZv9GQ2
        eIguF8zryRGXj+nnka08+WcPf8GmJT83BDBkm1/twIMkHsverpG9nw+jD3mE3XiOqAn7E5BW9y8/h
        y2m3636rWbCG9JtVL1IzLGSg2NpaZp32IERsu0abBQFgs1zmGFy5dNMng+i6ZHigSSDO7E3XgLtLK
        NDcce5YFGmV47f7NMgYtMi82/iGhl9+zJP4t7yvp6thhV2MXxrDamGjBG3mAXQw0VmVPtcYlq+dfK
        PpLhiTZrtVNOInK7mX8dF8n7yhRUjXqDpEFWACd+ozG6Ryn1d2BrkfU9wYeFOukHPCIXKqC0P8ITg
        5lDP2kaw==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YQ-SB; Wed, 12 Jun 2019 18:38:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88p-0002AR-RY; Wed, 12 Jun 2019 15:38:35 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Milo Kim <milo.kim@ti.com>
Subject: [PATCH v1 03/31] docs: lp855x-driver.txt: convert to ReST and move to kernel-api
Date:   Wed, 12 Jun 2019 15:38:06 -0300
Message-Id: <3ef2faf09191cc003bf5254c9f915ef458471ad9.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small file seems to be an attempt to start documenting
backlight drivers.

It contains descriptions of the controls for the driver
with could sound as an somewhat user-faced description, but
it's main focus is to describe, instead, the data that should
be passed via platform data and some driver-specific stuff.

While this is not part of the driver-api book, mark it as
:orphan:, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/backlight/lp855x-driver.rst | 83 +++++++++++++++++++++++
 Documentation/backlight/lp855x-driver.txt | 66 ------------------
 MAINTAINERS                               |  2 +-
 3 files changed, 84 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/backlight/lp855x-driver.rst
 delete mode 100644 Documentation/backlight/lp855x-driver.txt

diff --git a/Documentation/backlight/lp855x-driver.rst b/Documentation/backlight/lp855x-driver.rst
new file mode 100644
index 000000000000..62b7ed847a77
--- /dev/null
+++ b/Documentation/backlight/lp855x-driver.rst
@@ -0,0 +1,83 @@
+:orphan:
+
+====================
+Kernel driver lp855x
+====================
+
+Backlight driver for LP855x ICs
+
+Supported chips:
+
+	Texas Instruments LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
+	LP8557
+
+Author: Milo(Woogyom) Kim <milo.kim@ti.com>
+
+Description
+-----------
+
+* Brightness control
+
+  Brightness can be controlled by the pwm input or the i2c command.
+  The lp855x driver supports both cases.
+
+* Device attributes
+
+  1) bl_ctl_mode
+
+  Backlight control mode.
+
+  Value: pwm based or register based
+
+  2) chip_id
+
+  The lp855x chip id.
+
+  Value: lp8550/lp8551/lp8552/lp8553/lp8555/lp8556/lp8557
+
+Platform data for lp855x
+------------------------
+
+For supporting platform specific data, the lp855x platform data can be used.
+
+* name:
+	Backlight driver name. If it is not defined, default name is set.
+* device_control:
+	Value of DEVICE CONTROL register.
+* initial_brightness:
+	Initial value of backlight brightness.
+* period_ns:
+	Platform specific PWM period value. unit is nano.
+	Only valid when brightness is pwm input mode.
+* size_program:
+	Total size of lp855x_rom_data.
+* rom_data:
+	List of new eeprom/eprom registers.
+
+Examples
+========
+
+1) lp8552 platform data: i2c register mode with new eeprom data::
+
+    #define EEPROM_A5_ADDR	0xA5
+    #define EEPROM_A5_VAL	0x4f	/* EN_VSYNC=0 */
+
+    static struct lp855x_rom_data lp8552_eeprom_arr[] = {
+	{EEPROM_A5_ADDR, EEPROM_A5_VAL},
+    };
+
+    static struct lp855x_platform_data lp8552_pdata = {
+	.name = "lcd-bl",
+	.device_control = I2C_CONFIG(LP8552),
+	.initial_brightness = INITIAL_BRT,
+	.size_program = ARRAY_SIZE(lp8552_eeprom_arr),
+	.rom_data = lp8552_eeprom_arr,
+    };
+
+2) lp8556 platform data: pwm input mode with default rom data::
+
+    static struct lp855x_platform_data lp8556_pdata = {
+	.device_control = PWM_CONFIG(LP8556),
+	.initial_brightness = INITIAL_BRT,
+	.period_ns = 1000000,
+    };
diff --git a/Documentation/backlight/lp855x-driver.txt b/Documentation/backlight/lp855x-driver.txt
deleted file mode 100644
index 01bce243d3d7..000000000000
--- a/Documentation/backlight/lp855x-driver.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-Kernel driver lp855x
-====================
-
-Backlight driver for LP855x ICs
-
-Supported chips:
-	Texas Instruments LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
-	LP8557
-
-Author: Milo(Woogyom) Kim <milo.kim@ti.com>
-
-Description
------------
-
-* Brightness control
-
-Brightness can be controlled by the pwm input or the i2c command.
-The lp855x driver supports both cases.
-
-* Device attributes
-
-1) bl_ctl_mode
-Backlight control mode.
-Value : pwm based or register based
-
-2) chip_id
-The lp855x chip id.
-Value : lp8550/lp8551/lp8552/lp8553/lp8555/lp8556/lp8557
-
-Platform data for lp855x
-------------------------
-
-For supporting platform specific data, the lp855x platform data can be used.
-
-* name : Backlight driver name. If it is not defined, default name is set.
-* device_control : Value of DEVICE CONTROL register.
-* initial_brightness : Initial value of backlight brightness.
-* period_ns : Platform specific PWM period value. unit is nano.
-	     Only valid when brightness is pwm input mode.
-* size_program : Total size of lp855x_rom_data.
-* rom_data : List of new eeprom/eprom registers.
-
-example 1) lp8552 platform data : i2c register mode with new eeprom data
-
-#define EEPROM_A5_ADDR	0xA5
-#define EEPROM_A5_VAL	0x4f	/* EN_VSYNC=0 */
-
-static struct lp855x_rom_data lp8552_eeprom_arr[] = {
-	{EEPROM_A5_ADDR, EEPROM_A5_VAL},
-};
-
-static struct lp855x_platform_data lp8552_pdata = {
-	.name = "lcd-bl",
-	.device_control = I2C_CONFIG(LP8552),
-	.initial_brightness = INITIAL_BRT,
-	.size_program = ARRAY_SIZE(lp8552_eeprom_arr),
-	.rom_data = lp8552_eeprom_arr,
-};
-
-example 2) lp8556 platform data : pwm input mode with default rom data
-
-static struct lp855x_platform_data lp8556_pdata = {
-	.device_control = PWM_CONFIG(LP8556),
-	.initial_brightness = INITIAL_BRT,
-	.period_ns = 1000000,
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index fa236f3f5979..28c3b926555e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15828,7 +15828,7 @@ F:	sound/soc/codecs/isabelle*
 TI LP855x BACKLIGHT DRIVER
 M:	Milo Kim <milo.kim@ti.com>
 S:	Maintained
-F:	Documentation/backlight/lp855x-driver.txt
+F:	Documentation/backlight/lp855x-driver.rst
 F:	drivers/video/backlight/lp855x_bl.c
 F:	include/linux/platform_data/lp855x.h
 
-- 
2.21.0

