Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E90C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521B821479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfIJR7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:59:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfIJR7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:59:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE1CA10CC207;
        Tue, 10 Sep 2019 17:59:22 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-20.ams2.redhat.com [10.36.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C640260BF7;
        Tue, 10 Sep 2019 17:59:17 +0000 (UTC)
Date:   Tue, 10 Sep 2019 18:58:52 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v2] fork: check exit_signal passed in clone3() call
Message-ID: <20190910175852.GA15572@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 10 Sep 2019 17:59:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, higher 32 bits of exit_signal fields were lost when
copied to the kernel args structure (that uses int as a type for the
respective field).  Moreover, as Oleg has noted[1], exit_signal is used
unchecked, so it has to be checked for sanity before use; for the legacy
syscalls, applying CSIGNAL mask guarantees that it is at least non-negative;
however, there's no such thing is done in clone3() code path, and that can
break at least thread_group_leader.

Checking user-passed exit_signal against ~CSIGNAL mask solves both
of these problems.

[1] https://lkml.org/lkml/2019/9/10/467

* kernel/fork.c (copy_clone_args_from_user): Fail with -EINVAL if
args.exit_signal has bits set outside CSIGNAL mask.
(_do_fork): Note that exit_signal is expected to be checked for the
sanity by the caller.

Fixes: 7f192e3cd316 ("fork: add clone3")
Reported-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 kernel/fork.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2852d0e..9dee2ab 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2338,6 +2338,8 @@ struct mm_struct *copy_init_mm(void)
  *
  * It copies the process, and if successful kick-starts
  * it and waits for it to finish using the VM if required.
+ *
+ * args->exit_signal is expected to be checked for sanity by the caller.
  */
 long _do_fork(struct kernel_clone_args *args)
 {
@@ -2562,6 +2564,16 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 	if (copy_from_user(&args, uargs, size))
 		return -EFAULT;
 
+	/*
+	 * exit_signal is confined to CSIGNAL mask in legacy syscalls,
+	 * so it is used unchecked deeper in syscall handling routines;
+	 * moreover, copying to struct kernel_clone_args.exit_signals
+	 * trims higher 32 bits, so it is has to be checked that they
+	 * are zero.
+	 */
+	if (unlikely(args.exit_signal & ~((u64)CSIGNAL)))
+		return -EINVAL;
+
 	*kargs = (struct kernel_clone_args){
 		.flags		= args.flags,
 		.pidfd		= u64_to_user_ptr(args.pidfd),
-- 
2.1.4

