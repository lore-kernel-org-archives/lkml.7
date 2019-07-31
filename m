Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7429C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2DA206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/VtDTsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbfGaWRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:17:45 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50425 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbfGaWRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:43 -0400
Received: by mail-pf1-f201.google.com with SMTP id h27so44141939pfq.17
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E8qO1r9zkBco8i30LKei27yj1HI5jtBG2cEcj4TXoIY=;
        b=d/VtDTsSh8Z2c3zckzKtYvsAs7OIu4ECPYUplkE9TuBlbHkpKKw+4yhGFky4IbY0Me
         +ZJoIPZ6CYae79eKbVDE8AuXHelQJvpDQeu4uRwY/SbxpzvSNH7/YR3SIO112Cc/PV7d
         wKaRwZdjlaRx+LFGslqNYoog4KNTRKMiqDRHqa7uVQVQRdip1+ZdtLdlXcxQjVru2fqj
         MZtBoRnhsjhmNcaa3+FaargqMkuKSSB+SMGtcoQB5EVDkS3NBF9A9DE8B54UbhFu30qs
         wrTICeNOu46P656Vfzwj9RmqEhgJAbr1UHef6f7QuM1wNJKF0I8DZNamlH8zpPRQ+K6h
         3wLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E8qO1r9zkBco8i30LKei27yj1HI5jtBG2cEcj4TXoIY=;
        b=icoPxzUA/vkfwDL/z4osKYxvQV4qLffaBv0GcnljhyrhhhX8KiVwJkI2xmBebhxbvX
         4rCc0T7Du5jpSEwHW8Gt+KSy9qg+GdyE/ll6dqgu7pUEgB7gNxrj3oBe0whW1iSJEeHN
         lqB0fFZimcuhfK2+6IlujqO2VWtVe0ZVzpJ3v6D5ZUK13VdOL2cYjF3C2s6P0pOpWTMw
         LBzVSC8kYgJD2JhIPGJrz/ZL7LptqJa3eoVAaZkWPFTldBXw+oy+tIi1H8OroWAJFNYC
         NlG32z04/NP7oY2v2A0IP8AW5/aQBF0UyT0vXZ6/vceLJQ0ilIJuNb8h9+4ZnNWYZGHv
         Qd2g==
X-Gm-Message-State: APjAAAW994lAMZCBWCSDTHtzbnxSL0boEFLze6bsRifUPYfTgSPXa4Ku
        k/2VtARBEaVOQMgtmKgX6gkqcjLXjPHedcI=
X-Google-Smtp-Source: APXvYqxFHtbYH5daMidBua+QXHW/9hpGhJGW4N6/7EqrJehpvMYplMteVpFPEXqIjUZer9mgfGXCxBsrP/pYmSw=
X-Received: by 2002:a63:69c1:: with SMTP id e184mr111461437pgc.198.1564611462635;
 Wed, 31 Jul 2019 15:17:42 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:17:18 -0700
In-Reply-To: <20190731221721.187713-1-saravanak@google.com>
Message-Id: <20190731221721.187713-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190731221721.187713-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v9 5/7] of/platform: Pause/resume sync state during init and of_platform_populate()
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

When all the top level devices are populated from DT during kernel
init, the supplier devices could be added and probed before the
consumer devices are added and linked to the suppliers. To avoid the
sync_state() callback from being called prematurely, pause the
sync_state() callbacks before populating the devices and resume them
at late_initcall_sync().

Similarly, when children devices are populated after kernel init using
of_platform_populate(), there could be supplier-consumer dependencies
between the children devices that are populated. To avoid the same
problem with sync_state() being called prematurely, pause and resume
sync_state() callbacks across of_platform_populate().

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 64c4b91988f2..6c9c8dcee912 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -485,6 +485,7 @@ int of_platform_populate(struct device_node *root,
 	pr_debug("%s()\n", __func__);
 	pr_debug(" starting at: %pOF\n", root);
 
+	device_links_supplier_sync_state_pause();
 	for_each_child_of_node(root, child) {
 		rc = of_platform_bus_create(child, matches, lookup, parent, true);
 		if (rc) {
@@ -492,6 +493,8 @@ int of_platform_populate(struct device_node *root,
 			break;
 		}
 	}
+	device_links_supplier_sync_state_resume();
+
 	of_node_set_flag(root, OF_POPULATED_BUS);
 
 	of_node_put(root);
@@ -688,6 +691,7 @@ static int __init of_platform_default_populate_init(void)
 		return -ENODEV;
 
 	platform_bus_type.add_links = of_link_to_suppliers;
+	device_links_supplier_sync_state_pause();
 	/*
 	 * Handle certain compatibles explicitly, since we don't want to create
 	 * platform_devices for every node in /reserved-memory with a
@@ -708,6 +712,13 @@ static int __init of_platform_default_populate_init(void)
 	return 0;
 }
 arch_initcall_sync(of_platform_default_populate_init);
+
+static int __init of_platform_sync_state_init(void)
+{
+	device_links_supplier_sync_state_resume();
+	return 0;
+}
+late_initcall_sync(of_platform_sync_state_init);
 #endif
 
 int of_platform_device_destroy(struct device *dev, void *data)
-- 
2.22.0.709.g102302147b-goog

