Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A426C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BE620880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPga+VFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfDPWNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:13:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43405 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfDPWNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:13:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id u15so18976069otq.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 15:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=++JuYrY4aGlXaxg8i0H6LdoBIIR70Dii6585qdh5fcA=;
        b=OPga+VFE0XS84FvEFutL08MwYwo1W/CJXdCYjuGTUbCA+Zt/qM5Ka268e5eUJZQ3mD
         BTjkAe75X3BIPZgOW4mGYe7cawRJMX4nppF8k801KzTjVwRswuJvOhe9j6Z7WDqXCv7X
         7FbBP1HEDQkCgF9QngI1+6WyQBda9IWEGBpaOTYGoBfkeV/nhOLiQK6ZdTcZe67DI79D
         /Jk+HFjc3CobbaSlz/zy56E942kWElY2GvStQHMLt+pEILtcBDGRIj8d1Z7yrp92jaYw
         tasXgVk75awB9qI7c6a5u6gubMyvAxkXIKYRTfFp7ebGtR4gBMbDQBJXv6GL0T2+4Gfj
         ORWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=++JuYrY4aGlXaxg8i0H6LdoBIIR70Dii6585qdh5fcA=;
        b=icFo1gjXtbQSfwm7rd6YzkbGYEy4wBNR76lTIDOXdErfXABbNI+xo5sIzrepi3yedJ
         wLcNhdNiv/eJef2cOvFg+UIwSthKrmuFFz9C5dsV3PV5lE+E4R02xmbKpSZlkdo4NML5
         sXDf1t+Xh614Y55WlRZN0m6zMboGJrG59cnpDHV4+X4LLMQAX/If+ljvTxhtkzSKCeL+
         r16Iy6c1+pWpY5bTP85uTSa3PLGdhLD9mJYLW52ksXz29moxSO/hnOqLo7s+HnTBHWv+
         kClz7SWouKXUvE6T+x/jMLtl7/FUTC3IVVmJrG7cQqGtqrtoSBnZnhGDs34Ifn7HmMJD
         J0lg==
X-Gm-Message-State: APjAAAXUCHaC3NiO/RhqkzYF1ReYlXM8L6XHd4f349yfm3y5LKotubt4
        Fob3+FSEGAX6BxMtQeeXvN5SjjygiO8qCQ==
X-Google-Smtp-Source: APXvYqyMl+C4F7QLnmHeKYYjCKcJIDdp56tXvtYvHemNFumRHtjPRMabbpTZ05gscj6I994xMoR7Uw==
X-Received: by 2002:a9d:7f90:: with SMTP id t16mr55175462otp.9.1555452802667;
        Tue, 16 Apr 2019 15:13:22 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:cc4c:ef29:9735:1b8b])
        by smtp.gmail.com with ESMTPSA id m124sm21894520oia.3.2019.04.16.15.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 15:13:21 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH v2] Staging: greybus: Cleanup in greybus driver
Date:   Tue, 16 Apr 2019 17:13:18 -0500
Message-Id: <20190416221318.21161-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a blank line after structure declarations. Also, convert
macros into inline functions in order to maintain Linux kernel
coding style based on which the inline function is
preferable over the macro.

Blank line fixes are suggested by checkpatch.pl

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>

Changes in v2:
- To maintain consistency in driver greybus, all the instances of macro
with container_of are fixed in a single patch.
---
 drivers/staging/greybus/bundle.h    |  6 +++++-
 drivers/staging/greybus/control.h   |  6 +++++-
 drivers/staging/greybus/gbphy.h     | 12 ++++++++++--
 drivers/staging/greybus/greybus.h   |  6 +++++-
 drivers/staging/greybus/hd.h        |  6 +++++-
 drivers/staging/greybus/interface.h |  6 +++++-
 drivers/staging/greybus/module.h    |  6 +++++-
 drivers/staging/greybus/svc.h       |  6 +++++-
 8 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/greybus/bundle.h b/drivers/staging/greybus/bundle.h
index 8734d2055657..84956eedb1c4 100644
--- a/drivers/staging/greybus/bundle.h
+++ b/drivers/staging/greybus/bundle.h
@@ -31,7 +31,11 @@ struct gb_bundle {
 
 	struct list_head	links;	/* interface->bundles */
 };
-#define to_gb_bundle(d) container_of(d, struct gb_bundle, dev)
+
+static inline struct gb_bundle *to_gb_bundle(struct device *d)
+{
+	return container_of(d, struct gb_bundle, dev);
+}
 
 /* Greybus "private" definitions" */
 struct gb_bundle *gb_bundle_create(struct gb_interface *intf, u8 bundle_id,
diff --git a/drivers/staging/greybus/control.h b/drivers/staging/greybus/control.h
index 3a29ec05f631..a681ef74e7fe 100644
--- a/drivers/staging/greybus/control.h
+++ b/drivers/staging/greybus/control.h
@@ -24,7 +24,11 @@ struct gb_control {
 	char *vendor_string;
 	char *product_string;
 };
-#define to_gb_control(d) container_of(d, struct gb_control, dev)
+
+static inline struct gb_control *to_gb_control(struct device *d)
+{
+	return container_of(d, struct gb_control, dev);
+}
 
 struct gb_control *gb_control_create(struct gb_interface *intf);
 int gb_control_enable(struct gb_control *control);
diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
index 99463489d7d6..20307f6dfcb9 100644
--- a/drivers/staging/greybus/gbphy.h
+++ b/drivers/staging/greybus/gbphy.h
@@ -15,7 +15,11 @@ struct gbphy_device {
 	struct list_head list;
 	struct device dev;
 };
-#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
+
+static inline struct gbphy_device *to_gbphy_dev(struct device *d)
+{
+	return container_of(d, struct gbphy_device, dev);
+}
 
 static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
 {
@@ -43,7 +47,11 @@ struct gbphy_driver {
 
 	struct device_driver driver;
 };
-#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
+
+static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
+{
+	return container_of(d, struct gbphy_driver, driver);
+}
 
 int gb_gbphy_register_driver(struct gbphy_driver *driver,
 			     struct module *owner, const char *mod_name);
diff --git a/drivers/staging/greybus/greybus.h b/drivers/staging/greybus/greybus.h
index d03ddb7c9df0..a82d5002b4d5 100644
--- a/drivers/staging/greybus/greybus.h
+++ b/drivers/staging/greybus/greybus.h
@@ -64,7 +64,11 @@ struct greybus_driver {
 
 	struct device_driver driver;
 };
-#define to_greybus_driver(d) container_of(d, struct greybus_driver, driver)
+
+static inline struct greybus_driver *to_greybus_driver(struct device_driver *d)
+{
+	return container_of(d, struct greybus_driver, driver);
+}
 
 static inline void greybus_set_drvdata(struct gb_bundle *bundle, void *data)
 {
diff --git a/drivers/staging/greybus/hd.h b/drivers/staging/greybus/hd.h
index 6cf024a20a58..de7c49d05266 100644
--- a/drivers/staging/greybus/hd.h
+++ b/drivers/staging/greybus/hd.h
@@ -57,7 +57,11 @@ struct gb_host_device {
 	/* Private data for the host driver */
 	unsigned long hd_priv[0] __aligned(sizeof(s64));
 };
-#define to_gb_host_device(d) container_of(d, struct gb_host_device, dev)
+
+static inline struct gb_host_device *to_gb_host_device(struct device *d)
+{
+	return container_of(d, struct gb_host_device, dev);
+}
 
 int gb_hd_cport_reserve(struct gb_host_device *hd, u16 cport_id);
 void gb_hd_cport_release_reserved(struct gb_host_device *hd, u16 cport_id);
diff --git a/drivers/staging/greybus/interface.h b/drivers/staging/greybus/interface.h
index 1c00c5bb3ec9..f86c0d596dbe 100644
--- a/drivers/staging/greybus/interface.h
+++ b/drivers/staging/greybus/interface.h
@@ -63,7 +63,11 @@ struct gb_interface {
 	struct work_struct mode_switch_work;
 	struct completion mode_switch_completion;
 };
-#define to_gb_interface(d) container_of(d, struct gb_interface, dev)
+
+static inline struct gb_interface *to_gb_interface(struct device *d)
+{
+	return container_of(d, struct gb_interface, dev);
+}
 
 struct gb_interface *gb_interface_create(struct gb_module *module,
 					 u8 interface_id);
diff --git a/drivers/staging/greybus/module.h b/drivers/staging/greybus/module.h
index b1ebcc6636db..c427b788b677 100644
--- a/drivers/staging/greybus/module.h
+++ b/drivers/staging/greybus/module.h
@@ -22,7 +22,11 @@ struct gb_module {
 
 	struct gb_interface *interfaces[0];
 };
-#define to_gb_module(d) container_of(d, struct gb_module, dev)
+
+static inline struct gb_module *to_gb_module(struct device *d)
+{
+	return container_of(d, struct gb_module, dev);
+}
 
 struct gb_module *gb_module_create(struct gb_host_device *hd, u8 module_id,
 				   size_t num_interfaces);
diff --git a/drivers/staging/greybus/svc.h b/drivers/staging/greybus/svc.h
index ad01783bac9c..4e35ac9ed0ff 100644
--- a/drivers/staging/greybus/svc.h
+++ b/drivers/staging/greybus/svc.h
@@ -52,7 +52,11 @@ struct gb_svc {
 	struct dentry *debugfs_dentry;
 	struct svc_debugfs_pwrmon_rail *pwrmon_rails;
 };
-#define to_gb_svc(d) container_of(d, struct gb_svc, dev)
+
+static inline struct gb_svc *to_gb_svc(struct device *d)
+{
+	return container_of(d, struct gb_svc, dev);
+}
 
 struct gb_svc *gb_svc_create(struct gb_host_device *hd);
 int gb_svc_add(struct gb_svc *svc);
-- 
2.17.1

