Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A8CC742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B858A217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWVWNVmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfGLXx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:53:27 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:50598 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbfGLXxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:53:22 -0400
Received: by mail-yw1-f74.google.com with SMTP id p18so8963314ywe.17
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QW+zU+QNcjXCm1XYmfzCA7KbcESNkERoyOnm4EH5sTg=;
        b=iWVWNVmGIYOFOC2EfUg0jOTE4wOOeyFoogk3TsEl3yexL33cERuEvCn12OgGpVGh/M
         OtGuJMxBEMZlSnKf5FKH2pHfK/cKlC0cPi7DfFMYPXJf2yzxCIeq6XDuVcYAIB52RMUE
         sQCLSp7AV9oM8CfGVUKXuOnQQEGwZsKT8oqLwfyNnzKtKfMUYVl+LcZFJ6obQYgrJKaY
         1wZIOeEPIZ+d6h8cfkaSpG5mQ4so3XPUKFj5VV7qTtGb5LNApKngj/I4AntTthPzT6jK
         rZQU5ZGWoTZmJxCaejE0tyBR1mgYCpmddN209JDQWcZNOPM8rlBclnqvoGaPAdreRY+c
         SeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QW+zU+QNcjXCm1XYmfzCA7KbcESNkERoyOnm4EH5sTg=;
        b=PabVLVOsgc27UHn70hY4WioCZpzFpTGZIchqAp/ZEmQSJwHQKU2+58ckTN8CbPCwMN
         uctx7YQu0ceV5nz9qouAqgBiIRHb1voTqqIg/Q6y6aMQRkQAX9wWURFlYAi08y1SsC8g
         geD/5Tg6MyCK+iWwFELZvW1lbP8PuP/DgSwSKyC7Tjq24uNmDPazqVLRL7nIc+p9vJX1
         xKCqdqeGAA2w3ltJmvdr8/fzkSLuEQJwN7Kh/EEESUGk+510OMwRRwQLL6HPPXh4lVe2
         tIpbNoGjddpVeifotnsKt4nao1ND21SMQnGOQwp09trWWE3xbCmjDuEW2FUEzEtsn7Bq
         mWsg==
X-Gm-Message-State: APjAAAU/0x3yt0aU3Y4jpLF2ccI5BP6EpWt4q8dCOm50gPEzpgDlR8r4
        MUhmi1w1OY6FMvrEuHcDNT7hprT3JskcB8k=
X-Google-Smtp-Source: APXvYqx7VbQ88nJ8oFqEGVqdvtIAtzH6D/4k0+SgF5oYk4u33PLfWUs4+rkdopyVpvfPqMy6v3uCdYVY04dxJk4=
X-Received: by 2002:a81:3bd4:: with SMTP id i203mr7979284ywa.116.1562975600624;
 Fri, 12 Jul 2019 16:53:20 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:52:43 -0700
In-Reply-To: <20190712235245.202558-1-saravanak@google.com>
Message-Id: <20190712235245.202558-11-saravanak@google.com>
Mime-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v5 10/11] of/platform: Add functional dependency link from DT
 regulator bindings
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

Similar to creating functional dependency links from clock and
interconnect DT bindings, also create functional dependency links from
regulator DT bindings.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 83 ++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 6523d07ef2d7..9f3b7e1801bc 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -525,46 +525,50 @@ bool of_link_is_valid(struct device_node *con, struct device_node *sup)
 	return true;
 }
 
-static int of_link_binding(struct device *dev, struct device_node *con_np,
-			   const char *binding, const char *cell)
+static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
 {
-	struct of_phandle_args sup_args;
-	struct device_node *sup_np;
 	struct platform_device *sup_dev;
-	unsigned int i = 0, links = 0;
 	u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+	int ret = 0;
 
-	while (!of_parse_phandle_with_args(con_np, binding, cell, i,
-					   &sup_args)) {
-		sup_np = sup_args.np;
-		/*
-		 * Since we are trying to create device links, we need to find
-		 * the actual device node that owns this supplier phandle.
-		 * Often times it's the same node, but sometimes it can be one
-		 * of the parents. So walk up the parent till you find a
-		 * device.
-		 */
-		while (sup_np && !of_find_property(sup_np, "compatible", NULL))
-			sup_np = of_get_next_parent(sup_np);
-		if (!sup_np)
-			continue;
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
 
-		if (!of_link_is_valid(dev->of_node, sup_np)) {
-			of_node_put(sup_np);
-			continue;
-		}
-		i++;
-		sup_dev = of_find_device_by_node(sup_np);
+	if (!of_link_is_valid(dev->of_node, sup_np)) {
 		of_node_put(sup_np);
-		if (!sup_dev)
-			continue;
-		if (device_link_add(dev, &sup_dev->dev, dl_flags))
-			links++;
-		put_device(&sup_dev->dev);
+		return 0;
 	}
-	if (links < i)
+	sup_dev = of_find_device_by_node(sup_np);
+	of_node_put(sup_np);
+	if (!sup_dev)
 		return -ENODEV;
-	return 0;
+	if (!device_link_add(dev, &sup_dev->dev, dl_flags))
+		ret = -ENODEV;
+	put_device(&sup_dev->dev);
+	return ret;
+}
+
+static int of_link_binding(struct device *dev, struct device_node *con_np,
+			   const char *binding, const char *cell)
+{
+	struct of_phandle_args sup_args;
+	unsigned int i = 0;
+	bool done = true;
+
+	while (!of_parse_phandle_with_args(con_np, binding, cell, i++,
+					   &sup_args))
+		if (of_link_to_phandle(dev, sup_args.np))
+			done = false;
+	return done ? 0 : -ENODEV;
 }
 
 static bool of_devlink;
@@ -579,18 +583,33 @@ static const char * const link_bindings[] = {
 	"interconnects", "#interconnect-cells",
 };
 
+#define REG_SUFFIX	"-supply"
 static int __of_link_to_suppliers(struct device *dev,
 				  struct device_node *con_np)
 {
 	unsigned int i = 0;
 	bool done = true;
 	struct device_node *child;
+	struct property *p;
+	unsigned int len, reg_len;
 
 	for (i = 0; i < ARRAY_SIZE(link_bindings) / 2; i++)
 		if (of_link_binding(dev, con_np, link_bindings[i * 2],
 					link_bindings[i * 2 + 1]))
 			done = false;
 
+	reg_len = strlen(REG_SUFFIX);
+	for_each_property_of_node(con_np, p) {
+		len = strlen(p->name);
+		if (len <= reg_len)
+			continue;
+		if (strcmp(p->name + len - reg_len, REG_SUFFIX))
+			continue;
+		if (of_link_to_phandle(dev,
+				of_parse_phandle(con_np, p->name, 0)))
+			done = false;
+	}
+
 	for_each_child_of_node(con_np, child)
 		if (__of_link_to_suppliers(dev, child))
 			done = false;
-- 
2.22.0.510.g264f2c817a-goog

