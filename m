Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDFAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6134320851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCGQlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:41:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33514 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfCGQln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:41:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so18206621wrw.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 08:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+8gO2bxUPhw8S0046E3aigenabecmfP2phoppMgq7UU=;
        b=RBad4RlBDMT3vrjkA4AkpazPPvXoACPQGn1QvsYbMNbNYzxh8NPPJmNRi8t6TRatBD
         7Hj450I1bcGtNyggh3DMp95mMwITxnnTT0Z4aefkJ0S486FttWRunpPRuVTE7vvOdgz2
         2VX8vwk9Xe/1TzTZKH+J3ganBjSPc1PHKtng/mfmTZpzUAAdvtggxSs/xe8rDl0Zd68e
         yGmdn3zaoPigv2uigeS3bVY4JIVC7yCoPmv66QlV5nDSnaMZki+irtCLZQb0pZZ86KuD
         o2DG8s5UQfJg7yl9M/BWdsY3FHdeVYgDe6aFwuHnqF7cWc+33jdBC1FvROscC5rtJEOL
         1dQg==
X-Gm-Message-State: APjAAAXglKUVBZI1wK+8O5DtYY8YGhWaSTvzJHBzqV3kLZtDFwIEfrSp
        jmdaqTexn7blOapv15l74p1yoampyq8=
X-Google-Smtp-Source: APXvYqzY2Phknr26Hhii4EL6ADNmkSuyaDN2l0Mhey5ye3shT6Lnd7EQLDmEKBG0ZQr6igkOXK+9zQ==
X-Received: by 2002:a5d:4e44:: with SMTP id r4mr7124344wrt.228.1551976901293;
        Thu, 07 Mar 2019 08:41:41 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n6sm5972709wrt.23.2019.03.07.08.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 08:41:40 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RFC] x86/kvm/mmu: make mmu->prev_roots cache work for NPT case
In-Reply-To: <20190307160633.GA4986@linux.intel.com>
References: <0c13c94e-3226-8bfd-2dc7-c75aad1c03a2@redhat.com> <20190223111552.27221-1-vkuznets@redhat.com> <87ftrylqwm.fsf@vitty.brq.redhat.com> <20190307160633.GA4986@linux.intel.com>
Date:   Thu, 07 Mar 2019 17:41:39 +0100
Message-ID: <87a7i6ljr0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Thu, Mar 07, 2019 at 03:07:05PM +0100, Vitaly Kuznetsov wrote:
>> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>> 
>> > Alternative patch: remove the filtering from kvm_mmu_get_page() and check
>> > for direct on call sites. cr4_pae setting in kvm_calc_mmu_role_common()
>> > can be preserved for consistency.
>> >
>> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> > ---
>> >  arch/x86/kvm/mmu.c | 6 ++----
>> >  1 file changed, 2 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
>> > index f2d1d230d5b8..7fb8118f2af6 100644
>> > --- a/arch/x86/kvm/mmu.c
>> > +++ b/arch/x86/kvm/mmu.c
>> > @@ -2420,8 +2420,6 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>> >  	role = vcpu->arch.mmu->mmu_role.base;
>> >  	role.level = level;
>> >  	role.direct = direct;
>> > -	if (role.direct)
>> > -		role.cr4_pae = 0;
>> >  	role.access = access;
>> >  	if (!vcpu->arch.mmu->direct_map
>> >  	    && vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL) {
>> > @@ -5176,7 +5174,7 @@ static bool detect_write_misaligned(struct kvm_mmu_page *sp, gpa_t gpa,
>> >  		 gpa, bytes, sp->role.word);
>> >  
>> >  	offset = offset_in_page(gpa);
>> > -	pte_size = sp->role.cr4_pae ? 8 : 4;
>> > +	pte_size = (sp->role.cr4_pae && !sp->role.direct) ? 8 : 4;
>> >  
>> >  	/*
>> >  	 * Sometimes, the OS only writes the last one bytes to update status
>> > @@ -5200,7 +5198,7 @@ static u64 *get_written_sptes(struct kvm_mmu_page *sp, gpa_t gpa, int *nspte)
>> >  	page_offset = offset_in_page(gpa);
>> >  	level = sp->role.level;
>> >  	*nspte = 1;
>> > -	if (!sp->role.cr4_pae) {
>> > +	if (!sp->role.cr4_pae || sp->role.direct) {
>> >  		page_offset <<= 1;	/* 32->64 */
>> >  		/*
>> >  		 * A 32-bit pde maps 4MB while the shadow pdes map
>> 
>> While I personally prefer this approach to not setting role.cr4_pae in
>> kvm_calc_mmu_role_common() I'd like to get maintainers opinion (I did
>> test the patch with ept=off but I have to admit I don't know much about
>> shadow page tables which actually use detect_write_misaligned()/
>> get_written_sptes())
>> 
>> Paolo, Radim, (anyone else) - any thoughts?
>
> The changes to detect_write_misaligned() and get_written_sptes() are
> wrong/unnecessary as those functions should only be called for indirect
> shadow PTEs, e.g.:
>
> 	for_each_gfn_indirect_valid_sp(vcpu->kvm, sp, gfn) {
> 		if (detect_write_misaligned(sp, gpa, bytes) ||
> 		      detect_write_flooding(sp)) {
> 			kvm_mmu_prepare_zap_page(vcpu->kvm, sp, &invalid_list);
> 			++vcpu->kvm->stat.mmu_flooded;
> 			continue;
> 		}
>
> 		spte = get_written_sptes(sp, gpa, &npte);
> 		if (!spte)
> 			continue;
>
> 		...
> 	}
>
> If anything, they could WARN_ON(sp->role.direct), but IMO that's overkill
> since they're static helpers with a single call site (above).
>
> I'm missing the background for this patch, why does clearing role.cr4_pae
> for direct SPTEs cause problems with the prev_roots cache?

Oh, thank you for taking a look! You've probably missed my original v1
patch where I tried to explaing the issue:

"I noticed that fast_cr3_switch() always fails when we switch back from
L2 to L1 as it is not able to find a cached root. This is odd: host's
CR3 usually stays the same, we expect to always follow the fast
path. Turns out the problem is that page role is always mismatched
because kvm_mmu_get_page() filters out cr4_pae when direct, the value is
stored in page header and later compared with new_role in
cached_root_available(). As cr4_pae is always set in long mode
prev_roots cache is dysfunctional.

The problem appeared after we introduced kvm_calc_mmu_role_common():
previously, we were only setting this bit for shadow MMU root but now we
set it for everything. Restore the original behavior.

Fixes: 7dcd57552008 ("x86/kvm/mmu: check if tdp/shadow MMU reconfiguration is needed")
"

and the patch was just removing role.cr4_pae setting and moving it to
kvm_calc_shadow_mmu_root_page_role(). This is an alternative approach -
always set cr4_pae but count on kvm_mmu_get_page() filtering out cr4_pae
when direct is set.

-- 
Vitaly
