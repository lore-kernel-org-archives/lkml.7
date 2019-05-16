Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1723C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8073120848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Jjy9nF9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfEPHKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 03:10:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36221 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfEPHKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:10:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4G7ALDE710917
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 16 May 2019 00:10:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4G7ALDE710917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557990622;
        bh=OCazXXhgIvRMO9W3VarIQPHp9/HIQeqHqQ7g85rqSh8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Jjy9nF9rFhqWeggEUz0i1W5cv9qJT/PyU0k8aHDtfYuhrTSEBJc30YtVl6MksfgFX
         wtS8UxaiqYROAXpbKc/F516js3eXPJgYGgNOYkyuWF9fzzxDugIsjBHUfuc37EAt1+
         K301UP9ysHTKYQtCmjqAlzjp1CCU+B/wqj3RRCkKOjlAwNzZVs+d0+l3Fn6vSn5yfS
         VIBYf4Qxs/PexbrhJgUPJYMkDU2EgSFd2+7JhnnfAru3FHmWONVY700bzslUVQTTxu
         5YopGvgZmd3o187eu8xAlMARUD7HH7jH20z7Ew+K1LbVasgUO8Z+rzBICnBFr6yN4H
         VAAhcuRf6VtaA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4G7AL0W710912;
        Thu, 16 May 2019 00:10:21 -0700
Date:   Thu, 16 May 2019 00:10:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-88640e1dcd089879530a49a8d212d1814678dfe7@git.kernel.org>
Cc:     tglx@linutronix.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, frederic@kernel.org, bp@suse.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org, jcm@redhat.com, hpa@zytor.com, luto@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          gregkh@linuxfoundation.org, peterz@infradead.org, bp@suse.de,
          frederic@kernel.org, mingo@kernel.org, jcm@redhat.com,
          torvalds@linux-foundation.org, hpa@zytor.com, luto@kernel.org
In-Reply-To: <ac97612445c0a44ee10374f6ea79c222fe22a5c4.1557865329.git.luto@kernel.org>
References: <ac97612445c0a44ee10374f6ea79c222fe22a5c4.1557865329.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/speculation/mds: Revert CPU buffer clear on
 double fault exit
Git-Commit-ID: 88640e1dcd089879530a49a8d212d1814678dfe7
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

Commit-ID:  88640e1dcd089879530a49a8d212d1814678dfe7
Gitweb:     https://git.kernel.org/tip/88640e1dcd089879530a49a8d212d1814678dfe7
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 14 May 2019 13:24:39 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 16 May 2019 09:05:11 +0200

x86/speculation/mds: Revert CPU buffer clear on double fault exit

The double fault ESPFIX path doesn't return to user mode at all --
it returns back to the kernel by simulating a #GP fault.
prepare_exit_to_usermode() will run on the way out of
general_protection before running user code.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jon Masters <jcm@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: 04dcbdb80578 ("x86/speculation/mds: Clear CPU buffers on exit to user")
Link: http://lkml.kernel.org/r/ac97612445c0a44ee10374f6ea79c222fe22a5c4.1557865329.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/mds.rst | 7 -------
 arch/x86/kernel/traps.c   | 8 --------
 2 files changed, 15 deletions(-)

diff --git a/Documentation/x86/mds.rst b/Documentation/x86/mds.rst
index 534e9baa4e1d..0dc812bb9249 100644
--- a/Documentation/x86/mds.rst
+++ b/Documentation/x86/mds.rst
@@ -158,13 +158,6 @@ Mitigation points
      mitigated on the return from do_nmi() to provide almost complete
      coverage.
 
-   - Double fault (#DF):
-
-     A double fault is usually fatal, but the ESPFIX workaround, which can
-     be triggered from user space through modify_ldt(2) is a recoverable
-     double fault. #DF uses the paranoid exit path, so explicit mitigation
-     in the double fault handler is required.
-
    - Machine Check Exception (#MC):
 
      Another corner case is a #MC which hits between the CPU buffer clear
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7de466eb960b..8b6d03e55d2f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -58,7 +58,6 @@
 #include <asm/alternative.h>
 #include <asm/fpu/xstate.h>
 #include <asm/trace/mpx.h>
-#include <asm/nospec-branch.h>
 #include <asm/mpx.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
@@ -368,13 +367,6 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code)
 		regs->ip = (unsigned long)general_protection;
 		regs->sp = (unsigned long)&gpregs->orig_ax;
 
-		/*
-		 * This situation can be triggered by userspace via
-		 * modify_ldt(2) and the return does not take the regular
-		 * user space exit, so a CPU buffer clear is required when
-		 * MDS mitigation is enabled.
-		 */
-		mds_user_clear_cpu_buffers();
 		return;
 	}
 #endif
