Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EDDC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53442217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzW1eVeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbfEXBBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:01:47 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:47032 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388780AbfEXBBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:01:44 -0400
Received: by mail-ua1-f73.google.com with SMTP id v25so1997169uaa.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 18:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P97dfBzpFswAlWiRxO0PqsO4yzuQcoq0aayONejphOk=;
        b=CzW1eVeUVATFZxkUrfaQ8DSWpI/ti8ZxYQrSQSZIgAwnZzcqvwuARJjn8QkNxe4wtv
         MXg0sm+gTiMKZFe/V0VQy2enPlPonzfVqnoRxYU5Rdigj5lSpo2TW3d35URIr49ZnmWy
         3xOjlrsZLOKeejpTDd3+yesXduG2t5CDi+dBeJK8yydy55Xmpq69Z0qUlq5BJfkdoOdr
         /G6cJt/SwXZM0pqiTKKHqTRdYBYs0LB4yQOHYvrWCudVGfYLu1M6hgwCg32aJRxoAz7a
         JxMbz96FMOSLoOpE5D1Gw7GT5CQZKqMXjR+zXySlSZ3R7Bos8kAIDvqvoGZ4TEPnyVqh
         yZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P97dfBzpFswAlWiRxO0PqsO4yzuQcoq0aayONejphOk=;
        b=UKhnU5K7q7mmPS8TRT4RcG2jrgObVC6zGn2oETAVAcSlPaJEYe1/I/Acwiai8Gi+bz
         wrSAHFthIOo9XDW8S0gLYNHFacfJBS0T7Hf00XwMpcC3fGgViX9ILUgzzZTNSD57K0+5
         EL+x5TugkI83QY88y+2oz4ZkAPq35phQ+Ksw1jv49gCpPPIuLvJa6Y/8+tBnENL/Ms2f
         OzEz9i8rCHOVbnXD7RZVA6b407C7XN3jQfkfeh+kWc6qaya/SnMWcHEehzirKotYIeM8
         FBIY7OfAbznvaZ/N+K5ppPGMAiWvGA35ZbTppJ0TpTQocUIcV0I6KwRyQjyuUt4V/TzD
         g2MQ==
X-Gm-Message-State: APjAAAULzWEEoh/Ww8S6TF4E1WyhfTkGfF3b2mmdKp6CR9dDDr9ynWw9
        BJz7Skh67U7jgmoxyFX3pU73pkZgPHtOb0A=
X-Google-Smtp-Source: APXvYqyz//p7JiVB6INTnvvIemgF7+zb9Kl8nhvMlqeWp1rZGdelnBaE19Sc8UOKfXKCcWkZ2KOx1VQFMYy5Ilk=
X-Received: by 2002:ab0:7150:: with SMTP id k16mr7045378uao.22.1558659703301;
 Thu, 23 May 2019 18:01:43 -0700 (PDT)
Date:   Thu, 23 May 2019 18:01:15 -0700
In-Reply-To: <20190524010117.225219-1-saravanak@google.com>
Message-Id: <20190524010117.225219-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v1 4/5] of/platform: Add functional dependency link from
 "depends-on" property
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

Add device-links after the devices are created (but before they are
probed) by looking at the "depends-on" DT property that allows
specifying mandatory functional dependencies between devices.

This property is used instead of existing DT properties that specify
phandles of other devices (Eg: clocks, pinctrl, regulators, etc). This
is because not all resources referred to by existing DT properties are
mandatory functional dependencies. Some devices/drivers might be able
to operate with reduced functionality when some of the resources
aren't available. For example, a device could operate in polling mode
if no IRQ is available, a device could skip doing power management if
clock or voltage control isn't available and they are left on, etc.

Automatically adding device-links for functional dependencies at the
framework level provides the following benefits:

- Optimizes device probe order and avoids the useless work of
  attempting probes of devices that will not probe successfully
  (because their suppliers aren't present or haven't probed yet).

  For example, in a commonly available mobile SoC, registering just one
  consumer device's driver at an initcall level earlier than the
  supplier device's driver causes 11 failed probe attempts before the
  consumer device probes successfully. This was with a kernel with all
  the drivers statically compiled in. This problem gets a lot worse if
  all the drivers are loaded as modules without direct symbol
  dependencies.

- Supplier devices like clock providers, regulators providers, etc
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
  count of the number of dependent consumers. Once all of the consumers
  are active, the suppliers can turn off the unused resources without
  making assumptions about the number of consumers.

By default we just add device-links to track "driver presence" (probe
succeeded) of the supplier device. If any other functionality provided
by device-links are needed, it is left to the consumer/supplier devices
to change the link when they probe.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 1115a8d80a33..da1aa52b310a 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -74,6 +74,45 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
 EXPORT_SYMBOL(of_find_device_by_node);
 
 #ifdef CONFIG_OF_ADDRESS
+static int of_link_to_suppliers(struct device *dev)
+{
+	struct device_node *sup_node;
+	struct platform_device *sup_dev;
+	unsigned int i = 0, links = 0;
+	u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+
+	if (unlikely(!dev->of_node))
+		return 0;
+
+	while ((sup_node = of_parse_phandle(dev->of_node, "depends-on", i))) {
+		i++;
+		sup_dev = of_find_device_by_node(sup_node);
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
@@ -205,11 +244,14 @@ static struct platform_device *of_platform_device_create_pdata(
 	dev->dev.platform_data = platform_data;
 	of_msi_configure(&dev->dev, dev->dev.of_node);
 
+	if (of_link_to_suppliers(&dev->dev))
+		device_link_wait_for_supplier(&dev->dev);
 	if (of_device_add(dev) != 0) {
 		platform_device_put(dev);
 		goto err_clear_flag;
 	}
 	np->dev = &dev->dev;
+	link_waiting_consumers_trigger();
 
 	return dev;
 
@@ -555,6 +597,10 @@ static int __init of_platform_default_populate_init(void)
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
2.22.0.rc1.257.g3120a18244-goog

