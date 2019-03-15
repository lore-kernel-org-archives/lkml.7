Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA77FC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9542A21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="viuGl9BC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfCOIOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:14:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38224 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbfCOIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C1hlXwAgPlkKdUN13t23fAFlHAG79lruGDWYc2UvwJQ=; b=viuGl9BCdYe+/f3qUv9frjOCr8
        r+1VhlcZtzVWXujvJ/mP2X2gFMfZlyg4qqQwD0n7my43/zXp+bHriroifP4xqhXa3CBzpaGEfaYVu
        JYqjpgC8f5yUgZ8lLkJTWjRi/YD+8W4lMErKsSSXQ7K0drMDhJQ7ibxkplQ7uvYM/NzgHo9Cpy9A8
        hqHyG/oVy4J0pj67znDdvL5nBiqdWfJPGbQpAOKTKSNp1ofdJlBYr8QJL4n7G03DhdyU2QXc6SQJ/
        g/QRgHMcfsLJt57SBxWGvhSQiLxIpHEml1sUZfB40+d+DWN/x7gIYj99tBcLFZUzTaDRcX9AVKZsk
        /FIoXdWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4hyl-0004Bz-D6; Fri, 15 Mar 2019 08:14:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FE3221419E59; Fri, 15 Mar 2019 09:14:10 +0100 (CET)
Date:   Fri, 15 Mar 2019 09:14:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] perf/x86/intel: Make cpuc allocations consistent
Message-ID: <20190315081410.GR5996@hirez.programming.kicks-ass.net>
References: <20190314211014.GA25646@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190314211014.GA25646@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 02:10:14PM -0700, Guenter Roeck wrote:
> On Tue, Mar 05, 2019 at 10:23:15PM +0100, Peter Zijlstra (Intel) wrote:
> > The cpuc data structure allocation is different between fake and real
> > cpuc's; use the same code to init/free both.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> With allmodconfig-CONFIG_CPU_SUP_INTEL, this patch results in:
> 
> In file included from arch/x86/events/amd/core.c:8:0:
> arch/x86/events/amd/../perf_event.h:1036:45: warning: ‘struct cpu_hw_event’ declared inside parameter list will not be visible outside of this definition or declaration
>  static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
>                                              ^~~~~~~~~~~~
> arch/x86/events/amd/../perf_event.h:1041:45: warning: ‘struct cpu_hw_event’ declared inside parameter list will not be visible outside of this definition or declaration
>  static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
>                                              ^~~~~~~~~~~~
> 
> With -Werror, this is fatal, and I think it may be buggy (should it be
> cpu_hw_events) ?

Yep it should be. Won't result in a bug though, an unused pointer is an
unused poiner, no matter what known or unknown type it points to.

> The patch has been applied to stable releases. Any idea, anyone, why
> this is the case ? It doesn't look like a bug fix to me, and reverting
> it from v4.14.106 didn't seem to have a negative impact.

Reverting just this one patch will make your kernel go boom when you run
on a skylake or more recent Intel cpu, have updated your microcode and
do:

  echo 0 > /sys/bus/event_source/devices/cpu/allow_tsx_force_abort

And then try and create perf events. See also commit:

  400816f60c54 ("perf/x86/intel: Implement support for TSX Force Abort")

---
Subject: perf/x86: Fixup typo in stub functions

Guenter reported a build warning for CONFIG_CPU_SUP_INTEL=n. While
harmless (an unsed pointer is an unused pointer, no matter the type) it
needs fixing.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: d01b1f96a82e ("perf/x86/intel: Make cpuc allocations consistent")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index b04ae6c8775e..a75955741c50 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1033,12 +1033,12 @@ static inline int intel_pmu_init(void)
 	return 0;
 }
 
-static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
+static inline int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 {
 	return 0;
 }
 
-static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
+static inline void intel_cpuc_finish(struct cpu_hw_events *cpuc)
 {
 }
 
