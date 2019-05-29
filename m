Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FEFC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264AE208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GlIPp6vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfE2M4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:56:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35372 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfE2M4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ezJqmdGXuDFxk+yC+s5MBTQ1KIOcOFXTVhZGERGaSZE=; b=GlIPp6vvSyNmSfpucVORXmllw
        pd6siyW81asRf2ZdtAIS1jQ9/wJI9KaTwqbIbKdhI9h3ZL0hyNPzAqkIWLLa+XuEN8iNy0VN2UmAH
        qWBOipPXbwNNMpZHZynDOd29JWUf7t+JU5gAAtILJ3Tm2lg8Gx15ajtXObX+Bj0OMaE2LBRNNXOLc
        hDI85tePcrSd6ry+er24xVvzMF6EX92SG6ScHFjbgg+BblcNdhD+xxiY1Is+CPpGUfoWHr8MDHm3X
        1BeGmc6P4QKi3dM/zYBltiNYi3ZPvOQz1HAPegPptnpI6AbT89OLR94zb3NxA79nj0DDQZsIBmcl0
        v/Ou1OZsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVy7a-0004qc-BV; Wed, 29 May 2019 12:55:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23099201D5ACB; Wed, 29 May 2019 14:55:57 +0200 (CEST)
Date:   Wed, 29 May 2019 14:55:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au,
        acme@redhat.com, eranian@google.com, fweisbec@gmail.com,
        jolsa@redhat.com
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190529125557.GU2623@hirez.programming.kicks-ass.net>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
 <20190528140103.GT2623@hirez.programming.kicks-ass.net>
 <20190528153224.GE20758@fuggles.cambridge.arm.com>
 <20190528173228.GW2623@hirez.programming.kicks-ass.net>
 <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529102022.GC4485@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 11:20:22AM +0100, Will Deacon wrote:
> Anyway, you can add my ack to your patch, but I bet we can remove that mm
> check :D

I've ended up with the below. Ravi, can you test if that does indeed
obsolete your PPC patch?

---
Subject: perf: Fix perf_sample_regs_user()
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed May 29 14:37:24 CEST 2019

perf_sample_regs_user() uses 'current->mm' to test for the presence of
userspace, but this is insufficient, consider use_mm().

A better test is: '!(current->flags & PF_KTHREAD)', exec() clears
PF_KTHREAD after it sets the new ->mm but before it drops to userspace
for the first time.

Possibly obsoletes: bf05fc25f268 ("powerpc/perf: Fix oops when kthread execs user process")

Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reported-by: Young Xiao <92siuyang@gmail.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Fixes: 4018994f3d87 ("perf: Add ability to attach user level registers dump to sample")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5923,7 +5923,7 @@ static void perf_sample_regs_user(struct
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (current->mm) {
+	} else if (!(current->flags & PF_KTHREAD)) {
 		perf_get_regs_user(regs_user, regs, regs_user_copy);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
