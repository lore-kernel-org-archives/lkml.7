Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3008AC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012712173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wTRoNSd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbfGPWqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:46:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54195 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfGPWqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:46:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6GMkjWH1257572
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Jul 2019 15:46:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6GMkjWH1257572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563317206;
        bh=goJB9mEWdYvQyqv4Z/lwdTrp46FWdFCWF2GKfpeHZec=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wTRoNSd72mtJRUQyP/OA7QD7nAhX6aUg7WagGm+l9S4vVxNr2vG+tK8kvK26B+HlF
         O+kBU7CPly89BAtt3HW67GkWn68ybCv+iW23b6yEViGpFopPJzKCdELlbvkfRS/Ut1
         wU7sDdyzvvswgpPh4AtMwzuooOoxvNbpYY6D/K+BDim9SUc1pkr9vriKHGB+F9Q6Na
         EKD/4PZq1hNTIFiAzRd6hdqeG7+M1RZcKznJZcdDOYhcd4bUaVpPT5oED9yV4WADK5
         PIDrewAa0XutACesEgdp5b5okPZiiUmpmIPXlED2srZngjOhusoa/Aw2ty0JwyS8uI
         C9mAdLlcCiZdw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6GMkjv61257564;
        Tue, 16 Jul 2019 15:46:45 -0700
Date:   Tue, 16 Jul 2019 15:46:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-50e04acf2990d0d93983720b0a85b11ef805df60@git.kernel.org>
Cc:     jannh@google.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          jannh@google.com, tglx@linutronix.de
In-Reply-To: <20190712224152.13129-1-jannh@google.com>
References: <20190712224152.13129-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/process: Delete useless check for dead process
 with LDT
Git-Commit-ID: 50e04acf2990d0d93983720b0a85b11ef805df60
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  50e04acf2990d0d93983720b0a85b11ef805df60
Gitweb:     https://git.kernel.org/tip/50e04acf2990d0d93983720b0a85b11ef805df60
Author:     Jann Horn <jannh@google.com>
AuthorDate: Sat, 13 Jul 2019 00:41:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Jul 2019 00:42:27 +0200

x86/process: Delete useless check for dead process with LDT

At release_thread(), ->mm is NULL; and it is fine for the former mm to
still have an LDT. Delete this check in process_64.c, similar to
commit 2684927c6b93 ("[PATCH] x86: Deprecate useless bug"), which did the
same in process_32.c.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190712224152.13129-1-jannh@google.com


---
 arch/x86/kernel/process_64.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 250e4c4ac6d9..af64519b2695 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -143,17 +143,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 
 void release_thread(struct task_struct *dead_task)
 {
-	if (dead_task->mm) {
-#ifdef CONFIG_MODIFY_LDT_SYSCALL
-		if (dead_task->mm->context.ldt) {
-			pr_warn("WARNING: dead process %s still has LDT? <%p/%d>\n",
-				dead_task->comm,
-				dead_task->mm->context.ldt->entries,
-				dead_task->mm->context.ldt->nr_entries);
-			BUG();
-		}
-#endif
-	}
+	WARN_ON(dead_task->mm);
 }
 
 enum which_selector {
