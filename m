Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37487C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155BB2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfEPJmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:42:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34161 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfEPJmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:42:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id j187so6615739wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZGnY1AeO4vEIRNllzlClW+UmlSDLeAarYqLIOTY4ZI=;
        b=T4SumkTlMDJ3SSjFW8XB2Bt9lpn7ZUkT3MyJq8RNL9OneIMNtjcfT1B+/ufEP7eD4E
         oRb3aae/cqfetFFl0BB47kWmPg+FRFckyjsU47aU1ELf9Mz2ao+0DcSoz4e3Elr2Kdqv
         8N+HTOrk4Gs0GFT67wVvXpiNWTcUm8AoLUAtF/0e8IZYmPKE0yBBoNgcXYMCxBvZ7cHd
         zYDhp27jrSGe0eJfSFDkJQicaMA9BwZPQCEmGajcwSa808EvUdZcUE62Dw+DXiSG4qi0
         c+I2IW5DsZiviThGnlKHbieXsuvMRwwBOxrqQXDGsvwqYs0Z8aX2P4di/TMV3SPEpDFk
         2D+Q==
X-Gm-Message-State: APjAAAWTXB1/5syQ29wDZ0V0FttnEnqvaTkiDe//tJYjwTuShdwuzvMw
        EVPFX7Mb/+r54lqB7ebMXdOiqAdUULNyag==
X-Google-Smtp-Source: APXvYqzGCZsfZTLnp32ZXX+p/N913HP7wOvaTxVvqZVz8kRuhkb2Lox0z5g/+tp8DehjQ+5iLc3ZLg==
X-Received: by 2002:a7b:c8d1:: with SMTP id f17mr14149157wml.45.1557999763188;
        Thu, 16 May 2019 02:42:43 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s18sm4074000wmc.41.2019.05.16.02.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 02:42:42 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH RFC 4/5] mm/ksm, proc: introduce remote merge
Date:   Thu, 16 May 2019 11:42:33 +0200
Message-Id: <20190516094234.9116-5-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516094234.9116-1-oleksandr@redhat.com>
References: <20190516094234.9116-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use previously introduced remote madvise knob to mark task's
anonymous memory as mergeable.

To force merging task's VMAs, "merge" hint is used:

   # echo merge > /proc/<pid>/madvise

Force unmerging is done similarly:

   # echo unmerge > /proc/<pid>/madvise

To achieve this, previously introduced ksm_madvise_*() helpers
are used.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 fs/proc/base.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f69532d6b74f..6677580080ed 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,8 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
+#include <linux/mman.h>
+#include <linux/ksm.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -2960,15 +2962,63 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 static ssize_t madvise_write(struct file *file, const char __user *buf,
 		size_t count, loff_t *ppos)
 {
+	/* For now, only KSM hints are implemented */
+#ifdef CONFIG_KSM
+	char buffer[PROC_NUMBUF];
+	int behaviour;
 	struct task_struct *task;
+	struct mm_struct *mm;
+	int err = 0;
+	struct vm_area_struct *vma;
+
+	memset(buffer, 0, sizeof(buffer));
+	if (count > sizeof(buffer) - 1)
+		count = sizeof(buffer) - 1;
+	if (copy_from_user(buffer, buf, count))
+		return -EFAULT;
+
+	if (!memcmp("merge", buffer, min(sizeof("merge")-1, count)))
+		behaviour = MADV_MERGEABLE;
+	else if (!memcmp("unmerge", buffer, min(sizeof("unmerge")-1, count)))
+		behaviour = MADV_UNMERGEABLE;
+	else
+		return -EINVAL;
 
 	task = get_proc_task(file_inode(file));
 	if (!task)
 		return -ESRCH;
 
+	mm = get_task_mm(task);
+	if (!mm) {
+		err = -EINVAL;
+		goto out_put_task_struct;
+	}
+
+	down_write(&mm->mmap_sem);
+	switch (behaviour) {
+	case MADV_MERGEABLE:
+	case MADV_UNMERGEABLE:
+		vma = mm->mmap;
+		while (vma) {
+			if (behaviour == MADV_MERGEABLE)
+				ksm_madvise_merge(vma->vm_mm, vma, &vma->vm_flags);
+			else
+				ksm_madvise_unmerge(vma, vma->vm_start, vma->vm_end, &vma->vm_flags);
+			vma = vma->vm_next;
+		}
+		break;
+	}
+	up_write(&mm->mmap_sem);
+
+	mmput(mm);
+
+out_put_task_struct:
 	put_task_struct(task);
 
-	return count;
+	return err ? err : count;
+#else
+	return -EINVAL;
+#endif /* CONFIG_KSM */
 }
 
 static const struct file_operations proc_madvise_operations = {
-- 
2.21.0

