Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE457C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEDD207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfIKRqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:46:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbfIKRqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:46:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC0AA2A09B2;
        Wed, 11 Sep 2019 17:46:12 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-27.ams2.redhat.com [10.36.112.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B484A5D6A5;
        Wed, 11 Sep 2019 17:46:05 +0000 (UTC)
Date:   Wed, 11 Sep 2019 18:45:40 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v3] fork: check exit_signal passed in clone3() call
Message-ID: <4b38fa4ce420b119a4c6345f42fe3cec2de9b0b5.1568223594.git.esyr@redhat.com>
References: <cover.1568223594.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568223594.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 11 Sep 2019 17:46:12 +0000 (UTC)
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

Adding checks that user-passed exit_signal fits into int and passes
valid_signal() check solves both of these problems.

[1] https://lkml.org/lkml/2019/9/10/467

* kernel/fork.c (copy_clone_args_from_user): Fail with -EINVAL if
args.exit_signal is greater than UINT_MAX or is not a valid signal.
(_do_fork): Note that exit_signal is expected to be checked for the
sanity by the caller.

Fixes: 7f192e3cd316 ("fork: add clone3")
Reported-by: Oleg Nesterov <oleg@redhat.com>
Co-authored-by: Oleg Nesterov <oleg@redhat.com>
Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 kernel/fork.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2852d0e..f98314b 100644
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
@@ -2562,6 +2564,15 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 	if (copy_from_user(&args, uargs, size))
 		return -EFAULT;
 
+	/*
+	 * Two separate checks are needed, as valid_signal() takes unsigned long
+	 * as an argument, and struct kernel_clone_args uses int type
+	 * for the exit_signal field.
+	 */
+	if (unlikely((args.exit_signal > UINT_MAX) ||
+		     !valid_signal(args.exit_signal)))
+		return -EINVAL;
+
 	*kargs = (struct kernel_clone_args){
 		.flags		= args.flags,
 		.pidfd		= u64_to_user_ptr(args.pidfd),
-- 
2.1.4

