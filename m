Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36462C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090A3208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="a4Ocormi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfF1Tev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:34:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36745 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF1Tev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:34:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so3793442plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EKxLa9hnb5xkY364WafvE1Ug+KyOxqGtL7a6TmMgs9A=;
        b=a4Ocormi31rfgzjThkpX8okXS+lYlZmn0QcdifvMi+UbvpFL9Gie9lO5dB5KcFGeRY
         p2IMoo9+u4aWWKIpN9pkEQblyzGV/btumv4tMf6KQcbcsiC/YnwZsfsJzONKt3iwn+ys
         BO9lYzn7ZJpOjRj3dCtNv6rltCHNcJS5sLXIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EKxLa9hnb5xkY364WafvE1Ug+KyOxqGtL7a6TmMgs9A=;
        b=Wk02qOv+YE4q6mwlaGbv5puwl1gEi1FNpKDGgfBMOhBVHk8ZmwCUs0nMiJvxYyaR1K
         PYtVx1rrUMCrRIlPJ0IhEhk0rJWPz+n6AuSX9hvGVypXjHkiwNHkxEu+r72FQeqRY6IL
         TWN3qGcE+Q6pDm8LC1o2o4zGerAoirfpZpAcwfeLerzAZPs3mae3ra1bwbMeZ20ovfoc
         nN5n2UrIA/hdI2fi1uqz4niH//cx35XstLCrAxqmM/b3OznUg9aQgvrlsVYFtE88e9Uh
         tgh1ayc5A55lOVb3kwpjaIi3tYY1z3O3i9w2BlWX5wbvx9M4UyXoE2wuu2fSV8ti6Hua
         iF6Q==
X-Gm-Message-State: APjAAAUXlyxJBRwRcSmywodXk+Pt5RzSGIkIGV2RJJ0FazZ5pq3DpDjw
        L490ho6HfsoDC2K/SJHYz+hgKRD9lZE8Bw==
X-Google-Smtp-Source: APXvYqzG3hNnHjXkcQ3M+rogMmYvVt8Hga/QqKbzvLJhHfTm5UKcft5ek1E8wem2/fDUttYg17F1Zw==
X-Received: by 2002:a17:902:848b:: with SMTP id c11mr13466303plo.217.1561750490161;
        Fri, 28 Jun 2019 12:34:50 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 27sm2581900pgt.6.2019.06.28.12.34.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 12:34:49 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        mathieu.desnoyers@efficios.com, willy@infradead.org,
        peterz@infradead.org, will.deacon@arm.com,
        paulmck@linux.vnet.ibm.com, elena.reshetova@intel.com,
        keescook@chromium.org, kernel-team@android.com,
        kernel-hardening@lists.openwall.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] Convert struct pid count to refcount_t
Date:   Fri, 28 Jun 2019 15:34:42 -0400
Message-Id: <20190628193442.94745-1-joel@joelfernandes.org>
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
Only change from v1->v2 is to get rid of the atomic_read().

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
