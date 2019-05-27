Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA004C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79465208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lW9ZEB5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfE0TPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:15:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42752 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfE0TPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lQh5iMIK6tHDUIF/9F0izv09YkPpLetazpRY2IbhT9Y=; b=lW9ZEB5dRAprOlMWHMTROQS3WE
        WGUYgFwik+pP4/KSVn5JWoMd3OWFs0jpVzbvRchCh6sjIOEa1SqiRXJxKMJ/jzd5Z7c5LNEC+oMbw
        DiIVaaSrngYkEXqrg/+OQBCf3RpJ6/lcG4kP+sZwLOziXWcfDvbOMtJP0W1+ytP82yZB+xIhiEvG/
        i4BmXprMS0AjSTxDbLf9RwbMZq6x+3ALhXkYeZBuyjYFhCXgZqK5jlM7/ASTo2VQUcNisvckOCe7I
        HPsiP7CEVx7dkPKo4EjVZZBnp+TBAEFImsb2iTswUYN6ygjexZAq/d6oGyyQw7kzVyZJkkZk7CGXF
        HqF4DJJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVL5D-0005rB-OS; Mon, 27 May 2019 19:14:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 840A420301225; Mon, 27 May 2019 21:14:54 +0200 (CEST)
Date:   Mon, 27 May 2019 21:14:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH 4/6] x86/mm/tlb: Refactor common code into
 flush_tlb_on_cpus()
Message-ID: <20190527191454.GI2623@hirez.programming.kicks-ass.net>
References: <20190525082203.6531-1-namit@vmware.com>
 <20190525082203.6531-5-namit@vmware.com>
 <20190527092434.GT2623@hirez.programming.kicks-ass.net>
 <9BE478F9-C700-46C5-80BC-B905FD0AAB17@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BE478F9-C700-46C5-80BC-B905FD0AAB17@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 06:59:01PM +0000, Nadav Amit wrote:
> > On May 27, 2019, at 2:24 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Sat, May 25, 2019 at 01:22:01AM -0700, Nadav Amit wrote:
> > 
> >> There is one functional change, which should not affect correctness:
> >> flush_tlb_mm_range compared loaded_mm and the mm to figure out if local
> >> flush is needed. Instead, the common code would look at the mm_cpumask()
> >> which should give the same result.
> > 
> >> @@ -786,18 +804,9 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
> >> 	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
> >> 				  new_tlb_gen);
> >> 
> >> -	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
> >> -		lockdep_assert_irqs_enabled();
> >> -		local_irq_disable();
> >> -		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
> >> -		local_irq_enable();
> >> -	}
> >> -
> >> -	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> >> -		flush_tlb_others(mm_cpumask(mm), info);
> > 
> > So if we want to double check that; we'd add:
> > 
> > 	WARN_ON_ONCE(cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm)) ==
> > 		     (mm == this_cpu_read(cpu_tlbstate.loaded_mm)));
> > 
> > right?
> 
> Yes, except the condition should be inverted (“!=“ instead of “==“), and I
> would prefer to use VM_WARN_ON_ONCE().
> 
> Unfortunately, this condition does fire when copy_init_mm() calls dup_mm().
> I don’t think there is a correctness issue, and I am tempted just check,
> before warning, that (mm != init_mm) .
> 
> What do you say?

Works for me.
