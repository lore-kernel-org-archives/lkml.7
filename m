Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE639C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41A42075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prCHOm9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfIFEiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 00:38:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34994 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfIFEiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 00:38:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so3489804pfw.2;
        Thu, 05 Sep 2019 21:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rocKisRtaIo/HOtqERrBvsycAn2143YAZdtTrg16FdY=;
        b=prCHOm9/jV5cSbG34An0s5U9aRNFRwaRW6fH3dZPvrKBKmq0ypCYCTmSbAfxs/zopY
         5A8PN/994hPRLwnbVjarCVIf1QlHxlSsEquHn3uovIgs3vZhE/Utue6X/EKflGewaBNG
         zffhP3vXlnwGeT+ATgqI3i84NcafEVU9eedFQzVDAUQ+DMnEhn4Jj8PWGnr1TLKdDXl7
         j2xiBi4TU6ehOEEHCSs/uH4HzEoQ/C+ubSouzjv5riRECDJDvCWea1Itaf1DIWJQvUWx
         SBxvBS7mce744XR6FptXbvVjdwnYhvJGCRk9qNCFkcevZ/VrhLTwDdOpLzH2ia3bWPlb
         Cmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rocKisRtaIo/HOtqERrBvsycAn2143YAZdtTrg16FdY=;
        b=nqP6RGkOKBIgLYjpcd5v8x74cKF3cWukq4Nv3H9wk64YUQoHWzlArQxx50r980v9fE
         ccRqq4yrgroSH7Yrci3qGaL2jrrRipQ57g7hrpMGhkyx+Trd/XRr6p9e38/XjeTbHRNg
         iZgw17tlD2Z1IecBTO+kle1pch9WYqDQP5KJTz7iICgoCSQA6kVQK60Fe4EmaFAuQRhD
         UV8DuXYBVd8eqXqWNCNMZhz2of+HFTF3wg02LJEN45FJWVPWNclpxCiLMpmsMr5tgEEt
         bvLv6CG4wOc+LT4xWv2xttTVEUWN0MyVbTnmFr4K1BvA3LNzQZIAgQUysI4qR58aYmUz
         4yqg==
X-Gm-Message-State: APjAAAUyPJ46yp4KSj8BhJ+8vy4xGsFChjjU6vd6+tNuHk18MRYVbm8i
        6qVuD4SXL+DrpvZVFetVwUQ=
X-Google-Smtp-Source: APXvYqzy1JBgf6aWTKYYE51HITlrq7ScLKpndcFL+JknByCLokgHyIeWzq6oz5smpbvRaJR3TK584w==
X-Received: by 2002:a17:90a:bc08:: with SMTP id w8mr5195521pjr.80.1567744693563;
        Thu, 05 Sep 2019 21:38:13 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y15sm6085378pfp.111.2019.09.05.21.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 21:38:13 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: intel_cht_int33fe: use inline reference properties
Date:   Thu,  5 Sep 2019 21:38:08 -0700
Message-Id: <20190906043809.18990-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190906043809.18990-1-dmitry.torokhov@gmail.com>
References: <20190906043809.18990-1-dmitry.torokhov@gmail.com>
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

Heikki, I do not have this hardware, so if you could try this out
it would be really great.

 drivers/platform/x86/intel_cht_int33fe.c | 46 ++++++++++++------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 4fbdff48a4b5..91f3c8840fd8 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -50,28 +50,8 @@ struct cht_int33fe_data {
 
 static const struct software_node nodes[];
 
-static const struct software_node_ref_args pi3usb30532_ref = {
-	&nodes[INT33FE_NODE_PI3USB30532]
-};
-
-static const struct software_node_ref_args dp_ref = {
-	&nodes[INT33FE_NODE_DISPLAYPORT]
-};
-
 static struct software_node_ref_args mux_ref;
 
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
@@ -107,7 +87,13 @@ static const struct property_entry max17047_props[] = {
 	{ }
 };
 
-static const struct property_entry fusb302_props[] = {
+/* Not const because we need to update "usb-role-switch" property. */
+static struct property_entry fusb302_props[] = {
+	/*
+	 * usb-role-switch property must be first as we rely on fixed
+	 * position to adjust it once we know the real node.
+	 */
+	PROPERTY_ENTRY_REF("usb-role-switch", NULL),
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
 	{ }
 };
@@ -131,16 +117,22 @@ static const struct property_entry usb_connector_props[] = {
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
 	{ "usb-role-switch" },
-	{ "connector", &nodes[0], usb_connector_props, usb_connector_refs },
+	{ "connector", &nodes[0], usb_connector_props },
 	{ }
 };
 
@@ -174,7 +166,13 @@ static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
 
 	data->mux = fwnode_handle_get(dev->fwnode);
 	put_device(dev);
-	mux_ref.node = to_software_node(data->mux);
+
+	/*
+	 * Update "usb-role-switch" property with real node. Note that we
+	 * rely on software_node_register_nodes() to use the original
+	 * instance of properties instead of copying them.
+	 */
+	fusb302_props[0].value.ref.node = to_software_node(data->mux);
 
 	return 0;
 }
-- 
2.23.0.187.g17f5b7556c-goog

