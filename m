Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDA4C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA142075E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BqiOtcMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfF0VwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:52:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53967 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0VwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:52:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RLq0nd464952
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 14:52:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RLq0nd464952
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561672321;
        bh=IKXKz9MOR485MGNyLlQ8hSJHcee3ENsDy3/j9pz90pA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BqiOtcMv3dp6AhndbAAIhINa5XuKa9j4QumszoTPnE14dfDZla/b877M177Uomyhc
         DFgAoS+9xesUbFICgwEPVhDzT1psESDpJAguzJPdnHwyAu3fE4bQ7nNGGRKsmBtU8f
         BhMFxK3AS9m9KH0LSjQQqtd/2bTmu1BttOrbvgyXKBiZ/vd2rus1JejG9nPdo7L842
         8tQytJBCzEcLpr8qkPVls9GIJjudtfeJUV5v8uwbzGWT5BNIXtZq09FQ25EbBOT1H7
         N8nqdpQf6Hdr8bKvb8NfMRmVtFVN9Aq4DwMbwtJ0xDNdsP6jCYaTcWTZhJGDkjwwIB
         1eYrbGUmh3oIA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RLq0so464949;
        Thu, 27 Jun 2019 14:52:00 -0700
Date:   Thu, 27 Jun 2019 14:52:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dianzhang Chen <tipbot@zytor.com>
Message-ID: <tip-31a2fbb390fee4231281b939e1979e810f945415@git.kernel.org>
Cc:     dianzhangchen0@gmail.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, dianzhangchen0@gmail.com
In-Reply-To: <1561476617-3759-1-git-send-email-dianzhangchen0@gmail.com>
References: <1561476617-3759-1-git-send-email-dianzhangchen0@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/ptrace: Fix possible spectre-v1 in
 ptrace_get_debugreg()
Git-Commit-ID: 31a2fbb390fee4231281b939e1979e810f945415
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

Commit-ID:  31a2fbb390fee4231281b939e1979e810f945415
Gitweb:     https://git.kernel.org/tip/31a2fbb390fee4231281b939e1979e810f945415
Author:     Dianzhang Chen <dianzhangchen0@gmail.com>
AuthorDate: Tue, 25 Jun 2019 23:30:17 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Jun 2019 23:48:04 +0200

x86/ptrace: Fix possible spectre-v1 in ptrace_get_debugreg()

The index to access the threads ptrace_bps is controlled by userspace via
syscall: sys_ptrace(), hence leading to a potential exploitation of the
Spectre variant 1 vulnerability.

The index can be controlled from:
    ptrace -> arch_ptrace -> ptrace_get_debugreg.

Fix this by sanitizing the user supplied index before using it access
thread->ptrace_bps.

Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1561476617-3759-1-git-send-email-dianzhangchen0@gmail.com

---
 arch/x86/kernel/ptrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index a166c960bc9e..cbac64659dc4 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -25,6 +25,7 @@
 #include <linux/rcupdate.h>
 #include <linux/export.h>
 #include <linux/context_tracking.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <asm/pgtable.h>
@@ -643,9 +644,11 @@ static unsigned long ptrace_get_debugreg(struct task_struct *tsk, int n)
 {
 	struct thread_struct *thread = &tsk->thread;
 	unsigned long val = 0;
+	int index = n;
 
 	if (n < HBP_NUM) {
-		struct perf_event *bp = thread->ptrace_bps[n];
+		index = array_index_nospec(index, HBP_NUM);
+		struct perf_event *bp = thread->ptrace_bps[index];
 
 		if (bp)
 			val = bp->hw.info.address;
