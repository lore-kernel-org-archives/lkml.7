Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE49BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5E2208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560341600;
	bh=HEfVF3kXxJ0nC/WZgJnYTwFfoLD22fZO73D9qujcDW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cop6uFaGk6WJ6WpciC1TZrdZNzR5whCnruYpS1q3SBFAj4nhkZOByPuwrN+9/8E+i
	 s8ABx3jLpOuGnXdRufNjmd8//7cVzB3bcMcfx6kKTSmRKO82vw1KUdyadG/D3XcoZ/
	 SQcTiVmgJ/htSShrUsKuVRSmbwMnlmRlrpTVZoRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbfFLMNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfFLMNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:13:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C27208C4;
        Wed, 12 Jun 2019 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560341593;
        bh=HEfVF3kXxJ0nC/WZgJnYTwFfoLD22fZO73D9qujcDW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uly5nhvqu+cerVeYBgywQQJ0UwSMl6Ifr/guGTXQVODWkOj6CgbNDKDo8ju5vus7/
         a7sg0+ot4IZ0H3oWXRpJwjqP1PitvtQvuKJ/2u76Kh3XQ0EktwCYlzeHB7bb3toIY1
         CKAP7QnDPgYo/Fk1aMRXvshU4DIkKRv8Ov3iRTFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] platform: x86: asus-wmi: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:12:52 +0200
Message-Id: <20190612121258.19535-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612121258.19535-1-gregkh@linuxfoundation.org>
References: <20190612121258.19535-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Corentin Chary <corentin.chary@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: acpi4asus-user@lists.sourceforge.net
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/asus-wmi.c | 47 ++++++++-------------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3e4336025e8f..4e3786eae349 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2005,50 +2005,29 @@ static void asus_wmi_debugfs_exit(struct asus_wmi *asus)
 	debugfs_remove_recursive(asus->debug.root);
 }
 
-static int asus_wmi_debugfs_init(struct asus_wmi *asus)
+static void asus_wmi_debugfs_init(struct asus_wmi *asus)
 {
-	struct dentry *dent;
 	int i;
 
 	asus->debug.root = debugfs_create_dir(asus->driver->name, NULL);
-	if (!asus->debug.root) {
-		pr_err("failed to create debugfs directory\n");
-		goto error_debugfs;
-	}
 
-	dent = debugfs_create_x32("method_id", S_IRUGO | S_IWUSR,
-				  asus->debug.root, &asus->debug.method_id);
-	if (!dent)
-		goto error_debugfs;
+	debugfs_create_x32("method_id", S_IRUGO | S_IWUSR, asus->debug.root,
+			   &asus->debug.method_id);
 
-	dent = debugfs_create_x32("dev_id", S_IRUGO | S_IWUSR,
-				  asus->debug.root, &asus->debug.dev_id);
-	if (!dent)
-		goto error_debugfs;
+	debugfs_create_x32("dev_id", S_IRUGO | S_IWUSR, asus->debug.root,
+			   &asus->debug.dev_id);
 
-	dent = debugfs_create_x32("ctrl_param", S_IRUGO | S_IWUSR,
-				  asus->debug.root, &asus->debug.ctrl_param);
-	if (!dent)
-		goto error_debugfs;
+	debugfs_create_x32("ctrl_param", S_IRUGO | S_IWUSR, asus->debug.root,
+			   &asus->debug.ctrl_param);
 
 	for (i = 0; i < ARRAY_SIZE(asus_wmi_debug_files); i++) {
 		struct asus_wmi_debugfs_node *node = &asus_wmi_debug_files[i];
 
 		node->asus = asus;
-		dent = debugfs_create_file(node->name, S_IFREG | S_IRUGO,
-					   asus->debug.root, node,
-					   &asus_wmi_debugfs_io_ops);
-		if (!dent) {
-			pr_err("failed to create debug file: %s\n", node->name);
-			goto error_debugfs;
-		}
+		debugfs_create_file(node->name, S_IFREG | S_IRUGO,
+				    asus->debug.root, node,
+				    &asus_wmi_debugfs_io_ops);
 	}
-
-	return 0;
-
-error_debugfs:
-	asus_wmi_debugfs_exit(asus);
-	return -ENOMEM;
 }
 
 static int asus_wmi_fan_init(struct asus_wmi *asus)
@@ -2162,14 +2141,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 		goto fail_wmi_handler;
 	}
 
-	err = asus_wmi_debugfs_init(asus);
-	if (err)
-		goto fail_debugfs;
+	asus_wmi_debugfs_init(asus);
 
 	return 0;
 
-fail_debugfs:
-	wmi_remove_notify_handler(asus->driver->event_guid);
 fail_wmi_handler:
 	asus_wmi_backlight_exit(asus);
 fail_backlight:
-- 
2.22.0

