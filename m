Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF605C04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5A52133F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfEBMwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:52:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:34622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfEBMwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:52:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 916A7AEDB;
        Thu,  2 May 2019 12:52:16 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     gorcunov@gmail.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, mkoutny@suse.com,
        rppt@linux.ibm.com, vbabka@suse.cz, ktkhai@virtuozzo.com
Subject: [PATCH v3 2/2] prctl_set_mm: downgrade mmap_sem to read lock
Date:   Thu,  2 May 2019 14:52:03 +0200
Message-Id: <20190502125203.24014-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190502125203.24014-1-mkoutny@suse.com>
References: <0a48e0a2-a282-159e-a56e-201fbc0faa91@virtuozzo.com>
 <20190502125203.24014-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit a3b609ef9f8b ("proc read mm's {arg,env}_{start,end} with mmap
semaphore taken.") added synchronization of reading argument/environment
boundaries under mmap_sem. Later commit 88aa7cc688d4 ("mm: introduce
arg_lock to protect arg_start|end and env_start|end in mm_struct")
avoided the coarse use of mmap_sem in similar situations. But there
still remained two places that (mis)use mmap_sem.

get_cmdline should also use arg_lock instead of mmap_sem when it reads the
boundaries.

The second place that should use arg_lock is in prctl_set_mm. By
protecting the boundaries fields with the arg_lock, we can downgrade
mmap_sem to reader lock (analogous to what we already do in
prctl_set_mm_map).

v2: call find_vma without arg_lock held
v3: squashed get_cmdline arg_lock patch

Fixes: 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|end and env_start|end in mm_struct")
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Mateusz Guzik <mguzik@redhat.com>
CC: Cyrill Gorcunov <gorcunov@gmail.com>
Co-developed-by: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sys.c | 10 ++++++++--
 mm/util.c    |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 5e0a5edf47f8..14be57840511 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2122,9 +2122,14 @@ static int prctl_set_mm(int opt, unsigned long addr,
 
 	error = -EINVAL;
 
-	down_write(&mm->mmap_sem);
+	/*
+	 * arg_lock protects concurent updates of arg boundaries, we need mmap_sem for
+	 * a) concurrent sys_brk, b) finding VMA for addr validation.
+	 */
+	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, addr);
 
+	spin_lock(&mm->arg_lock);
 	prctl_map.start_code	= mm->start_code;
 	prctl_map.end_code	= mm->end_code;
 	prctl_map.start_data	= mm->start_data;
@@ -2212,7 +2217,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
 
 	error = 0;
 out:
-	up_write(&mm->mmap_sem);
+	spin_unlock(&mm->arg_lock);
+	up_read(&mm->mmap_sem);
 	return error;
 }
 
diff --git a/mm/util.c b/mm/util.c
index 43a2984bccaa..5cf0e84a0823 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -758,12 +758,12 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	if (!mm->arg_end)
 		goto out_mm;	/* Shh! No looking before we're done */
 
-	down_read(&mm->mmap_sem);
+	spin_lock(&mm->arg_lock);
 	arg_start = mm->arg_start;
 	arg_end = mm->arg_end;
 	env_start = mm->env_start;
 	env_end = mm->env_end;
-	up_read(&mm->mmap_sem);
+	spin_unlock(&mm->arg_lock);
 
 	len = arg_end - arg_start;
 
-- 
2.16.4

