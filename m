Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1134AC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D869720B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWsIJryF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfE2LdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:33:06 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:42324 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfE2LdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:33:05 -0400
Received: by mail-vk1-f202.google.com with SMTP id l20so847656vkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EPoVy8lx0burcqRe9tnNKcLoXN9lfRRXZMjhWxr4XRw=;
        b=CWsIJryFsXwTbU5c7t9lokMjdfRXXNr0foOaD5TZxOkCPbrKdjqCdooJY+N16Zcdc+
         lhmPlI7p4rC/EpxHYMXFECQ2hJoea2SQPwNMH8vwMvJboBKEpU/UTfkvG8VsG3quMpRX
         vKUcAGSA1Vi2zbLJAQODn62wcO4PmJVZOdpkzdgbSWl/Ilt+iHpHdV3QMShxa00Uw8ek
         qisJYnAW1PIc4/TeIluzaTHmZxmai/af998YqoRPXcJMEpS+B5cHqwKXrwdtot7AnK8u
         +d6XZqUa7u7ZvCmR4u5n2mn13+wpdPddyVscYCb6XnDn6NIPOmpIqk8tZ6RBBjULAQZg
         Th+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EPoVy8lx0burcqRe9tnNKcLoXN9lfRRXZMjhWxr4XRw=;
        b=bFpn4chsY8nYkUQjh7itA4LdsV4EDb0Ith85VB10aLdSqdbPhvYxGhsWZ0ZauHQn86
         Fp6UiE5ArZd+pyFOrId/SvN0CYp7IY96X+O5Una+MT5mcguUEXhIMHdyO5wTonJWhJtS
         JVp0tDMTD4+63mVg/33PwoRsc0Mm/lFWSLYAJskWz3E/8qUxFF5yxEu1uTJTjDQjz90h
         UM51bb9UXAscx4WdxuGTigiVidFmD819MLrcMlpiPrH6Ywgy03EEJOim5RZM0KJDUPQH
         TpPUjuXsVMd0wAy5PDPREYkxe2xYtfjw75IGYWrehmGJ1CWTR5yPx3zk1tHUSmtj2uH7
         bg2w==
X-Gm-Message-State: APjAAAWwfOUSoigVtUNzWZwgWmIYtCC0ijrzsuPq9dE6obayfglT8QyX
        7l2OFhIn2CaRtqyRPp+mQS4buUhfjw==
X-Google-Smtp-Source: APXvYqxchUgQZbyKRC3Fz+fFZ11sCN/4NRnGLAsryiW13pJ5/PcIXiARspgv5Wt8tukfciEkcv5kqoCI3w==
X-Received: by 2002:ab0:14cb:: with SMTP id f11mr7593106uae.24.1559129583868;
 Wed, 29 May 2019 04:33:03 -0700 (PDT)
Date:   Wed, 29 May 2019 13:31:57 +0200
Message-Id: <20190529113157.227380-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
From:   Jann Horn <jannh@google.com>
To:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, jannh@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore the read memory barrier in __ptrace_may_access() that was deleted
a couple years ago. Also add comments on this barrier and the one it pairs
with to explain why they're there (as far as I understand).

Fixes: bfedb589252c ("mm: Add a user_ns owner to mm_struct and fix ptrace permission checks")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
(I have no clue whatsoever what the relevant tree for this is, but I
guess Oleg is the relevant maintainer?)

 kernel/cred.c   |  9 +++++++++
 kernel/ptrace.c | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/kernel/cred.c b/kernel/cred.c
index 45d77284aed0..07e069d00696 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -450,6 +450,15 @@ int commit_creds(struct cred *new)
 		if (task->mm)
 			set_dumpable(task->mm, suid_dumpable);
 		task->pdeath_signal = 0;
+		/*
+		 * If a task drops privileges and becomes nondumpable,
+		 * the dumpability change must become visible before
+		 * the credential change; otherwise, a __ptrace_may_access()
+		 * racing with this change may be able to attach to a task it
+		 * shouldn't be able to attach to (as if the task had dropped
+		 * privileges without becoming nondumpable).
+		 * Pairs with a read barrier in __ptrace_may_access().
+		 */
 		smp_wmb();
 	}
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 5710d07e67cf..e54452c2954b 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -324,6 +324,16 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	return -EPERM;
 ok:
 	rcu_read_unlock();
+	/*
+	 * If a task drops privileges and becomes nondumpable (through a syscall
+	 * like setresuid()) while we are trying to access it, we must ensure
+	 * that the dumpability is read after the credentials; otherwise,
+	 * we may be able to attach to a task that we shouldn't be able to
+	 * attach to (as if the task had dropped privileges without becoming
+	 * nondumpable).
+	 * Pairs with a write barrier in commit_creds().
+	 */
+	smp_rmb();
 	mm = task->mm;
 	if (mm &&
 	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
-- 
2.22.0.rc1.257.g3120a18244-goog

