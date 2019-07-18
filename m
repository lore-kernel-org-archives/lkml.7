Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDCCC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3985A2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sl/xHuoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbfGRI6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:58:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRI6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=59pNHHpCEcKGOhsQiGgUt+ozL25ouhHhLVmOteYpHqo=; b=Sl/xHuoEHjnd9+oJnoOHl+/dV
        503KCLncGOkHKgDtY+ZuvmefhEkKqCy1i7V2t9gROCg3zRoqmiR6Js9X0oD8qy3Y7Tth3LbmafYDT
        He1JTC/E5qR+RDoonXOpEFSw77sgdWgaesPD6TPI8NkcWwHiHUWsW7y5WDwGpt9EIcbYFmVBdu2FA
        bhUj3ItAO0m80sPA0kDGIVhNtMxtzHiIe4CYM9FFlyPbHb1ilO60jm++5uhJyrN/R/J2hnWh4aq+0
        UmsbRbYswE7+2mTN0mguwwNsaNhIAdRhfIn107Cdwjmc7MLSSMBcKdut3FKmazKei3cL/6ohIy70T
        /uhe4BojQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho2Ee-00071l-H2; Thu, 18 Jul 2019 08:58:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63545202173EA; Thu, 18 Jul 2019 10:57:54 +0200 (CEST)
Date:   Thu, 18 Jul 2019 10:57:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
Subject: [PATCH] stacktrace: Force USER_DS for stack_trace_save_user()
Message-ID: <20190718085754.GM3402@hirez.programming.kicks-ass.net>
References: <20190711114054.406765395@infradead.org>
 <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
 <20190717080725.GK3402@hirez.programming.kicks-ass.net>
 <b0a3406c-5de7-20e0-0f09-dbb7222426e2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a3406c-5de7-20e0-0f09-dbb7222426e2@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:09:45AM +0200, Vegard Nossum wrote:
> On 7/17/19 10:07 AM, Peter Zijlstra wrote:

> > Does something like the below help?

> Yes.

Thanks!

---
Subject: stacktrace: Force USER_DS for stack_trace_save_user()
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jul 18 10:47:47 CEST 2019

When walking userspace stacks, we should set USER_DS, otherwise
access_ok() will not function as expected.

Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Tested-by: Vegard Nossum <vegard.nossum@oracle.com>
Reported-by: Eiichi Tsukata <devel@etsukata.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -226,12 +226,17 @@ unsigned int stack_trace_save_user(unsig
 		.store	= store,
 		.size	= size,
 	};
+	mm_segment_t fs;
 
 	/* Trace user stack if not a kernel thread */
 	if (current->flags & PF_KTHREAD)
 		return 0;
 
+	fs = get_fs();
+	set_fs(USER_DS);
 	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
+	set_fs(fs);
+
 	return c.len;
 }
 #endif
