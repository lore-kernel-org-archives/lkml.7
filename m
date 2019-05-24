Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0336C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04ED20862
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6xGWh38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388709AbfEXBBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:01:36 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:53978 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbfEXBBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:01:34 -0400
Received: by mail-yb1-f201.google.com with SMTP id n76so6836033ybf.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 18:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oMHoMPQmhEqS1OrwCj/awDAcMj4261wJxPL5IX32+TA=;
        b=N6xGWh38j089YENdGB1y1toAjMbL0Tk0p0HgQT4dENUnm11Y/lPTT6d0n6nNe4H/27
         0K0BlNPORCwSJS03Q+N/YpqDi1xomO4mMcuadIzfwxz+77+EpE2Jz0zSQf3XCwfSkHoH
         3/gooWaHO/6vlbwRImifLRtjDK0qc+OC12V+k7gT67ZEeSVy8okg+5MrpnEhtLXfIpWw
         2qxvTf8QybPXKhLsA4AqS9N1dt7ue9D8TJirG4SJYJB+Skow8kqgwEKqqn2JCCG2u9O3
         LFzW188Y5jh0ZQXRhHRIV7GXG80N68zkDJluePvhC6dkv+eoGakcP/+oXLz3+WU7b2an
         hYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oMHoMPQmhEqS1OrwCj/awDAcMj4261wJxPL5IX32+TA=;
        b=uf8lk/5+PjorvWHXpJz2ywu52cAH8XCRdED/3R4xlEi4amFsB0QyJgFyN6K6snSEGY
         CZF9Byk3olmw+z4Iz1BxLCeHY1nT2rGU37b3GSU5Si4zJ8/vZyxvKn7Psy+V7EAlyayl
         cXHbakyjQsh74fVIqkBOtaWUi69ykztkQicdRB5fqi9E441nFc3LVjto/TLwMOzb6ler
         2xYhBOcMtH+j7rn9HnGvzrsrkhbIAtvV4BS5WAC+YaM5kQWX0yZWdWH+0/uaDUGeOGy7
         QDlEqJx6JbwCn2Rlv8NT1TYcf7Obq1IQv5oRzLW/5SRtP5BUa2JGLxhp4d5CW3to6C5/
         95bw==
X-Gm-Message-State: APjAAAVLcm3AkOpFHMMhKCK4NC7J9y25HhBLWpSVB97fJlZvE3AHgmFI
        w5EzWkK9h0AJlJWRN4o+1HjcswRvOMt6YYY=
X-Google-Smtp-Source: APXvYqz/KBoDXeBFvZyUJHa1QtM335Lv75rS2hBvoULIzAtt0sqft2b2tmszS1FvwmAQ8QyxcHusgdhCY2g6JUw=
X-Received: by 2002:a25:9b86:: with SMTP id v6mr11146780ybo.342.1558659693863;
 Thu, 23 May 2019 18:01:33 -0700 (PDT)
Date:   Thu, 23 May 2019 18:01:12 -0700
In-Reply-To: <20190524010117.225219-1-saravanak@google.com>
Message-Id: <20190524010117.225219-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v1 1/5] of/platform: Speed up of_find_device_by_node()
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pointer from device tree node to the device created from it.
This allows us to find the device corresponding to a device tree node
without having to loop through all the platform devices.

However, fallback to looping through the platform devices to handle
any devices that might set their own of_node.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 20 +++++++++++++++++++-
 include/linux/of.h    |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 04ad312fd85b..1115a8d80a33 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -42,6 +42,8 @@ static int of_dev_node_match(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static DEFINE_SPINLOCK(of_dev_lock);
+
 /**
  * of_find_device_by_node - Find the platform_device associated with a node
  * @np: Pointer to device tree node
@@ -55,7 +57,18 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
+	/*
+	 * Spinlock needed to make sure np->dev doesn't get freed between NULL
+	 * check inside and kref count increment inside get_device(). This is
+	 * achieved by grabbing the spinlock before setting np->dev = NULL in
+	 * of_platform_device_destroy().
+	 */
+	spin_lock(&of_dev_lock);
+	dev = get_device(np->dev);
+	spin_unlock(&of_dev_lock);
+	if (!dev)
+		dev = bus_find_device(&platform_bus_type, NULL, np,
+				      of_dev_node_match);
 	return dev ? to_platform_device(dev) : NULL;
 }
 EXPORT_SYMBOL(of_find_device_by_node);
@@ -196,6 +209,7 @@ static struct platform_device *of_platform_device_create_pdata(
 		platform_device_put(dev);
 		goto err_clear_flag;
 	}
+	np->dev = &dev->dev;
 
 	return dev;
 
@@ -556,6 +570,10 @@ int of_platform_device_destroy(struct device *dev, void *data)
 	if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
 		device_for_each_child(dev, NULL, of_platform_device_destroy);
 
+	/* Spinlock is needed for of_find_device_by_node() to work */
+	spin_lock(&of_dev_lock);
+	dev->of_node->dev = NULL;
+	spin_unlock(&of_dev_lock);
 	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 0cf857012f11..f2b4912cbca1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -48,6 +48,8 @@ struct property {
 struct of_irq_controller;
 #endif
 
+struct device;
+
 struct device_node {
 	const char *name;
 	phandle phandle;
@@ -68,6 +70,7 @@ struct device_node {
 	unsigned int unique_id;
 	struct of_irq_controller *irq_trans;
 #endif
+	struct device *dev;		/* Device created from this node */
 };
 
 #define MAX_PHANDLE_ARGS 16
-- 
2.22.0.rc1.257.g3120a18244-goog

