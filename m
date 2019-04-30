Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B2CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C42216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfD3ITh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:19:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:55642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726648AbfD3ITc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:19:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3F04AE4F;
        Tue, 30 Apr 2019 08:19:31 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     gorcunov@gmail.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, mkoutny@suse.com,
        rppt@linux.ibm.com, vbabka@suse.cz, ktkhai@virtuozzo.com
Subject: [PATCH 3/3] prctl_set_mm: downgrade mmap_sem to read lock
Date:   Tue, 30 Apr 2019 10:18:44 +0200
Message-Id: <20190430081844.22597-4-mkoutny@suse.com>
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

Since commit 88aa7cc688d4 ("mm: introduce arg_lock to protect
arg_start|end and env_start|end in mm_struct") we use arg_lock for
boundaries modifications. Synchronize prctl_set_mm with this lock and
keep mmap_sem for reading only (analogous to what we already do in
prctl_set_mm_map).

v2: call find_vma without arg_lock held

CC: Cyrill Gorcunov <gorcunov@gmail.com>
CC: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sys.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index e1acb444d7b0..641fda756575 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2123,9 +2123,14 @@ static int prctl_set_mm(int opt, unsigned long addr,
 
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
@@ -2213,7 +2218,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
 
 	error = 0;
 out:
-	up_write(&mm->mmap_sem);
+	spin_unlock(&mm->arg_lock);
+	up_read(&mm->mmap_sem);
 	return error;
 }
 
-- 
2.16.4

