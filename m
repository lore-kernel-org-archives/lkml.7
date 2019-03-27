Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2800EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC022082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BBpgm1Nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfC0Oxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:53:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46298 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfC0Oxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:53:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so9804922pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsF4MOIT4z4fdfwNAyuntvIwt6iP7atPYvwA3arGD14=;
        b=BBpgm1NlnZhKSH87DRVYI3AiOhzjJ/q+7CpqM13H6AK9SrAM7t03D4sy3ofzfxOO85
         xX1bvplar5BK2gUlCy4BuHy4C17duVGawvs1myHFzfpTp3CCMofjJDM1Vo+vYeXYyPj9
         xB3lwuLqvozSSgMgkd4ETIQ5ehAr+QKLO+Cn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsF4MOIT4z4fdfwNAyuntvIwt6iP7atPYvwA3arGD14=;
        b=CJHG2cJNErHP84qyC4ILeqqTZ7I5jQDTYxIht8Hs8yR3lCGr0OrWqw4668n715KN1/
         Vw0WIQXMhhEc+CfPiMWrOCOFkWTa6+aObM/MnLjatLdKMVRgswaHD0T6pM53mysbnC6k
         Z/F+qLMcdiWLeNfesxK5bBiosipW4i0M3OpcDWGhZw9ON8gbp99GfYy50z05JCODIwc6
         ocKvJuIkXHeTdSgrUXJplNvQP0XPMC0Suzw30A8cX0v7sohmHDR2rsr+78vssd5YGsxK
         PYKDOu1YjvBwbVlsUh+c00uC+r+WrVWesyxK2FYryp1iii0fwp/RJtBI6aWroDxZaTWu
         /NTg==
X-Gm-Message-State: APjAAAUdiYmoUuqPGWVXFt1ng/pSr8y3UflUK74e8AnIDzJNmObnPyH1
        WKzSvKldyAzd6Ip3nKh/XJg4UvJJSs4=
X-Google-Smtp-Source: APXvYqyyiDNB/7Nz2PGpQaojBQJUROXMahgJR1nQmWE9UUZ8H0XmI2JbT58UtGX3OLjtB/wc6WTgYA==
X-Received: by 2002:a63:28f:: with SMTP id 137mr8252384pgc.377.1553698427990;
        Wed, 27 Mar 2019 07:53:47 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f125sm41335245pfc.91.2019.03.27.07.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 07:53:47 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        keescook@chromium.org, kernel-team@android.com,
        kernel-hardening@lists.openwall.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] Convert struct pid count to refcount_t
Date:   Wed, 27 Mar 2019 10:53:31 -0400
Message-Id: <20190327145331.215360-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct pid's count is an atomic_t field used as a refcount. Use
refcount_t for it which is basically atomic_t but does additional
checking to prevent use-after-free bugs. No change in behavior if
CONFIG_REFCOUNT_FULL=n.

Cc: keescook@chromium.org
Cc: kernel-team@android.com
Cc: kernel-hardening@lists.openwall.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 include/linux/pid.h | 5 +++--
 kernel/pid.c        | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

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
index 20881598bdfa..2095c7da644d 100644
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
 
@@ -106,8 +106,8 @@ void put_pid(struct pid *pid)
 		return;
 
 	ns = pid->numbers[pid->level].ns;
-	if ((atomic_read(&pid->count) == 1) ||
-	     atomic_dec_and_test(&pid->count)) {
+	if ((refcount_read(&pid->count) == 1) ||
+	     refcount_dec_and_test(&pid->count)) {
 		kmem_cache_free(ns->pid_cachep, pid);
 		put_pid_ns(ns);
 	}
@@ -210,7 +210,7 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 	}
 
 	get_pid_ns(ns);
-	atomic_set(&pid->count, 1);
+	refcount_set(&pid->count, 1);
 	for (type = 0; type < PIDTYPE_MAX; ++type)
 		INIT_HLIST_HEAD(&pid->tasks[type]);
 
-- 
2.21.0.392.gf8f6787159e-goog

