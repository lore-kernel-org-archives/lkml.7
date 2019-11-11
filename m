Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8EDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE8E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r2tbYsVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKKRUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:20:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKRUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3BImvdb2SjGg8FjjNsGxYBZHiJBQpDDVPvVag5XpsOE=; b=r2tbYsVKwZIBwdlDgP2eTSjCn
        pu8VDDf2gMnj8yMwXNGYiA6rmXhMNS6ntXgudtDU5KYpGhvU5BNxwpRNra0BLXXijHVKRGEy0eAZs
        2nRhMJxJAPQ12q1BBW22S4y6jSG1JSlbzUcZvyUC4oS5Cy6UR1OLN9kwsUIdIoBZaiTav0iNU7emJ
        7AEzD5fZgKtp/DEPmLvKmKi7G/JrXIh362rnqwhqqZqh1rGWLCY/dpM68AWA/x6L0PZDu7hxtvh6s
        mfgfDmObvaa38xcDubCR488ESw4i18FOmt0gzl4C6RL8Op+W+fZiQQGgMZ62m8aQweW7ewGnCiQ5r
        BkjU2Zx8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUDM6-0004mb-IG; Mon, 11 Nov 2019 17:19:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 639CD3056BE;
        Mon, 11 Nov 2019 18:18:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C28C120302EF3; Mon, 11 Nov 2019 18:19:55 +0100 (CET)
Date:   Mon, 11 Nov 2019 18:19:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com, rabin@rab.in,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Subject: Re: [PATCH -v5 13/17] arm/ftrace: Use __patch_text_real()
Message-ID: <20191111171955.GO4114@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111132458.220458362@infradead.org>
 <20191111164703.GA11521@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111164703.GA11521@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:47:03PM +0000, Will Deacon wrote:

> I'd still prefer to pass 'true' unconditionally here, since I don't think
> this is a hot path.

If you can give me a Tested-by, I'll replace it with the below... :-)

--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -22,6 +22,7 @@
 #include <asm/ftrace.h>
 #include <asm/insn.h>
 #include <asm/set_memory.h>
+#include <asm/patch.h>
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define	NOP		0xf85deb04	/* pop.w {lr} */
@@ -35,9 +36,7 @@ static int __ftrace_modify_code(void *da
 {
 	int *command = data;
 
-	set_kernel_text_rw();
 	ftrace_modify_all_code(*command);
-	set_kernel_text_ro();
 
 	return 0;
 }
@@ -59,13 +58,11 @@ static unsigned long adjust_address(stru
 
 int ftrace_arch_code_modify_prepare(void)
 {
-	set_all_modules_text_rw();
 	return 0;
 }
 
 int ftrace_arch_code_modify_post_process(void)
 {
-	set_all_modules_text_ro();
 	/* Make sure any TLB misses during machine stop are cleared. */
 	flush_tlb_all();
 	return 0;
@@ -97,10 +94,7 @@ static int ftrace_modify_code(unsigned l
 			return -EINVAL;
 	}
 
-	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
-		return -EPERM;
-
-	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
+	__patch_text_real((void *)pc, new, true);
 
 	return 0;
 }
