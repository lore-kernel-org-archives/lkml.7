Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACECC46477
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D89B2173C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfFPI6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 04:58:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35407 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfFPI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 04:58:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so6087815wml.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 01:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PJSsC+ETTbEm0MFSswbRZG13yzb82K1kjBPqEvVe/Y8=;
        b=cEARi0MS4kTNaAaGlcmVAKUBruBjKvTdJpmJ1dGtzsWxPPkrP1GJQL0wf0sVa96dxC
         RRwhDeVVATgDJ3IGC86ksewqZeIaaJ6+vqTol/MAI0BbzExR5lrRbAaMFKZTlzVH0CNJ
         sdDQo9TaYlL/cZMB6ymNg0y4xT1o1Tr+4DmizQ8QLbKftXZHd0el+A5/6+fQshGpgqgI
         zODC3bgFz5m7ZHyU7u/XDKK6MiJqSJkTApB+eXv7hkJBHbSOLC7C4eN3nIsi53Agthgb
         QCRK6AX1xNM7QIy5qMN0MPPMu1yM3tF8xQqgN3ei2FU4sId0Pv2+Ny9DJ1rgDc9HnCRD
         VbeA==
X-Gm-Message-State: APjAAAXVWCRG/oWv/tdEKRyBm+7XDeNog/mpTaRBbcTpSaazn1bSfMcS
        VVD0HJamTPQM7A2ANTyClnLvRg==
X-Google-Smtp-Source: APXvYqziZjswyLaPjH4zzuukgwYGgZMcx72QbU3TZfm0v5QbPhsR4W+rR5m+8XGdtVYkv9SHvMzBoA==
X-Received: by 2002:a1c:99c6:: with SMTP id b189mr14663437wme.57.1560675519453;
        Sun, 16 Jun 2019 01:58:39 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 6sm8148471wrd.51.2019.06.16.01.58.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:58:38 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH NOTFORMERGE 1/5] mm: rename madvise_core to madvise_common
Date:   Sun, 16 Jun 2019 10:58:31 +0200
Message-Id: <20190616085835.953-2-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616085835.953-1-oleksandr@redhat.com>
References: <20190616085835.953-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"core" usually means something very different within the kernel land,
thus lets just follow the way it is handled in mutexes, rw_semaphores
etc and name common things as "_common".

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 mm/madvise.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 94d782097afd..edb7184f665c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -998,7 +998,7 @@ process_madvise_behavior_valid(int behavior)
 }
 
 /*
- * madvise_core - request behavior hint to address range of the target process
+ * madvise_common - request behavior hint to address range of the target process
  *
  * @task: task_struct got behavior hint, not giving the hint
  * @mm: mm_struct got behavior hint, not giving the hint
@@ -1009,7 +1009,7 @@ process_madvise_behavior_valid(int behavior)
  * @task could be a zombie leader if it calls sys_exit so accessing mm_struct
  * via task->mm is prohibited. Please use @mm insetad of task->mm.
  */
-static int madvise_core(struct task_struct *task, struct mm_struct *mm,
+static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 			unsigned long start, size_t len_in, int behavior)
 {
 	unsigned long end, tmp;
@@ -1132,7 +1132,7 @@ static int pr_madvise_copy_param(struct pr_madvise_param __user *u_param,
 	return ret;
 }
 
-static int process_madvise_core(struct task_struct *tsk, struct mm_struct *mm,
+static int process_madvise_common(struct task_struct *tsk, struct mm_struct *mm,
 				int *behaviors,
 				struct iov_iter *iter,
 				const struct iovec *range_vec,
@@ -1144,7 +1144,7 @@ static int process_madvise_core(struct task_struct *tsk, struct mm_struct *mm,
 	for (i = 0; i < riovcnt && iov_iter_count(iter); i++) {
 		err = -EINVAL;
 		if (process_madvise_behavior_valid(behaviors[i]))
-			err = madvise_core(tsk, mm,
+			err = madvise_common(tsk, mm,
 				(unsigned long)range_vec[i].iov_base,
 				range_vec[i].iov_len, behaviors[i]);
 
@@ -1220,7 +1220,7 @@ static int process_madvise_core(struct task_struct *tsk, struct mm_struct *mm,
  */
 SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
-	return madvise_core(current, current->mm, start, len_in, behavior);
+	return madvise_common(current, current->mm, start, len_in, behavior);
 }
 
 
@@ -1252,7 +1252,7 @@ SYSCALL_DEFINE3(process_madvise, int, pidfd,
 
 	/*
 	 * We don't support cookie to gaurantee address space atomicity yet.
-	 * Once we implment cookie, process_madvise_core need to hold mmap_sme
+	 * Once we implment cookie, process_madvise_common need to hold mmap_sme
 	 * during entire operation to guarantee atomicity.
 	 */
 	if (params.cookie != 0)
@@ -1316,7 +1316,7 @@ SYSCALL_DEFINE3(process_madvise, int, pidfd,
 		goto release_task;
 	}
 
-	ret = process_madvise_core(task, mm, behaviors, &iter, iov_r, nr_elem);
+	ret = process_madvise_common(task, mm, behaviors, &iter, iov_r, nr_elem);
 	mmput(mm);
 release_task:
 	put_task_struct(task);
-- 
2.22.0

