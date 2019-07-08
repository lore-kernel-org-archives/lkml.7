Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E362C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104732173E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGI50DdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfGHW4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:56:50 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:33332 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfGHW4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:56:48 -0400
Received: by mail-qt1-f202.google.com with SMTP id y19so17792192qtm.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 15:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u1eu5Q6qNnosVNL7ZS50tOQF+TSWAKuZjVys5X8lD3k=;
        b=WGI50DdYYx+Uhgt7xYtokHpc+GBb8ht5o/y+/bOew2g9L4TI3CIL3otG9zQBwG6pKj
         zBvvqcnXmdQCddkCO/0mOEPYwl9XkVTHDBHJuaONn/jcEploVqB982SvtJfhJDl3N4EW
         rUeKytatMYLpHjrJzjLXjhDqCD7ctM+rz+QhWCPVBClBTxexTGKq4ebLdaxj24Yeja1q
         nF2tTDG1LOJM3yZ+iNYLO+ZtUfvlpGWE8r0DoX8gnlg0I5IFtu7ttKm0zlx7iRJ5drwz
         MY8eQP5HUaL5wYrnjGk6eM9KQcQLQ8xqTtKsjluRJVNASqwF8D2gNDvxLaREzs4/mNke
         d7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u1eu5Q6qNnosVNL7ZS50tOQF+TSWAKuZjVys5X8lD3k=;
        b=Zlhzi/MpguxhO43sJoHSG/BSLxMx0m9zLptBmAYgLQt8dMe+DUgph6/DXfz48AKwEb
         auxCwGHeLrchP/wtkoq6MLP8961mFLW1GIjqLgH8tBVX7JGSAJ9KyL1PiTtr8ROjh540
         R5I5C28hZdZ9+CG3X1PYzfdq0uwizfSMiYQiHlxETVGOr7ItalVNF9avykCOWq6vmqlv
         MNdPt+W3jJ2VfWzOQQwtvH3rukqRlk+5FPbiqpLJeokwg6j9242oX1Z/ncVkg5JcEhrx
         NtFJQ9H37I5uCbIBJqyIBgFEUEpJJqxaW5pQVCGjtV9Bej9piyDFHXEzlOfM05NeL5S+
         Sz1w==
X-Gm-Message-State: APjAAAX4DNt9ZUZlE/+M+UOR0S09TRqscHwBlsLZC/ONVrLzg7BaS0wQ
        0Jj3JH6IOaGgyT8IcsLjF5p1F+SzczTC4tM=
X-Google-Smtp-Source: APXvYqwvRo+4i76hVWIzQ54oOss1Uos7FRzSKKQK6Nv32bMLUcRsIH63nzjSOE5keCoHd7ixFyLGNDMc2TWbAtM=
X-Received: by 2002:a37:4c4e:: with SMTP id z75mr16269072qka.230.1562626607478;
 Mon, 08 Jul 2019 15:56:47 -0700 (PDT)
Date:   Mon,  8 Jul 2019 15:56:22 -0700
In-Reply-To: <20190708225624.119973-1-saravanak@google.com>
Message-Id: <20190708225624.119973-7-saravanak@google.com>
Mime-Version: 1.0
References: <20190708225624.119973-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 6/8] of/platform: Pause/resume sync state in of_platform_populate()
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

When multiple child devices are populated using of_platform_populate()
after kernel init, there could be supplier-consumer dependencies between
the child devices.

Wait for all the devices to be added and linked before calling sync_state()
on all the suppliers.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 56b718f09929..dba962a0ee50 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -486,6 +486,7 @@ int of_platform_populate(struct device_node *root,
 	pr_debug("%s()\n", __func__);
 	pr_debug(" starting at: %pOF\n", root);
 
+	device_links_supplier_sync_state_pause();
 	for_each_child_of_node(root, child) {
 		rc = of_platform_bus_create(child, matches, lookup, parent, true);
 		if (rc) {
@@ -493,6 +494,8 @@ int of_platform_populate(struct device_node *root,
 			break;
 		}
 	}
+	device_links_supplier_sync_state_resume();
+
 	of_node_set_flag(root, OF_POPULATED_BUS);
 
 	of_node_put(root);
-- 
2.22.0.410.gd8fdbe21b5-goog

