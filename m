Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C87BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFC8206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfCDRNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:13:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36242 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfCDRNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:13:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8718CA78;
        Mon,  4 Mar 2019 09:13:29 -0800 (PST)
Received: from en101 (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 962F73F703;
        Mon,  4 Mar 2019 09:13:27 -0800 (PST)
Date:   Mon, 4 Mar 2019 17:13:21 +0000
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
To:     Zenghui Yu <zenghuiyu96@gmail.com>
Cc:     christoffer.dall@arm.com, marc.zyngier@arm.com,
        Punit Agrawal <punit.agrawal@arm.com>, julien.thierry@arm.com,
        LKML <linux-kernel@vger.kernel.org>, james.morse@arm.com,
        Zenghui Yu <yuzenghui@huawei.com>, wanghaibin.wang@huawei.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] KVM: arm64: Force a PTE mapping when logging is
 enabled
Message-ID: <20190304171320.GA3984@en101>
References: <1551497728-12576-1-git-send-email-yuzenghui@huawei.com>
 <CAKcZhuWa4UcsoFPRkZg=M3WeUJibX8T0_R+JHS3=cyd51N9cgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKcZhuWa4UcsoFPRkZg=M3WeUJibX8T0_R+JHS3=cyd51N9cgQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On Sun, Mar 03, 2019 at 11:14:38PM +0800, Zenghui Yu wrote:
> I think there're still some problems in this patch... Details below.
> 
> On Sat, Mar 2, 2019 at 11:39 AM Zenghui Yu <yuzenghui@huawei.com> wrote:
> >
> > The idea behind this is: we don't want to keep tracking of huge pages when
> > logging_active is true, which will result in performance degradation.  We
> > still need to set vma_pagesize to PAGE_SIZE, so that we can make use of it
> > to force a PTE mapping.

Yes, you're right. We are indeed ignoring the force_pte flag.

> >
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Punit Agrawal <punit.agrawal@arm.com>
> > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> >
> > ---
> > Atfer looking into https://patchwork.codeaurora.org/patch/647985/ , the
> > "vma_pagesize = PAGE_SIZE" logic was not intended to be deleted. As far
> > as I can tell, we used to have "hugetlb" to force the PTE mapping, but
> > we have "vma_pagesize" currently instead. We should set it properly for
> > performance reasons (e.g, in VM migration). Did I miss something important?
> >
> > ---
> >  virt/kvm/arm/mmu.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> > index 30251e2..7d41b16 100644
> > --- a/virt/kvm/arm/mmu.c
> > +++ b/virt/kvm/arm/mmu.c
> > @@ -1705,6 +1705,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >              (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
> >             !force_pte) {
> >                 gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
> > +       } else {
> > +               /*
> > +                * Fallback to PTE if it's not one of the stage2
> > +                * supported hugepage sizes or the corresponding level
> > +                * doesn't exist, or logging is enabled.
> 
> First, Instead of "logging is enabled", it should be "force_pte is true",
> since "force_pte" will be true when:
> 
>         1) fault_supports_stage2_pmd_mappings() return false; or
>         2) "logging is enabled" (e.g, in VM migration).
> 
> Second, fallback some unsupported hugepage sizes (e.g, 64K hugepage with
> 4K pages) to PTE is somewhat strange. And it will then _unexpectedly_
> reach transparent_hugepage_adjust(), though no real adjustment will happen
> since commit fd2ef358282c ("KVM: arm/arm64: Ensure only THP is candidate
> for adjustment"). Keeping "vma_pagesize" there as it is will be better,
> right?
> 
> So I'd just simplify the logic like:

We could fix this right in the beginning. See patch below:

> 
>         } else if (force_pte) {
>                 vma_pagesize = PAGE_SIZE;
>         }
> 
> 
> Will send a V2 later and waiting for your comments :)


diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 30251e2..529331e 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1693,7 +1693,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	vma_pagesize = vma_kernel_pagesize(vma);
+	/* If we are forced to map at page granularity, force the pagesize here */
+	vma_pagesize = force_pte ? PAGE_SIZE : vma_kernel_pagesize(vma);
+
 	/*
 	 * The stage2 has a minimum of 2 level table (For arm64 see
 	 * kvm_arm_setup_stage2()). Hence, we are guaranteed that we can
@@ -1701,11 +1703,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * As for PUD huge maps, we must make sure that we have at least
 	 * 3 levels, i.e, PMD is not folded.
 	 */
-	if ((vma_pagesize == PMD_SIZE ||
-	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
-	    !force_pte) {
+	if (vma_pagesize == PMD_SIZE ||
+	    (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm)))
 		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
-	}
+
 	up_read(&current->mm->mmap_sem);
 
 	/* We need minimum second+third level pages */

---

Suzuki
