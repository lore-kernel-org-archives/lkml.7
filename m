Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1170AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D617320657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hV9Hginv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfFXSp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:45:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38608 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFXSp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:45:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so4371041qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7vmIFoMsLv6AsnWiTP/27K1ZwOU/uez0zA/43q6sf8=;
        b=hV9Hginvi+G8TJyLdFMXeusvL3jKgQeZ98y9O6WGRT8Lj4OL7/hTzbF1SbIu9vAQ5y
         KHr6CiTlqIoq0p/yWkLE00/bQd14rCQytxBXYchlWzPlq8nkHLXnMLYb0b+sHVxaoqSq
         DE0YShUZYUMvzHlQ3leSkTcQznouO4lQVt3mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7vmIFoMsLv6AsnWiTP/27K1ZwOU/uez0zA/43q6sf8=;
        b=GvAKGRW1QvWxVO8jH3NTiHIC3gcCwefdcOatPMwkdX4dhzpq1lr1jeXSVN7Oqo6ntv
         t+ff4NZLZCtjuuJtHpC4zmZkoOFaDdcN12VCHkE+EjsSF1wpSJuewPVsIUmc/x2mIHOF
         Sl5ALlptJLgNFppydNWlxTbBLbwL7bA+ifcK3Y4WYqSjiNCcOPUseNfpAezYs+viJXAy
         0UWYcTnJIaDnXcKm+ywiaTOABOQmco4xxbn6L/tx2mGYrfvid2gW8tQcHNTWXs6mO+ik
         ndts/mAj3aTufSCFSS3BDGVe5w27vqShDJiwsvUaOUs2x8cHbK7UYBE+motkcwTOb1Yq
         iYGw==
X-Gm-Message-State: APjAAAVhlm/bndSVdVMKhe1g/k0o/MFj/n+7iITuGrX8nV+KUaPAZuM7
        8FsDRG+P85LkUEtEbSZNMTLt8eDUm1yJEg==
X-Google-Smtp-Source: APXvYqxn2Nn5FET3LlhRWVj/WXwyovGkegdYS6rULBlkCwmq2MHqiEV8acU6rL6Nn0X0HEwP582EYA==
X-Received: by 2002:a0c:8a26:: with SMTP id 35mr58659957qvt.158.1561401957565;
        Mon, 24 Jun 2019 11:45:57 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f1sm5964663qke.117.2019.06.24.11.45.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 11:45:56 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        jannh@google.com, oleg@redhat.com, mathieu.desnoyers@efficios.com,
        willy@infradead.org, peterz@infradead.org, will.deacon@arm.com,
        paulmck@linux.vnet.ibm.com, elena.reshetova@intel.com,
        keescook@chromium.org, kernel-team@android.com,
        kernel-hardening@lists.openwall.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH RFC v2] Convert struct pid count to refcount_t
Date:   Mon, 24 Jun 2019 14:45:34 -0400
Message-Id: <20190624184534.209896-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct pid's count is an atomic_t field used as a refcount. Use
refcount_t for it which is basically atomic_t but does additional
checking to prevent use-after-free bugs.

For memory ordering, the only change is with the following:
 -	if ((atomic_read(&pid->count) == 1) ||
 -	     atomic_dec_and_test(&pid->count)) {
 +	if (refcount_dec_and_test(&pid->count)) {
 		kmem_cache_free(ns->pid_cachep, pid);

Here the change is from:
Fully ordered --> RELEASE + ACQUIRE (as per refcount-vs-atomic.rst)
This ACQUIRE should take care of making sure the free happens after the
refcount_dec_and_test().

The above hunk also removes atomic_read() since it is not needed for the
code to work and it is unclear how beneficial it is. The removal lets
refcount_dec_and_test() check for cases where get_pid() happened before
the object was freed.

Cc: jannh@google.com
Cc: oleg@redhat.com
Cc: mathieu.desnoyers@efficios.com
Cc: willy@infradead.org
Cc: peterz@infradead.org
Cc: will.deacon@arm.com
Cc: paulmck@linux.vnet.ibm.com
Cc: elena.reshetova@intel.com
Cc: keescook@chromium.org
Cc: kernel-team@android.com
Cc: kernel-hardening@lists.openwall.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
Changed to RFC to get any feedback on the memory ordering.


 include/linux/pid.h | 5 +++--
 kernel/pid.c        | 7 +++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 14a9a39da9c7..8cb86d377ff5 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -3,6 +3,7 @@
 #define _LINUX_PID_H
 
 #include <linux/rculist.h>
+#include <linux/refcount.h>
 
 enum pid_type
 {
@@ -56,7 +57,7 @@ struct upid {
 
 struct pid
 {
-	atomic_t count;
+	refcount_t count;
 	unsigned int level;
 	/* lists of tasks that use this pid */
 	struct hlist_head tasks[PIDTYPE_MAX];
@@ -69,7 +70,7 @@ extern struct pid init_struct_pid;
 static inline struct pid *get_pid(struct pid *pid)
 {
 	if (pid)
-		atomic_inc(&pid->count);
+		refcount_inc(&pid->count);
 	return pid;
 }
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 20881598bdfa..89c4849fab5d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -37,7 +37,7 @@
 #include <linux/init_task.h>
 #include <linux/syscalls.h>
 #include <linux/proc_ns.h>
-#include <linux/proc_fs.h>
+#include <linux/refcount.h>
 #include <linux/sched/task.h>
 #include <linux/idr.h>
 
@@ -106,8 +106,7 @@ void put_pid(struct pid *pid)
 		return;
 
 	ns = pid->numbers[pid->level].ns;
-	if ((atomic_read(&pid->count) == 1) ||
-	     atomic_dec_and_test(&pid->count)) {
+	if (refcount_dec_and_test(&pid->count)) {
 		kmem_cache_free(ns->pid_cachep, pid);
 		put_pid_ns(ns);
 	}
@@ -210,7 +209,7 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 	}
 
 	get_pid_ns(ns);
-	atomic_set(&pid->count, 1);
+	refcount_set(&pid->count, 1);
 	for (type = 0; type < PIDTYPE_MAX; ++type)
 		INIT_HLIST_HEAD(&pid->tasks[type]);
 
-- 
2.22.0.410.gd8fdbe21b5-goog
