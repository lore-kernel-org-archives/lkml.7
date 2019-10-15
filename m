Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5AEECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 04:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A939E21835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 04:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfJOEwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 00:52:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52285 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfJOEwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 00:52:17 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1iKEog-0002uI-L1
        for linux-kernel@vger.kernel.org; Tue, 15 Oct 2019 04:52:14 +0000
Received: by mail-pf1-f200.google.com with SMTP id a2so15019715pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 21:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQMobvz2HZDQGzhhbi3ppB5RzKsxgUB3nvRB102SsS8=;
        b=ZhOEddV0wRF5ujPX2AWIp6vDlfP/8psKohl4XPOLptIU4QNsSAEHsgLJOzcDgu3Js1
         ZhbdVtAIEqXy9lE2Yku+C+EmCOdyvjd2prvP5sGX6GMGuuDHHHhcDZGW+hUujWEI232b
         X0aVYUIDZwqZQuQQg+VSUgxNuIIFw8NjhK1la+UeusfqZMJ2tO6KURr8wPlNpfObSfjZ
         5SMgJsvvqEjE2zJS8DrJDnUG47BKD9JOIpbMx5358kJAizmRGF4ajJ1/xLUIDfswR1lA
         sUXxa618E5nKX2gS6iYVm90lfm1pNeiYYbFtVhj3ZMEilon4xEnejrZaSwSpsfC/4awr
         K8PQ==
X-Gm-Message-State: APjAAAXya5TLvrWFk3yZCQ/+bx+EQxSFXLYUH3puNndqVx9nIG0Pz6r4
        hUHXzEfDdbOp73MScDqLr4Q8VJfKd+JgSDiA8RFLDcmRjmb+Q/5c0HkdEu1IzdA86Wo5O2rw6/W
        vJ8PloRd+HrtCXX5skyESzu7eQlUzxV+Z3e44qNdmkA==
X-Received: by 2002:a62:e90d:: with SMTP id j13mr22903923pfh.237.1571115133372;
        Mon, 14 Oct 2019 21:52:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzRnvSEwlddqeNb8FLTT8pchhPLd30L7P1E1zjw8HNEHB7GOQA2xa9U/odCorAcPojihGJF1w==
X-Received: by 2002:a62:e90d:: with SMTP id j13mr22903906pfh.237.1571115133094;
        Mon, 14 Oct 2019 21:52:13 -0700 (PDT)
Received: from localhost (201-92-249-168.dsl.telesp.net.br. [201.92.249.168])
        by smtp.gmail.com with ESMTPSA id r18sm26476953pfc.3.2019.10.14.21.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 21:52:12 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-mm@kvack.org, mike.kravetz@oracle.com
Cc:     linux-kernel@vger.kernel.org, jay.vosburgh@canonical.com,
        gpiccoli@canonical.com, kernel@gpiccoli.net
Subject: [PATCH V2] hugetlb: Add nohugepages parameter to prevent hugepages creation
Date:   Tue, 15 Oct 2019 01:51:58 -0300
Message-Id: <20191015045158.5297-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are 2 ways for setting HugeTLB hugepages in kernel; either
users pass parameters on kernel command-line or they can write to sysfs
files (which is effectively the sysctl way).

Kdump kernels won't benefit from hugepages - in fact it's quite opposite,
it may be the case hugepages on kdump kernel can lead to OOM if kernel
gets unable to allocate demanded pages due to the fact the preallocated
hugepages are consuming a lot of memory.

This patch proposes a new kernel parameter to prevent the creation of
HugeTLB hugepages - we currently don't have a way to do that. We can
even have kdump scripts removing the kernel command-line options to
set hugepages, but it's not straightforward to prevent sysctl/sysfs
configuration, given it happens in later boot or anytime when the
system is running.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 +++
 fs/hugetlbfs/inode.c                          |  5 ++--
 include/linux/hugetlb.h                       |  7 ++++++
 mm/hugetlb.c                                  | 25 +++++++++++++------
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a84a83f8881e..061bec851114 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2982,6 +2982,10 @@
 
 	nohugeiomap	[KNL,x86,PPC] Disable kernel huge I/O mappings.
 
+	nohugepages	[KNL] Disable HugeTLB hugepages completely, preventing
+			its setting either by kernel parameter or sysfs;
+			useful specially in kdump kernel.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a478df035651..bbf8827ecccf 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1451,8 +1451,9 @@ static int __init init_hugetlbfs_fs(void)
 	int error;
 	int i;
 
-	if (!hugepages_supported()) {
-		pr_info("disabling because there are no supported hugepage sizes\n");
+	if (!hugepages_enabled()) {
+		if (!hugetlb_disable_hugepages)
+			pr_info("disabling because there are no supported hugepage sizes\n");
 		return -ENOTSUPP;
 	}
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 53fc34f930d0..91b3cc7ae891 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -549,6 +549,13 @@ static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 #define hugepages_supported() (HPAGE_SHIFT != 0)
 #endif
 
+extern int hugetlb_disable_hugepages;
+
+static inline bool hugepages_enabled(void)
+{
+	return (hugepages_supported() && (!hugetlb_disable_hugepages));
+}
+
 void hugetlb_report_usage(struct seq_file *m, struct mm_struct *mm);
 
 static inline void hugetlb_count_add(long l, struct mm_struct *mm)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ef37c85423a5..d0151454f13f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -43,6 +43,8 @@
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
+int hugetlb_disable_hugepages;
+
 /*
  * Minimum page order among possible hugepage sizes, set to a proper value
  * at boot time.
@@ -1604,7 +1606,7 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 	struct page *page;
 	int rc = 0;
 
-	if (!hugepages_supported())
+	if (!hugepages_enabled())
 		return rc;
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
@@ -2897,7 +2899,7 @@ static int __init hugetlb_init(void)
 {
 	int i;
 
-	if (!hugepages_supported())
+	if (!hugepages_enabled())
 		return 0;
 
 	if (!size_to_hstate(default_hstate_size)) {
@@ -3022,6 +3024,15 @@ static int __init hugetlb_default_setup(char *s)
 }
 __setup("default_hugepagesz=", hugetlb_default_setup);
 
+static int __init nohugepages_setup(char *str)
+{
+	hugetlb_disable_hugepages = 1;
+	pr_info("HugeTLB: hugepages disabled by kernel parameter\n");
+
+	return 0;
+}
+early_param("nohugepages", nohugepages_setup);
+
 static unsigned int cpuset_mems_nr(unsigned int *array)
 {
 	int node;
@@ -3042,7 +3053,7 @@ static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
 	unsigned long tmp = h->max_huge_pages;
 	int ret;
 
-	if (!hugepages_supported())
+	if (!hugepages_enabled())
 		return -EOPNOTSUPP;
 
 	table->data = &tmp;
@@ -3083,7 +3094,7 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 	unsigned long tmp;
 	int ret;
 
-	if (!hugepages_supported())
+	if (!hugepages_enabled())
 		return -EOPNOTSUPP;
 
 	tmp = h->nr_overcommit_huge_pages;
@@ -3113,7 +3124,7 @@ void hugetlb_report_meminfo(struct seq_file *m)
 	struct hstate *h;
 	unsigned long total = 0;
 
-	if (!hugepages_supported())
+	if (!hugepages_enabled())
 		return;
 
 	for_each_hstate(h) {
@@ -3141,7 +3152,7 @@ void hugetlb_report_meminfo(struct seq_file *m)
 int hugetlb_report_node_meminfo(int nid, char *buf)
 {
 	struct hstate *h = &default_hstate;
-	if (!hugepages_supported())
+	if (!hugepages_enabled())
 		return 0;
 	return sprintf(buf,
 		"Node %d HugePages_Total: %5u\n"
@@ -3157,7 +3168,7 @@ void hugetlb_show_meminfo(void)
 	struct hstate *h;
 	int nid;
 
-	if (!hugepages_supported())
+	if (!hugepages_enabled())
 		return;
 
 	for_each_node_state(nid, N_MEMORY)
-- 
2.23.0

