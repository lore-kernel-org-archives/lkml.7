Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027132133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GeXEeI82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfJCJ33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:29:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36511 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfJCJ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:29:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so2176959wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QqJ1WGMAV/9pOpubSvWtoTDBAN7XnEHSAkl4nvGIl8=;
        b=GeXEeI82MVo6sv8lFrDvsnI1zheB8u/XxFJGhO2v3TBuZFmLT378iIgzoIw1Mbvzu+
         5BZeuvlGlTPxUOeMciCbz3/nDgdoUhTr3Ow5k/EhI2o5hW9KK7M1IeicoTZxtiFlnVGc
         tQfSW1zOHDUFMImbtxW841wGSml1yuTSJQAHP4bIbK47mEmadZ4AcpT2lRh2LQjp2Xom
         3rZKQV7G9joApIqbel0HbKVmEvytgU+9Hg6ef+V7bR2kRfZ7Pu8ZfxGvoR1d78Tyvoxq
         kj3hC27nEk9SGkYoKLHL6MNX5L4veqBZqlLwLL5pSdxz5jxwDxnyUDhK7npUFxyOQ2mp
         It9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QqJ1WGMAV/9pOpubSvWtoTDBAN7XnEHSAkl4nvGIl8=;
        b=JPqq1bME7NdB4uVCikVnuTCSCm0NJ9xnxF3UnrqwUCnYywLf5koVoKOLmBqSb03XvT
         4vN9swI4UkuJYSkKxG5nx7pALG8c7BYRgX498hi8sQpyy4DFsiUZQuYYSwFfm2Mt8a0I
         HEH0/u4uOgfPR4+mMcI04mJDT/zbi0X5oTefSoYIxYRsZ/Pf1YEycP9Oq4d1DAzM0L7V
         iOLIN4u8HLwjQN5WSZD+DUVBgEOyekx5LCLBqXDJObgg417kC351TqSismxpP3YNpU69
         WDPXN2ZNNrNR5wUF7f64Lg78fr9Ea6Vfz8zK7PCyxPqIaxtxvQe+C1HHjJP/oNiFLTFF
         xH8A==
X-Gm-Message-State: APjAAAXLwXorjqksRMv0At32dKFCjmDjfSlBVxAuI72N23NoA5LOTZgM
        EgRqW5EERgq06na0H5uYTg4Z+g==
X-Google-Smtp-Source: APXvYqzGlQeiAejc5uoqVGeqcmHFfK2m5W2X2X7B0oQaBI7NPJKRtqn4zo3PIjuQp4ueuTKsLkrIRg==
X-Received: by 2002:adf:cf02:: with SMTP id o2mr6855381wrj.380.1570094964817;
        Thu, 03 Oct 2019 02:29:24 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id u83sm10554259wme.0.2019.10.03.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 02:29:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 2/2] sh: add the sh_ prefix to early platform symbols
Date:   Thu,  3 Oct 2019 11:29:13 +0200
Message-Id: <20191003092913.10731-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003092913.10731-1-brgl@bgdev.pl>
References: <20191003092913.10731-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Old early platform device support is now sh-specific. Before moving on
to implementing new early platform framework based on real platform
devices, prefix all early platform symbols with 'sh_'.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/sh/drivers/platform_early.c       | 66 +++++++++++++-------------
 arch/sh/include/asm/platform_early.h   | 30 ++++++------
 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c |  2 +-
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |  2 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |  2 +-
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |  2 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |  2 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |  2 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |  8 ++--
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |  2 +-
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |  2 +-
 arch/sh/kernel/setup.c                 |  2 +-
 arch/sh/kernel/time.c                  |  4 +-
 drivers/clocksource/sh_cmt.c           |  6 +--
 drivers/clocksource/sh_mtu2.c          |  6 +--
 drivers/clocksource/sh_tmu.c           |  6 +--
 drivers/tty/serial/sh-sci.c            |  4 +-
 include/linux/platform_device.h        |  2 +-
 37 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index 3dfe9f3541bb..f6d148451dfc 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -4,8 +4,8 @@
 #include <linux/mod_devicetable.h>
 #include <linux/pm.h>
 
-static __initdata LIST_HEAD(early_platform_driver_list);
-static __initdata LIST_HEAD(early_platform_device_list);
+static __initdata LIST_HEAD(sh_early_platform_driver_list);
+static __initdata LIST_HEAD(sh_early_platform_device_list);
 
 static const struct platform_device_id *
 platform_match_id(const struct platform_device_id *id,
@@ -58,13 +58,13 @@ static void pm_runtime_early_init(struct device *dev) {}
 #endif
 
 /**
- * early_platform_driver_register - register early platform driver
- * @epdrv: early_platform driver structure
+ * sh_early_platform_driver_register - register early platform driver
+ * @epdrv: sh_early_platform driver structure
  * @buf: string passed from early_param()
  *
- * Helper function for early_platform_init() / early_platform_init_buffer()
+ * Helper function for sh_early_platform_init() / sh_early_platform_init_buffer()
  */
-int __init early_platform_driver_register(struct early_platform_driver *epdrv,
+int __init sh_early_platform_driver_register(struct sh_early_platform_driver *epdrv,
 					  char *buf)
 {
 	char *tmp;
@@ -75,7 +75,7 @@ int __init early_platform_driver_register(struct early_platform_driver *epdrv,
 	 */
 	if (!epdrv->list.next) {
 		INIT_LIST_HEAD(&epdrv->list);
-		list_add_tail(&epdrv->list, &early_platform_driver_list);
+		list_add_tail(&epdrv->list, &sh_early_platform_driver_list);
 	}
 
 	/* If the user has specified device then make sure the driver
@@ -84,7 +84,7 @@ int __init early_platform_driver_register(struct early_platform_driver *epdrv,
 	 */
 	n = strlen(epdrv->pdrv->driver.name);
 	if (buf && !strncmp(buf, epdrv->pdrv->driver.name, n)) {
-		list_move(&epdrv->list, &early_platform_driver_list);
+		list_move(&epdrv->list, &sh_early_platform_driver_list);
 
 		/* Allow passing parameters after device name */
 		if (buf[n] == '\0' || buf[n] == ',')
@@ -114,14 +114,14 @@ int __init early_platform_driver_register(struct early_platform_driver *epdrv,
 }
 
 /**
- * early_platform_add_devices - adds a number of early platform devices
+ * sh_early_platform_add_devices - adds a number of early platform devices
  * @devs: array of early platform devices to add
  * @num: number of early platform devices in array
  *
  * Used by early architecture code to register early platform devices and
  * their platform data.
  */
-void __init early_platform_add_devices(struct platform_device **devs, int num)
+void __init sh_early_platform_add_devices(struct platform_device **devs, int num)
 {
 	struct device *dev;
 	int i;
@@ -134,20 +134,20 @@ void __init early_platform_add_devices(struct platform_device **devs, int num)
 			pm_runtime_early_init(dev);
 			INIT_LIST_HEAD(&dev->devres_head);
 			list_add_tail(&dev->devres_head,
-				      &early_platform_device_list);
+				      &sh_early_platform_device_list);
 		}
 	}
 }
 
 /**
- * early_platform_driver_register_all - register early platform drivers
+ * sh_early_platform_driver_register_all - register early platform drivers
  * @class_str: string to identify early platform driver class
  *
  * Used by architecture code to register all early platform drivers
  * for a certain class. If omitted then only early platform drivers
  * with matching kernel command line class parameters will be registered.
  */
-void __init early_platform_driver_register_all(char *class_str)
+void __init sh_early_platform_driver_register_all(char *class_str)
 {
 	/* The "class_str" parameter may or may not be present on the kernel
 	 * command line. If it is present then there may be more than one
@@ -160,23 +160,23 @@ void __init early_platform_driver_register_all(char *class_str)
 	 * We use parse_early_options() to make sure the early_param() gets
 	 * called at least once. The early_param() may be called more than
 	 * once since the name of the preferred device may be specified on
-	 * the kernel command line. early_platform_driver_register() handles
+	 * the kernel command line. sh_early_platform_driver_register() handles
 	 * this case for us.
 	 */
 	parse_early_options(class_str);
 }
 
 /**
- * early_platform_match - find early platform device matching driver
+ * sh_early_platform_match - find early platform device matching driver
  * @epdrv: early platform driver structure
  * @id: id to match against
  */
 static struct platform_device * __init
-early_platform_match(struct early_platform_driver *epdrv, int id)
+sh_early_platform_match(struct sh_early_platform_driver *epdrv, int id)
 {
 	struct platform_device *pd;
 
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+	list_for_each_entry(pd, &sh_early_platform_device_list, dev.devres_head)
 		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
 			if (pd->id == id)
 				return pd;
@@ -185,16 +185,16 @@ early_platform_match(struct early_platform_driver *epdrv, int id)
 }
 
 /**
- * early_platform_left - check if early platform driver has matching devices
+ * sh_early_platform_left - check if early platform driver has matching devices
  * @epdrv: early platform driver structure
  * @id: return true if id or above exists
  */
-static int __init early_platform_left(struct early_platform_driver *epdrv,
+static int __init sh_early_platform_left(struct sh_early_platform_driver *epdrv,
 				       int id)
 {
 	struct platform_device *pd;
 
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+	list_for_each_entry(pd, &sh_early_platform_device_list, dev.devres_head)
 		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
 			if (pd->id >= id)
 				return 1;
@@ -203,22 +203,22 @@ static int __init early_platform_left(struct early_platform_driver *epdrv,
 }
 
 /**
- * early_platform_driver_probe_id - probe drivers matching class_str and id
+ * sh_early_platform_driver_probe_id - probe drivers matching class_str and id
  * @class_str: string to identify early platform driver class
  * @id: id to match against
  * @nr_probe: number of platform devices to successfully probe before exiting
  */
-static int __init early_platform_driver_probe_id(char *class_str,
+static int __init sh_early_platform_driver_probe_id(char *class_str,
 						 int id,
 						 int nr_probe)
 {
-	struct early_platform_driver *epdrv;
+	struct sh_early_platform_driver *epdrv;
 	struct platform_device *match;
 	int match_id;
 	int n = 0;
 	int left = 0;
 
-	list_for_each_entry(epdrv, &early_platform_driver_list, list) {
+	list_for_each_entry(epdrv, &sh_early_platform_driver_list, list) {
 		/* only use drivers matching our class_str */
 		if (strcmp(class_str, epdrv->class_str))
 			continue;
@@ -229,7 +229,7 @@ static int __init early_platform_driver_probe_id(char *class_str,
 
 		} else {
 			match_id = id;
-			left += early_platform_left(epdrv, id);
+			left += sh_early_platform_left(epdrv, id);
 
 			/* skip requested id */
 			switch (epdrv->requested_id) {
@@ -251,7 +251,7 @@ static int __init early_platform_driver_probe_id(char *class_str,
 			match = NULL;
 			break;
 		default:
-			match = early_platform_match(epdrv, match_id);
+			match = sh_early_platform_match(epdrv, match_id);
 		}
 
 		if (match) {
@@ -293,7 +293,7 @@ static int __init early_platform_driver_probe_id(char *class_str,
 }
 
 /**
- * early_platform_driver_probe - probe a class of registered drivers
+ * sh_early_platform_driver_probe - probe a class of registered drivers
  * @class_str: string to identify early platform driver class
  * @nr_probe: number of platform devices to successfully probe before exiting
  * @user_only: only probe user specified early platform devices
@@ -302,7 +302,7 @@ static int __init early_platform_driver_probe_id(char *class_str,
  * within a certain class. For probe to happen a registered early platform
  * device matching a registered early platform driver is needed.
  */
-int __init early_platform_driver_probe(char *class_str,
+int __init sh_early_platform_driver_probe(char *class_str,
 				       int nr_probe,
 				       int user_only)
 {
@@ -310,7 +310,7 @@ int __init early_platform_driver_probe(char *class_str,
 
 	n = 0;
 	for (i = -2; n < nr_probe; i++) {
-		k = early_platform_driver_probe_id(class_str, i, nr_probe - n);
+		k = sh_early_platform_driver_probe_id(class_str, i, nr_probe - n);
 
 		if (k < 0)
 			break;
@@ -325,14 +325,14 @@ int __init early_platform_driver_probe(char *class_str,
 }
 
 /**
- * early_platform_cleanup - clean up early platform code
+ * sh_early_platform_cleanup - clean up early platform code
  */
-static int __init early_platform_cleanup(void)
+static int __init sh_early_platform_cleanup(void)
 {
 	struct platform_device *pd, *pd2;
 
 	/* clean up the devres list used to chain devices */
-	list_for_each_entry_safe(pd, pd2, &early_platform_device_list,
+	list_for_each_entry_safe(pd, pd2, &sh_early_platform_device_list,
 				 dev.devres_head) {
 		list_del(&pd->dev.devres_head);
 		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
@@ -344,4 +344,4 @@ static int __init early_platform_cleanup(void)
  * This must happen once after all early devices are probed but before probing
  * real platform devices.
  */
-subsys_initcall(early_platform_cleanup);
+subsys_initcall(sh_early_platform_cleanup);
diff --git a/arch/sh/include/asm/platform_early.h b/arch/sh/include/asm/platform_early.h
index 4590ab757d5f..fc802137c37d 100644
--- a/arch/sh/include/asm/platform_early.h
+++ b/arch/sh/include/asm/platform_early.h
@@ -8,7 +8,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
-struct early_platform_driver {
+struct sh_early_platform_driver {
 	const char *class_str;
 	struct platform_driver *pdrv;
 	struct list_head list;
@@ -20,39 +20,39 @@ struct early_platform_driver {
 #define EARLY_PLATFORM_ID_UNSET -2
 #define EARLY_PLATFORM_ID_ERROR -3
 
-extern int early_platform_driver_register(struct early_platform_driver *epdrv,
+extern int sh_early_platform_driver_register(struct sh_early_platform_driver *epdrv,
 					  char *buf);
-extern void early_platform_add_devices(struct platform_device **devs, int num);
+extern void sh_early_platform_add_devices(struct platform_device **devs, int num);
 
-static inline int is_early_platform_device(struct platform_device *pdev)
+static inline int is_sh_early_platform_device(struct platform_device *pdev)
 {
 	return !pdev->dev.driver;
 }
 
-extern void early_platform_driver_register_all(char *class_str);
-extern int early_platform_driver_probe(char *class_str,
+extern void sh_early_platform_driver_register_all(char *class_str);
+extern int sh_early_platform_driver_probe(char *class_str,
 				       int nr_probe, int user_only);
 
-#define early_platform_init(class_string, platdrv)		\
-	early_platform_init_buffer(class_string, platdrv, NULL, 0)
+#define sh_early_platform_init(class_string, platdrv)		\
+	sh_early_platform_init_buffer(class_string, platdrv, NULL, 0)
 
 #ifndef MODULE
-#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
-static __initdata struct early_platform_driver early_driver = {		\
+#define sh_early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
+static __initdata struct sh_early_platform_driver early_driver = {		\
 	.class_str = class_string,					\
 	.buffer = buf,							\
 	.bufsize = bufsiz,						\
 	.pdrv = platdrv,						\
 	.requested_id = EARLY_PLATFORM_ID_UNSET,			\
 };									\
-static int __init early_platform_driver_setup_func(char *buffer)	\
+static int __init sh_early_platform_driver_setup_func(char *buffer)	\
 {									\
-	return early_platform_driver_register(&early_driver, buffer);	\
+	return sh_early_platform_driver_register(&early_driver, buffer);	\
 }									\
-early_param(class_string, early_platform_driver_setup_func)
+early_param(class_string, sh_early_platform_driver_setup_func)
 #else /* MODULE */
-#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
-static inline char *early_platform_driver_setup_func(void)		\
+#define sh_early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
+static inline char *sh_early_platform_driver_setup_func(void)		\
 {									\
 	return bufsiz ? buf : NULL;					\
 }
diff --git a/arch/sh/kernel/cpu/sh2/setup-sh7619.c b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
index 27d459e8a598..b1c877b6a420 100644
--- a/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -200,6 +200,6 @@ void __init plat_early_device_setup(void)
 	/* enable CMT clock */
 	__raw_writeb(__raw_readb(STBCR3) & ~0x10, STBCR3);
 
-	early_platform_add_devices(sh7619_early_devices,
+	sh_early_platform_add_devices(sh7619_early_devices,
 				   ARRAY_SIZE(sh7619_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-mxg.c b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
index 8a19c5754978..cefa07924c16 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
@@ -170,6 +170,6 @@ static struct platform_device *mxg_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(mxg_early_devices,
+	sh_early_platform_add_devices(mxg_early_devices,
 				   ARRAY_SIZE(mxg_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
index d975e4d404bd..28f1bebf3405 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
@@ -413,6 +413,6 @@ void __init plat_early_device_setup(void)
 	/* enable MTU2 clock */
 	__raw_writeb(__raw_readb(STBCR3) & ~0x20, STBCR3);
 
-	early_platform_add_devices(sh7201_early_devices,
+	sh_early_platform_add_devices(sh7201_early_devices,
 				   ARRAY_SIZE(sh7201_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
index 318b8cd8d5b7..4839f3aaeb4c 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
@@ -350,6 +350,6 @@ void __init plat_early_device_setup(void)
 	/* enable MTU2 clock */
 	__raw_writeb(__raw_readb(STBCR3) & ~0x20, STBCR3);
 
-	early_platform_add_devices(sh7203_early_devices,
+	sh_early_platform_add_devices(sh7203_early_devices,
 				   ARRAY_SIZE(sh7203_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
index 8e6fae60074a..68add5af4cc5 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
@@ -286,6 +286,6 @@ void __init plat_early_device_setup(void)
 	/* enable MTU2 clock */
 	__raw_writeb(__raw_readb(STBCR3) & ~0x20, STBCR3);
 
-	early_platform_add_devices(sh7206_early_devices,
+	sh_early_platform_add_devices(sh7206_early_devices,
 				   ARRAY_SIZE(sh7206_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
index 2d95c9b38330..8a1cb613dd2e 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
@@ -547,6 +547,6 @@ static struct platform_device *sh7264_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7264_early_devices,
+	sh_early_platform_add_devices(sh7264_early_devices,
 				   ARRAY_SIZE(sh7264_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
index ef4ff76cbe9e..8b1ef3028320 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
@@ -563,6 +563,6 @@ static struct platform_device *sh7269_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7269_early_devices,
+	sh_early_platform_add_devices(sh7269_early_devices,
 				   ARRAY_SIZE(sh7269_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7705.c b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
index 9b34d1f4e797..0544134b3f20 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
@@ -179,7 +179,7 @@ static struct platform_device *sh7705_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7705_early_devices,
+	sh_early_platform_add_devices(sh7705_early_devices,
 				   ARRAY_SIZE(sh7705_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 39f09504bd96..4947f57748bc 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -231,7 +231,7 @@ static struct platform_device *sh770x_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh770x_early_devices,
+	sh_early_platform_add_devices(sh770x_early_devices,
 				   ARRAY_SIZE(sh770x_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7710.c b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
index c006c8fcfa0f..381910761579 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
@@ -178,7 +178,7 @@ static struct platform_device *sh7710_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7710_early_devices,
+	sh_early_platform_add_devices(sh7710_early_devices,
 				   ARRAY_SIZE(sh7710_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7720.c b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
index cf2eec9f6abd..425d067dae9b 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
@@ -212,7 +212,7 @@ static struct platform_device *sh7720_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7720_early_devices,
+	sh_early_platform_add_devices(sh7720_early_devices,
 				   ARRAY_SIZE(sh7720_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
index 2480ce4a3b1e..e6737f3d0df2 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
@@ -77,7 +77,7 @@ static struct platform_device *sh4202_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh4202_early_devices,
+	sh_early_platform_add_devices(sh4202_early_devices,
 				   ARRAY_SIZE(sh4202_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index 4592d660b942..19c8f1d69071 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -162,15 +162,15 @@ void __init plat_early_device_setup(void)
 	if (mach_is_rts7751r2d()) {
 		scif_platform_data.scscr |= SCSCR_CKE1;
 		dev[0] = &scif_device;
-		early_platform_add_devices(dev, 1);
+		sh_early_platform_add_devices(dev, 1);
 	} else {
 		dev[0] = &sci_device;
-		early_platform_add_devices(dev, 1);
+		sh_early_platform_add_devices(dev, 1);
 		dev[0] = &scif_device;
-		early_platform_add_devices(dev, 1);
+		sh_early_platform_add_devices(dev, 1);
 	}
 
-	early_platform_add_devices(sh7750_early_devices,
+	sh_early_platform_add_devices(sh7750_early_devices,
 				   ARRAY_SIZE(sh7750_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index e64eb96e3589..14212f5d803c 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -272,7 +272,7 @@ static struct platform_device *sh7760_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7760_early_devices,
+	sh_early_platform_add_devices(sh7760_early_devices,
 				   ARRAY_SIZE(sh7760_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
index 0fa56128bdca..b6015188fab1 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
@@ -297,7 +297,7 @@ static struct platform_device *sh7343_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7343_early_devices,
+	sh_early_platform_add_devices(sh7343_early_devices,
 				   ARRAY_SIZE(sh7343_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index 9f2f75285ec3..6676beef053e 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -241,7 +241,7 @@ static struct platform_device *sh7366_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7366_early_devices,
+	sh_early_platform_add_devices(sh7366_early_devices,
 				   ARRAY_SIZE(sh7366_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 8e5eaac789a7..0c6757ef63f4 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -513,7 +513,7 @@ static struct platform_device *sh7722_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7722_early_devices,
+	sh_early_platform_add_devices(sh7722_early_devices,
 				   ARRAY_SIZE(sh7722_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index b4b54aa0c267..83ae1ad4a86e 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -411,7 +411,7 @@ static struct platform_device *sh7723_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7723_early_devices,
+	sh_early_platform_add_devices(sh7723_early_devices,
 				   ARRAY_SIZE(sh7723_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index ec237ab112cf..0d990ab1ba2a 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -831,7 +831,7 @@ static struct platform_device *sh7724_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7724_early_devices,
+	sh_early_platform_add_devices(sh7724_early_devices,
 				   ARRAY_SIZE(sh7724_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index 7ea9a8b43955..9911da794358 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -281,7 +281,7 @@ static struct platform_device *sh7734_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7734_early_devices,
+	sh_early_platform_add_devices(sh7734_early_devices,
 		ARRAY_SIZE(sh7734_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 922d9886be18..67e330b7ea46 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -768,7 +768,7 @@ static struct platform_device *sh7757_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7757_early_devices,
+	sh_early_platform_add_devices(sh7757_early_devices,
 				   ARRAY_SIZE(sh7757_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index 8725d4751baf..b0608664785f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -222,7 +222,7 @@ static struct platform_device *sh7763_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7763_early_devices,
+	sh_early_platform_add_devices(sh7763_early_devices,
 				   ARRAY_SIZE(sh7763_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
index 035a0d4f2a2e..5efec6ceb04d 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
@@ -317,7 +317,7 @@ static struct platform_device *sh7770_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7770_early_devices,
+	sh_early_platform_add_devices(sh7770_early_devices,
 				   ARRAY_SIZE(sh7770_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index 983be87cb7be..c818b788ecb0 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -286,7 +286,7 @@ void __init plat_early_device_setup(void)
 		scif1_platform_data.scscr &= ~SCSCR_CKE1;
 	}
 
-	early_platform_add_devices(sh7780_early_devices,
+	sh_early_platform_add_devices(sh7780_early_devices,
 				   ARRAY_SIZE(sh7780_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index bb0cb710c16e..3b4a414d60a9 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -354,7 +354,7 @@ static struct platform_device *sh7785_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7785_early_devices,
+	sh_early_platform_add_devices(sh7785_early_devices,
 				   ARRAY_SIZE(sh7785_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index b5d94366eed3..4b0db8259e3d 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -835,6 +835,6 @@ arch_initcall(sh7786_devices_setup);
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7786_early_devices,
+	sh_early_platform_add_devices(sh7786_early_devices,
 				   ARRAY_SIZE(sh7786_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh4a/setup-shx3.c b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
index e82398d80b74..7014d6d199b3 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
@@ -153,7 +153,7 @@ arch_initcall(shx3_devices_setup);
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(shx3_early_devices,
+	sh_early_platform_add_devices(shx3_early_devices,
 				   ARRAY_SIZE(shx3_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh5/setup-sh5.c b/arch/sh/kernel/cpu/sh5/setup-sh5.c
index 584a6aeeca26..dc8476d67244 100644
--- a/arch/sh/kernel/cpu/sh5/setup-sh5.c
+++ b/arch/sh/kernel/cpu/sh5/setup-sh5.c
@@ -116,6 +116,6 @@ arch_initcall(sh5_devices_setup);
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh5_early_devices,
+	sh_early_platform_add_devices(sh5_early_devices,
 				   ARRAY_SIZE(sh5_early_devices));
 }
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index e535507851e1..914174a125a4 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -329,7 +329,7 @@ void __init setup_arch(char **cmdline_p)
 	sh_mv_setup();
 
 	/* Let earlyprintk output early console messages */
-	early_platform_driver_probe("earlyprintk", 1, 1);
+	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
 #ifdef CONFIG_OF_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index 8ad9fd5c4ff6..821a09cbd605 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -31,8 +31,8 @@ static void __init sh_late_time_init(void)
 	 * clocksource and the jiffies clocksource is used transparently
 	 * instead. No error handling is necessary here.
 	 */
-	early_platform_driver_register_all("earlytimer");
-	early_platform_driver_probe("earlytimer", 2, 0);
+	sh_early_platform_driver_register_all("earlytimer");
+	sh_early_platform_driver_probe("earlytimer", 2, 0);
 }
 
 void __init time_init(void)
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 3a185485300e..9cde50cb3220 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1056,7 +1056,7 @@ static int sh_cmt_probe(struct platform_device *pdev)
 	struct sh_cmt_device *cmt = platform_get_drvdata(pdev);
 	int ret;
 
-	if (!is_early_platform_device(pdev)) {
+	if (!is_sh_early_platform_device(pdev)) {
 		pm_runtime_set_active(&pdev->dev);
 		pm_runtime_enable(&pdev->dev);
 	}
@@ -1076,7 +1076,7 @@ static int sh_cmt_probe(struct platform_device *pdev)
 		pm_runtime_idle(&pdev->dev);
 		return ret;
 	}
-	if (is_early_platform_device(pdev))
+	if (is_sh_early_platform_device(pdev))
 		return 0;
 
  out:
@@ -1114,7 +1114,7 @@ static void __exit sh_cmt_exit(void)
 }
 
 #ifdef CONFIG_SUPERH
-early_platform_init("earlytimer", &sh_cmt_device_driver);
+sh_early_platform_init("earlytimer", &sh_cmt_device_driver);
 #endif
 
 subsys_initcall(sh_cmt_init);
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index d581060d33a2..c40eef091a04 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -446,7 +446,7 @@ static int sh_mtu2_probe(struct platform_device *pdev)
 	struct sh_mtu2_device *mtu = platform_get_drvdata(pdev);
 	int ret;
 
-	if (!is_early_platform_device(pdev)) {
+	if (!is_sh_early_platform_device(pdev)) {
 		pm_runtime_set_active(&pdev->dev);
 		pm_runtime_enable(&pdev->dev);
 	}
@@ -466,7 +466,7 @@ static int sh_mtu2_probe(struct platform_device *pdev)
 		pm_runtime_idle(&pdev->dev);
 		return ret;
 	}
-	if (is_early_platform_device(pdev))
+	if (is_sh_early_platform_device(pdev))
 		return 0;
 
  out:
@@ -516,7 +516,7 @@ static void __exit sh_mtu2_exit(void)
 }
 
 #ifdef CONFIG_SUPERH
-early_platform_init("earlytimer", &sh_mtu2_device_driver);
+sh_early_platform_init("earlytimer", &sh_mtu2_device_driver);
 #endif
 
 subsys_initcall(sh_mtu2_init);
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 50e30ead050e..d49690d15536 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -599,7 +599,7 @@ static int sh_tmu_probe(struct platform_device *pdev)
 	struct sh_tmu_device *tmu = platform_get_drvdata(pdev);
 	int ret;
 
-	if (!is_early_platform_device(pdev)) {
+	if (!is_sh_early_platform_device(pdev)) {
 		pm_runtime_set_active(&pdev->dev);
 		pm_runtime_enable(&pdev->dev);
 	}
@@ -620,7 +620,7 @@ static int sh_tmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (is_early_platform_device(pdev))
+	if (is_sh_early_platform_device(pdev))
 		return 0;
 
  out:
@@ -671,7 +671,7 @@ static void __exit sh_tmu_exit(void)
 }
 
 #ifdef CONFIG_SUPERH
-early_platform_init("earlytimer", &sh_tmu_device_driver);
+sh_early_platform_init("earlytimer", &sh_tmu_device_driver);
 #endif
 
 subsys_initcall(sh_tmu_init);
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 2a645fd7f07b..970f1f86b945 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3318,7 +3318,7 @@ static int sci_probe(struct platform_device *dev)
 	 * to make it beyond this yet.
 	 */
 #ifdef CONFIG_SUPERH
-	if (is_early_platform_device(dev))
+	if (is_sh_early_platform_device(dev))
 		return sci_probe_earlyprintk(dev);
 #endif
 
@@ -3416,7 +3416,7 @@ static void __exit sci_exit(void)
 }
 
 #if defined(CONFIG_SUPERH) && defined(CONFIG_SERIAL_SH_SCI_CONSOLE)
-early_platform_init_buffer("earlyprintk", &sci_driver,
+sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 85aa28a041a9..f086b6a1bc6b 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -332,7 +332,7 @@ extern int platform_dma_configure(struct device *dev);
  * drivers. It should go away once we introduce the new platform_device-based
  * early driver framework.
  */
-static inline int is_early_platform_device(struct platform_device *pdev)
+static inline int is_sh_early_platform_device(struct platform_device *pdev)
 {
 	return 0;
 }
-- 
2.23.0

