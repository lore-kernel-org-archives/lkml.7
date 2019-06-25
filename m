Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A03C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E491A2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfFYWDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:03:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44544 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYWDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:03:12 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hftWn-0001Le-Q7; Wed, 26 Jun 2019 00:03:01 +0200
Date:   Wed, 26 Jun 2019 00:03:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 9/9] x86/apic: Use non-atomic operations when possible
In-Reply-To: <c0473294-bf14-f9b8-325c-bc860361733a@intel.com>
Message-ID: <alpine.DEB.2.21.1906260001510.32342@nanos.tec.linutronix.de>
References: <20190613064813.8102-1-namit@vmware.com> <20190613064813.8102-10-namit@vmware.com> <c0473294-bf14-f9b8-325c-bc860361733a@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019, Dave Hansen wrote:

> > diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
> > index 7685444a106b..609e499387a1 100644
> > --- a/arch/x86/kernel/apic/x2apic_cluster.c
> > +++ b/arch/x86/kernel/apic/x2apic_cluster.c
> > @@ -50,7 +50,7 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
> >  	cpumask_copy(tmpmsk, mask);
> >  	/* If IPI should not be sent to self, clear current CPU */
> >  	if (apic_dest != APIC_DEST_ALLINC)
> > -		cpumask_clear_cpu(smp_processor_id(), tmpmsk);
> > +		__cpumask_clear_cpu(smp_processor_id(), tmpmsk);
> 
> tmpmsk is on-stack, but it's a pointer to a per-cpu variable:
> 
>         tmpmsk = this_cpu_cpumask_var_ptr(ipi_mask);
> 
> So this one doesn't appear as obviously correct as a mask which itself
> is on the stack.  The other three look obviously OK, though.

It's still correct. The mask is per cpu and protected because interrupts
are disabled. I noticed and wanted to amend the change log and forgot.

Thanks,

	tglx

