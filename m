Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE50C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409DC2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="x7mlhMam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfGCHIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:08:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33441 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfGCHIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:08:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6377KEe3176993
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 00:07:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6377KEe3176993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562137640;
        bh=AIigXA0nJ1xpXRrsT1JFgh4Vupgap+xlRnwpJjhFiZY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=x7mlhMamIGWSmx7ytXKucrxFKzgvmelWmYDxGOfsPYNWYIe1pip+fiVmSzxJcBAyF
         ffxVshad/5FTsmF2V3vSFHqnyv4ghMswtj9vj7HepX3paYhHru/fMUqLQ/aOc+WxyA
         k4GSgGS3dMaYjWmefshzXuZp8NjzJdkkeFTcaaHHCUvdaHeQq01EnpSeEBdPEIh+Ms
         HSumNdw2j4eqTPWM3vsNf/Z5DoJNoEhX1z3R+UlZfAbvoo7LyBs4Xn2qBnB0szHYEZ
         8SM6V69snXP5CE403Su3GwIEbem/+d/rnMOj26UjETHpaTURfSyDjPVyeX3nZwVDnQ
         MVB4K8dUzaemg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6377JUG3176990;
        Wed, 3 Jul 2019 00:07:19 -0700
Date:   Wed, 3 Jul 2019 00:07:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7e8e6816c6495a1168f9a7a50125d82c23e59300@git.kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, jpoimboe@redhat.com
Reply-To: rostedt@goodmis.org, tglx@linutronix.de, hpa@zytor.com,
          peterz@infradead.org, mark.rutland@arm.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          jpoimboe@redhat.com
In-Reply-To: <alpine.DEB.2.21.1907021750100.1802@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907021750100.1802@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] stacktrace: Use PF_KTHREAD to check for
 kernel threads
Git-Commit-ID: 7e8e6816c6495a1168f9a7a50125d82c23e59300
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

Commit-ID:  7e8e6816c6495a1168f9a7a50125d82c23e59300
Gitweb:     https://git.kernel.org/tip/7e8e6816c6495a1168f9a7a50125d82c23e59300
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 2 Jul 2019 17:53:35 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 09:04:06 +0200

stacktrace: Use PF_KTHREAD to check for kernel threads

!current->mm is not a reliable indicator for kernel threads as they might
temporarily use a user mm. Check for PF_KTHREAD instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1907021750100.1802@nanos.tec.linutronix.de

---
 kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 36139de0a3c4..c8d0f05721a1 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -228,7 +228,7 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 	};
 
 	/* Trace user stack if not a kernel thread */
-	if (!current->mm)
+	if (current->flags & PF_KTHREAD)
 		return 0;
 
 	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
