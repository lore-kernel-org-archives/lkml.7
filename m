Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EC2C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 16:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFE0206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 16:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576944991;
	bh=bEm+OWSq9nSvNz46o1zc2xuMxncpDHY/jJqVWqT5ZZc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=KHfgj9oVnIul6AF5+0Jv3Vwf63buxQrvKb7Gw75zQi5dNcmKCeu+qyWDEPyu25UYp
	 UfkysWy/ne2L0ZFUYTdMx5HmhNG4ZkwqFUqVdx/MqCcRrQZowQqWsUMMdMO5UAo4PI
	 C57xhgpuk4okNeZkLYmt9ShC9Rv5zD/4wEKn2MZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfLUQQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 11:16:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35333 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfLUQQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 11:16:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so12174264wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 08:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xzexOq9mpJcjihe+DzmkoEqKGrCRdBe5Ig+OTv1Z7Xc=;
        b=D9huYuQJRyZ6eG7IyVQBDpuaMmEO2gwgtQBQJSl8FUY+Q5xGYegQ+FRAA5pWgBNu9l
         CATgepPcSS3jvekoxi8EnKGS9gh8+1SrlZ4cJLRDGrmpzCYQRFJFcNf52SPBd5zef1WW
         ukapezqKUDCbn7557qGEU6AgcHg79e2Xg8QtPREvdj1hgxuQi/Wzdx1cQKbiqFiWsaCH
         dwDwl5c0a5x6xjeqcwUWxieAyWkZ2Wn/lc5UrdVAYukQU84pCAynRDAs/XpMXvDNMiJM
         k3e96tSc/inppRDVA6u0ULXsO4vNAG/U34MuGfzDWyHDcS/7yhB0o4GV38KHw3cagdD9
         2ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=xzexOq9mpJcjihe+DzmkoEqKGrCRdBe5Ig+OTv1Z7Xc=;
        b=lT11uHX6rtkHNyj64ItbsC5tcnW5ymftzvLKUB9DSkj3G5q6QI9dfK7mH/t2QzLt1T
         29Fd17ciT+Goi8Gkbd/gdVQrV9XqkCwuw246BArR5KjgQdEzcmfwEWSEy5r7dvwSRi8c
         uIaQ9A7o8ANF01I1rRzoTqNj0WY+fGVDKDbwrJ6lhrUhj7gCJI/8CJNkptIJxfKTu1Sr
         j7HEYZn1wJH4Jxli7OALmwPl2/FKwLUr8oU9IDyZI1T3qAdEEz58IWwpIVRqPsN48v2X
         3a+FMfDTHhuHxRj2nmiJhA1yWseVTZAFrpmCgH9/vUr8DB2fy75CFto3hl7yM7YA9hkI
         IU0A==
X-Gm-Message-State: APjAAAWWTZ+v2wlZIMbOcExKQ8eInqHXsu+JTsCCHH6SUlK8IK6EWw3x
        NLJqZ8wd/xvlV2q2KnPQwFY=
X-Google-Smtp-Source: APXvYqytGWDZusg1vkeWu31wTXFZP3fq6kp4CERRivuKi9wgUOw8WCtQ1v3DYpcuKqSvGc3lmIZlLA==
X-Received: by 2002:a05:600c:2509:: with SMTP id d9mr23174569wma.148.1576944986926;
        Sat, 21 Dec 2019 08:16:26 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z3sm13624668wrs.94.2019.12.21.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 08:16:25 -0800 (PST)
Date:   Sat, 21 Dec 2019 17:16:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20191221161624.GA130017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 9f0bff1180efc9ea988fed3fd93da7647151ac8b perf/core: Add SRCU annotation for pmus list walk

Misc fixes: a BTS fix, a PT NMI handling fix, a PMU sysfs fix and an SRCU 
annotation.

 Thanks,

	Ingo

------------------>
Alexander Shishkin (2):
      perf/x86/intel/bts: Fix the use of page_private()
      perf/x86/intel: Fix PT PMI handling

Peter Zijlstra (1):
      perf/x86: Fix potential out-of-bounds access

Sebastian Andrzej Siewior (1):
      perf/core: Add SRCU annotation for pmus list walk


 arch/x86/events/core.c      | 19 +++++++++++++++----
 arch/x86/events/intel/bts.c | 16 +++++++++++-----
 kernel/events/core.c        |  2 +-
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9a89d98c55bd..f118af9f0718 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -376,7 +376,7 @@ int x86_add_exclusive(unsigned int what)
 	 * LBR and BTS are still mutually exclusive.
 	 */
 	if (x86_pmu.lbr_pt_coexist && what == x86_lbr_exclusive_pt)
-		return 0;
+		goto out;
 
 	if (!atomic_inc_not_zero(&x86_pmu.lbr_exclusive[what])) {
 		mutex_lock(&pmc_reserve_mutex);
@@ -388,6 +388,7 @@ int x86_add_exclusive(unsigned int what)
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 
+out:
 	atomic_inc(&active_events);
 	return 0;
 
@@ -398,11 +399,15 @@ int x86_add_exclusive(unsigned int what)
 
 void x86_del_exclusive(unsigned int what)
 {
+	atomic_dec(&active_events);
+
+	/*
+	 * See the comment in x86_add_exclusive().
+	 */
 	if (x86_pmu.lbr_pt_coexist && what == x86_lbr_exclusive_pt)
 		return;
 
 	atomic_dec(&x86_pmu.lbr_exclusive[what]);
-	atomic_dec(&active_events);
 }
 
 int x86_setup_perfctr(struct perf_event *event)
@@ -1642,9 +1647,12 @@ static struct attribute_group x86_pmu_format_group __ro_after_init = {
 
 ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr, char *page)
 {
-	struct perf_pmu_events_attr *pmu_attr = \
+	struct perf_pmu_events_attr *pmu_attr =
 		container_of(attr, struct perf_pmu_events_attr, attr);
-	u64 config = x86_pmu.event_map(pmu_attr->id);
+	u64 config = 0;
+
+	if (pmu_attr->id < x86_pmu.max_events)
+		config = x86_pmu.event_map(pmu_attr->id);
 
 	/* string trumps id */
 	if (pmu_attr->event_str)
@@ -1713,6 +1721,9 @@ is_visible(struct kobject *kobj, struct attribute *attr, int idx)
 {
 	struct perf_pmu_events_attr *pmu_attr;
 
+	if (idx >= x86_pmu.max_events)
+		return 0;
+
 	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
 	/* str trumps id */
 	return pmu_attr->event_str || x86_pmu.event_map(idx) ? attr->mode : 0;
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 38de4a7f6752..6a3b599ee0fe 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -63,9 +63,17 @@ struct bts_buffer {
 
 static struct pmu bts_pmu;
 
+static int buf_nr_pages(struct page *page)
+{
+	if (!PagePrivate(page))
+		return 1;
+
+	return 1 << page_private(page);
+}
+
 static size_t buf_size(struct page *page)
 {
-	return 1 << (PAGE_SHIFT + page_private(page));
+	return buf_nr_pages(page) * PAGE_SIZE;
 }
 
 static void *
@@ -83,9 +91,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
 	/* count all the high order buffers */
 	for (pg = 0, nbuf = 0; pg < nr_pages;) {
 		page = virt_to_page(pages[pg]);
-		if (WARN_ON_ONCE(!PagePrivate(page) && nr_pages > 1))
-			return NULL;
-		pg += 1 << page_private(page);
+		pg += buf_nr_pages(page);
 		nbuf++;
 	}
 
@@ -109,7 +115,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
 		unsigned int __nr_pages;
 
 		page = virt_to_page(pages[pg]);
-		__nr_pages = PagePrivate(page) ? 1 << page_private(page) : 1;
+		__nr_pages = buf_nr_pages(page);
 		buf->buf[nbuf].page = page;
 		buf->buf[nbuf].offset = offset;
 		buf->buf[nbuf].displacement = (pad ? BTS_RECORD_SIZE - pad : 0);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ff86d57f9e5..a1f8bde19b56 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10523,7 +10523,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
 		goto unlock;
 	}
 
-	list_for_each_entry_rcu(pmu, &pmus, entry) {
+	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
 		ret = perf_try_init_event(pmu, event);
 		if (!ret)
 			goto unlock;
