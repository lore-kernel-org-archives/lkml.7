Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25546C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FEB217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfEJHVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:21:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33806 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfEJHVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:21:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id j6so5518581qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlMuZ+baS9vhQtlkYflvWcBmyvS2Oox5GVM3xd9Ae4c=;
        b=aGUQ/xvIGXvCbBCyhPebNNC1xnr8BfM2Fi/DrOY+bhEdiT4wWBuKgaYImXTkSBd+gC
         yP2naY5gNYnDBW86gJRWpAAU2huTAm/9hQ+6MP0MNZxevTF6LuFfP4wCN+7QFEQERKUq
         /4TV/kmImKfm8t8CZvu+m53S6QMKXeUcTZkWSOuHmbPMEpqfM3GjjVbg+GWyv2PNK+1W
         K0/5iM2Igt9uh2ZyTRQk16aQU6zZ1QuUG1vUYy+MMUEdolTZ9bb6qPKjFv4PmVZbvehI
         kZgB7RM8bOKCenr29z3++kz931ZOKbJltaXd6N71xiAa3w8ZC8tRds9ia4Sha/1C/Jpd
         ++Pw==
X-Gm-Message-State: APjAAAXmeviiyiMRZgKtQLr1lIb+SKFJD+fYiEkXdbPisPv1PBZj4PKF
        duCTh9cCvrPBK6RCdIUdPpdl7YA5rDkZ4w==
X-Google-Smtp-Source: APXvYqz/+ynrCsQP/BLl+LKcOs3x84+6OIoUVWb8hO3FNCiBMNoBPIf1oHQue0SdB9Zjhf1ZT6HdwQ==
X-Received: by 2002:a0c:b28e:: with SMTP id r14mr7753580qve.158.1557472894619;
        Fri, 10 May 2019 00:21:34 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 124sm1641385qkj.59.2019.05.10.00.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 00:21:33 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Subject: [PATCH RFC 3/4] mm/ksm: allow anonymous memory automerging
Date:   Fri, 10 May 2019 09:21:24 +0200
Message-Id: <20190510072125.18059-4-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190510072125.18059-1-oleksandr@redhat.com>
References: <20190510072125.18059-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce 2 KSM modes:

  * madvise, which is default and maintains old behaviour; and
  * always, in which new anonymous allocations are marked as eligible
    for merging.

The mode is controlled either via sysfs or via kernel cmdline for VMAs
to be marked as soon as possible during the boot process.

Previously introduced ksm_enter() helper is used to hook into
do_anonymous_page() and mark each eligible VMA as ready for merging.
This avoids introducing separate kthread to walk through the task/VMAs
list.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 include/linux/ksm.h |  3 +++
 mm/ksm.c            | 65 +++++++++++++++++++++++++++++++++++++++++++++
 mm/memory.c         |  6 +++++
 3 files changed, 74 insertions(+)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index bc13f228e2ed..3c076b35259c 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -21,6 +21,9 @@ struct mem_cgroup;
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
+#ifdef VM_UNMERGEABLE
+bool ksm_mode_always(void);
+#endif
 int ksm_enter(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long *vm_flags);
 int __ksm_enter(struct mm_struct *mm);
diff --git a/mm/ksm.c b/mm/ksm.c
index 0fb5f850087a..6a2280b875cc 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -295,6 +295,12 @@ static int ksm_nr_node_ids = 1;
 static unsigned long ksm_run = KSM_RUN_STOP;
 static void wait_while_offlining(void);
 
+#ifdef VM_UNMERGEABLE
+#define KSM_MODE_MADVISE	0
+#define KSM_MODE_ALWAYS		1
+static unsigned long ksm_mode = KSM_MODE_MADVISE;
+#endif
+
 static DECLARE_WAIT_QUEUE_HEAD(ksm_thread_wait);
 static DECLARE_WAIT_QUEUE_HEAD(ksm_iter_wait);
 static DEFINE_MUTEX(ksm_thread_mutex);
@@ -2478,6 +2484,36 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 	return 0;
 }
 
+#ifdef VM_UNMERGEABLE
+bool ksm_mode_always(void)
+{
+	return ksm_mode == KSM_MODE_ALWAYS;
+}
+
+static int __init setup_ksm_mode(char *str)
+{
+	int ret = 0;
+
+	if (!str)
+		goto out;
+
+	if (!strcmp(str, "madvise")) {
+		ksm_mode = KSM_MODE_MADVISE;
+		ret = 1;
+	} else if (!strcmp(str, "always")) {
+		ksm_mode = KSM_MODE_ALWAYS;
+		ret = 1;
+	}
+
+out:
+	if (!ret)
+		pr_warn("ksm_mode= cannot parse, ignored\n");
+
+	return ret;
+}
+__setup("ksm_mode=", setup_ksm_mode);
+#endif
+
 int ksm_enter(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long *vm_flags)
 {
@@ -2881,6 +2917,35 @@ static void wait_while_offlining(void)
 	static struct kobj_attribute _name##_attr = \
 		__ATTR(_name, 0644, _name##_show, _name##_store)
 
+#ifdef VM_UNMERGEABLE
+static ssize_t mode_show(struct kobject *kobj, struct kobj_attribute *attr,
+	char *buf)
+{
+	switch (ksm_mode) {
+	case KSM_MODE_MADVISE:
+		return sprintf(buf, "always [madvise]\n");
+	case KSM_MODE_ALWAYS:
+		return sprintf(buf, "[always] madvise\n");
+	}
+
+	return sprintf(buf, "always [madvise]\n");
+}
+
+static ssize_t mode_store(struct kobject *kobj, struct kobj_attribute *attr,
+	const char *buf, size_t count)
+{
+	if (!memcmp("madvise", buf, min(sizeof("madvise")-1, count)))
+		ksm_mode = KSM_MODE_MADVISE;
+	else if (!memcmp("always", buf, min(sizeof("always")-1, count)))
+		ksm_mode = KSM_MODE_ALWAYS;
+	else
+		return -EINVAL;
+
+	return count;
+}
+KSM_ATTR(mode);
+#endif
+
 static ssize_t sleep_millisecs_show(struct kobject *kobj,
 				    struct kobj_attribute *attr, char *buf)
 {
diff --git a/mm/memory.c b/mm/memory.c
index ab650c21bccd..08f3f92de310 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2994,6 +2994,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+
+#if defined(CONFIG_KSM) && defined(VM_UNMERGEABLE)
+	if (ksm_mode_always())
+		ksm_enter(vma->vm_mm, vma, &vma->vm_flags);
+#endif
+
 	return ret;
 release:
 	mem_cgroup_cancel_charge(page, memcg, false);
-- 
2.21.0

