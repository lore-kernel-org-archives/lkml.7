Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AFBC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB90621874
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfCNQKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:10:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfCNQKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:10:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15C4F67BAC;
        Thu, 14 Mar 2019 16:10:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A46A917C28;
        Thu, 14 Mar 2019 16:10:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/38] vfs: Convert ia64 perfmon to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:10:32 +0000
Message-ID: <155257983288.13720.10412307262671159711.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 14 Mar 2019 16:10:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Tony Luck <tony.luck@intel.com>
cc: Fenghua Yu <fenghua.yu@intel.com>
cc: linux-ia64@vger.kernel.org
---

 arch/ia64/kernel/perfmon.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 7a969f4c3534..4b5770736ac5 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -38,6 +38,7 @@
 #include <linux/smp.h>
 #include <linux/pagemap.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/bitops.h>
 #include <linux/capability.h>
 #include <linux/rcupdate.h>
@@ -599,17 +600,16 @@ pfm_unprotect_ctx_ctxsw(pfm_context_t *x, unsigned long f)
 /* forward declaration */
 static const struct dentry_operations pfmfs_dentry_operations;
 
-static struct dentry *
-pfmfs_mount(struct file_system_type *fs_type, int flags, const char *dev_name, void *data)
+static int pfmfs_init_fs_context(struct fs_context *fc)
 {
-	return mount_pseudo(fs_type, "pfm:", NULL, &pfmfs_dentry_operations,
-			PFMFS_MAGIC);
+	return vfs_init_pseudo_fs_context(fc, "pfm:", NULL, NULL,
+					  &pfmfs_dentry_operations, PFMFS_MAGIC);
 }
 
 static struct file_system_type pfm_fs_type = {
-	.name     = "pfmfs",
-	.mount    = pfmfs_mount,
-	.kill_sb  = kill_anon_super,
+	.name			= "pfmfs",
+	.init_fs_context	= pfmfs_init_fs_context,
+	.kill_sb		= kill_anon_super,
 };
 MODULE_ALIAS_FS("pfmfs");
 

