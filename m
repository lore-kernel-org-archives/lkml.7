Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87638C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B53A20815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569936748;
	bh=0lVAD3VCUz1DTQ0h1V68+Ytgr0b+QQHBISt2D6CbGX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cvTDi2eEbkehc9A651nU2dZo24ZXkH8g+TrSx/jJlIEFl9FDmaw66yM4LzfOnCjsB
	 vJ1auJTHmG/2mce0dEAP9CLGYoTVyJGmYeDGz+1AIziuXTpC9udqGWu9457bFuJwdd
	 cEqorzvVBWPwTIQyHQa5UJiPYp8TmFLjBcB83bEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbfJANc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:32:27 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:46743 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388466AbfJANc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:32:27 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iFIGL-00060M-7n; Tue, 01 Oct 2019 15:32:21 +0200
Date:   Tue, 1 Oct 2019 14:32:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jia He <justin.he@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v10 2/3] arm64: mm: implement arch_faults_on_old_pte()
 on arm64
Message-ID: <20191001143219.018281be@why>
In-Reply-To: <20191001125031.7ddm5dlwss6m3dth@willie-the-truck>
References: <20190930015740.84362-1-justin.he@arm.com>
        <20190930015740.84362-3-justin.he@arm.com>
        <20191001125031.7ddm5dlwss6m3dth@willie-the-truck>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, justin.he@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com, willy@infradead.org, kirill.shutemov@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, punitagrawal@gmail.com, tglx@linutronix.de, akpm@linux-foundation.org, hejianet@gmail.com, Kaly.Xin@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 13:50:32 +0100
Will Deacon <will@kernel.org> wrote:

> On Mon, Sep 30, 2019 at 09:57:39AM +0800, Jia He wrote:
> > On arm64 without hardware Access Flag, copying fromuser will fail because
> > the pte is old and cannot be marked young. So we always end up with zeroed
> > page after fork() + CoW for pfn mappings. we don't always have a
> > hardware-managed access flag on arm64.
> > 
> > Hence implement arch_faults_on_old_pte on arm64 to indicate that it might
> > cause page fault when accessing old pte.
> > 
> > Signed-off-by: Jia He <justin.he@arm.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 7576df00eb50..e96fb82f62de 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -885,6 +885,20 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
> >  #define phys_to_ttbr(addr)	(addr)
> >  #endif
> >  
> > +/*
> > + * On arm64 without hardware Access Flag, copying from user will fail because
> > + * the pte is old and cannot be marked young. So we always end up with zeroed
> > + * page after fork() + CoW for pfn mappings. We don't always have a
> > + * hardware-managed access flag on arm64.
> > + */
> > +static inline bool arch_faults_on_old_pte(void)
> > +{
> > +	WARN_ON(preemptible());
> > +
> > +	return !cpu_has_hw_af();
> > +}  
> 
> Does this work correctly in a KVM guest? (i.e. is the MMFR sanitised in that
> case, despite not being the case on the host?)

Yup, all the 64bit MMFRs are trapped (HCR_EL2.TID3 is set for an
AArch64 guest), and we return the sanitised version.

But that's an interesting remark: we're now trading an extra fault on
CPUs that do not support HWAFDBS for a guaranteed trap for each and
every guest under the sun that will hit the COW path...

My gut feeling is that this is going to be pretty visible. Jia, do you
have any numbers for this kind of behaviour?

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
