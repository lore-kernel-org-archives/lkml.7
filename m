Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528B8C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D806216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfD3ITd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:19:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:55614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbfD3ITc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:19:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19136AE3F;
        Tue, 30 Apr 2019 08:19:30 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     gorcunov@gmail.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, mkoutny@suse.com,
        rppt@linux.ibm.com, vbabka@suse.cz, ktkhai@virtuozzo.com
Subject: [PATCH 2/3] prctl_set_mm: Refactor checks from validate_prctl_map
Date:   Tue, 30 Apr 2019 10:18:43 +0200
Message-Id: <20190430081844.22597-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190430081844.22597-1-mkoutny@suse.com>
References: <20190418182321.GJ3040@uranus.lan>
 <20190430081844.22597-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite comment of validate_prctl_map claims there are no capability
checks, it is not completely true since commit 4d28df6152aa ("prctl:
Allow local CAP_SYS_ADMIN changing exe_file"). Extract the check out of
the function and make the function perform purely arithmetic checks.

This patch should not change any behavior, it is mere refactoring for
following patch.

CC: Kirill Tkhai <ktkhai@virtuozzo.com>
CC: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sys.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 12df0e5434b8..e1acb444d7b0 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1882,10 +1882,12 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
 }
 
 /*
+ * Check arithmetic relations of passed addresses.
+ *
  * WARNING: we don't require any capability here so be very careful
  * in what is allowed for modification from userspace.
  */
-static int validate_prctl_map(struct prctl_mm_map *prctl_map)
+static int validate_prctl_map_addr(struct prctl_mm_map *prctl_map)
 {
 	unsigned long mmap_max_addr = TASK_SIZE;
 	struct mm_struct *mm = current->mm;
@@ -1949,24 +1951,6 @@ static int validate_prctl_map(struct prctl_mm_map *prctl_map)
 			      prctl_map->start_data))
 			goto out;
 
-	/*
-	 * Someone is trying to cheat the auxv vector.
-	 */
-	if (prctl_map->auxv_size) {
-		if (!prctl_map->auxv || prctl_map->auxv_size > sizeof(mm->saved_auxv))
-			goto out;
-	}
-
-	/*
-	 * Finally, make sure the caller has the rights to
-	 * change /proc/pid/exe link: only local sys admin should
-	 * be allowed to.
-	 */
-	if (prctl_map->exe_fd != (u32)-1) {
-		if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
-			goto out;
-	}
-
 	error = 0;
 out:
 	return error;
@@ -1993,11 +1977,17 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	if (copy_from_user(&prctl_map, addr, sizeof(prctl_map)))
 		return -EFAULT;
 
-	error = validate_prctl_map(&prctl_map);
+	error = validate_prctl_map_addr(&prctl_map);
 	if (error)
 		return error;
 
 	if (prctl_map.auxv_size) {
+		/*
+		 * Someone is trying to cheat the auxv vector.
+		 */
+		if (!prctl_map.auxv || prctl_map.auxv_size > sizeof(mm->saved_auxv))
+			return -EINVAL;
+
 		memset(user_auxv, 0, sizeof(user_auxv));
 		if (copy_from_user(user_auxv,
 				   (const void __user *)prctl_map.auxv,
@@ -2010,6 +2000,14 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	}
 
 	if (prctl_map.exe_fd != (u32)-1) {
+		/*
+		 * Make sure the caller has the rights to
+		 * change /proc/pid/exe link: only local sys admin should
+		 * be allowed to.
+		 */
+		if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
+			return -EINVAL;
+
 		error = prctl_set_mm_exe_file(mm, prctl_map.exe_fd);
 		if (error)
 			return error;
@@ -2097,7 +2095,7 @@ static int prctl_set_mm(int opt, unsigned long addr,
 			unsigned long arg4, unsigned long arg5)
 {
 	struct mm_struct *mm = current->mm;
-	struct prctl_mm_map prctl_map;
+	struct prctl_mm_map prctl_map = { .auxv = NULL, .auxv_size = 0, .exe_fd = -1 };
 	struct vm_area_struct *vma;
 	int error;
 
@@ -2139,9 +2137,6 @@ static int prctl_set_mm(int opt, unsigned long addr,
 	prctl_map.arg_end	= mm->arg_end;
 	prctl_map.env_start	= mm->env_start;
 	prctl_map.env_end	= mm->env_end;
-	prctl_map.auxv		= NULL;
-	prctl_map.auxv_size	= 0;
-	prctl_map.exe_fd	= -1;
 
 	switch (opt) {
 	case PR_SET_MM_START_CODE:
@@ -2181,7 +2176,7 @@ static int prctl_set_mm(int opt, unsigned long addr,
 		goto out;
 	}
 
-	error = validate_prctl_map(&prctl_map);
+	error = validate_prctl_map_addr(&prctl_map);
 	if (error)
 		goto out;
 
-- 
2.16.4

