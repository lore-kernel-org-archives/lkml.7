Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22116C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC44206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099349;
	bh=BT0+PLSHpy9Y6WnvFZU/IEPYQG63I+Jmn3K3hx214Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TaikD76lcviuJJtNa5ABz78QaM3uHtDHayomeGoElDOjXM6T7k0Eo2FCN/HWABQ7g
	 7wl9FTeCGU1tBF8sFt2ffLF5Vc3ZSZygbp6ta+7ps90i9kCT7hTym5aibsnU3e7zev
	 gtltDOyKgIMKSrJxFJbpRM2gJNZ3pnrjsq2dqxII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbfFIQzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732824AbfFIQzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:55:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04813204EC;
        Sun,  9 Jun 2019 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099343;
        bh=BT0+PLSHpy9Y6WnvFZU/IEPYQG63I+Jmn3K3hx214Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyYdgiiiIl+uwzzBqFNwY7ZnMGg5kT1w6nf0XEewUO/s+iZpXN8b34lSDGsVawuCy
         08b7oxpKummlSvqXyopDWaYZk5kRDAmttbJTh4ra2OE0SiKOcZXF9yjiUpkuqz3vKK
         MDksUxJU2ANDuzZBsi0UZorbbkrgt0g7CYbcWS/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jon Masters <jcm@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 001/241] x86/speculation/mds: Revert CPU buffer clear on double fault exit
Date:   Sun,  9 Jun 2019 18:39:03 +0200
Message-Id: <20190609164147.815178298@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

commit 88640e1dcd089879530a49a8d212d1814678dfe7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/x86/mds.rst |    7 -------
 arch/x86/kernel/traps.c   |    8 --------
 2 files changed, 15 deletions(-)

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
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,7 +61,6 @@
 #include <asm/alternative.h>
 #include <asm/fpu/xstate.h>
 #include <asm/trace/mpx.h>
-#include <asm/nospec-branch.h>
 #include <asm/mpx.h>
 #include <asm/vm86.h>
 
@@ -338,13 +337,6 @@ dotraplinkage void do_double_fault(struc
 		regs->ip = (unsigned long)general_protection;
 		regs->sp = (unsigned long)&normal_regs->orig_ax;
 
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


