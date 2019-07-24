Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED5CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080692184E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TG63xheF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfGXAL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:11:27 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:43597 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfGXALZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:11:25 -0400
Received: by mail-pl1-f202.google.com with SMTP id t2so22976863plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L03s0/cCwSibWbjOlLSetg9NEt3OrkecIhAnIwN841s=;
        b=TG63xheFeu2TtgFwns1F37AaSHu7rAHoMRk+RRVOIKJ8Ya+2Znfh8TIvoJJB4JkqHU
         gSNCzASvMpUQnrcSjpvOmaDQqPxEsL1iEEwUutzRjWt0rvWBXuY6A+fJ3T31BqTqkXYy
         75wO6Isa8nJ99vGoEKt2cs9nfxoY5qA3fjYp80D9Bey/LO93+orki8csi0DDKNMoRACM
         EtF1g+p+LezFGYIYqBssjGmjAd2JRIVpe1QqD4mhCTTsgwZcVM2fqr72YoyzPXAzht8r
         rY+tYHS9Z1vGj4bWXcM/1coYsmxI9spyPAWy1i1VJtk9BW3yqfE1KNM4SYeFIUHfPyR3
         JelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L03s0/cCwSibWbjOlLSetg9NEt3OrkecIhAnIwN841s=;
        b=PRoDmUfaTxdlrPrYkuow39iVWfBLmFx5s/99YxWP0UMw3CggZ+uT5Pkd1Q2E+7sTGM
         o3ZgH628uLmcVdi9HquYGsaBoT4XejIQGaW3HFXGoobAnz/ZP5Luzn7TNcoM+qPiiaDP
         fHW++AV/EgcpsvVt5h7anL4T5nmJRJBoZJ4+olCjdftgaAGY3QIhVN6RODUgExx1HSqe
         RvOzEJEaqwEVZSUXb9SxEcYUwBdDGh8wcbsgYIjTONpOUuDkJtjKIYwc6OvAg7oAhcRa
         5A9xU6uITJd0XoHseCMjf1OlYz+s5/WZfHU2p/fz2iKBjHItULX4cJBGMbMLaYdV85gR
         7zlA==
X-Gm-Message-State: APjAAAWh8TBG9WPdUmqRK9Z0RivVULbam5/hon59RwnTXfscmKGQLh1Q
        6ul8V49+xqBH/PETzZOkuEWHxIj0uBTgNNM=
X-Google-Smtp-Source: APXvYqwXM3zaatfsro6OzkcL1pd5UbOLfzL1dK6ZYUTH1e3CKFd84+WcyriFc2O6S1UEB9t2wnPoV/KmMJuO2tM=
X-Received: by 2002:a63:204b:: with SMTP id r11mr38959699pgm.121.1563927084355;
 Tue, 23 Jul 2019 17:11:24 -0700 (PDT)
Date:   Tue, 23 Jul 2019 17:10:59 -0700
In-Reply-To: <20190724001100.133423-1-saravanak@google.com>
Message-Id: <20190724001100.133423-7-saravanak@google.com>
Mime-Version: 1.0
References: <20190724001100.133423-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v7 6/7] of/platform: Create device links for all
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
index 71d6138698ec..41499ddc8d95 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -655,24 +655,35 @@ static bool of_link_property(struct device *dev, struct device_node *con_np,
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
2.22.0.709.g102302147b-goog

