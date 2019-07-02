Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D197C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151BB21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TqcBQeW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfGBAsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:48:24 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:51256 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfGBAsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:48:23 -0400
Received: by mail-ua1-f73.google.com with SMTP id d5so2709338uaj.18
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 17:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jULzy6NXq0fcJd9RzDRERBL8Yt+QsIBTSSsohU/dA1c=;
        b=TqcBQeW/Mwi2wnF70DLEF0dXIjTE1jSvAit+iJMgCsuYoYkYMf5RwewMFEtb9T//OB
         0uMSEzhcUSnRAVVv9ooXjtPGPNKE8hE0V1v6l7F9bwuT9frpFTWDoIRLQS1lsgj37qYS
         C39C6zCWTKU0UHwK0S6yTqWNiCkiV+W9fnS4KM+cJmNmM95docKlCmtIdd+ykJ23vb2I
         FwKI46znxQ9nVJ48woS6YifsBxx9/RgbEmOOsJGjFIXyFr4GIrr4N0qS7qBN0mtQnYNt
         jRbwYSLG/PWL19aGt2DvAdEs3Y2XEu6N5wmziTBzNAwpjGCkltMCCuhjbq0NnRp4UBPU
         9Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jULzy6NXq0fcJd9RzDRERBL8Yt+QsIBTSSsohU/dA1c=;
        b=a1rxXqabQE08j9TEY/ffo5Rpwl30gQem9M2qkbZjqYyNZVPFQ+7rWiwED/X8AgEPLV
         tsY8FK4spSt58KfgEUq7WNynCWtrPCv8/vyeTUxfmpYN/U12fa7fnvva8TajcB3AJQJz
         SqzTyG+ZRSmw8yNjcdYGzaLtz8AfNEi6OBwlVpR/zgIk/B77edlBasKaDEtfInjfl4cK
         Sgacv0gbyuxRJNC5pYRHKan09w/j5LWHbIQNoI6tnFrLAk+r6S8rro0WHHnwjzS2Gmmn
         bhbZVO7h4V8UTdecoorZr1HgnXHlBZ3zmy0ERp7Qv7IszLUAeGzoH4UP46ahFC9AGgtV
         H+cw==
X-Gm-Message-State: APjAAAUIGTe5GqkKSwk299J/EK7FLfPpkppnWzXVQ4Iap7ry5mjXjPxp
        bW7KwQMogmXvFSVhbG4jgUZzGHyZ/xjmd8E=
X-Google-Smtp-Source: APXvYqzTqlfK5E8KQpTrYH92s9th4gVwCZod+ED4yFiRFX0vT+ILKMColSwiy8L/a7ZBwj6fa8UFbfo9rR+q+YM=
X-Received: by 2002:a1f:2b07:: with SMTP id r7mr9854857vkr.65.1562028502417;
 Mon, 01 Jul 2019 17:48:22 -0700 (PDT)
Date:   Mon,  1 Jul 2019 17:48:09 -0700
In-Reply-To: <20190702004811.136450-1-saravanak@google.com>
Message-Id: <20190702004811.136450-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190702004811.136450-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 2/4] of/platform: Add functional dependency link from DT bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-links after the devices are created (but before they are
probed) by looking at common DT bindings like clocks and
interconnects.

Automatically adding device-links for functional dependencies at the
framework level provides the following benefits:

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
 drivers/of/Kconfig    |  9 ++++++++
 drivers/of/platform.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

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
index 04ad312fd85b..a53717168aca 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -61,6 +61,57 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
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
 /*
  * The following routines scan a subtree and registers a device for
  * each applicable node.
@@ -524,6 +575,7 @@ static int __init of_platform_default_populate_init(void)
 	if (!of_have_populated_dt())
 		return -ENODEV;
 
+	platform_bus_type.add_links = of_link_to_suppliers;
 	/*
 	 * Handle certain compatibles explicitly, since we don't want to create
 	 * platform_devices for every node in /reserved-memory with a
-- 
2.22.0.410.gd8fdbe21b5-goog

