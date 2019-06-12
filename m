Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06582C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD90C20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560352536;
	bh=8YsZVYvb5Dgl2t1CnOn762ha2MjdrYZOjpGQ6A63jAU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Vb2wA9pHbM02m/dgzUmLwhvmAtB8neI+5v80nqUs4A5YmidG3kgOv0EPc+e7EwnSp
	 RE5hNbXAA6IuTQczgxGYi50I3IM3NjnwUXVczUrBEZ6Bqau1HLUWeDXBi4N9gVopxc
	 k4tkY8CRh5BOOdDEdlk/SFfC7Fo2jfNoaS9C0fG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfFLPPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfFLPPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:15:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5EA120874;
        Wed, 12 Jun 2019 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560352534;
        bh=8YsZVYvb5Dgl2t1CnOn762ha2MjdrYZOjpGQ6A63jAU=;
        h=Date:From:To:Cc:Subject:From;
        b=kHsQ1CgN+2e2sOphto06r/jAXCSZ6TRRKiXs81Wv11i9YS37FU913sSJIT0OUUfNr
         d+mGzTbZ1yc8QDPXAG5xwz1zHdLgmjENscpwFOU5kpuhSrxceiTUxUcHfg5H/jZp+K
         WHTcxRVL2nJgH8le/rmd7GHeB0Km0e+K5lztrEE4=
Date:   Wed, 12 Jun 2019 17:15:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Pu Wen <puwen@hygon.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: mce: no need to check return value of debugfs_create
 functions
Message-ID: <20190612151531.GA16278@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Pu Wen <puwen@hygon.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/mce/core.c     | 16 +++++---------
 arch/x86/kernel/cpu/mce/inject.c   | 34 +++++-------------------------
 arch/x86/kernel/cpu/mce/severity.c | 14 +++---------
 3 files changed, 13 insertions(+), 51 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 282916f3b8d8..fb055b9a486a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2441,22 +2441,16 @@ static int fake_panic_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fake_panic_fops, fake_panic_get, fake_panic_set,
 			 "%llu\n");
 
-static int __init mcheck_debugfs_init(void)
+static void __init mcheck_debugfs_init(void)
 {
-	struct dentry *dmce, *ffake_panic;
+	struct dentry *dmce;
 
 	dmce = mce_get_debugfs_dir();
-	if (!dmce)
-		return -ENOMEM;
-	ffake_panic = debugfs_create_file_unsafe("fake_panic", 0444, dmce,
-						 NULL, &fake_panic_fops);
-	if (!ffake_panic)
-		return -ENOMEM;
-
-	return 0;
+	debugfs_create_file_unsafe("fake_panic", 0444, dmce, NULL,
+				   &fake_panic_fops);
 }
 #else
-static int __init mcheck_debugfs_init(void) { return -EINVAL; }
+static void __init mcheck_debugfs_init(void) { }
 #endif
 
 DEFINE_STATIC_KEY_FALSE(mcsafe_key);
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5d108f70f315..97a0d5384c08 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -645,7 +645,6 @@ static const struct file_operations readme_fops = {
 
 static struct dfs_node {
 	char *name;
-	struct dentry *d;
 	const struct file_operations *fops;
 	umode_t perm;
 } dfs_fls[] = {
@@ -659,35 +658,16 @@ static struct dfs_node {
 	{ .name = "README",	.fops = &readme_fops, .perm = S_IRUSR | S_IRGRP | S_IROTH },
 };
 
-static int __init debugfs_init(void)
+static void __init debugfs_init(void)
 {
 	unsigned int i;
 
 	dfs_inj = debugfs_create_dir("mce-inject", NULL);
-	if (!dfs_inj)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(dfs_fls); i++) {
-		dfs_fls[i].d = debugfs_create_file(dfs_fls[i].name,
-						    dfs_fls[i].perm,
-						    dfs_inj,
-						    &i_mce,
-						    dfs_fls[i].fops);
-
-		if (!dfs_fls[i].d)
-			goto err_dfs_add;
-	}
-
-	return 0;
 
-err_dfs_add:
-	while (i-- > 0)
-		debugfs_remove(dfs_fls[i].d);
+	for (i = 0; i < ARRAY_SIZE(dfs_fls); i++)
+		debugfs_create_file(dfs_fls[i].name, dfs_fls[i].perm, dfs_inj,
+				    &i_mce, dfs_fls[i].fops);
 
-	debugfs_remove(dfs_inj);
-	dfs_inj = NULL;
-
-	return -ENODEV;
 }
 
 static int __init inject_init(void)
@@ -697,11 +677,7 @@ static int __init inject_init(void)
 	if (!alloc_cpumask_var(&mce_inject_cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
-	err = debugfs_init();
-	if (err) {
-		free_cpumask_var(mce_inject_cpumask);
-		return err;
-	}
+	debugfs_init();
 
 	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify");
 	mce_register_injector_chain(&inject_nb);
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 65201e180fe0..27fd6816e270 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -404,21 +404,13 @@ static const struct file_operations severities_coverage_fops = {
 
 static int __init severities_debugfs_init(void)
 {
-	struct dentry *dmce, *fsev;
+	struct dentry *dmce;
 
 	dmce = mce_get_debugfs_dir();
-	if (!dmce)
-		goto err_out;
-
-	fsev = debugfs_create_file("severities-coverage", 0444, dmce, NULL,
-				   &severities_coverage_fops);
-	if (!fsev)
-		goto err_out;
 
+	debugfs_create_file("severities-coverage", 0444, dmce, NULL,
+			    &severities_coverage_fops);
 	return 0;
-
-err_out:
-	return -ENOMEM;
 }
 late_initcall(severities_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
-- 
2.22.0

