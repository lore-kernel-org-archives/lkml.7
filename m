Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9438C48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C2E204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053886;
	bh=W0ZoOHmqDMjJ+NHKOS0J47iPev1a8ilmNbezR/YN1yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hx7QtPZk5k5u2AkPq8y+aLCo6v2/oQ+OP7n9i8crOKp+5EpMpi+e/wqDbbGWQP8vq
	 Xy+XCPyQo9MvrfnWALQBs3FL5z3ieGN/J6gM3RNdPI3vzYqumv03PsqYhq9sMFncrp
	 KacRr67xi+8t/1gmp79/yCJESelyD2X8qVT+octA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfFTSEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfFTSEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:04:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD7621530;
        Thu, 20 Jun 2019 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053883;
        bh=W0ZoOHmqDMjJ+NHKOS0J47iPev1a8ilmNbezR/YN1yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=owOkMTluWB9ISSE07qtuUjqkz25yPfHrEi43fKk+Y5aqycdQdzgjpM/9TQMQZZ7QM
         nWfkfgtAbLmkgazxhHEZPgmekKTKUmD0xbLnZgYjQq1te66uFgTulVcFk3K8jZPA7x
         OD0YE5RP95SQyfpzYLZs+YBfsbuztQ/H7grnXTbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 061/117] [PATCH] signal/ptrace: Dont leak unitialized kernel memory with PTRACE_PEEK_SIGINFO
Date:   Thu, 20 Jun 2019 19:56:35 +0200
Message-Id: <20190620174356.601936665@linuxfoundation.org>
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

[ Upstream commit f6e2aa91a46d2bc79fce9b93a988dbe7655c90c0 ]

Recently syzbot in conjunction with KMSAN reported that
ptrace_peek_siginfo can copy an uninitialized siginfo to userspace.
Inspecting ptrace_peek_siginfo confirms this.

The problem is that off when initialized from args.off can be
initialized to a negaive value.  At which point the "if (off >= 0)"
test to see if off became negative fails because off started off
negative.

Prevent the core problem by adding a variable found that is only true
if a siginfo is found and copied to a temporary in preparation for
being copied to userspace.

Prevent args.off from being truncated when being assigned to off by
testing that off is <= the maximum possible value of off.  Convert off
to an unsigned long so that we should not have to truncate args.off,
we have well defined overflow behavior so if we add another check we
won't risk fighting undefined compiler behavior, and so that we have a
type whose maximum value is easy to test for.

Cc: Andrei Vagin <avagin@gmail.com>
Cc: stable@vger.kernel.org
Reported-by: syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com
Fixes: 84c751bd4aeb ("ptrace: add ability to retrieve signals without removing from a queue (v4)")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/ptrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index efba851ee018..df06d2fcbb92 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -710,6 +710,10 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 	if (arg.nr < 0)
 		return -EINVAL;
 
+	/* Ensure arg.off fits in an unsigned long */
+	if (arg.off > ULONG_MAX)
+		return 0;
+
 	if (arg.flags & PTRACE_PEEKSIGINFO_SHARED)
 		pending = &child->signal->shared_pending;
 	else
@@ -717,18 +721,20 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 
 	for (i = 0; i < arg.nr; ) {
 		siginfo_t info;
-		s32 off = arg.off + i;
+		unsigned long off = arg.off + i;
+		bool found = false;
 
 		spin_lock_irq(&child->sighand->siglock);
 		list_for_each_entry(q, &pending->list, list) {
 			if (!off--) {
+				found = true;
 				copy_siginfo(&info, &q->info);
 				break;
 			}
 		}
 		spin_unlock_irq(&child->sighand->siglock);
 
-		if (off >= 0) /* beyond the end of the list */
+		if (!found) /* beyond the end of the list */
 			break;
 
 #ifdef CONFIG_COMPAT
-- 
2.20.1



