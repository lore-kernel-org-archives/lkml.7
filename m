Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C92CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C89222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437490;
	bh=q4gA284Acw4GIJYTIVOl+MOguuyn/m44jy1aaSgaG34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ccGjRt5o4nDgAFiFUBRx2iD2P2Zr4YKuKxcoBEG4ktqnJG0RORZVuTi3EhxvzbzQ4
	 hRocmvj2A53ajOY02wFEpq+r5wIHnNS3LMdd/zMbj0ptLXogq1+XBs9V/FNrTPav4A
	 uO6vK7dtZFYEGWmPOC1BTTMxT4ZV5e5PyYMGsWYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394613AbfJRWYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbfJRWEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:04:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35A2222D1;
        Fri, 18 Oct 2019 22:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436291;
        bh=q4gA284Acw4GIJYTIVOl+MOguuyn/m44jy1aaSgaG34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0pKD7R3Cwd6l868zR6qayhWRK6BQzYB5bqBC/6HkQbkxboJ2jxSjWygwTzzjZgrQt
         hMFspj5J5U7kr6IF/5XyY30URCdDYl/it5hH8s3Yg0K950/3eEcs/tuR+7726XeFpo
         k6ujJJdmAaxZj+heZ7HZPCupJgGQ8GkewYNOZB4A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>, Hechao Li <hechaol@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        Jie Meng <jmeng@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 65/89] perf/core: Rework memory accounting in perf_mmap()
Date:   Fri, 18 Oct 2019 18:03:00 -0400
Message-Id: <20191018220324.8165-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

[ Upstream commit d44248a41337731a111374822d7d4451b64e73e4 ]

perf_mmap() always increases user->locked_vm. As a result, "extra" could
grow bigger than "user_extra", which doesn't make sense. Here is an
example case:

(Note: Assume "user_lock_limit" is very small.)

  | # of perf_mmap calls |vma->vm_mm->pinned_vm|user->locked_vm|
  | 0                    | 0                   | 0             |
  | 1                    | user_extra          | user_extra    |
  | 2                    | 3 * user_extra      | 2 * user_extra|
  | 3                    | 6 * user_extra      | 3 * user_extra|
  | 4                    | 10 * user_extra     | 4 * user_extra|

Fix this by maintaining proper user_extra and extra.

Reviewed-By: Hechao Li <hechaol@fb.com>
Reported-by: Hechao Li <hechaol@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <kernel-team@fb.com>
Cc: Jie Meng <jmeng@fb.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190904214618.3795672-1-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0463c1151baeb..a0120bdbce177 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5585,7 +5585,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	 * undo the VM accounting.
 	 */
 
-	atomic_long_sub((size >> PAGE_SHIFT) + 1, &mmap_user->locked_vm);
+	atomic_long_sub((size >> PAGE_SHIFT) + 1 - mmap_locked,
+			&mmap_user->locked_vm);
 	atomic64_sub(mmap_locked, &vma->vm_mm->pinned_vm);
 	free_uid(mmap_user);
 
@@ -5729,8 +5730,20 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 	user_locked = atomic_long_read(&user->locked_vm) + user_extra;
 
-	if (user_locked > user_lock_limit)
+	if (user_locked <= user_lock_limit) {
+		/* charge all to locked_vm */
+	} else if (atomic_long_read(&user->locked_vm) >= user_lock_limit) {
+		/* charge all to pinned_vm */
+		extra = user_extra;
+		user_extra = 0;
+	} else {
+		/*
+		 * charge locked_vm until it hits user_lock_limit;
+		 * charge the rest from pinned_vm
+		 */
 		extra = user_locked - user_lock_limit;
+		user_extra -= extra;
+	}
 
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
 	lock_limit >>= PAGE_SHIFT;
-- 
2.20.1

