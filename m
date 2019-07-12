Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B31C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43211217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmTIoga6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfGLXxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:53:23 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:37552 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfGLXxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:53:18 -0400
Received: by mail-qt1-f201.google.com with SMTP id 41so2642288qtm.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aNfyFMFZafWi71b+o8VurVJ/Moxv/9An2Vz0MQSpw2E=;
        b=SmTIoga6HOIwTIw08mAMeozQrZPePiLyKswn4zNjz2IPFPycWu6caDt6xVt2AFzVx6
         pRqcSLKYRs6KGvzn+l8I0Tx5kMSe6Q22foMB1DRJnqLcM4QYCwXzTmwjkrIlKV7uvZWD
         7nqtMqvQo1P/qkz/KWX0Of4toJREidB5YJB40WKmm/cGbLXVgbeEBz6jnF3slzWnNuRA
         T0Ga2wZ05IJMko75q61JwavKkOX53+rAa7w+4pxthG/DiuKwnusJcZk1GO8uryDncRwS
         WACxjkLMsEDf3yiGuouoIVNhGXbwfJoLn6Z3Q28q1Es1Xl4Ba8dj5UQrwJcyvSxRBX0s
         Z0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aNfyFMFZafWi71b+o8VurVJ/Moxv/9An2Vz0MQSpw2E=;
        b=O7+Ve4wjx2kKmHiqPw/hFvQCsZlTStdY8o3EzYlTsJTHfsFjfkmtQBNeF83vIfvfWU
         OybUjBbV4ACYBykRZIiMbWExY+dmeB/hqaQqRJnZ5t21lZE53egW13bJ8MyQQ2AozP0n
         kU3JkBd2FkrY/CGzFsnVnAhv8ajig7TlUKJogehIRCNLWEuofKHLeklVOdg0zoGnUZKr
         kQbUSKf2iHLmTRGYCKbaUldtELts1lrPJVP7xGCE1iNL5YR71ePCjQI+MSoOMVUb9Yza
         542VmHFHBK2v5376hTgMB1Gjn6nLu6kXNUxRtimVt9SFgMEQZ+4e013zu5WRe4s4yPFm
         r3EA==
X-Gm-Message-State: APjAAAWU0DcNjE4oz3gMzSENZPqH4QxRwoJIrK5KL4wDsKIIsTSz7I8j
        pZE7xratD/CyM0LQwYSWx/2btX0jaCvOxk4=
X-Google-Smtp-Source: APXvYqyyIBmeECglDcsfHezEruplDPEH4/v5Nq5NAhyh+EhK+LjnFi7lONixaTVz6xmPPJp4ZzV0Vr5/ngo9sAI=
X-Received: by 2002:a0c:99e6:: with SMTP id y38mr9095787qve.42.1562975597621;
 Fri, 12 Jul 2019 16:53:17 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:52:42 -0700
In-Reply-To: <20190712235245.202558-1-saravanak@google.com>
Message-Id: <20190712235245.202558-10-saravanak@google.com>
Mime-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v5 09/11] of/platform: Create device links for all
 child-supplier depencencies
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

A parent device can have child devices that it adds when it probes. But
this probing of the parent device can happen way after kernel init is done
-- for example, when the parent device's driver is loaded as a module.

In such cases, if the child devices depend on a supplier in the system, we
need to make sure the supplier gets the sync_state() callback only after
these child devices are added and probed.

To achieve this, when creating device links for a device by looking at its
DT node, don't just look at DT references at the top node level. Look at DT
references in all the descendant nodes too and create device links from the
ancestor device to all these supplier devices.

This way, when the parent device probes and adds child devices, the child
devices can then create their own device links to the suppliers and further
delay the supplier's sync_state() callback to after the child devices are
probed.

Example:
In this illustration, -> denotes DT references and indentation
represents child status.

Device node A
	Device node B -> D
	Device node C -> B, D

Device node D

Assume all these devices have their drivers loaded as modules.

Without this patch, this is the sequence of events:
1. D is added.
2. A is added.
3. Device D probes.
4. Device D gets its sync_state() callback.
5. Device B and C might malfunction because their resources got
   altered/turned off before they can make active requests for them.

With this patch, this is the sequence of events:
1. D is added.
2. A is added and creates device links to D.
3. Device link from A to B is not added because A is a parent of B.
4. Device D probes.
5. Device D does not get it's sync_state() callback because consumer A
   hasn't probed yet.
5. Device A probes.
5. a. Devices B and C are added.
5. b. Device links from B and C to D are added.
5. c. Device A's probe completes.
6. Device D does not get it's sync_state() callback because consumer A
   has probed but consumers B and C haven't probed yet.
7. Device B and C probe.
8. Device D gets it's sync_state() callback because all its consumers
   have probed.
9. None of the devices malfunction.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index cf8625abe30c..6523d07ef2d7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -525,7 +525,7 @@ bool of_link_is_valid(struct device_node *con, struct device_node *sup)
 	return true;
 }
 
-static int of_link_binding(struct device *dev,
+static int of_link_binding(struct device *dev, struct device_node *con_np,
 			   const char *binding, const char *cell)
 {
 	struct of_phandle_args sup_args;
@@ -534,7 +534,7 @@ static int of_link_binding(struct device *dev,
 	unsigned int i = 0, links = 0;
 	u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
 
-	while (!of_parse_phandle_with_args(dev->of_node, binding, cell, i,
+	while (!of_parse_phandle_with_args(con_np, binding, cell, i,
 					   &sup_args)) {
 		sup_np = sup_args.np;
 		/*
@@ -579,26 +579,37 @@ static const char * const link_bindings[] = {
 	"interconnects", "#interconnect-cells",
 };
 
-static int of_link_to_suppliers(struct device *dev)
+static int __of_link_to_suppliers(struct device *dev,
+				  struct device_node *con_np)
 {
 	unsigned int i = 0;
 	bool done = true;
-
-	if (!of_devlink)
-		return 0;
-	if (unlikely(!dev->of_node))
-		return 0;
+	struct device_node *child;
 
 	for (i = 0; i < ARRAY_SIZE(link_bindings) / 2; i++)
-		if (of_link_binding(dev, link_bindings[i * 2],
+		if (of_link_binding(dev, con_np, link_bindings[i * 2],
 					link_bindings[i * 2 + 1]))
 			done = false;
 
+	for_each_child_of_node(con_np, child)
+		if (__of_link_to_suppliers(dev, child))
+			done = false;
+
 	if (!done)
 		return -ENODEV;
 	return 0;
 }
 
+static int of_link_to_suppliers(struct device *dev)
+{
+	if (!of_devlink)
+		return 0;
+	if (unlikely(!dev->of_node))
+		return 0;
+
+	return __of_link_to_suppliers(dev, dev->of_node);
+}
+
 #ifndef CONFIG_PPC
 static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "qcom,rmtfs-mem" },
-- 
2.22.0.510.g264f2c817a-goog

