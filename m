Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B3CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEAA2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N34QL3Et"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfGXALS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:11:18 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:34690 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfGXALQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:11:16 -0400
Received: by mail-vs1-f74.google.com with SMTP id x22so11884905vsj.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=98OUdn+pluVNmpQHs0/5FBBUDYzwIohCNhKsPgXVGmw=;
        b=N34QL3EtPk26kjAtA0NHSi6z9ap3u0oUAKGPBafJkZBfyiSM67Pog6vi6pSs5F1VjZ
         vUdHfFxkgYxKi1u7wQ+vLNBC57nGmYUdXJLDI2RZEqtIUQzdSO/7jTzcfHu0WN3p62xe
         qkRCPIj18BA5/qG/1GaEz/eL7Hlh0BToVryJ9UcTbzO1dynMCnpWf9JtHUutUiWuebXU
         qpU5gmo9PmDrmVLiU4Kf6kyj4O1sFzcVCpoDcAc9dByDMglAFzVzXJsXNlCRiQDMomdg
         TWvX1U2yGAoGC+xV7t5kKHCIqeHtr+nJUNl0a1c/nuGNmuC6nejzX5t5mkQKE/MJ3aTZ
         sz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=98OUdn+pluVNmpQHs0/5FBBUDYzwIohCNhKsPgXVGmw=;
        b=g5/QYNy/lCl0GzuWpGJUNwKIGR/fVwJx5dK+BRqGF042eNTkEJejbW8stegrJoEGkU
         Gw2hdtLnPwZSQbU3GlImigHsPOEh3lJ/63mdZJMMaJvL0843kmuwamzQB5XU50snHMpT
         uI3cTaXnqRFAv2eYkGMijTUr70JibVtDfopPzOsVLlhgGrYCDrOyL9Ei78rr9/Bk3kGr
         AxcwqRxAP6K7ZvT+SLWXoAm51n+own/XIYzaIZsEi+rrXYFthH/rg6rFNCgnImU4M3in
         BCIsNL1TiDqD5OFw8xJPr8mwDZax/99IezGvnUSX31A4sksFBa7LQ+iGj17CQU148QSZ
         e3Jw==
X-Gm-Message-State: APjAAAVNTDTzH7kvgTSFY2wAz1WmwAl6fimcBubJARYTukCKTv+cLCWh
        U0KuE8Fs6Bl2E4o/lNbapaHdMjnVEPB3So4=
X-Google-Smtp-Source: APXvYqzqjZnSq0YhGm6eldLeXF03o9zbaCWZcq8S+is3OD6Wx0MhT6EgjHljJFZ/I3hTUcA+Dunr0wyR7eG8kGw=
X-Received: by 2002:ab0:20cc:: with SMTP id z12mr16983879ual.32.1563927074834;
 Tue, 23 Jul 2019 17:11:14 -0700 (PDT)
Date:   Tue, 23 Jul 2019 17:10:56 -0700
In-Reply-To: <20190724001100.133423-1-saravanak@google.com>
Message-Id: <20190724001100.133423-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190724001100.133423-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v7 3/7] of/platform: Add functional dependency link from DT bindings
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
 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/of/platform.c                         | 165 ++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 46b826fcb5ad..12937349d79d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3170,6 +3170,11 @@
 			This can be set from sysctl after boot.
 			See Documentation/admin-guide/sysctl/vm.rst for details.
 
+	of_devlink	[KNL] Make device links from common DT bindings. Useful
+			for optimizing probe order and making sure resources
+			aren't turned off before the consumer devices have
+			probed.
+
 	ohci1394_dma=early	[HW] enable debugging via the ohci1394 driver.
 			See Documentation/debugging-via-ohci1394.txt for more
 			info.
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 7801e25e6895..4344419a26fc 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -508,6 +508,170 @@ int of_platform_default_populate(struct device_node *root,
 }
 EXPORT_SYMBOL_GPL(of_platform_default_populate);
 
+bool of_link_is_valid(struct device_node *con, struct device_node *sup)
+{
+	of_node_get(sup);
+	/*
+	 * Don't allow linking a device node as a consumer of one of its
+	 * descendant nodes. By definition, a child node can't be a functional
+	 * dependency for the parent node.
+	 */
+	while (sup) {
+		if (sup == con) {
+			of_node_put(sup);
+			return false;
+		}
+		sup = of_get_next_parent(sup);
+	}
+	return true;
+}
+
+static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
+{
+	struct platform_device *sup_dev;
+	u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+	int ret = 0;
+
+	/*
+	 * Since we are trying to create device links, we need to find
+	 * the actual device node that owns this supplier phandle.
+	 * Often times it's the same node, but sometimes it can be one
+	 * of the parents. So walk up the parent till you find a
+	 * device.
+	 */
+	while (sup_np && !of_find_property(sup_np, "compatible", NULL))
+		sup_np = of_get_next_parent(sup_np);
+	if (!sup_np)
+		return 0;
+
+	if (!of_link_is_valid(dev->of_node, sup_np)) {
+		of_node_put(sup_np);
+		return 0;
+	}
+	sup_dev = of_find_device_by_node(sup_np);
+	of_node_put(sup_np);
+	if (!sup_dev)
+		return -ENODEV;
+	if (!device_link_add(dev, &sup_dev->dev, dl_flags))
+		ret = -ENODEV;
+	put_device(&sup_dev->dev);
+	return ret;
+}
+
+static struct device_node *parse_prop_cells(struct device_node *np,
+					    const char *prop, int index,
+					    const char *binding,
+					    const char *cell)
+{
+	struct of_phandle_args sup_args;
+
+	/* Don't need to check property name for every index. */
+	if (!index && strcmp(prop, binding))
+		return NULL;
+
+	if (of_parse_phandle_with_args(np, binding, cell, index, &sup_args))
+		return NULL;
+
+	return sup_args.np;
+}
+
+static struct device_node *parse_clocks(struct device_node *np,
+					const char *prop, int index)
+{
+	return parse_prop_cells(np, prop, index, "clocks", "#clock-cells");
+}
+
+static struct device_node *parse_interconnects(struct device_node *np,
+					       const char *prop, int index)
+{
+	return parse_prop_cells(np, prop, index, "interconnects",
+				"#interconnect-cells");
+}
+
+static int strcmp_suffix(const char *str, const char *suffix)
+{
+	unsigned int len, suffix_len;
+
+	len = strlen(str);
+	suffix_len = strlen(suffix);
+	if (len <= suffix_len)
+		return -1;
+	return strcmp(str + len - suffix_len, suffix);
+}
+
+static struct device_node *parse_regulators(struct device_node *np,
+					    const char *prop, int index)
+{
+	if (index || strcmp_suffix(prop, "-supply"))
+		return NULL;
+
+	return of_parse_phandle(np, prop, 0);
+}
+
+/**
+ * struct supplier_bindings - Information for parsing supplier DT binding
+ *
+ * @parse_prop:		If the function cannot parse the property, return NULL.
+ *			Otherwise, return the phandle listed in the property
+ *			that corresponds to the index.
+ */
+struct supplier_bindings {
+	struct device_node *(*parse_prop)(struct device_node *np,
+					  const char *name, int index);
+};
+
+static const struct supplier_bindings bindings[] = {
+	{ .parse_prop = parse_clocks, },
+	{ .parse_prop = parse_interconnects, },
+	{ .parse_prop = parse_regulators, },
+	{ },
+};
+
+static bool of_link_property(struct device *dev, struct device_node *con_np,
+			     const char *prop)
+{
+	struct device_node *phandle;
+	struct supplier_bindings *s = bindings;
+	unsigned int i = 0;
+	bool done = true, matched = false;
+
+	while (!matched && s->parse_prop) {
+		while ((phandle = s->parse_prop(con_np, prop, i))) {
+			matched = true;
+			i++;
+			if (of_link_to_phandle(dev, phandle))
+				/*
+				 * Don't stop at the first failure. See
+				 * Documentation for bus_type.add_links for
+				 * more details.
+				 */
+				done = false;
+		}
+		s++;
+	}
+	return done ? 0 : -ENODEV;
+}
+
+static bool of_devlink;
+core_param(of_devlink, of_devlink, bool, 0);
+
+static int of_link_to_suppliers(struct device *dev)
+{
+	struct property *p;
+	bool done = true;
+
+	if (!of_devlink)
+		return 0;
+	if (unlikely(!dev->of_node))
+		return 0;
+
+	for_each_property_of_node(dev->of_node, p)
+		if (of_link_property(dev, dev->of_node, p->name))
+			done = false;
+
+	return done ? 0 : -ENODEV;
+}
+
 #ifndef CONFIG_PPC
 static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "qcom,rmtfs-mem" },
@@ -523,6 +687,7 @@ static int __init of_platform_default_populate_init(void)
 	if (!of_have_populated_dt())
 		return -ENODEV;
 
+	platform_bus_type.add_links = of_link_to_suppliers;
 	/*
 	 * Handle certain compatibles explicitly, since we don't want to create
 	 * platform_devices for every node in /reserved-memory with a
-- 
2.22.0.709.g102302147b-goog

