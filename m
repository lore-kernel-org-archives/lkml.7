Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4600C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98849216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tp4Euh6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfE1Rcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:32:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53008 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfE1Rcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8hqQ/4mY+bEfn2TTxujxDR99aFDvZhBW5ujyUYsewrA=; b=tp4Euh6rEs5ztJp2Jat+Uqdvn
        czVGXFImP9LykLjKyzlEaOFjzQ3IOl3Wf5G+k4+2dOgAHWCVtnv2kfAmkGLpCsy8ME63e0c377YWM
        EVAFoj16561WdTQutv/JVyOrCiTLlx894bbHEKW6OqY9c2ye0o6JzPNHaMbRKqpA33k1dI1sweW9i
        zk/xyhyncKacrc3WhfmGr9ggCUj/k4eya7Dgn9Yzjhds9Orb3tG36g2tGNshyXNPwbfvXYykEiATq
        pgnj0pfe9QLsrOC6J8sJi7CJbpPjbIM+QjJOyGn55704x2tWs0HstV8esLSUR3Im/7QQmtIPQfpJk
        H7ru2Veig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVfxd-0005ts-TE; Tue, 28 May 2019 17:32:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A8A25200E9AEF; Tue, 28 May 2019 19:32:28 +0200 (CEST)
Date:   Tue, 28 May 2019 19:32:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190528173228.GW2623@hirez.programming.kicks-ass.net>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
 <20190528140103.GT2623@hirez.programming.kicks-ass.net>
 <20190528153224.GE20758@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528153224.GE20758@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 04:32:24PM +0100, Will Deacon wrote:
> On Tue, May 28, 2019 at 04:01:03PM +0200, Peter Zijlstra wrote:
> > On Tue, May 28, 2019 at 08:31:29PM +0800, Young Xiao wrote:
> > > When a kthread calls call_usermodehelper() the steps are:
> > >   1. allocate current->mm
> > >   2. load_elf_binary()
> > >   3. populate current->thread.regs
> > > 
> > > While doing this, interrupts are not disabled. If there is a perf
> > > interrupt in the middle of this process (i.e. step 1 has completed
> > > but not yet reached to step 3) and if perf tries to read userspace
> > > regs, kernel oops.
> 
> This seems to be because pt_regs(current) gives NULL for kthreads on Power.

'funny' thing that, perf_sample_regs_user() seems to assume that
anything with current->mm is in fact a user task, and that assumption is
just plain wrong, consider use_mm().

So I'm thinking the right thing to do here is something like the below;
umh should get PF_KTHREAD cleared when it passes exec(). And this should
also fix the power splat I'm thinking.

---

diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..9929404b6eb9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5923,7 +5923,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (current->mm) {
+	} else if (!(current->flags & PF_KTHREAD) && current->mm) {
 		perf_get_regs_user(regs_user, regs, regs_user_copy);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
