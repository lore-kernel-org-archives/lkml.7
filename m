Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966EDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7E9208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560341623;
	bh=meMOfm/cp2ZdmdOTfHwzOUf3Ik63/BpInCj8Dv0OURk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2mFiKx5JVdcLJQ6oy/EKOoAS8fC19orvKFJRYtFcQi9iqFpq270mldhnsq0ZiVwz8
	 0QKhHlixOjflpAvOS7WPPR92chm2zlxpCGavFJZohrsvAB8DriObGAChBVhcHzluWn
	 1JWrUPO/ikXXmlOsvsaWh967qbuwOms5IGKhjl6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438710AbfFLMNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731398AbfFLMNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:13:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADCD121019;
        Wed, 12 Jun 2019 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560341599;
        bh=meMOfm/cp2ZdmdOTfHwzOUf3Ik63/BpInCj8Dv0OURk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwxd+mORdOMEwy7oRUBVQ9NGUlquywuNXh1lFe/AvAVgSH1inkX1PrSyx8eWaqoFS
         O1mdBM1EMzjnyxUwdVyLlgxdZLaSDJkz5ULfVpGAqKuTpJzAOiLQv/VV+xlUcvhU2H
         bI5TP2yyMMQHPgVYww5iIsAA2Q+Dt63Q/FYxyJZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ike Panhc <ike.pan@canonical.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] platform: x86: ideapad-laptop: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:12:54 +0200
Message-Id: <20190612121258.19535-4-gregkh@linuxfoundation.org>
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

Cc: Ike Panhc <ike.pan@canonical.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/ideapad-laptop.c | 36 ++++++---------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 5fb9bfdf1019..7598cd46cf60 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -316,34 +316,15 @@ static int debugfs_cfg_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(debugfs_cfg);
 
-static int ideapad_debugfs_init(struct ideapad_private *priv)
+static void ideapad_debugfs_init(struct ideapad_private *priv)
 {
-	struct dentry *node;
+	struct dentry *dir;
 
-	priv->debug = debugfs_create_dir("ideapad", NULL);
-	if (priv->debug == NULL) {
-		pr_err("failed to create debugfs directory");
-		goto errout;
-	}
-
-	node = debugfs_create_file("cfg", S_IRUGO, priv->debug, priv,
-				   &debugfs_cfg_fops);
-	if (!node) {
-		pr_err("failed to create cfg in debugfs");
-		goto errout;
-	}
-
-	node = debugfs_create_file("status", S_IRUGO, priv->debug, priv,
-				   &debugfs_status_fops);
-	if (!node) {
-		pr_err("failed to create status in debugfs");
-		goto errout;
-	}
-
-	return 0;
+	dir = debugfs_create_dir("ideapad", NULL);
+	priv->debug = dir;
 
-errout:
-	return -ENOMEM;
+	debugfs_create_file("cfg", S_IRUGO, dir, priv, &debugfs_cfg_fops);
+	debugfs_create_file("status", S_IRUGO, dir, priv, &debugfs_status_fops);
 }
 
 static void ideapad_debugfs_exit(struct ideapad_private *priv)
@@ -1012,9 +993,7 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = ideapad_debugfs_init(priv);
-	if (ret)
-		goto debugfs_failed;
+	ideapad_debugfs_init(priv);
 
 	ret = ideapad_input_init(priv);
 	if (ret)
@@ -1071,7 +1050,6 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	ideapad_input_exit(priv);
 input_failed:
 	ideapad_debugfs_exit(priv);
-debugfs_failed:
 	ideapad_sysfs_exit(priv);
 	return ret;
 }
-- 
2.22.0

