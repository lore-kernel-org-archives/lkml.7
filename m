Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C90AC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7931A20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfENNRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:17:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36458 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfENNRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:17:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so2719842wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VdAVf6UsURaBN1kR2hvAUBFTDOMaklbC2zfjfZkKj2k=;
        b=ioUhWLRT7MVpotVAob5fLfWxkWadHOIMwNAcYtO/6/oAdIuGi8VNrGnZ3XjSoLNEvx
         6OhIPr0k3PzEQ4WtnLuoKMD5EQpzWRgq38CA5jM7jel7oVw1stEhUR2edg0rGN35XPDB
         +pFhUmQYrn50yxjEJXL64fB8D7ndkXl6W1cGrnUvPloNNk00Xu0e73xSUqUBh5AgYLYY
         h8WbFrkpoy57Nufe0sjLxaLqBG5igLL8HojHKwqypweCTh1dVqqlz2CwdSmCwRJ37ptM
         rDKyWn8CXGRbF9kurEAXbw/nbYh5D5jeQ/JQFmdP6jQHcWGwWODXkirK2K0K5MCk43Bi
         dHjw==
X-Gm-Message-State: APjAAAX5o28MW32teIeoVUlt9GqTVPKr5p7cCAwqcySsGB9IxbyjFrHU
        1NErtIog9Z4+LRec4in+dz9OHNOZJbg15Q==
X-Google-Smtp-Source: APXvYqyKKvVTOE8RaLl7n7pCLi0m5G1sMvqGxaeEklK4ZdRJocqbNZnJLuLQOOWk1SEOtgBgAe0hnw==
X-Received: by 2002:adf:8306:: with SMTP id 6mr9923763wrd.155.1557839821146;
        Tue, 14 May 2019 06:17:01 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f7sm1720014wmc.26.2019.05.14.06.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 06:17:00 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org
Subject: [PATCH RFC v2 3/4] mm/ksm: introduce force_madvise knob
Date:   Tue, 14 May 2019 15:16:53 +0200
Message-Id: <20190514131654.25463-4-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514131654.25463-1-oleksandr@redhat.com>
References: <20190514131654.25463-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Present a new sysfs knob to mark task's anonymous memory as mergeable.

To force merging task's VMAs, its PID is echoed in a write-only file:

   # echo PID > /sys/kernel/mm/ksm/force_madvise

Force unmerging is done similarly, but with "minus" sign:

   # echo -PID > /sys/kernel/mm/ksm/force_madvise

"0" or "-0" can be used to control the current task.

To achieve this, previously introduced ksm_enter()/ksm_leave() helpers
are used in the "store" handler.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 mm/ksm.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index e9f3901168bb..22c59fb03d3a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2879,10 +2879,77 @@ static void wait_while_offlining(void)
 
 #define KSM_ATTR_RO(_name) \
 	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+#define KSM_ATTR_WO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_WO(_name)
 #define KSM_ATTR(_name) \
 	static struct kobj_attribute _name##_attr = \
 		__ATTR(_name, 0644, _name##_show, _name##_store)
 
+static ssize_t force_madvise_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int err;
+	pid_t pid;
+	bool merge = true;
+	struct task_struct *tsk;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+
+	err = kstrtoint(buf, 10, &pid);
+	if (err)
+		return -EINVAL;
+
+	if (pid < 0) {
+		pid = abs(pid);
+		merge = false;
+	}
+
+	if (!pid && *buf == '-')
+		merge = false;
+
+	rcu_read_lock();
+	if (pid) {
+		tsk = find_task_by_vpid(pid);
+		if (!tsk) {
+			err = -ESRCH;
+			rcu_read_unlock();
+			goto out;
+		}
+	} else {
+		tsk = current;
+	}
+
+	tsk = tsk->group_leader;
+
+	get_task_struct(tsk);
+	rcu_read_unlock();
+
+	mm = get_task_mm(tsk);
+	if (!mm) {
+		err = -EINVAL;
+		goto out_put_task_struct;
+	}
+	down_write(&mm->mmap_sem);
+	vma = mm->mmap;
+	while (vma) {
+		if (merge)
+			ksm_enter(vma->vm_mm, vma, &vma->vm_flags);
+		else
+			ksm_leave(vma, vma->vm_start, vma->vm_end, &vma->vm_flags);
+		vma = vma->vm_next;
+	}
+	up_write(&mm->mmap_sem);
+	mmput(mm);
+
+out_put_task_struct:
+	put_task_struct(tsk);
+
+out:
+	return err ? err : count;
+}
+KSM_ATTR_WO(force_madvise);
+
 static ssize_t sleep_millisecs_show(struct kobject *kobj,
 				    struct kobj_attribute *attr, char *buf)
 {
@@ -3185,6 +3252,7 @@ static ssize_t full_scans_show(struct kobject *kobj,
 KSM_ATTR_RO(full_scans);
 
 static struct attribute *ksm_attrs[] = {
+	&force_madvise_attr.attr,
 	&sleep_millisecs_attr.attr,
 	&pages_to_scan_attr.attr,
 	&run_attr.attr,
-- 
2.21.0

