Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2CDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8521F20665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhZ7jvJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfF1CWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:22:17 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:39712 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfF1CWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:22:16 -0400
Received: by mail-qt1-f202.google.com with SMTP id o16so4516170qtj.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uW4z5E2QWEUvcAA+ttibS+EnG86XvIu/bb2yFtcFDZo=;
        b=fhZ7jvJGww51yiHKa4XQkuAzrDgt/7jIVmmA1gOleiQRibEqH8IGjSm9NmMevnLZsE
         ZAmlk9KFSRao8Wgfa/1E/z7tbuqMIJMOMKOb58KPZ73kCnVE6FgGsVmPcozQXzVjwIa2
         eFqmTvE9jlZ0a06ldDa7AU9fxvhsvY0ASPHEj7qME0eaoqhUTVsiUsQIZ0YfhLhykN4y
         sZd3nOPrMqYY7jgFm2Lkr9IvL4L39qGGBqwjb1bWxMOGUM7o/M6CAUwRBeOvxnatHHPV
         8qMJgJMAyAtvCa978qF8vpiWIZiWlHzz7I3eyXejVya/QzG1TtrZYlN7kq+9fQk2W+4E
         t9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uW4z5E2QWEUvcAA+ttibS+EnG86XvIu/bb2yFtcFDZo=;
        b=HvLENfip6VeaYGkcHX1lsP/LkqiQfcMgHksyLJbtkRY+6Q6ASnkf/XQWqT0qGcrkaO
         uHOWR0NIeKAUkoV3qh/NvHjc8b4WmsogVQ68/Rk8+IjctrlglIZsNvWIq0RzJ8JrDj0N
         T7DxSyELqWhteEWqBlnCrVtuTkCumAH7Ou2unNvkrfLg7DfkUUQHmpxTQFXGGv6XPmhh
         ShfLcGnouIviIOmxuDgYwY2ukldMySCcP6/wgsB40uqvrJDcCJKk444qUwr7Xk3gvdf2
         Y+p3rMrmUZs+OA2vAQrppYPQWM4LJ/aWeiY7VP1qunFl0iXQYfLcGd8AZE0hQ79MUH3f
         8dzg==
X-Gm-Message-State: APjAAAXXWHWMJbCYEHNx/BfZsftztjCfkDHMtAS0rIkKRM5HHdgUs9lq
        rBDpjliTZwVbW8jIqSpcCj6NYiaRiPyotO4=
X-Google-Smtp-Source: APXvYqwMexIDFk042fXKB0tv0oaWlAVRaEljJLWVilGJC7PpAHphbeDZt6FoMNa0kJ+SmK4OLjrdpRTdYixZ0gM=
X-Received: by 2002:a05:620a:1393:: with SMTP id k19mr6287665qki.67.1561688534784;
 Thu, 27 Jun 2019 19:22:14 -0700 (PDT)
Date:   Thu, 27 Jun 2019 19:22:01 -0700
In-Reply-To: <20190628022202.118166-1-saravanak@google.com>
Message-Id: <20190628022202.118166-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190628022202.118166-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 2/3] of/platform: Add functional dependency link from DT bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-links to track functional dependencies between devices
after they are created (but before they are probed) by looking at
their common DT bindings like clocks, interconnects, etc.

Automatically adding device-links to track functional dependencies at
the framework level provides the following benefits:

- Optimizes device probe order and avoids the useless work of
  attempting probes of devices that will not probe successfully
  (because their suppliers aren't present or haven't probed yet).

  For example, in a commonly available mobile SoC, registering just
  one consumer device's driver at an initcall level earlier than the
  supplier device's driver causes 11 failed probe attempts before the
  consumer device probes successfully. This was with a kernel with all
  the drivers statically compiled in. This problem gets a lot worse if
  all the drivers are loaded as modules without direct symbol
  dependencies.

- Supplier devices like clock providers, interconnect providers, etc
  need to keep the resources they provide active and at a particular
  state(s) during boot up even if their current set of consumers don't
  request the resource to be active. This is because the rest of the
  consumers might not have probed yet and turning off the resource
  before all the consumers have probed could lead to a hang or
  undesired user experience.

  Some frameworks (Eg: regulator) handle this today by turning off
  "unused" resources at late_initcall_sync and hoping all the devices
  have probed by then. This is not a valid assumption for systems with
  loadable modules. Other frameworks (Eg: clock) just don't handle
  this due to the lack of a clear signal for when they can turn off
  resources. This leads to downstream hacks to handle cases like this
  that can easily be solved in the upstream kernel.

  By linking devices before they are probed, we give suppliers a clear
  count of the number of dependent consumers. Once all of the
  consumers are active, the suppliers can turn off the unused
  resources without making assumptions about the number of consumers.

By default we just add device-links to track "driver presence" (probe
succeeded) of the supplier device. If any other functionality provided
by device-links are needed, it is left to the consumer/supplier
devices to change the link when they probe.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/Kconfig    |  9 ++++++
 drivers/of/platform.c | 73 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 37c2ccbefecd..7c7fa7394b4c 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -103,4 +103,13 @@ config OF_OVERLAY
 config OF_NUMA
 	bool
 
+config OF_DEVLINKS
+	bool "Device links from DT bindings"
+	help
+	  Common DT bindings like clocks, interconnects, etc represent a
+	  consumer device's dependency on suppliers devices. This option
+	  creates device links from these common bindings so that consumers are
+	  probed only after all their suppliers are active and suppliers can
+	  tell when all their consumers are active.
+
 endif # OF
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 04ad312fd85b..8d690fa0f47c 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -61,6 +61,72 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
 EXPORT_SYMBOL(of_find_device_by_node);
 
 #ifdef CONFIG_OF_ADDRESS
+static int of_link_binding(struct device *dev, char *binding, char *cell)
+{
+	struct of_phandle_args sup_args;
+	struct platform_device *sup_dev;
+	unsigned int i = 0, links = 0;
+	u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+
+	while (!of_parse_phandle_with_args(dev->of_node, binding, cell, i,
+					   &sup_args)) {
+		i++;
+		sup_dev = of_find_device_by_node(sup_args.np);
+		if (!sup_dev)
+			continue;
+		if (device_link_add(dev, &sup_dev->dev, dl_flags))
+			links++;
+		put_device(&sup_dev->dev);
+	}
+	if (links < i)
+		return -ENODEV;
+	return 0;
+}
+
+/*
+ * List of bindings and their cell names (use NULL if no cell names) from which
+ * device links need to be created.
+ */
+static char *link_bindings[] = {
+#ifdef CONFIG_OF_DEVLINKS
+	"clocks", "#clock-cells",
+	"interconnects", "#interconnect-cells",
+#endif
+};
+
+static int of_link_to_suppliers(struct device *dev)
+{
+	unsigned int i = 0;
+	bool done = true;
+
+	if (unlikely(!dev->of_node))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(link_bindings) / 2; i++)
+		if (of_link_binding(dev, link_bindings[i * 2],
+					link_bindings[i * 2 + 1]))
+			done = false;
+
+	if (!done)
+		return -ENODEV;
+	return 0;
+}
+
+static void link_waiting_consumers_func(struct work_struct *work)
+{
+	device_link_check_waiting_consumers(of_link_to_suppliers);
+}
+static DECLARE_WORK(link_waiting_consumers_work, link_waiting_consumers_func);
+
+static bool link_waiting_consumers_enable;
+static void link_waiting_consumers_trigger(void)
+{
+	if (!link_waiting_consumers_enable)
+		return;
+
+	schedule_work(&link_waiting_consumers_work);
+}
+
 /*
  * The following routines scan a subtree and registers a device for
  * each applicable node.
@@ -192,10 +258,13 @@ static struct platform_device *of_platform_device_create_pdata(
 	dev->dev.platform_data = platform_data;
 	of_msi_configure(&dev->dev, dev->dev.of_node);
 
+	if (of_link_to_suppliers(&dev->dev))
+		device_link_wait_for_supplier(&dev->dev);
 	if (of_device_add(dev) != 0) {
 		platform_device_put(dev);
 		goto err_clear_flag;
 	}
+	link_waiting_consumers_trigger();
 
 	return dev;
 
@@ -541,6 +610,10 @@ static int __init of_platform_default_populate_init(void)
 	/* Populate everything else. */
 	of_platform_default_populate(NULL, NULL, NULL);
 
+	/* Make the device-links between suppliers and consumers */
+	link_waiting_consumers_enable = true;
+	device_link_check_waiting_consumers(of_link_to_suppliers);
+
 	return 0;
 }
 arch_initcall_sync(of_platform_default_populate_init);
-- 
2.22.0.410.gd8fdbe21b5-goog

