Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F8BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A283C20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCGQGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:06:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:37521 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfCGQGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:06:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 08:06:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="280619539"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2019 08:06:33 -0800
Date:   Thu, 7 Mar 2019 08:06:33 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RFC] x86/kvm/mmu: make mmu->prev_roots cache work for
 NPT case
Message-ID: <20190307160633.GA4986@linux.intel.com>
References: <0c13c94e-3226-8bfd-2dc7-c75aad1c03a2@redhat.com>
 <20190223111552.27221-1-vkuznets@redhat.com>
 <87ftrylqwm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftrylqwm.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:07:05PM +0100, Vitaly Kuznetsov wrote:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> 
> > Alternative patch: remove the filtering from kvm_mmu_get_page() and check
> > for direct on call sites. cr4_pae setting in kvm_calc_mmu_role_common()
> > can be preserved for consistency.
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> >  arch/x86/kvm/mmu.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index f2d1d230d5b8..7fb8118f2af6 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -2420,8 +2420,6 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
> >  	role = vcpu->arch.mmu->mmu_role.base;
> >  	role.level = level;
> >  	role.direct = direct;
> > -	if (role.direct)
> > -		role.cr4_pae = 0;
> >  	role.access = access;
> >  	if (!vcpu->arch.mmu->direct_map
> >  	    && vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL) {
> > @@ -5176,7 +5174,7 @@ static bool detect_write_misaligned(struct kvm_mmu_page *sp, gpa_t gpa,
> >  		 gpa, bytes, sp->role.word);
> >  
> >  	offset = offset_in_page(gpa);
> > -	pte_size = sp->role.cr4_pae ? 8 : 4;
> > +	pte_size = (sp->role.cr4_pae && !sp->role.direct) ? 8 : 4;
> >  
> >  	/*
> >  	 * Sometimes, the OS only writes the last one bytes to update status
> > @@ -5200,7 +5198,7 @@ static u64 *get_written_sptes(struct kvm_mmu_page *sp, gpa_t gpa, int *nspte)
> >  	page_offset = offset_in_page(gpa);
> >  	level = sp->role.level;
> >  	*nspte = 1;
> > -	if (!sp->role.cr4_pae) {
> > +	if (!sp->role.cr4_pae || sp->role.direct) {
> >  		page_offset <<= 1;	/* 32->64 */
> >  		/*
> >  		 * A 32-bit pde maps 4MB while the shadow pdes map
> 
> While I personally prefer this approach to not setting role.cr4_pae in
> kvm_calc_mmu_role_common() I'd like to get maintainers opinion (I did
> test the patch with ept=off but I have to admit I don't know much about
> shadow page tables which actually use detect_write_misaligned()/
> get_written_sptes())
> 
> Paolo, Radim, (anyone else) - any thoughts?

The changes to detect_write_misaligned() and get_written_sptes() are
wrong/unnecessary as those functions should only be called for indirect
shadow PTEs, e.g.:

	for_each_gfn_indirect_valid_sp(vcpu->kvm, sp, gfn) {
		if (detect_write_misaligned(sp, gpa, bytes) ||
		      detect_write_flooding(sp)) {
			kvm_mmu_prepare_zap_page(vcpu->kvm, sp, &invalid_list);
			++vcpu->kvm->stat.mmu_flooded;
			continue;
		}

		spte = get_written_sptes(sp, gpa, &npte);
		if (!spte)
			continue;

		...
	}

If anything, they could WARN_ON(sp->role.direct), but IMO that's overkill
since they're static helpers with a single call site (above).

I'm missing the background for this patch, why does clearing role.cr4_pae
for direct SPTEs cause problems with the prev_roots cache?
