Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8A7C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC3D222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfJEVEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 17:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfJEVEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 17:04:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 670F610C0937;
        Sat,  5 Oct 2019 21:04:54 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-21.ams2.redhat.com [10.36.116.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0153F5D70D;
        Sat,  5 Oct 2019 21:04:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] driver core: platform: Add platform_get_irq_byname_optional()
Date:   Sat,  5 Oct 2019 23:04:47 +0200
Message-Id: <20191005210449.3926-2-hdegoede@redhat.com>
In-Reply-To: <20191005210449.3926-1-hdegoede@redhat.com>
References: <20191005210449.3926-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Sat, 05 Oct 2019 21:04:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers (e.g dwc3) first try to get an IRQ byname and then fall
back to the one at index 0. In this case we do not want the error(s)
printed by platform_get_irq_byname(). This commit adds a new
platform_get_irq_byname_optional(), which does not print errors, for this.

While at it also improve the kdoc text for platform_get_irq_byname() a bit.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205037
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/base/platform.c         | 46 ++++++++++++++++++++++++++++-----
 include/linux/platform_device.h |  2 ++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b6c6c7d97d5b..b230beb6ccb4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -241,12 +241,8 @@ struct resource *platform_get_resource_byname(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource_byname);
 
-/**
- * platform_get_irq_byname - get an IRQ for a device by name
- * @dev: platform device
- * @name: IRQ name
- */
-int platform_get_irq_byname(struct platform_device *dev, const char *name)
+static int __platform_get_irq_byname(struct platform_device *dev,
+				     const char *name)
 {
 	struct resource *r;
 
@@ -262,11 +258,47 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
 	if (r)
 		return r->start;
 
-	dev_err(&dev->dev, "IRQ %s not found\n", name);
 	return -ENXIO;
 }
+
+/**
+ * platform_get_irq_byname - get an IRQ for a device by name
+ * @dev: platform device
+ * @name: IRQ name
+ *
+ * Get an IRQ like platform_get_irq(), but then by name rather then by index.
+ *
+ * Return: IRQ number on success, negative error number on failure.
+ */
+int platform_get_irq_byname(struct platform_device *dev, const char *name)
+{
+	int ret;
+
+	ret = __platform_get_irq_byname(dev, name);
+	if (ret < 0 && ret != -EPROBE_DEFER)
+		dev_err(&dev->dev, "IRQ %s not found\n", name);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(platform_get_irq_byname);
 
+/**
+ * platform_get_irq_byname_optional - get an optional IRQ for a device by name
+ * @dev: platform device
+ * @name: IRQ name
+ *
+ * Get an optional IRQ by name like platform_get_irq_byname(). Except that it
+ * does not print an error message if an IRQ can not be obtained.
+ *
+ * Return: IRQ number on success, negative error number on failure.
+ */
+int platform_get_irq_byname_optional(struct platform_device *dev,
+				     const char *name)
+{
+	return __platform_get_irq_byname(dev, name);
+}
+EXPORT_SYMBOL_GPL(platform_get_irq_byname_optional);
+
 /**
  * platform_add_devices - add a numbers of platform devices
  * @devs: array of platform devices to add
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 1b5cec067533..f2688404d1cd 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -64,6 +64,8 @@ extern struct resource *platform_get_resource_byname(struct platform_device *,
 						     unsigned int,
 						     const char *);
 extern int platform_get_irq_byname(struct platform_device *, const char *);
+extern int platform_get_irq_byname_optional(struct platform_device *dev,
+					    const char *name);
 extern int platform_add_devices(struct platform_device **, int);
 
 struct platform_device_info {
-- 
2.23.0

