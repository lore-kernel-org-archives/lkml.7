Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05F8C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BA421743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="j159e5gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbfGPVXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:23:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49227 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbfGPVXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:23:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6GLNU4Z1230213
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Jul 2019 14:23:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6GLNU4Z1230213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563312210;
        bh=mZly5m76WunbErWThdFwGFsBxL1DZTLDI/+r4isJRL4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=j159e5gdOqIEy0TcKm6CDKcl+x1AQR7Z4j909TqHSomKSOHJDGUikH+GW34c6eRzC
         XaCqxvkIgQSANbJabSwrnV1vKYbUY+3NiQOgpiWDkvcoV2vmmpTX3Yu6Epu8wL8SGB
         6U4vxPrPu7TlUK70ALf2oyYMbhDeCYSuJZROxB5572mseGImd3D9iznr3Z4rGHZ8pC
         bD+mMhJW2pFmds6NU5q2tKG8E7hLyF6iecGrGUWiExkPTPw88EHqb1McKLI9GHJ/Oz
         jCAWvya1+k8QuSYXcRDJ5J6vX4mivagDc0oRMgFaqbyHYLpk5Jgy6JGVLh342Qum6G
         3ybf80PtBJMEg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6GLNUow1230210;
        Tue, 16 Jul 2019 14:23:30 -0700
Date:   Tue, 16 Jul 2019 14:23:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-68c2976d7d93392d33ccd8871e9e61b33b5e640f@git.kernel.org>
Cc:     jannh@google.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, jannh@google.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190712224152.13129-1-jannh@google.com>
References: <20190712224152.13129-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/process: Delete useless check for dead process
 with LDT
Git-Commit-ID: 68c2976d7d93392d33ccd8871e9e61b33b5e640f
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

Commit-ID:  68c2976d7d93392d33ccd8871e9e61b33b5e640f
Gitweb:     https://git.kernel.org/tip/68c2976d7d93392d33ccd8871e9e61b33b5e640f
Author:     Jann Horn <jannh@google.com>
AuthorDate: Sat, 13 Jul 2019 00:41:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 16 Jul 2019 23:13:50 +0200

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
