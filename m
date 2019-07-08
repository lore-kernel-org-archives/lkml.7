Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7B0C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89D921479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600932;
	bh=yeybfoY3aX4WhdcmzO9PBFQXE+dk9vasnGbliLQV7hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b08WhzCvrKcsNkOPzH5JY/MtAI0wn0j4lAqKbh6LzlZa75uExkkFpNvpUqFhEggZR
	 39odslB+B+qhBNVZ2KUCN07SKvnZ8RPg7L2QXIY+/S1uC7xF1eBq+gxYKKORo+7yGn
	 aUe14L0HThgQGyE6eDT1JRSUETgLoxxe4ojJvcv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbfGHPRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732842AbfGHPRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:17:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DFD0216C4;
        Mon,  8 Jul 2019 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599053;
        bh=yeybfoY3aX4WhdcmzO9PBFQXE+dk9vasnGbliLQV7hY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFjROdHlHZ3Oglfo6nPQHB4sFvcoLSc2Q9vOFIa+KSDg/B/X0FuE8z/KNaF5iUDCC
         EFOmLfsiO+GiJLyllFJpUCuLIO9UbVhAqDUeyosf4UualzhittlcF7DK1LVbSHd3Pg
         sUBcnIKfuB6E3pRRk+Lh4TYY821JDUcQWUnrZSWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 62/73] ptrace: Fix ->ptracer_cred handling for PTRACE_TRACEME
Date:   Mon,  8 Jul 2019 17:13:12 +0200
Message-Id: <20190708150524.578927600@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit 6994eefb0053799d2e07cd140df6c2ea106c41ee upstream.

Fix two issues:

When called for PTRACE_TRACEME, ptrace_link() would obtain an RCU
reference to the parent's objective credentials, then give that pointer
to get_cred().  However, the object lifetime rules for things like
struct cred do not permit unconditionally turning an RCU reference into
a stable reference.

PTRACE_TRACEME records the parent's credentials as if the parent was
acting as the subject, but that's not the case.  If a malicious
unprivileged child uses PTRACE_TRACEME and the parent is privileged, and
at a later point, the parent process becomes attacker-controlled
(because it drops privileges and calls execve()), the attacker ends up
with control over two processes with a privileged ptrace relationship,
which can be abused to ptrace a suid binary and obtain root privileges.

Fix both of these by always recording the credentials of the process
that is requesting the creation of the ptrace relationship:
current_cred() can't change under us, and current is the proper subject
for access control.

This change is theoretically userspace-visible, but I am not aware of
any code that it will actually break.

Fixes: 64b875f7ac8a ("ptrace: Capture the ptracer's creds not PT_PTRACE_CAP")
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/ptrace.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -45,9 +45,7 @@ void __ptrace_link(struct task_struct *c
  */
 static void ptrace_link(struct task_struct *child, struct task_struct *new_parent)
 {
-	rcu_read_lock();
-	__ptrace_link(child, new_parent, __task_cred(new_parent));
-	rcu_read_unlock();
+	__ptrace_link(child, new_parent, current_cred());
 }
 
 /**


