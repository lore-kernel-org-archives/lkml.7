Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40800C606D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148012173E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="erO12Tbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfGHW45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:56:57 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46664 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbfGHW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:56:54 -0400
Received: by mail-pl1-f202.google.com with SMTP id k9so5626046pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MTr0WXiwfZFuIKY9jsAjn+uW0EYoc04W3T0ITGfcuvY=;
        b=erO12TbvXx9Jt73BjR0QApVgSUOZw7nCeVzqHXOBah3inPhN5MDZEPJtJndAvNW4xI
         R1dyYJCXMs5/bYP96IJ+D7NtUzB4+SEKUPRrQwNJt+37vr1SxJ5WrN1Kea/yjxrBjlIZ
         v2TOwFK6dA+baiodp+ndXm2KRrFyDiI5wJDcEB8VHBHtUE1AxEImqF/UC8dsC/ED8MQF
         1ZYBuRpKGbePpO/abK7IqDVx8Mq+/l73sBngNiYIf7GxXMPasXjbaDfH1vHzWMNCYxBv
         YC3lVwotiI0UIgowpMkviE5VOOFbnkElSdrw0iBuZhlwyAGP+8LeuJfrcJwnBuOYHMUL
         8K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MTr0WXiwfZFuIKY9jsAjn+uW0EYoc04W3T0ITGfcuvY=;
        b=sZPDoZMxKk4aoFmV7BBbMT/BhEOUQll8gTTmKYOFwt8oOq3PBkShBJe+49WPt+s4Zv
         l9hDLzhr3YOtQwoeld63rFrnK1IX1kJt44aaBMnIbj87cEFslq3imE/LCKfjwYTG7Cwd
         zEvnwBF1qML+j0qO8jET1uqiq06LCqtF8vazqy3RaeuVvIf9DKLUCORbLJWjJ4MP6T4q
         ZG6X7cTZO2fSMcRXX/DP5tGvBvoyo4z0zFIkrNiRFiP60hQFL7qpKthZAWLOWnTOPOP0
         HuP12HiSzcYfrZSkQviRN2Tyi2ixmoqAwLyS2Hjw/EtpTPfUxuGoxhp/6yovPpMY9sdQ
         sJrw==
X-Gm-Message-State: APjAAAVYU+vSmN3BCXCg9w8eWGKa/CP5AYyxox5OYZI7MmiKBaZFxRCs
        anjpcSiN4xM+6/nEIUcd6k60Fz1GZpDmH4Q=
X-Google-Smtp-Source: APXvYqwVbl5/w1CheQpVu8xYeB02AJMjA41gjANj8F1MpN1d/W6LZ2xVI2sH0U6bMCXIclOuQVL6Ri3fw8dn5yE=
X-Received: by 2002:a65:534b:: with SMTP id w11mr26971266pgr.210.1562626613318;
 Mon, 08 Jul 2019 15:56:53 -0700 (PDT)
Date:   Mon,  8 Jul 2019 15:56:24 -0700
In-Reply-To: <20190708225624.119973-1-saravanak@google.com>
Message-Id: <20190708225624.119973-9-saravanak@google.com>
Mime-Version: 1.0
References: <20190708225624.119973-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 8/8] of/platform: Create device links for all
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
 drivers/of/platform.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 98414ba53b1f..85796a09464c 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -525,16 +525,26 @@ bool of_link_is_valid(struct device_node *con, struct device_node *sup)
 	return true;
 }
 
-static int of_link_binding(struct device *dev,
+static int of_link_binding(struct device *dev, struct device_node *con_np,
 			   const char *binding, const char *cell)
 {
 	struct of_phandle_args sup_args;
+	struct device_node *child;
 	struct platform_device *sup_dev;
 	unsigned int i = 0, links = 0;
 	u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+	bool done = true;
 
-	while (!of_parse_phandle_with_args(dev->of_node, binding, cell, i,
+	while (!of_parse_phandle_with_args(con_np, binding, cell, i,
 					   &sup_args)) {
+		/*
+		 * This check needs to be done against dev->of_node (and not
+		 * con_np) due to the recursive calls for the child DT nodes.
+		 * Since all the device links for the child DT nodes are also
+		 * created against the parent device, we need to check for
+		 * validity against the parent DT node and not just the child
+		 * DT nodes.
+		 */
 		if (!of_link_is_valid(dev->of_node, sup_args.np)) {
 			of_node_put(sup_args.np);
 			continue;
@@ -548,7 +558,12 @@ static int of_link_binding(struct device *dev,
 			links++;
 		put_device(&sup_dev->dev);
 	}
-	if (links < i)
+
+	for_each_child_of_node(con_np, child)
+		if (of_link_binding(dev, child, binding, cell))
+			done = false;
+
+	if (links < i || !done)
 		return -ENODEV;
 	return 0;
 }
@@ -576,7 +591,8 @@ static int of_link_to_suppliers(struct device *dev)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(link_bindings) / 2; i++)
-		if (of_link_binding(dev, link_bindings[i * 2],
+		if (of_link_binding(dev, dev->of_node,
+					link_bindings[i * 2],
 					link_bindings[i * 2 + 1]))
 			done = false;
 
-- 
2.22.0.410.gd8fdbe21b5-goog

