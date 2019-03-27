Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C68BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149352075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="fa5sgELy";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="m1RGXT0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfC0JoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:44:16 -0400
Received: from mail128-16.atl41.mandrillapp.com ([198.2.128.16]:18894 "EHLO
        mail128-16.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726241AbfC0JoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:44:16 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 05:44:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=M3W9EymIbtNlepIICFQEKnmSlW1q5GOiNtFo19F089s=;
 b=fa5sgELyEmrI/UFTSFMBRqvvTjfJEzh2dZwqaHa6G/qPax08LcQc0PervWzyuhOqLzphy9uEOgkI
   Lmey3YuN6cVmWkmtGbIhcGClzijJQ5HAwlJcqb6Q81rendFxU1mOhICrKd9O+8uAKZiR0pqIxWxe
   ynZYp4ISRT75mSnWByk=
Received: from pmta01.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail128-16.atl41.mandrillapp.com id hjd2us1mquk8 for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 09:15:18 +0000 (envelope-from <bounce-md_31050260.5c9b3f25.v1-14e2950b37d9463e8d0aef3eccad9188@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1553678117; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=M3W9EymIbtNlepIICFQEKnmSlW1q5GOiNtFo19F089s=; 
 b=m1RGXT0+TNrP7c5JqBs+D0zMd4ykLDk+5wWwt64zg1gDlk7sRvZL34wtwoDPhp1Y3pD1TU
 JxW2f3MTLocaUPPvwWfGIw5Jc7OfvOn+j1JTdoPOFAt3ekyB9969ql6fEcOOLh2sxo0iVZBf
 W+KqyOE9hDqa4IXKL2YLooXfYawCo=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [RESEND1, PATCH 1/2] fuse: convert printk -> pr_*
Received: from [87.98.221.171] by mandrillapp.com id 14e2950b37d9463e8d0aef3eccad9188; Wed, 27 Mar 2019 09:15:17 +0000
X-Mailer: git-send-email 2.21.0.392.gf8f6787159
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Brian Foster <bfoster@redhat.com>,
        Maxim Patlasov <mpatlasov@parallels.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrew Gallagher <andrewjcg@fb.com>,
        "Anand V . Avati" <avati@redhat.com>,
        Alexey Kuznetsov <kuznet@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Constantine Shulyupin <const@MakeLinux.com>,
        Chad Austin <chadaustin@fb.com>,
        Dan Schatzberg <dschatzberg@fb.com>,
        <linux-fsdevel@vger.kernel.org>,
        <fuse-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Smelkov <kirr@nexedi.com>
Message-Id: <d916d401a80e9834c95970d86ca71c0154e988a6.1553677194.git.kirr@nexedi.com>
In-Reply-To: <cover.1553677194.git.kirr@nexedi.com>
References: <cover.1553677194.git.kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.14e2950b37d9463e8d0aef3eccad9188
X-Mandrill-User: md_31050260
Date:   Wed, 27 Mar 2019 09:15:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions, like pr_err, are a more modern variant of printing compared to
printk. They could be used to denoise sources by using needed level in
the print function name, and by automatically inserting per-driver /
function / ... print prefix as defined by pr_fmt macro. pr_* are also
said to be used in Documentation/process/coding-style.rst and more
recent code - for example overlayfs - uses them instead of printk.

Convert CUSE and FUSE to use the new pr_* functions.

CUSE output stays completely unchanged, while FUSE output is amended a
bit for "trying to steal weird page" warning - the second line now comes
also with "fuse:" prefix. I hope it is ok.

Suggested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/cuse.c   | 13 +++++++------
 fs/fuse/dev.c    |  4 ++--
 fs/fuse/fuse_i.h |  4 ++++
 fs/fuse/inode.c  |  6 +++---
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 55a26f351467..4b41df1d4642 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -33,6 +33,8 @@
  * closed.
  */
 
+#define pr_fmt(fmt) "CUSE: " fmt
+
 #include <linux/fuse.h>
 #include <linux/cdev.h>
 #include <linux/device.h>
@@ -225,7 +227,7 @@ static int cuse_parse_one(char **pp, char *end, char **keyp, char **valp)
 		return 0;
 
 	if (end[-1] != '\0') {
-		printk(KERN_ERR "CUSE: info not properly terminated\n");
+		pr_err("info not properly terminated\n");
 		return -EINVAL;
 	}
 
@@ -242,7 +244,7 @@ static int cuse_parse_one(char **pp, char *end, char **keyp, char **valp)
 		key = strstrip(key);
 
 	if (!strlen(key)) {
-		printk(KERN_ERR "CUSE: zero length info key specified\n");
+		pr_err("zero length info key specified\n");
 		return -EINVAL;
 	}
 
@@ -282,12 +284,11 @@ static int cuse_parse_devinfo(char *p, size_t len, struct cuse_devinfo *devinfo)
 		if (strcmp(key, "DEVNAME") == 0)
 			devinfo->name = val;
 		else
-			printk(KERN_WARNING "CUSE: unknown device info \"%s\"\n",
-			       key);
+			pr_warn("unknown device info \"%s\"\n", key);
 	}
 
 	if (!devinfo->name || !strlen(devinfo->name)) {
-		printk(KERN_ERR "CUSE: DEVNAME unspecified\n");
+		pr_err("DEVNAME unspecified\n");
 		return -EINVAL;
 	}
 
@@ -341,7 +342,7 @@ static void cuse_process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 	else
 		rc = register_chrdev_region(devt, 1, devinfo.name);
 	if (rc) {
-		printk(KERN_ERR "CUSE: failed to register chrdev region\n");
+		pr_err("failed to register chrdev region\n");
 		goto err;
 	}
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8a63e52785e9..ccb4c3980829 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -906,8 +906,8 @@ static int fuse_check_page(struct page *page)
 	       1 << PG_lru |
 	       1 << PG_active |
 	       1 << PG_reclaim))) {
-		printk(KERN_WARNING "fuse: trying to steal weird page\n");
-		printk(KERN_WARNING "  page=%p index=%li flags=%08lx, count=%i, mapcount=%i, mapping=%p\n", page, page->index, page->flags, page_count(page), page_mapcount(page), page->mapping);
+		pr_warn("trying to steal weird page\n");
+		pr_warn("  page=%p index=%li flags=%08lx, count=%i, mapcount=%i, mapping=%p\n", page, page->index, page->flags, page_count(page), page_mapcount(page), page->mapping);
 		return 1;
 	}
 	return 0;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0920c0c032a0..e6195bc8f836 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -9,6 +9,10 @@
 #ifndef _FS_FUSE_I_H
 #define _FS_FUSE_I_H
 
+#ifndef pr_fmt
+# define pr_fmt(fmt) "fuse: " fmt
+#endif
+
 #include <linux/fuse.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1b3f3b67d9f0..1bca5023bcc5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1397,8 +1397,8 @@ static int __init fuse_init(void)
 {
 	int res;
 
-	printk(KERN_INFO "fuse init (API version %i.%i)\n",
-	       FUSE_KERNEL_VERSION, FUSE_KERNEL_MINOR_VERSION);
+	pr_info("init (API version %i.%i)\n",
+	        FUSE_KERNEL_VERSION, FUSE_KERNEL_MINOR_VERSION);
 
 	INIT_LIST_HEAD(&fuse_conn_list);
 	res = fuse_fs_init();
@@ -1434,7 +1434,7 @@ static int __init fuse_init(void)
 
 static void __exit fuse_exit(void)
 {
-	printk(KERN_DEBUG "fuse exit\n");
+	pr_debug("exit\n");
 
 	fuse_ctl_cleanup();
 	fuse_sysfs_cleanup();
-- 
2.21.0.392.gf8f6787159
