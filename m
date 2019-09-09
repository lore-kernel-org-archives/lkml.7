Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C7C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD08A21D6C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qigzDhNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbfIIIQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43801 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389040AbfIIIQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id u72so7364273pgb.10;
        Mon, 09 Sep 2019 01:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s5lcI5ZT5uEtAOYeMR+NRyVAv3KOm634t5rLdZn9cuQ=;
        b=qigzDhNQZcpku6hm7hEXsLdHXT1JnLAMNU5YXdeG5NFyk1p/w53IZVCAku63n+C39B
         XJBsqXTsornza5NmUseAfdavAdIvbtT4fHxSArzwIVfYEomUuFWvP9YpwGSbqAq4qC//
         uLWFORbbG1/0Vjy5/XLJUHA1gGqHyREfPqPnqBe1lqt7VliTaKJ+FIsL0PGN9LLOOPDk
         W7S+kpHQ95/Sy/YyVu03BdxXYOrvx4gT2CqO+t02wZ7nhC7klKGFlAji+ckVInBptVGc
         rIyXFrt9CimpYJjsfa4Bg8iBX4JNbJXzCB5pv4l9H2TG6Sq5P5JHtSfkOWYUhU+4x6Pa
         PTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s5lcI5ZT5uEtAOYeMR+NRyVAv3KOm634t5rLdZn9cuQ=;
        b=kDm0Oo+0UaT5xJ8GXC4BNlNhjOaMu2jvaDTZkSOJMJ+rrYOty2UAW8oZFwcIO4JTrM
         9INGNRy3B0Nn9YNpWoUfqF1FdRWu9jFTw0OikN6INOdPDB2u/U4QSkHk20DGRdgACWbb
         ijm5OC1HbGrekZtwH42bJRAcJ7xWSt71nt9G4VdGWzlUkShSjY7QjU+I4X8DsgNxircO
         h2C0cAXslf2oor7bR++4WWolRvHev1R9KNsqcSsPvFdrkM64FQE+/XYX4IIM5TDOUz3o
         Jl4W8xCGKbs14dIjEy74VgX1hsf8CdxDy8w73aj3IHDG/ApdnIpQFPE0sn2vlaRICAC6
         QryA==
X-Gm-Message-State: APjAAAUaCkuFHyY8lfHwXOWw89Bud9M07nIlybRWm1tw8Q1YvTK9LQmr
        5BftfTLAmeChUPAnfO6uBxE=
X-Google-Smtp-Source: APXvYqx1wD9Vx1E7T/0OAPU57TO/5+PKImydhn67JmCWmT9shE/CMmb2nwX2jJ3qcydqZUaH3/KHHg==
X-Received: by 2002:a63:fe52:: with SMTP id x18mr3660734pgj.344.1568016979143;
        Mon, 09 Sep 2019 01:16:19 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:18 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 12/13] platform/x86: intel_cht_int33fe: use inline reference properties
Date:   Mon,  9 Sep 2019 01:15:56 -0700
Message-Id: <20190909081557.93766-13-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
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
2.23.0.187.g17f5b7556c-goog

