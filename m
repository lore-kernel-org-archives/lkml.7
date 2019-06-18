Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04EEC31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB542189F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891242;
	bh=L/Sdk6CKaFTbu8gWc1tk0/YYEd2dapzu3worQ5M9/Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MmwyFq5P2B5e16H9ayFSd/9sv++aSpP0ULDvemUCH11eY0g+mDkbElNgxJ47obL6q
	 AYHmWRl7okk5BjybT9MXiXtzj1ZMsTa63WYifdEkh3HxVIhMJOarKnnb63QdrKUg9n
	 9+qwYyA7iyHXQUOekY26ZIIOWtxmIIYd5krut5F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfFRUyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:54:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbfFRUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5SfYNoI2veL+EyE/1v6HXSjfJsKXEwialcjlovAv4sY=; b=KaM4aDL40giM6QvI/jsAUrV0E3
        AkqJaP1WWuZlMn/sdrD8zBgr2uHkrLumYJaZearrmxJjOxInT83IO/3KQQEJvPZC+mLDKUleWeAd/
        xGIFbR6mdqSM9Vs9AT6Fl44QbT8af8MdwHrYNBV+8iZvKs6l4XHxOkl9wcmUEuLWWwMoTJJfX7nTD
        b2DmiWbMXE5JHA/z3tJ8bSxZd/Ov4rzKxOPfYYGLtilRX0h76jnS1UuMKVqByQTTtOfVeEyUPfUYk
        COzzmD2hK+qCWXeRys0itcvMP6HsM4sycopZil0CpTBytgfVnThm1PgUAdvr3vNSlDLvHsfFnZZbq
        IrlbT8Mg==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdL77-0008Ra-5F; Tue, 18 Jun 2019 20:53:57 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdL6z-0001z2-Ly; Tue, 18 Jun 2019 17:53:49 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 03/29] docs: lp855x-driver.txt: convert to ReST and move to kernel-api
Date:   Tue, 18 Jun 2019 17:53:21 -0300
Message-Id: <335fddb362664bbcc7b7360b35e56a8d347880d9.1560890800.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560890800.git.mchehab+samsung@kernel.org>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
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
index d64d8bb46323..3e43c7ab3d6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15831,7 +15831,7 @@ F:	sound/soc/codecs/isabelle*
 TI LP855x BACKLIGHT DRIVER
 M:	Milo Kim <milo.kim@ti.com>
 S:	Maintained
-F:	Documentation/backlight/lp855x-driver.txt
+F:	Documentation/backlight/lp855x-driver.rst
 F:	drivers/video/backlight/lp855x_bl.c
 F:	include/linux/platform_data/lp855x.h
 
-- 
2.21.0

