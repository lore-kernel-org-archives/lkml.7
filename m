Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E507217D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dvq0o8MZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfCRJrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:47:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfCRJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HEGuI18hqh5frPWqUe6FxZWpHjMFVsQ6h+RIMt/o4ls=; b=Dvq0o8MZQ+YLi/ccMuFsGs4dL
        gUTqN/YuXqND7ULu8fuY026cbG+mwStnBCFv2nEUjg2B+3L5+1Zttc4ckd48tJRX+2olYW0K1Z34K
        3JLJopKo2njoqX3AQwbqFmROaCTjHRhJaobim7FFAyl++NrlXcYICsVqr4h/loDCtkDiP81+Qa0By
        GV4z9Ky2ELMRrudCg7hBeGVLUXopDUe0s/Ryfwwy74Qw+7HhLy4+sdX/MjUIfM5pHCm5X1fx8TKt1
        tJhuaJ8DqJmqszpyggPwceE/YL7v1aD2zbIWyj4lAhkuWOCr14JjG/QdjNOvTt2fdFdUmw6JMK9HZ
        k+IfPCSsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5ora-0006cP-Ge; Mon, 18 Mar 2019 09:47:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9FC520A0FF88; Mon, 18 Mar 2019 10:47:19 +0100 (CET)
Date:   Mon, 18 Mar 2019 10:47:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC PATCH 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Message-ID: <20190318094719.GD6521@hirez.programming.kicks-ass.net>
References: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
 <155232292961.21417.3665243457569518550.stgit@tlendack-t1.amdoffice.net>
 <20190315120311.GX5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315120311.GX5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 01:03:11PM +0100, Peter Zijlstra wrote:

> Anyway, we already had code to deal with spurious NMIs from AMD; see
> commit:
> 
>   63e6be6d98e1 ("perf, x86: Catch spurious interrupts after disabling counters")
> 
> And that looks to be doing something very much the same. Why then do you
> still need this on top?

And I think I've spotted a bug there; consider the case where only PMC3
has an active event left, then the interrupt would consume the running
state for PMC0-2, not leaving it for the spurious interrupt that might
come after it.

Similarly, if there's nothing running anymore, a single spurious
interrupt will clear the entire state.

It effectively is a single state, not a per-pmc one.

Something like the below would cure that... would that help with
something? Or were we going to get get rid of this entirely with your
patches...


diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e2b1447192a8..a8b5535f7888 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1432,6 +1432,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 	struct cpu_hw_events *cpuc;
 	struct perf_event *event;
 	int idx, handled = 0;
+	int ridx = -1;
 	u64 val;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1453,8 +1454,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 			 * might still deliver spurious interrupts still
 			 * in flight. Catch them:
 			 */
-			if (__test_and_clear_bit(idx, cpuc->running))
-				handled++;
+			if (test_bit(idx, cpuc->running))
+				ridx = idx;
 			continue;
 		}
 
@@ -1477,6 +1478,11 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 			x86_pmu_stop(event, 0);
 	}
 
+	if (!handled && ridx >= 0) {
+		__clear_bit(ridx, cpuc->running);
+		handled++;
+	}
+
 	if (handled)
 		inc_irq_stat(apic_perf_irqs);
 
