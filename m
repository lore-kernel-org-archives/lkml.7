Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4DAC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A0F21655
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053895;
	bh=cRcDWZHkooms6WmCUxm/G7+skOna08W3rNZ4Aa7wVsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RATrzWl3XWC8FcOd33xLar8sO7nyXDJukXASxcjhZe5NQb7njIM9TPLAu8jcrKKko
	 yPxiDizTO7YGOGUrTaOXvhvqIpG08bhE1Wqdz5ON7zZ50C9SIYfxm8GlcXfUFWuDvm
	 2WpLEhomYc8WVclYtv/5w1mxU07QjYfmsP3q0ZeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfFTSEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbfFTSEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:04:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F1792166E;
        Thu, 20 Jun 2019 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053888;
        bh=cRcDWZHkooms6WmCUxm/G7+skOna08W3rNZ4Aa7wVsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBV6E0Zb2PZ5wqBLKZsJp5vu9hDisba6hTn/o1qVFk4Dv2rJU2wmMQ2it+XJX2WXt
         eez9+i7/aMEsuJZVNpTb7beyDsEp/DbdSWH+JE425QPCPzLyYIg7qgh5IpTaGUHf9l
         JZc4Z/vows87dM1qoPKu6dkEIkP5vYWSfGWdS3l4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.9 062/117] ptrace: restore smp_rmb() in __ptrace_may_access()
Date:   Thu, 20 Jun 2019 19:56:36 +0200
Message-Id: <20190620174356.642476782@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit f6581f5b55141a95657ef5742cf6a6bfa20a109f upstream.

Restore the read memory barrier in __ptrace_may_access() that was deleted
a couple years ago. Also add comments on this barrier and the one it pairs
with to explain why they're there (as far as I understand).

Fixes: bfedb589252c ("mm: Add a user_ns owner to mm_struct and fix ptrace permission checks")
Cc: stable@vger.kernel.org
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/cred.c   |    9 +++++++++
 kernel/ptrace.c |   10 ++++++++++
 2 files changed, 19 insertions(+)

--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -447,6 +447,15 @@ int commit_creds(struct cred *new)
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
 
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -322,6 +322,16 @@ static int __ptrace_may_access(struct ta
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


