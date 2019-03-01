Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D4DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E77120675
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbfCAOxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:53:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:38690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728171AbfCAOx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:53:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04BE7B118;
        Fri,  1 Mar 2019 14:53:26 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     keescook@chromium.org
Cc:     joel@joelfernandes.org, tony.luck@intel.com, ccross@android.com,
        anton@enomsg.org, duwe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: automatically dump and clean dmesg entries
Date:   Fri, 01 Mar 2019 15:53:25 +0100
Message-ID: <35267159.Lyx5QdZ5Rb@house>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Torsten Duwe <duwe@suse.de>

Dump a previous oops or panic, which has made it to pstore,
to the new syslog after reboot, optionally deleting it.
This can happen automatically, without user land interaction.

Signed-off-by: Torsten Duwe <duwe@suse.de>
CC: Thomas Renninger <trenn@suse.de>

---
 fs/pstore/inode.c    |  6 +++---
 fs/pstore/internal.h | 11 +++++++++--
 fs/pstore/platform.c | 33 +++++++++++++++++++++++++++------
 3 files changed, 39 insertions(+), 11 deletions(-)

Index: test_pstore/fs/pstore/inode.c
===================================================================
--- test_pstore.orig/fs/pstore/inode.c	2019-03-01 13:55:50.561322896 +0100
+++ test_pstore/fs/pstore/inode.c	2019-03-01 13:56:05.349323693 +0100
@@ -374,7 +374,7 @@ fail:
  * when we are re-scanning the backing store looking to add new
  * error records.
  */
-void pstore_get_records(int quiet)
+void pstore_get_records(unsigned flags)
 {
 	struct pstore_info *psi = psinfo;
 	struct dentry *root;
@@ -385,7 +385,7 @@ void pstore_get_records(int quiet)
 	root = pstore_sb->s_root;
 
 	inode_lock(d_inode(root));
-	pstore_get_backend_records(psi, root, quiet);
+	pstore_get_backend_records(psi, root, flags);
 	inode_unlock(d_inode(root));
 }
 
@@ -415,7 +415,7 @@ static int pstore_fill_super(struct supe
 	if (!sb->s_root)
 		return -ENOMEM;
 
-	pstore_get_records(0);
+	pstore_get_records(PGR_VERBOSE|PGR_POPULATE);
 
 	return 0;
 }
Index: test_pstore/fs/pstore/internal.h
===================================================================
--- test_pstore.orig/fs/pstore/internal.h	2019-03-01 13:55:50.565322897 +0100
+++ test_pstore/fs/pstore/internal.h	2019-03-01 13:56:05.349323693 +0100
@@ -28,9 +28,16 @@ static inline void pstore_unregister_pms
 extern struct pstore_info *psinfo;
 
 extern void	pstore_set_kmsg_bytes(int);
-extern void	pstore_get_records(int);
+extern void	pstore_get_records(unsigned);
+/* Flags for the pstore iterator pstore_get_records() */
+#define PGR_QUIET	0
+#define PGR_VERBOSE	1
+#define PGR_POPULATE	2
+#define PGR_SYSLOG	4
+#define PGR_CLEAR	8
+
 extern void	pstore_get_backend_records(struct pstore_info *psi,
-					   struct dentry *root, int quiet);
+					   struct dentry *root, unsigned flags);
 extern int	pstore_mkfile(struct dentry *root,
 			      struct pstore_record *record);
 extern bool	pstore_is_mounted(void);
Index: test_pstore/fs/pstore/platform.c
===================================================================
--- test_pstore.orig/fs/pstore/platform.c	2019-03-01 13:55:50.565322897 +0100
+++ test_pstore/fs/pstore/platform.c	2019-03-01 13:59:06.077333431 +0100
@@ -87,6 +87,11 @@ static DECLARE_WORK(pstore_work, pstore_
 static DEFINE_SPINLOCK(pstore_lock);
 struct pstore_info *psinfo;
 
+static int auto_action=0;
+module_param(auto_action, int, 0664);
+MODULE_PARM_DESC(auto_action, "action to take on backend "
+		 "registration: 0=nothing, 1=print, 2=print+clear");
+
 static char *backend;
 static char *compress =
 #ifdef CONFIG_PSTORE_COMPRESS_DEFAULT
@@ -108,6 +113,8 @@ static size_t big_oops_buf_sz;
 
 /* How much of the console log to snapshot */
 unsigned long kmsg_bytes = PSTORE_DEFAULT_KMSG_BYTES;
+module_param(kmsg_bytes, ulong, 0644);
+MODULE_PARM_DESC(kmsg_bytes, "maximum size to save of a crash dump");
 
 void pstore_set_kmsg_bytes(int bytes)
 {
@@ -606,7 +613,11 @@ int pstore_register(struct pstore_info *
 	allocate_buf_for_compression();
 
 	if (pstore_is_mounted())
-		pstore_get_records(0);
+		pstore_get_records(PGR_VERBOSE|PGR_POPULATE);
+
+	if (auto_action)
+		pstore_get_records(PGR_SYSLOG|
+				   ((auto_action>1)?PGR_CLEAR:0));
 
 	if (psi->flags & PSTORE_FLAGS_DMESG)
 		pstore_register_kmsg();
@@ -723,7 +734,7 @@ static void decompress_record(struct pst
  * error records.
  */
 void pstore_get_backend_records(struct pstore_info *psi,
-				struct dentry *root, int quiet)
+				struct dentry *root, unsigned flags)
 {
 	int failed = 0;
 	unsigned int stop_loop = 65536;
@@ -742,7 +753,7 @@ void pstore_get_backend_records(struct p
 	 */
 	for (; stop_loop; stop_loop--) {
 		struct pstore_record *record;
-		int rc;
+		int rc = 0;
 
 		record = kzalloc(sizeof(*record), GFP_KERNEL);
 		if (!record) {
@@ -760,12 +771,23 @@ void pstore_get_backend_records(struct p
 		}
 
 		decompress_record(record);
-		rc = pstore_mkfile(root, record);
+		if (flags & PGR_POPULATE)
+			rc = pstore_mkfile(root, record);
+		if (record->type == PSTORE_TYPE_DMESG) {
+			if (flags & PGR_SYSLOG) {
+				pr_notice("---------- pstore: ----------\n");
+				pr_notice("%.*s\n", (int)record->size,
+					  record->buf);
+				pr_notice("-----------------------------\n");
+			}
+			if (flags & PGR_CLEAR && psi->erase)
+				psi->erase(record);
+		}
 		if (rc) {
 			/* pstore_mkfile() did not take record, so free it. */
 			kfree(record->buf);
 			kfree(record);
-			if (rc != -EEXIST || !quiet)
+			if (rc != -EEXIST || (flags & PGR_VERBOSE))
 				failed++;
 		}
 	}
@@ -784,7 +806,7 @@ out:
 
 static void pstore_dowork(struct work_struct *work)
 {
-	pstore_get_records(1);
+	pstore_get_records(PGR_QUIET|PGR_POPULATE);
 }
 
 static void pstore_timefunc(struct timer_list *unused)

