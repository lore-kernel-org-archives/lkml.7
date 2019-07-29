Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BABC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234042073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bySAqByO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbfG2WL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:11:26 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:36587 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387961AbfG2WLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:11:22 -0400
Received: by mail-vk1-f202.google.com with SMTP id o75so24924855vke.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 15:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dW/eX2JkclSqL7u9D8ywYYaolgPaeztKnKrJrmo9wG4=;
        b=bySAqByOQEebmp0j4EW02YygURHxnGu2CbcM5wh7QMJeT35C/YmOp9G2uE4Tm2UCpR
         DBJ2/YG8hRmosv6YRQMY911QGpWgmrKIKbLg/x2i37Ws0RHG010G2AOJoymCWQQlZiGK
         juC2LtX6jwgKaeRXNXqM5FOZ5Lcb+WVho0oA8Bb3GVIrLD3VhUS2szvLXhzLshnCcQJl
         2SjStyZmgU2qCUx0yPR1Ci/sxkWqSm66dgqHp7Q6FyOyvIZIITUJgwhKNqLGq4JlUyVE
         Dy0ov2iJF5/jCEFr9tOVQIDwa0eYiIzDk0rvPHSxz5p9Ccc4npD99KObx8cO6qE14BmA
         VkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dW/eX2JkclSqL7u9D8ywYYaolgPaeztKnKrJrmo9wG4=;
        b=dQHp40MH2+d9geR5UYbCqLbqZz/qq+3+8fu5EGd2wtI+yvxLAfC+Nzbtwh5ZvFznrc
         lOFFWYQLV30+M+4HIHWJ+VGQjTPqPLzWnbk50gyNIFZPfTllAsL3EBl+WPzY7jW+DfPS
         rG6EsDq4wjbMRfvGyexo8BWUohibtGQh1bhq/mMnGpHAI1Ul+HYj2gzDefZn6Mb4N+7P
         7oQt4/UzPWpMO+vO0YhxLkU2kRLStbDy8QF5ZzTRSRymRxgCveQrZKFCpETJ5IshMyQG
         kdpeHr13nlU6YqkrDczH5ympBDFFWP37uXbvy+JXJuAJEZqu3udrV5enkmPAv4ZYJoqd
         txlQ==
X-Gm-Message-State: APjAAAUGlroGlS76eecKskEaeqm/ZkYXy1eEJ7Zb23BM9s+jw6GXyoRQ
        wHNEs4yOOio7KO18TLSM18WJ/BUhb59KABo=
X-Google-Smtp-Source: APXvYqzo0PN6DL7D6k4sULyjTwuAh6SbT2tqJCQhccjrQ1zw0I19R2v4ViDBAEOic7sqBrKzTO0/SH8uYoikjwY=
X-Received: by 2002:a67:ff0b:: with SMTP id v11mr36432820vsp.14.1564438281896;
 Mon, 29 Jul 2019 15:11:21 -0700 (PDT)
Date:   Mon, 29 Jul 2019 15:10:59 -0700
In-Reply-To: <20190729221101.228240-1-saravanak@google.com>
Message-Id: <20190729221101.228240-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190729221101.228240-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v8 5/7] of/platform: Pause/resume sync state during init and of_platform_populate()
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
index 4344419a26fc..71d6138698ec 100644
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

