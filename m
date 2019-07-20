Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C2FC76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6163D21872
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjeSiWUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfGTGRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 02:17:18 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:43452 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfGTGRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 02:17:14 -0400
Received: by mail-qk1-f202.google.com with SMTP id v4so28242926qkj.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=czN7OgNyihOa9VdIP6ZEMSedIRrbUsmUmhpHuJJjXTo=;
        b=JjeSiWUWj0/rue13YU+ELAHX6hLfpI4PJnFZ3Q3aZh5PTfek/rlsbRkh9vntEdz3pc
         RVJXwy8Z/Eq5iaSAz00CO7t/AzU/8PBLyovCjFnjha9Q3UbeEUv8jNIVllc5UZDvQbu6
         iz5YOIH9wo86uj6dUCcIKZv9wTyW4SpxKEYiPy34pOz7dy3/Aax9RQLXEFYjhITigF2y
         eVurdpmIiZe3KXQMcoyvXqVq8XJ9iVAm7XR4T+aZ1r/sN4eIAhud6GkZvhQFh7732JAZ
         DKrXi6HKEMhxT1OhGFzJq1scn0ol5E0tdLDkd88gWhZ9U0UH1LCxNybbbYW0T3oWHtCq
         MTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=czN7OgNyihOa9VdIP6ZEMSedIRrbUsmUmhpHuJJjXTo=;
        b=ZRfGEIUFV4eU/cNeyTePZjUzDgrJOxYnVlqsEvNvxRoc1HSFaXNO7Fc9ahXgnepKz8
         5YXjbPXArnLfueifJ6TmJXSrYmiCtaINO7B0Jbyn9j1P6gZatz9U5DqXpdFXo+uqBgMH
         5jJmYeeELAQBy90K66XufFAnai62CnS98DjEmC+a5A4jVscCo4Osf/JUt41ZQRhm9gdm
         vD6JIu6xl81/IeApBwUaTGtdqIlITQWEYJm9pNVUFn7vUSRYG11uyhMBkZUabFeu5CI2
         iBEXt6Xcg7omGyko9ptr93pm37+Cwohq6YEEPikbc0QGuHFAyg+s5RVQFsaWvroAvVQp
         iM+g==
X-Gm-Message-State: APjAAAXulADW1MOeKsyKSVCYmUyDjhoNubhpiCHF06525Z0LIbEtSdTO
        36QuJFc/A42BlyzvHR++j5jtrD9S5THwXV4=
X-Google-Smtp-Source: APXvYqygd13xcNmYEyZjLdS4UFApbnJ8wQTgyJWml2t3cpy9zX8fatUprOcbabMm7FZ5uWgUmhb8yrS73/j7zmE=
X-Received: by 2002:a37:7ec1:: with SMTP id z184mr38505880qkc.491.1563603433832;
 Fri, 19 Jul 2019 23:17:13 -0700 (PDT)
Date:   Fri, 19 Jul 2019 23:16:45 -0700
In-Reply-To: <20190720061647.234852-1-saravanak@google.com>
Message-Id: <20190720061647.234852-7-saravanak@google.com>
Mime-Version: 1.0
References: <20190720061647.234852-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v6 6/7] of/platform: Create device links for all
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
 drivers/of/platform.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index d0c2f6443247..c1a116f7a087 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -649,24 +649,35 @@ static bool of_link_property(struct device *dev, struct device_node *con_np,
 	return done ? 0 : -ENODEV;
 }
 
+static int __of_link_to_suppliers(struct device *dev,
+				  struct device_node *con_np)
+{
+	struct device_node *child;
+	struct property *p;
+	bool done = true;
+
+	for_each_property_of_node(con_np, p)
+		if (of_link_property(dev, con_np, p->name))
+			done = false;
+
+	for_each_child_of_node(con_np, child)
+		if (__of_link_to_suppliers(dev, child))
+			done = false;
+
+	return done ? 0 : -ENODEV;
+}
+
 static bool of_devlink;
 core_param(of_devlink, of_devlink, bool, 0);
 
 static int of_link_to_suppliers(struct device *dev)
 {
-	struct property *p;
-	bool done = true;
-
 	if (!of_devlink)
 		return 0;
 	if (unlikely(!dev->of_node))
 		return 0;
 
-	for_each_property_of_node(dev->of_node, p)
-		if (of_link_property(dev, dev->of_node, p->name))
-			done = false;
-
-	return done ? 0 : -ENODEV;
+	return __of_link_to_suppliers(dev, dev->of_node);
 }
 
 #ifndef CONFIG_PPC
-- 
2.22.0.657.g960e92d24f-goog

