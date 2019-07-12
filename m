Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF9CC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27762217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jn0odGG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfGLXw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:52:59 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50352 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfGLXw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:52:57 -0400
Received: by mail-pf1-f201.google.com with SMTP id h27so6442096pfq.17
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eaQJVzKVYitsX+nBcXNXCgca4tYNoR3mi+s/+unfQdQ=;
        b=jn0odGG/oFt0js4DkYxZzkmmn6cZzljmylWA0Mx4zBCxeTFHUyc0WyKdJjFGAQ5q+G
         vr7sEMJJnVEK0J0cRgr+HDfLDKIGLg/C4Ve5+RY76PBISpPI/PEUE94cwuWBNwDCg4bf
         7dqQq6QfLYzuoFW1POXgFCuqwLBUiCkcLgf4fCZD0fOwhJx86tHh6Fjegunp+aIgERgF
         v869pQE2pDVdGwMXCqrXw0+BKE3KT3numFnjyH9wtQzzPHP8/5KQ8pnD4FatNjPRkqIq
         1/JqhH9Qs0ms0eeLTMxfhaoJUuKUZFhimZ7I5g6SjvrjLMB1vT7LSE0TwLLmITxQzXrm
         GwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eaQJVzKVYitsX+nBcXNXCgca4tYNoR3mi+s/+unfQdQ=;
        b=cDb7JtdMnUm0MqE+HdggSJEF0uV2O4O3X7tl3/ZEMu4jtPvhfIyqYO+RZYKIoJCD1F
         GHUf47oguofNOnyUbeycISVaL/RF1eclEP0Ewq55U41aQxV2PvYOgZ+DCf+5gpjxpXCB
         SGOQjCa8IrLU9cn/PlesD7tQXX7HbSzCYNRj0bxY1dwQtAejEI9KSRAlW3W9JPhWjDg9
         3wsttCG/e7eohzNeWiLMG5otLDqPwZcOkeJdXxXwNAVi2s3JpRhg5C4GGhC2vUI1T2f4
         fxa4Ba2ahkUe4Ra4sAExPgqxJm9AM6RcpRnL8hWtVEygY60pR+8Yry96gvPHFWYBXybI
         DZhA==
X-Gm-Message-State: APjAAAVThzpwtyCTS2jKzKT45pyUmAwUC/lCleBAN0FqHyAVkFOXcPqN
        B8Ws9pu/YBhswXI9euy0XCK4+gJEGdlErNU=
X-Google-Smtp-Source: APXvYqzcXhm6MzlfeEhmVbdJbUNlik4cYgtPgDKR9xS8FKJtjyANKiCJSi1hR/+Yc/CQmA+WYZUOX2t9DTqHx3Q=
X-Received: by 2002:a63:1e0b:: with SMTP id e11mr13111041pge.402.1562975575788;
 Fri, 12 Jul 2019 16:52:55 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:52:35 -0700
In-Reply-To: <20190712235245.202558-1-saravanak@google.com>
Message-Id: <20190712235245.202558-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v5 02/11] of/platform: Add functional dependency link from DT bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com, linux-doc@vger.kernel.org
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
 .../admin-guide/kernel-parameters.txt         |  5 ++
 drivers/of/platform.c                         | 57 +++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 138f6664b2e2..109b4310844f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3141,6 +3141,11 @@
 			This can be set from sysctl after boot.
 			See Documentation/sysctl/vm.txt for details.
 
+	of_devlink	[KNL] Make device links from common DT bindings. Useful
+			for optimizing probe order and making sure resources
+			aren't turned off before the consumer devices have
+			probed.
+
 	ohci1394_dma=early	[HW] enable debugging via the ohci1394 driver.
 			See Documentation/debugging-via-ohci1394.txt for more
 			info.
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 04ad312fd85b..0930f9f89571 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -509,6 +509,62 @@ int of_platform_default_populate(struct device_node *root,
 }
 EXPORT_SYMBOL_GPL(of_platform_default_populate);
 
+static int of_link_binding(struct device *dev,
+			   const char *binding, const char *cell)
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
+		of_node_put(sup_args.np);
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
+static bool of_devlink;
+core_param(of_devlink, of_devlink, bool, 0);
+
+/*
+ * List of bindings and their cell names (use NULL if no cell names) from which
+ * device links need to be created.
+ */
+static const char * const link_bindings[] = {
+	"clocks", "#clock-cells",
+	"interconnects", "#interconnect-cells",
+};
+
+static int of_link_to_suppliers(struct device *dev)
+{
+	unsigned int i = 0;
+	bool done = true;
+
+	if (!of_devlink)
+		return 0;
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
 #ifndef CONFIG_PPC
 static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "qcom,rmtfs-mem" },
@@ -524,6 +580,7 @@ static int __init of_platform_default_populate_init(void)
 	if (!of_have_populated_dt())
 		return -ENODEV;
 
+	platform_bus_type.add_links = of_link_to_suppliers;
 	/*
 	 * Handle certain compatibles explicitly, since we don't want to create
 	 * platform_devices for every node in /reserved-memory with a
-- 
2.22.0.510.g264f2c817a-goog

