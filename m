Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD60BC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94832206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570520774;
	bh=aO7mbhGTjhKlXSC5HmKCY5zbdscGE+lQO6YFKWrnMG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JB7fPkhGp9mLxszmQuSRxvDXTUE2OSTlW0FRne8BrcQnF8NgbR55U14YOVbt5x5aZ
	 2+s58tCKXvmbui+CYuNC2XxS9gBHh7SGtbN9lxPjrqQspFWx5JdcRL1Vo2HnxXFeBs
	 o9q+VAITQCx9WhqCrFJRaQtoX/7ZhVGVkXobboDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfJHHqN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:46:13 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:44779 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730370AbfJHHqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:46:13 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iHkC5-0001oY-Va; Tue, 08 Oct 2019 09:46:06 +0200
Date:   Tue, 8 Oct 2019 08:46:04 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "Justin He (Arm Technology China)" <Justin.He@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v10 2/3] arm64: mm: implement arch_faults_on_old_pte()
 on arm64
Message-ID: <20191008084604.7db2a123@why>
In-Reply-To: <DB7PR08MB308265EB3ED2465D2471B492F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190930015740.84362-1-justin.he@arm.com>
        <20190930015740.84362-3-justin.he@arm.com>
        <20191001125031.7ddm5dlwss6m3dth@willie-the-truck>
        <20191001143219.018281be@why>
        <DB7PR08MB308265EB3ED2465D2471B492F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: Justin.He@arm.com, will@kernel.org, Catalin.Marinas@arm.com, Mark.Rutland@arm.com, James.Morse@arm.com, willy@infradead.org, kirill.shutemov@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, punitagrawal@gmail.com, tglx@linutronix.de, akpm@linux-foundation.org, hejianet@gmail.com, Kaly.Xin@arm.com, nd@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 01:55:04 +0000
"Justin He (Arm Technology China)" <Justin.He@arm.com> wrote:

> Hi Will and Marc
> 
> > -----Original Message-----
> > From: Marc Zyngier <maz@kernel.org>
> > Sent: 2019年10月1日 21:32
> > To: Will Deacon <will@kernel.org>
> > Cc: Justin He (Arm Technology China) <Justin.He@arm.com>; Catalin
> > Marinas <Catalin.Marinas@arm.com>; Mark Rutland
> > <Mark.Rutland@arm.com>; James Morse <James.Morse@arm.com>;
> > Matthew Wilcox <willy@infradead.org>; Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com>; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux-mm@kvack.org; Punit Agrawal
> > <punitagrawal@gmail.com>; Thomas Gleixner <tglx@linutronix.de>;
> > Andrew Morton <akpm@linux-foundation.org>; hejianet@gmail.com; Kaly
> > Xin (Arm Technology China) <Kaly.Xin@arm.com>
> > Subject: Re: [PATCH v10 2/3] arm64: mm: implement
> > arch_faults_on_old_pte() on arm64
> > 
> > On Tue, 1 Oct 2019 13:50:32 +0100
> > Will Deacon <will@kernel.org> wrote:
> >   
> > > On Mon, Sep 30, 2019 at 09:57:39AM +0800, Jia He wrote:  
> > > > On arm64 without hardware Access Flag, copying fromuser will fail  
> > because  
> > > > the pte is old and cannot be marked young. So we always end up with  
> > zeroed  
> > > > page after fork() + CoW for pfn mappings. we don't always have a
> > > > hardware-managed access flag on arm64.
> > > >
> > > > Hence implement arch_faults_on_old_pte on arm64 to indicate that it  
> > might  
> > > > cause page fault when accessing old pte.
> > > >
> > > > Signed-off-by: Jia He <justin.he@arm.com>
> > > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > ---
> > > >  arch/arm64/include/asm/pgtable.h | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/include/asm/pgtable.h  
> > b/arch/arm64/include/asm/pgtable.h  
> > > > index 7576df00eb50..e96fb82f62de 100644
> > > > --- a/arch/arm64/include/asm/pgtable.h
> > > > +++ b/arch/arm64/include/asm/pgtable.h
> > > > @@ -885,6 +885,20 @@ static inline void update_mmu_cache(struct  
> > vm_area_struct *vma,  
> > > >  #define phys_to_ttbr(addr)	(addr)
> > > >  #endif
> > > >
> > > > +/*
> > > > + * On arm64 without hardware Access Flag, copying from user will fail  
> > because  
> > > > + * the pte is old and cannot be marked young. So we always end up  
> > with zeroed  
> > > > + * page after fork() + CoW for pfn mappings. We don't always have a
> > > > + * hardware-managed access flag on arm64.
> > > > + */
> > > > +static inline bool arch_faults_on_old_pte(void)
> > > > +{
> > > > +	WARN_ON(preemptible());
> > > > +
> > > > +	return !cpu_has_hw_af();
> > > > +}  
> > >
> > > Does this work correctly in a KVM guest? (i.e. is the MMFR sanitised in  
> > that  
> > > case, despite not being the case on the host?)  
> > 
> > Yup, all the 64bit MMFRs are trapped (HCR_EL2.TID3 is set for an
> > AArch64 guest), and we return the sanitised version.  
> Thanks for Marc's explanation. I verified the patch series on a kvm guest (-M virt)
> with simulated nvdimm device created by qemu. The host is ThunderX2 aarch64.
> 
> > 
> > But that's an interesting remark: we're now trading an extra fault on
> > CPUs that do not support HWAFDBS for a guaranteed trap for each and
> > every guest under the sun that will hit the COW path...
> > 
> > My gut feeling is that this is going to be pretty visible. Jia, do you
> > have any numbers for this kind of behaviour?  
> It is not a common COW path, but a COW for PFN mapping pages only.
> I add a g_counter before pte_mkyoung in force_mkyoung{} when testing 
> vmmalloc_fork at [1].
> 
> In this test case, it will start M fork processes and N pthreads. The default is
> M=2,N=4. the g_counter is about 241, that is it will hit my patch series for 241
> times.
> If I set M=20 and N=40 for TEST3, the g_counter is about 1492.

I must confess I'm not so much interested in random microbenchmarks,
but more in actual applications that could potentially be impacted by
this. The numbers you're quoting here seem pretty small, which would
indicate a low overhead, but that's not indicative of what would happen
in real life.

I guess that we can leave it at that for now, and turn it into a CPU
feature (with the associated static key) if this shows anywhere.

Thanks,

	M.


>   
> [1] https://github.com/pmem/pmdk/tree/master/src/test/vmmalloc_fork
> 
> 
> --
> Cheers,
> Justin (Jia He)
> 
-- 
Jazz is not dead. It just smells funny...
