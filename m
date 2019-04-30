Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8049C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9EF216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfD3IT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:19:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfD3IT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:19:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85D05AE4F;
        Tue, 30 Apr 2019 08:19:26 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     gorcunov@gmail.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, mkoutny@suse.com,
        rppt@linux.ibm.com, vbabka@suse.cz, ktkhai@virtuozzo.com
Subject: [PATCH 1/3] mm: get_cmdline use arg_lock instead of mmap_sem
Date:   Tue, 30 Apr 2019 10:18:42 +0200
Message-Id: <20190430081844.22597-2-mkoutny@suse.com>
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

The commit a3b609ef9f8b ("proc read mm's {arg,env}_{start,end} with mmap
semaphore taken.") added synchronization of reading argument/environment
boundaries under mmap_sem. Later commit 88aa7cc688d4 ("mm: introduce
arg_lock to protect arg_start|end and env_start|end in mm_struct")
avoided the coarse use of mmap_sem in similar situations.

get_cmdline can also use arg_lock instead of mmap_sem when it reads the
boundaries.

Fixes: 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|end and env_start|end in mm_struct")
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Mateusz Guzik <mguzik@redhat.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 mm/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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

