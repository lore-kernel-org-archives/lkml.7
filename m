Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AACAC3A5AB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EBB22CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRrXlCAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfIDVLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:11:49 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:45425 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbfIDVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:11:48 -0400
Received: by mail-pg1-f201.google.com with SMTP id i12so9974516pgm.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BNYZzlx9aTQ+LCgQZ8IG6mRelU0sVitbFkM6D5hbnnk=;
        b=YRrXlCAVnzOOK2AfKz9blA2WPrjNpEFwO6Leu6qgi/oZvs/DH9zgLemvWVbfxKWe0s
         YCxi/y1Mm7LjwnUr7HhL0vUqE/tbkSq31IsqlVHfvBPhSpEC4XwJGtllRI+Aph4kHhz5
         w35aCIKvqsH6vrHDhJYqLhBJmU0Py9hgPWxl5VpPKN8gMj2iaNMdX1oqh9SuENVPRlE0
         vuL7OAgySwzO1pszYEoAHk5QI404dziPwjaKEx5Dp0Ys9UTaBYjuXGHRiXIDK4HZQuTs
         97JdZlBhmpkBtfEIiemSRvuK+M7OqFzBYTaVLRdKXAsDFNHkmFldBvv6wGYmveq1NB66
         cqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BNYZzlx9aTQ+LCgQZ8IG6mRelU0sVitbFkM6D5hbnnk=;
        b=lQ3YpbHm3mZyTP7Yk1rfba8bq97zegyqicj/Kgtx5KOYlTBpTa51GMtcWkoXPrEGx+
         vNNzP+VFEbcgyhSNqXO62hGzK+izchqJ/k2SHN6bsSDZWX+bSp5bNT6lN0inKS/sJM9S
         SnTeIzBwM8MPJ/QhUQjg4ts+UaEk+UvduoKSa/sbbx26ie15J8e4e/ZcI4EnMnf4ymvM
         Av4qaOTbiwpyWw/vz3A+deNlHdBeG/2f8dKsz7GVBDmbxZFEmzJuk4hk+UNrzggX1Ql3
         ES/e22nOxhuweCB+cTYHf1Tn5F9JJyWbgyGQ+10aXd2T6xGQlAO0obua+V3aDA+VFYur
         TqOA==
X-Gm-Message-State: APjAAAUf10ZPnBBemSRqzUgrZf5quvKHIBTSYUKCB37L3DeehD6jl7Ur
        f4dnZISOZDUtVj3/vdQkMmZHUSENBzmi8gM=
X-Google-Smtp-Source: APXvYqxa0Q445BT0USKWHcd+K+nDsZIoXWF5ccMgBrzd0E7J8jAJCvSVyiJOr/BJ7oiKfX/XVA1lQD7iaFaxsQU=
X-Received: by 2002:a63:2a08:: with SMTP id q8mr101014pgq.415.1567631507124;
 Wed, 04 Sep 2019 14:11:47 -0700 (PDT)
Date:   Wed,  4 Sep 2019 14:11:24 -0700
In-Reply-To: <20190904211126.47518-1-saravanak@google.com>
Message-Id: <20190904211126.47518-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190904211126.47518-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v11 5/6] of/platform: Pause/resume sync state during init and of_platform_populate()
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, clang-built-linux@googlegroups.com,
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

Similarly, when children devices are populated from a module using
of_platform_populate(), there could be supplier-consumer dependencies
between the children devices that are populated. To avoid the same
problem with sync_state() being called prematurely, pause and resume
sync_state() callbacks across of_platform_populate().

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b47a2292fe8e..d93891a05f60 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -480,6 +480,7 @@ int of_platform_populate(struct device_node *root,
 	pr_debug("%s()\n", __func__);
 	pr_debug(" starting at: %pOF\n", root);
 
+	device_links_supplier_sync_state_pause();
 	for_each_child_of_node(root, child) {
 		rc = of_platform_bus_create(child, matches, lookup, parent, true);
 		if (rc) {
@@ -487,6 +488,8 @@ int of_platform_populate(struct device_node *root,
 			break;
 		}
 	}
+	device_links_supplier_sync_state_resume();
+
 	of_node_set_flag(root, OF_POPULATED_BUS);
 
 	of_node_put(root);
@@ -518,6 +521,7 @@ static int __init of_platform_default_populate_init(void)
 	if (!of_have_populated_dt())
 		return -ENODEV;
 
+	device_links_supplier_sync_state_pause();
 	/*
 	 * Handle certain compatibles explicitly, since we don't want to create
 	 * platform_devices for every node in /reserved-memory with a
@@ -538,6 +542,14 @@ static int __init of_platform_default_populate_init(void)
 	return 0;
 }
 arch_initcall_sync(of_platform_default_populate_init);
+
+static int __init of_platform_sync_state_init(void)
+{
+	if (of_have_populated_dt())
+		device_links_supplier_sync_state_resume();
+	return 0;
+}
+late_initcall_sync(of_platform_sync_state_init);
 #endif
 
 int of_platform_device_destroy(struct device *dev, void *data)
-- 
2.23.0.187.g17f5b7556c-goog

