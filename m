Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E0AECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3D2214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408794AbfJQKTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:19:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36457 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408769AbfJQKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:19:04 -0400
Received: from [185.81.136.22] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iL2s2-0007tP-Rd; Thu, 17 Oct 2019 10:19:03 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     oleg@redhat.com, linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@kellner.me, cyphar@cyphar.com, elena.reshetova@intel.com,
        guro@fb.com, jannh@google.com, ldv@altlinux.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, peterz@infradead.org,
        shuah@kernel.org, tglx@linutronix.de, viro@zeniv.linux.org.uk,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 3/5] pid: use pid_has_task() in __change_pid()
Date:   Thu, 17 Oct 2019 12:18:30 +0200
Message-Id: <20191017101832.5985-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017101832.5985-1-christian.brauner@ubuntu.com>
References: <20191016153606.2326-1-christian.brauner@ubuntu.com>
 <20191017101832.5985-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hlist_empty() with the new pid_has_task() helper which is more
idiomatic, easier to grep for, and unifies how callers perform this
check.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
/* pidfd selftests */
passed

/* v1 */
patch not present

/* v2 */
Link: https://lore.kernel.org/r/20191016153606.2326-3-christian.brauner@ubuntu.com
patch introduced

/* v2 */
- Oleg Nesterov <oleg@redhat.com>:
  - s/task_alive/pid_has_task/g
---
 kernel/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 0a9f2e437217..124d40b239b1 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -299,7 +299,7 @@ static void __change_pid(struct task_struct *task, enum pid_type type,
 	*pid_ptr = new;
 
 	for (tmp = PIDTYPE_MAX; --tmp >= 0; )
-		if (!hlist_empty(&pid->tasks[tmp]))
+		if (pid_has_task(pid, tmp))
 			return;
 
 	free_pid(pid);
-- 
2.23.0

