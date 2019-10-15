Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD647C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15E420854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J9tnel2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbfJOOno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:43:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35924 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbfJOOno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BWcOBQNedloFMcUSVBi+lak7wlJILq9dGz2dM7VJlk8=; b=J9tnel2MY8snkRQeHAsYz5LCe
        UeEUx2I+ZDYSbmgEVBL19PvOgu0QMWOQss1xYsKIG8OEjoduL6sAv7OQNhoFDuRF0n8vMuJHXf6UQ
        XuQlft80tmm6WaWMSr9vv2UADNSKNEIccOYllMcVh4pFUprNCeKgmAkdA+Urbmm5dmccp+dJmZCsT
        v4BTuaTFZZ/TBPABReXkDVDjwia5lPAHVhkzOp07grmKH7/1o7Ys5GAeuNa5J70Di6T1XLSHdpYvJ
        9EVEU7t+jcfJZTpCzSXyFw4XgA+SR18mnoXJOxqoESSYW0KAWTjbKiHuNxYs8MnqoTBvZ3zvaHexn
        aBNOSR+2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKO2R-0005d2-2Q; Tue, 15 Oct 2019 14:43:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62A42304637;
        Tue, 15 Oct 2019 16:42:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA4FF2023D649; Tue, 15 Oct 2019 16:42:58 +0200 (CEST)
Date:   Tue, 15 Oct 2019 16:42:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, rabin@rab.in,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, james.morse@arm.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191015144258.GQ2359@hirez.programming.kicks-ass.net>
References: <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
 <20191010172819.GS2328@hirez.programming.kicks-ass.net>
 <20191011125903.GN2359@hirez.programming.kicks-ass.net>
 <20191015130739.GA23565@linux-8ccs>
 <20191015135634.GK2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015135634.GK2328@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 03:56:34PM +0200, Peter Zijlstra wrote:
> Right, the problem is set_all_modules_text_*(), that relies on COMING
> having made the protection changes.
> 
> After the x86 changes, there's only 2 more architectures that use that
> function. I'll work on getting those converted and then we can delete
> that function and worry no more about it.

Here's a possible patch for arch/arm, which only leaves arch/nds32/.

---
 arch/arm/kernel/ftrace.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index bda949fd84e8..c87e68e4ccf7 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -22,6 +22,7 @@
 #include <asm/ftrace.h>
 #include <asm/insn.h>
 #include <asm/set_memory.h>
+#include <asm/patch.h>
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define	NOP		0xf85deb04	/* pop.w {lr} */
@@ -31,13 +32,15 @@
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
+static int patch_text_remap = 0;
+
 static int __ftrace_modify_code(void *data)
 {
 	int *command = data;
 
-	set_kernel_text_rw();
+	patch_text_remap = 1;
 	ftrace_modify_all_code(*command);
-	set_kernel_text_ro();
+	patch_text_remap = 0;
 
 	return 0;
 }
@@ -59,13 +62,13 @@ static unsigned long adjust_address(struct dyn_ftrace *rec, unsigned long addr)
 
 int ftrace_arch_code_modify_prepare(void)
 {
-	set_all_modules_text_rw();
+	patch_text_remap = 1;
 	return 0;
 }
 
 int ftrace_arch_code_modify_post_process(void)
 {
-	set_all_modules_text_ro();
+	patch_text_remap = 0;
 	/* Make sure any TLB misses during machine stop are cleared. */
 	flush_tlb_all();
 	return 0;
@@ -97,10 +100,7 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 			return -EINVAL;
 	}
 
-	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
-		return -EPERM;
-
-	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
+	__patch_text_real((void *)pc, new, patch_text_remap);
 
 	return 0;
 }
