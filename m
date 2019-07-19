Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD26CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F23B20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbfGSWoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 18:44:16 -0400
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:60273 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727344AbfGSWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 18:44:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 15343180A68C8;
        Fri, 19 Jul 2019 22:44:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rail92_24b7b27a6db47
X-Filterd-Recvd-Size: 2601
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jul 2019 22:44:12 +0000 (UTC)
Message-ID: <511eb129bc0a6c92e3547c69a6e55695241dfe4a.camel@perches.com>
Subject: Re: [PATCH v3 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask()
 for tlb_is_not_lazy()
From:   Joe Perches <joe@perches.com>
To:     Nadav Amit <namit@vmware.com>, Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Date:   Fri, 19 Jul 2019 15:44:10 -0700
In-Reply-To: <6847D7A3-4618-4BC3-97B6-EC53F6985504@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
         <20190719005837.4150-4-namit@vmware.com>
         <8bf005e2-7ac7-f1cf-eca1-0e152dd912a7@intel.com>
         <6847D7A3-4618-4BC3-97B6-EC53F6985504@vmware.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-19 at 18:41 +0000, Nadav Amit wrote:
> > On Jul 19, 2019, at 11:36 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> > 
> > On 7/18/19 5:58 PM, Nadav Amit wrote:
> > > @@ -865,7 +893,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> > > 	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
> > > 		lockdep_assert_irqs_enabled();
> > > 		local_irq_disable();
> > > -		flush_tlb_func_local(&full_flush_tlb_info);
> > > +		flush_tlb_func_local((void *)&full_flush_tlb_info);
> > > 		local_irq_enable();
> > > 	}
> > 
> > This looks like superfluous churn.  Is it?
> 
> Unfortunately not, since full_flush_tlb_info is defined as const. Without it
> you would get:
> 
> warning: passing argument 1 of ‘flush_tlb_func_local’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
> 
> And flush_tlb_func_local() should get (void *) argument since it is also
> used by the SMP infrastructure.

huh?

commit 3db6d5a5ecaf0a778d721ccf9809248350d4bfaf
Author: Nadav Amit <namit@vmware.com>
Date:   Thu Apr 25 16:01:43 2019 -0700

[]

-static void flush_tlb_func_local(void *info, enum tlb_flush_reason reason)
+static void flush_tlb_func_local(const void *info, enum tlb_flush_reason reason)

