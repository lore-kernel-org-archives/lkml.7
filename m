Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB5DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370C0217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560341616;
	bh=VzkLSGcPjGZ9zxQTwow3pQZPqT0PVx6/J+e/zLME1/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gSAmbfgqztDnz/rR3rccJOfz8tJJqK4rDxNixIEmqmOSGzKtd6b0FBhTU/Db5ZI/3
	 967aLPse4A2YC1HiC0NrcQ/p4HIAq+dYgoiG2sDr/42ipUuAYctbeYfj+giBRkb6DM
	 fVK6eJejMbJpBmCZa5y8v5FUFOHGDFU+RlWhgBus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438682AbfFLMNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438674AbfFLMNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:13:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B10C2173C;
        Wed, 12 Jun 2019 12:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560341609;
        bh=VzkLSGcPjGZ9zxQTwow3pQZPqT0PVx6/J+e/zLME1/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xIWVqNFE2nkFvJpuwYJPFllQ7QHMXPFGKAwUffq7vm6sBOZDxe4NeBynIO5OyfsFn
         qGueKqvHKONrl2RTzjLAJuqBmBXDquwWF0twnRgyCUNvPxsPEXlMxxXY8fmHhTUB5y
         F3QIsSdhBcDHHA4Sr16ou/mnQd85PzAWnMVP0OUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] platform: x86: intel_telemetry: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:12:58 +0200
Message-Id: <20190612121258.19535-8-gregkh@linuxfoundation.org>
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

Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Cc: "David E. Box" <david.e.box@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../platform/x86/intel_telemetry_debugfs.c    | 78 ++++---------------
 1 file changed, 16 insertions(+), 62 deletions(-)

diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
index 98ba9185a27b..e84d3e983e0c 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -900,7 +900,7 @@ static int __init telemetry_debugfs_init(void)
 {
 	const struct x86_cpu_id *id;
 	int err;
-	struct dentry *f;
+	struct dentry *dir;
 
 	/* Only APL supported for now */
 	id = x86_match_cpu(telemetry_debugfs_cpu_ids);
@@ -923,68 +923,22 @@ static int __init telemetry_debugfs_init(void)
 
 	register_pm_notifier(&pm_notifier);
 
-	err = -ENOMEM;
-	debugfs_conf->telemetry_dbg_dir = debugfs_create_dir("telemetry", NULL);
-	if (!debugfs_conf->telemetry_dbg_dir)
-		goto out_pm;
-
-	f = debugfs_create_file("pss_info", S_IFREG | S_IRUGO,
-				debugfs_conf->telemetry_dbg_dir, NULL,
-				&telem_pss_states_fops);
-	if (!f) {
-		pr_err("pss_sample_info debugfs register failed\n");
-		goto out;
-	}
-
-	f = debugfs_create_file("ioss_info", S_IFREG | S_IRUGO,
-				debugfs_conf->telemetry_dbg_dir, NULL,
-				&telem_ioss_states_fops);
-	if (!f) {
-		pr_err("ioss_sample_info debugfs register failed\n");
-		goto out;
-	}
-
-	f = debugfs_create_file("soc_states", S_IFREG | S_IRUGO,
-				debugfs_conf->telemetry_dbg_dir,
-				NULL, &telem_soc_states_fops);
-	if (!f) {
-		pr_err("ioss_sample_info debugfs register failed\n");
-		goto out;
-	}
-
-	f = debugfs_create_file("s0ix_residency_usec", S_IFREG | S_IRUGO,
-				debugfs_conf->telemetry_dbg_dir,
-				NULL, &telem_s0ix_fops);
-	if (!f) {
-		pr_err("s0ix_residency_usec debugfs register failed\n");
-		goto out;
-	}
-
-	f = debugfs_create_file("pss_trace_verbosity", S_IFREG | S_IRUGO,
-				debugfs_conf->telemetry_dbg_dir, NULL,
-				&telem_pss_trc_verb_ops);
-	if (!f) {
-		pr_err("pss_trace_verbosity debugfs register failed\n");
-		goto out;
-	}
-
-	f = debugfs_create_file("ioss_trace_verbosity", S_IFREG | S_IRUGO,
-				debugfs_conf->telemetry_dbg_dir, NULL,
-				&telem_ioss_trc_verb_ops);
-	if (!f) {
-		pr_err("ioss_trace_verbosity debugfs register failed\n");
-		goto out;
-	}
-
+	dir = debugfs_create_dir("telemetry", NULL);
+	debugfs_conf->telemetry_dbg_dir = dir;
+
+	debugfs_create_file("pss_info", S_IFREG | S_IRUGO, dir, NULL,
+			    &telem_pss_states_fops);
+	debugfs_create_file("ioss_info", S_IFREG | S_IRUGO, dir, NULL,
+			    &telem_ioss_states_fops);
+	debugfs_create_file("soc_states", S_IFREG | S_IRUGO, dir, NULL,
+			    &telem_soc_states_fops);
+	debugfs_create_file("s0ix_residency_usec", S_IFREG | S_IRUGO, dir, NULL,
+			    &telem_s0ix_fops);
+	debugfs_create_file("pss_trace_verbosity", S_IFREG | S_IRUGO, dir, NULL,
+			    &telem_pss_trc_verb_ops);
+	debugfs_create_file("ioss_trace_verbosity", S_IFREG | S_IRUGO, dir,
+			    NULL, &telem_ioss_trc_verb_ops);
 	return 0;
-
-out:
-	debugfs_remove_recursive(debugfs_conf->telemetry_dbg_dir);
-	debugfs_conf->telemetry_dbg_dir = NULL;
-out_pm:
-	unregister_pm_notifier(&pm_notifier);
-
-	return err;
 }
 
 static void __exit telemetry_debugfs_exit(void)
-- 
2.22.0

