Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C44C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB79229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u946jxc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfGXALZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:11:25 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43596 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfGXALW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:11:22 -0400
Received: by mail-pl1-f201.google.com with SMTP id t2so22976790plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dW/eX2JkclSqL7u9D8ywYYaolgPaeztKnKrJrmo9wG4=;
        b=u946jxc1RmSvSOtzAKB3GMM86YLHchlYMuLFogO7YsdmMYJyI/7JXiQonjz3bcjopu
         elHlrksvcvbieQ5JZrC8tfVphdsbpDrryd7Z/sFe+tWszPgvfTmkqDd+g1wm/sTmt499
         gtOymTg8kvR2Y7hXivULQm/EfjGEB1KEAhZVwElnZH5RTntDEw55/zGR0eFNE7cjSF2m
         Fr4IlI72U7F4mZfaFKNfmZVADen5GkW7me5ZUjC141Y4ao4x5wfsMcbswStnYrBe3lLm
         fgxpOMKVuceTCQhNsmeK1NhqpvhIT5GPsRSahADu5u1Xwkbf5FYCT6XOXBPf+mymKQV0
         w+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dW/eX2JkclSqL7u9D8ywYYaolgPaeztKnKrJrmo9wG4=;
        b=J9mg4ndYeSgybfYQ83/+6QR+wGqBdXLjY+TbQEOYddOl9luu/VOZU+ZPcsLZknqDN0
         auw5Xw6jMiTg3M5JXoNn4aMTvKflvSEOjQaP4XDXle0PMxkz2hb7OTItWdBRYGKvhTSm
         +4GEgo1InCSwnbMsUlzUaEBHtJuLA5F9404vebuBuf92oXel/0gerlmlIcjbVtAyvG0F
         YNDJ+fCO1G/R3O4EhWdo6KKJyScpOwTPk1oHmSQUS/nMqhcXL0IeX8lWdp/cxdNYwU9S
         bcrL3/x57eLFiBvhmgiVCSsQsKOJPBH9nbkf2CRYgBnQMuSTArKCMA/f4+sInEJxqAc7
         FmkA==
X-Gm-Message-State: APjAAAVpYbMBP1sXDWxewyCw9ftn7U/243y9l/oOcP+VKKkvpSIyb3V0
        964/lnc/ACclB6YvWGoDposG/gIVbjvnSzU=
X-Google-Smtp-Source: APXvYqz9YflAXImGtKl/9HK7UKMqSBdU9Tp6PYpqM84Q1eb8vrgbKFOPzUha0/HYyHn1gr8xv8NM/AwgD1w+mT8=
X-Received: by 2002:a65:4103:: with SMTP id w3mr63674222pgp.1.1563927081240;
 Tue, 23 Jul 2019 17:11:21 -0700 (PDT)
Date:   Tue, 23 Jul 2019 17:10:58 -0700
In-Reply-To: <20190724001100.133423-1-saravanak@google.com>
Message-Id: <20190724001100.133423-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190724001100.133423-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v7 5/7] of/platform: Pause/resume sync state during init and of_platform_populate()
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

