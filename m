Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCE1C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E5F21773
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279333;
	bh=0R2zOmorGZsNgEEEPiNEgjzKH2jE82jgb9T4TNAc6XE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CkJ0TuxTZGgbEa7ST2YDt/L6WpPoVCns+AsmgcYlxCAzA1itALRSCS6v/yJlz5gaA
	 djh1C/lt0Y60SbI2KoUjxRtTWQKOKIm2o4P9AjnpkENY3qDWoWZALMh2AHA6jLyfcM
	 gbVPNFWo6cj7VVnPawjzcbrHE1iS+MMBfMDK+ShM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404230AbfFKSzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391772AbfFKSzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:55:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FA9206E0;
        Tue, 11 Jun 2019 18:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279331;
        bh=0R2zOmorGZsNgEEEPiNEgjzKH2jE82jgb9T4TNAc6XE=;
        h=Date:From:To:Cc:Subject:From;
        b=WAc2/XLofYI4U2Ry9ppcLh0Qu/nw6o884k+QOvXXY64ECbeLjOyo/HoRR6F7OopAC
         slilVZmVe89gbiPJK90aFkE7pHzZv/tbf+4pAD79EKzb+GtmlS00UGYec7oEJMr9yV
         QEOzFTS9iXpo82Tvc2c0iPSjYYR1GovUOQNHYyVI=
Date:   Tue, 11 Jun 2019 20:55:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Julien Freche <jfreche@vmware.com>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] vmw_ballon: no need to check return value of debugfs_create
 functions
Message-ID: <20190611185528.GA4659@kroah.com>
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

Cc: Julien Freche <jfreche@vmware.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: "VMware, Inc." <pv-drivers@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/vmw_balloon.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index ad807d5a3141..fdf5ad757226 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1516,19 +1516,10 @@ static int vmballoon_debug_show(struct seq_file *f, void *offset)
 
 DEFINE_SHOW_ATTRIBUTE(vmballoon_debug);
 
-static int __init vmballoon_debugfs_init(struct vmballoon *b)
+static void __init vmballoon_debugfs_init(struct vmballoon *b)
 {
-	int error;
-
 	b->dbg_entry = debugfs_create_file("vmmemctl", S_IRUGO, NULL, b,
 					   &vmballoon_debug_fops);
-	if (IS_ERR(b->dbg_entry)) {
-		error = PTR_ERR(b->dbg_entry);
-		pr_err("failed to create debugfs entry, error: %d\n", error);
-		return error;
-	}
-
-	return 0;
 }
 
 static void __exit vmballoon_debugfs_exit(struct vmballoon *b)
@@ -1541,9 +1532,8 @@ static void __exit vmballoon_debugfs_exit(struct vmballoon *b)
 
 #else
 
-static inline int vmballoon_debugfs_init(struct vmballoon *b)
+static inline void vmballoon_debugfs_init(struct vmballoon *b)
 {
-	return 0;
 }
 
 static inline void vmballoon_debugfs_exit(struct vmballoon *b)
@@ -1555,7 +1545,6 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
 static int __init vmballoon_init(void)
 {
 	enum vmballoon_page_size_type page_size;
-	int error;
 
 	/*
 	 * Check if we are running on VMware's hypervisor and bail out
@@ -1571,9 +1560,7 @@ static int __init vmballoon_init(void)
 
 	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
 
-	error = vmballoon_debugfs_init(&balloon);
-	if (error)
-		return error;
+	vmballoon_debugfs_init(&balloon);
 
 	spin_lock_init(&balloon.comm_lock);
 	init_rwsem(&balloon.conf_sem);
-- 
2.22.0

