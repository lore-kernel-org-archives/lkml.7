Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1736C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C7220645
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIZCFwI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfGIKPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:15:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34965 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfGIKPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:15:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so7876209pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WA5gtuo+ySOXWIRiIrkIDOQyLhIa86b74KS4PTR9iAM=;
        b=FIZCFwI3aBiR/vggDtx3YbxukWikWD/bDAZ+PULJfXWC5pJAtF9fan84oIQvdBAv1z
         FrznwbgKfcmVahncHfLTinXidR1k5BhS41Nb+Ge5XSryESE3NKSAQgNZ+5bKQO1VSvqY
         +eZh7xy9s7HiJwSWt3MnC2Yui/V5TBHCURh1zeevkFSz3sYeGbR3apVok8/B/1W6PujA
         y1SsdtPcOmH6HVcJQ0meqk0ue2UCT151epRyaq6Cs/3eHyduHznh9hFzceYNnvAAwddD
         doDztV60kGrUHN+LdImWdIn7o2AgTiHVitNJOWw6RTybGCMbYvPmBHItBpD/Gyr3mKM0
         B5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WA5gtuo+ySOXWIRiIrkIDOQyLhIa86b74KS4PTR9iAM=;
        b=GybackT+ltQnJU1zIQhmFvLVCXe47LlaSAfclbXaufgLPQdq3a7Lu6LlX6C/FW85cG
         EnfN0ZvJqZMwqDmieFP+0EqVue0HQpw017N7LBLbiCCFoWahxPMpKcv26+tWcCA1xz+X
         //gGcfxeOynhEuR2lLR7XDAc4FPNw8EAETdsBRv5qYMbGLmO9JIITb9YULJFtlT57MwA
         MXnjpPSAgbPGpnQpAr5iU8o+5Tur3Ei1lqomUyOR70UrWl/Irf7ne6NmbOpnr0kc7xHo
         vUS65k7aM4wv7UjqaTl5fs2rXJJUcA3vH+ix0lm6BLrZOyXn+u/WeHM0ItFJOrstwy73
         hE8w==
X-Gm-Message-State: APjAAAW718gvjQ4QXYkv2WBerwzL+81G14hEs/I4Jr5LJPAYBMHRb9g/
        ami3/ou40J0/COAThafYFFA=
X-Google-Smtp-Source: APXvYqyYbZ2FcPOM4BrBIsJaKGs2wX4QGplboi4GLRlBACy/APhEYK73afvGEAyA6IiDHBBQMpEwxQ==
X-Received: by 2002:a63:6901:: with SMTP id e1mr1697000pgc.390.1562667333181;
        Tue, 09 Jul 2019 03:15:33 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id i15sm22195320pfd.160.2019.07.09.03.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 03:15:32 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org, arnd@arndb.de,
        cai@lca.pw, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH] locking/lockdep: Fix lock used or unused stats error
Date:   Tue,  9 Jul 2019 18:15:22 +0800
Message-Id: <20190709101522.9117-1-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stats variable nr_unused_locks is incremented every time a new lock
class is register and decremented when the lock is first used in
__lock_acquire(). And after all, it is shown and checked in lockdep_stats.

However, under configurations that either CONFIG_TRACE_IRQFLAGS or
CONFIG_PROVE_LOCKING is not defined:

The commit:

  091806515124b20 ("locking/lockdep: Consolidate lock usage bit initialization")

missed marking the LOCK_USED flag at IRQ usage initialization because
as mark_usage() is not called. And the commit:

  886532aee3cd42d ("locking/lockdep: Move mark_lock() inside
CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")

further made mark_lock() not defined such that the LOCK_USED cannot be
marked at all when the lock is first acquired.

As a result, we fix this by not showing and checking the stats under such
configurations for lockdep_stats.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep_proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 9c49ec6..65b6a16 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -210,6 +210,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 		      nr_hardirq_read_safe = 0, nr_hardirq_read_unsafe = 0,
 		      sum_forward_deps = 0;
 
+#ifdef CONFIG_PROVE_LOCKING
 	list_for_each_entry(class, &all_lock_classes, lock_entry) {
 
 		if (class->usage_mask == 0)
@@ -241,13 +242,13 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 		if (class->usage_mask & LOCKF_ENABLED_HARDIRQ_READ)
 			nr_hardirq_read_unsafe++;
 
-#ifdef CONFIG_PROVE_LOCKING
 		sum_forward_deps += lockdep_count_forward_deps(class);
-#endif
 	}
 #ifdef CONFIG_DEBUG_LOCKDEP
 	DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused);
 #endif
+
+#endif
 	seq_printf(m, " lock-classes:                  %11lu [max: %lu]\n",
 			nr_lock_classes, MAX_LOCKDEP_KEYS);
 	seq_printf(m, " direct dependencies:           %11lu [max: %lu]\n",
-- 
1.8.3.1

