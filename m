Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B330C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F20208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560341605;
	bh=s7t54JWbBuNtEvtmX8/LDytHT2xfujJQNzLt26RSLK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PXRH+SVYWP6a9snYK0ny7bFOH5s/9Z7O97xXxE58FDiOelf+2KOmQSaUjEh0FscnS
	 zI2xP3dlqE7mf8MmTOekJOlqtuqGNeyU4q6vQW9Jr+6Kiv0HSmP3ARz2XZ39wxvWJl
	 tS/nNPz8Gi/LRCvho2XaCdUkQvaKpFzoY6QTIYxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbfFLMNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbfFLMNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:13:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C286208CA;
        Wed, 12 Jun 2019 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560341601;
        bh=s7t54JWbBuNtEvtmX8/LDytHT2xfujJQNzLt26RSLK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpv41V0nZjIAJGFvc7NA4lGDoD2jotV0pKMKdLkbDoKvwAbdC+dDy7tx+ZGCwBmgg
         SjZVtWp2xpmn2nrLHllnPjEcxhgXi6aHs7JFxBLdvxrjJjD8e2k4sD+cM9MOTqhme6
         m2fDURwhnGvWvxPkDME2wqzoFREMV9jobEbkoj8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] platform: x86: samsung-laptop: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:12:55 +0200
Message-Id: <20190612121258.19535-5-gregkh@linuxfoundation.org>
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
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/samsung-laptop.c | 89 +++++++--------------------
 1 file changed, 23 insertions(+), 66 deletions(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 7b160ee98115..e84f11398c1b 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1280,15 +1280,12 @@ static void samsung_debugfs_exit(struct samsung_laptop *samsung)
 	debugfs_remove_recursive(samsung->debug.root);
 }
 
-static int samsung_debugfs_init(struct samsung_laptop *samsung)
+static void samsung_debugfs_init(struct samsung_laptop *samsung)
 {
-	struct dentry *dent;
+	struct dentry *root;
 
-	samsung->debug.root = debugfs_create_dir("samsung-laptop", NULL);
-	if (!samsung->debug.root) {
-		pr_err("failed to create debugfs directory");
-		goto error_debugfs;
-	}
+	root = debugfs_create_dir("samsung-laptop", NULL);
+	samsung->debug.root = root;
 
 	samsung->debug.f0000_wrapper.data = samsung->f0000_segment;
 	samsung->debug.f0000_wrapper.size = 0xffff;
@@ -1299,60 +1296,24 @@ static int samsung_debugfs_init(struct samsung_laptop *samsung)
 	samsung->debug.sdiag_wrapper.data = samsung->sdiag;
 	samsung->debug.sdiag_wrapper.size = strlen(samsung->sdiag);
 
-	dent = debugfs_create_u16("command", S_IRUGO | S_IWUSR,
-				  samsung->debug.root, &samsung->debug.command);
-	if (!dent)
-		goto error_debugfs;
-
-	dent = debugfs_create_u32("d0", S_IRUGO | S_IWUSR, samsung->debug.root,
-				  &samsung->debug.data.d0);
-	if (!dent)
-		goto error_debugfs;
-
-	dent = debugfs_create_u32("d1", S_IRUGO | S_IWUSR, samsung->debug.root,
-				  &samsung->debug.data.d1);
-	if (!dent)
-		goto error_debugfs;
-
-	dent = debugfs_create_u16("d2", S_IRUGO | S_IWUSR, samsung->debug.root,
-				  &samsung->debug.data.d2);
-	if (!dent)
-		goto error_debugfs;
-
-	dent = debugfs_create_u8("d3", S_IRUGO | S_IWUSR, samsung->debug.root,
-				 &samsung->debug.data.d3);
-	if (!dent)
-		goto error_debugfs;
-
-	dent = debugfs_create_blob("data", S_IRUGO | S_IWUSR,
-				   samsung->debug.root,
-				   &samsung->debug.data_wrapper);
-	if (!dent)
-		goto error_debugfs;
-
-	dent = debugfs_create_blob("f0000_segment", S_IRUSR | S_IWUSR,
-				   samsung->debug.root,
-				   &samsung->debug.f0000_wrapper);
-	if (!dent)
-		goto error_debugfs;
-
-	dent = debugfs_create_file("call", S_IFREG | S_IRUGO,
-				   samsung->debug.root, samsung,
-				   &samsung_laptop_call_fops);
-	if (!dent)
-		goto error_debugfs;
-
-	dent = debugfs_create_blob("sdiag", S_IRUGO | S_IWUSR,
-				   samsung->debug.root,
-				   &samsung->debug.sdiag_wrapper);
-	if (!dent)
-		goto error_debugfs;
-
-	return 0;
-
-error_debugfs:
-	samsung_debugfs_exit(samsung);
-	return -ENOMEM;
+	debugfs_create_u16("command", S_IRUGO | S_IWUSR, root,
+			   &samsung->debug.command);
+	debugfs_create_u32("d0", S_IRUGO | S_IWUSR, root,
+			   &samsung->debug.data.d0);
+	debugfs_create_u32("d1", S_IRUGO | S_IWUSR, root,
+			   &samsung->debug.data.d1);
+	debugfs_create_u16("d2", S_IRUGO | S_IWUSR, root,
+			   &samsung->debug.data.d2);
+	debugfs_create_u8("d3", S_IRUGO | S_IWUSR, root,
+			  &samsung->debug.data.d3);
+	debugfs_create_blob("data", S_IRUGO | S_IWUSR, root,
+			    &samsung->debug.data_wrapper);
+	debugfs_create_blob("f0000_segment", S_IRUSR | S_IWUSR, root,
+			    &samsung->debug.f0000_wrapper);
+	debugfs_create_file("call", S_IFREG | S_IRUGO, root, samsung,
+			    &samsung_laptop_call_fops);
+	debugfs_create_blob("sdiag", S_IRUGO | S_IWUSR, root,
+			    &samsung->debug.sdiag_wrapper);
 }
 
 static void samsung_sabi_exit(struct samsung_laptop *samsung)
@@ -1745,9 +1706,7 @@ static int __init samsung_init(void)
 	if (ret)
 		goto error_lid_handling;
 
-	ret = samsung_debugfs_init(samsung);
-	if (ret)
-		goto error_debugfs;
+	samsung_debugfs_init(samsung);
 
 	samsung->pm_nb.notifier_call = samsung_pm_notification;
 	register_pm_notifier(&samsung->pm_nb);
@@ -1755,8 +1714,6 @@ static int __init samsung_init(void)
 	samsung_platform_device = samsung->platform_device;
 	return ret;
 
-error_debugfs:
-	samsung_lid_handling_exit(samsung);
 error_lid_handling:
 	samsung_leds_exit(samsung);
 error_leds:
-- 
2.22.0

