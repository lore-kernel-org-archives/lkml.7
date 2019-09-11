Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D5DECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5E6222BF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge/EeQoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfIKFNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:13:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38430 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfIKFMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id p9so4913274plk.5;
        Tue, 10 Sep 2019 22:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gm/hCgpnzaPrHHZ/aR0dzYOcB5B3Hpj/g7rPPbjysyo=;
        b=ge/EeQoTSdNzd/rNC2nGLo/0qQUgNcs86a8i8BAd4VD52vlRii1Og0wgaMBNJV9Y5+
         l0ewhWqj+gIH8H23D6luD1mx0/ZOVxwC+WquAkxJ+90WOvSyHGab6Ji0hjIYr6b7y6Re
         QIPdiACXjzLaGxhj5evNMv6Fo/qTzSgbuOx3wgHxPirFr2z2CuV8QsR49D5V6txz3aWw
         HxcaWv2mNvw5ZsQmtVFKVlASxnfu2w0HM53E+fiu+dj8A7FLgnigRzYEf5UI2yxjXH/z
         98vbU90hhMSOhhNxgzUo3iOCPiB4qvBhJJSYaIFruS5hyjNdDyNVTYy0r+YQyZTK6VOC
         e5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gm/hCgpnzaPrHHZ/aR0dzYOcB5B3Hpj/g7rPPbjysyo=;
        b=cewHXIQXv3dxRucn40hFEFijiF5MMGOEwwxIp/BXGM+uF0fl2Q6ZF+HOthLG9KdlYH
         eQ9fwUf1vZ2acRDqyS0irdvJ4EuC29lSz4dpG5/K7T4G1NnLPIV7EYtCTr4jtD1W1Sf/
         FuLHwzRQT4n0GdUUxhwW7n4Iu6xWI//7p4IoPfsW5wuVr/bSsFrQgHLUk148CyAAR3xu
         UonQa2xAFWexZ15Tqj2kVSYIPK1SbBFIMdgSFpXkn0c7LdnC7o4ovRL8YMu49L4UMao0
         01EvzltL5O1UwKg39hIwLT655oFeCuUugYZijm2eWUEsh3+K4PtaMZFVWo6bfn7KXDdb
         IKUg==
X-Gm-Message-State: APjAAAV9nnTtV0Kdf951TwvItFkoZv2h66q1tP6t/I4KfjmEbuQSVrhV
        28FDZRt7+xbSlJ+kk+FyTCA=
X-Google-Smtp-Source: APXvYqxCN8xHj1/tJrUJLanYOX5QM8tQ7EGhpG/qJaI0k1L87m1Llsg1JAnyL2f1gPvGXM9+1aLFRA==
X-Received: by 2002:a17:902:bd05:: with SMTP id p5mr33681188pls.339.1568178773116;
        Tue, 10 Sep 2019 22:12:53 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:52 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 13/14] platform/x86: intel_cht_int33fe: use inline reference properties
Date:   Tue, 10 Sep 2019 22:12:30 -0700
Message-Id: <20190911051231.148032-14-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that static device properties allow defining reference properties
together with all other types of properties, instead of managing them
separately, let's adjust the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 81 ++++++++++++------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 1d5d877b9582..4177c5424931 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -46,30 +46,6 @@ struct cht_int33fe_data {
 	struct fwnode_handle *dp;
 };
 
-static const struct software_node nodes[];
-
-static const struct software_node_ref_args pi3usb30532_ref = {
-	&nodes[INT33FE_NODE_PI3USB30532]
-};
-
-static const struct software_node_ref_args dp_ref = {
-	&nodes[INT33FE_NODE_DISPLAYPORT]
-};
-
-static struct software_node_ref_args mux_ref;
-
-static const struct software_node_reference usb_connector_refs[] = {
-	{ "orientation-switch", 1, &pi3usb30532_ref},
-	{ "mode-switch", 1, &pi3usb30532_ref},
-	{ "displayport", 1, &dp_ref},
-	{ }
-};
-
-static const struct software_node_reference fusb302_refs[] = {
-	{ "usb-role-switch", 1, &mux_ref},
-	{ }
-};
-
 /*
  * Grrr I severly dislike buggy BIOS-es. At least one BIOS enumerates
  * the max17047 both through the INT33FE ACPI device (it is right there
@@ -105,8 +81,18 @@ static const struct property_entry max17047_props[] = {
 	{ }
 };
 
+/*
+ * We are not using inline property here because those are constant,
+ * and we need to adjust this one at runtime to point to real
+ * software node.
+ */
+static struct software_node_ref_args fusb302_mux_refs[] = {
+	{ .node = NULL },
+};
+
 static const struct property_entry fusb302_props[] = {
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
+	PROPERTY_ENTRY_REF_ARRAY("usb-role-switch", fusb302_mux_refs),
 	{ }
 };
 
@@ -122,6 +108,8 @@ static const u32 snk_pdo[] = {
 	PDO_VAR(5000, 12000, 3000),
 };
 
+static const struct software_node nodes[];
+
 static const struct property_entry usb_connector_props[] = {
 	PROPERTY_ENTRY_STRING("data-role", "dual"),
 	PROPERTY_ENTRY_STRING("power-role", "dual"),
@@ -129,15 +117,21 @@ static const struct property_entry usb_connector_props[] = {
 	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
 	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
 	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500000),
+	PROPERTY_ENTRY_REF("orientation-switch",
+			   &nodes[INT33FE_NODE_PI3USB30532]),
+	PROPERTY_ENTRY_REF("mode-switch",
+			   &nodes[INT33FE_NODE_PI3USB30532]),
+	PROPERTY_ENTRY_REF("displayport",
+			   &nodes[INT33FE_NODE_DISPLAYPORT]),
 	{ }
 };
 
 static const struct software_node nodes[] = {
-	{ "fusb302", NULL, fusb302_props, fusb302_refs },
+	{ "fusb302", NULL, fusb302_props },
 	{ "max17047", NULL, max17047_props },
 	{ "pi3usb30532" },
 	{ "displayport" },
-	{ "connector", &nodes[0], usb_connector_props, usb_connector_refs },
+	{ "connector", &nodes[0], usb_connector_props },
 	{ }
 };
 
@@ -173,9 +167,10 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 {
 	software_node_unregister_nodes(nodes);
 
-	if (mux_ref.node) {
-		fwnode_handle_put(software_node_fwnode(mux_ref.node));
-		mux_ref.node = NULL;
+	if (fusb302_mux_refs[0].node) {
+		fwnode_handle_put(
+			software_node_fwnode(fusb302_mux_refs[0].node));
+		fusb302_mux_refs[0].node = NULL;
 	}
 
 	if (data->dp) {
@@ -187,25 +182,31 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 
 static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
 {
+	const struct software_node *mux_ref_node;
 	int ret;
 
-	ret = software_node_register_nodes(nodes);
-	if (ret)
-		return ret;
-
-	/* The devices that are not created in this driver need extra steps. */
-
 	/*
 	 * There is no ACPI device node for the USB role mux, so we need to wait
 	 * until the mux driver has created software node for the mux device.
 	 * It means we depend on the mux driver. This function will return
 	 * -EPROBE_DEFER until the mux device is registered.
 	 */
-	mux_ref.node = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
-	if (!mux_ref.node) {
-		ret = -EPROBE_DEFER;
-		goto err_remove_nodes;
-	}
+	mux_ref_node = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
+	if (!mux_ref_node)
+		return -EPROBE_DEFER;
+
+	/*
+	 * Update node used in "usb-role-switch" property. Note that we
+	 * rely on software_node_register_nodes() to use the original
+	 * instance of properties instead of copying them.
+	 */
+	fusb302_mux_refs[0].node = mux_ref_node;
+
+	ret = software_node_register_nodes(nodes);
+	if (ret)
+		return ret;
+
+	/* The devices that are not created in this driver need extra steps. */
 
 	/*
 	 * The DP connector does have ACPI device node. In this case we can just
-- 
2.23.0.162.g0b9fbb3734-goog

