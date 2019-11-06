Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA3CC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBCB217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="h75vWf1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbfKFSEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:04:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35563 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfKFSEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:04:35 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so21861179oig.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0n4m9isT+Ck0ZHgj9nNKHVTcK5i7dBz9IQntg3gksQ=;
        b=h75vWf1kfqT7WCo9oPzlH2IwFP6eMdStUMP0AfAWnCe9OTYcu6TEsPQN+yx0WoqEfq
         E9HYz+A8UEG4Su4we8xTN//jPaDiLogimAXPPq7m0mNmordt3w8sFggaWtnyUYem3jnV
         6YlDe2ZG+OUVXEku1BqAlx0/+2QNx95Nabu6PSJOBfwuZ+nVV7z5t51ZXYtFHS66k90N
         GVDBPQilrV8oMQ7DNQWzztigOCU2RVft+4pAWjC/QdLhQ/XhuHntvIeT7H1UOhmG8tMz
         llLeRyvDxLSm3aV446uh3sdLt05Xn/RhAJAmzbveqLU3H+9a7DKOraTRf5EWciCNfYOw
         VwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0n4m9isT+Ck0ZHgj9nNKHVTcK5i7dBz9IQntg3gksQ=;
        b=P45mPpCZc6wRRTPKJuXn6wirCvqZe7D+czzLhDdRf7pjCqAjv5QdIGXjovd49QKrbC
         MacNtsQse+OJ4kupJNntKYs9qYhAw6+wl/X299IQyTU7AP7uW9t7vdGy4F8PkMuJvHSX
         lAV5b+xALHOWkWDeaZnGQZIThfRPsy8M5kuIGMnJYpzUIpzDLalQ4UhzbUrgaRs8nxKW
         Ruv4PNjqX9MdZbnxeSnzx5UyYaemU/ufAp9k/RmHQHnh5d9cGfKeAm4bYSmlVBrqSriN
         k19TC3sztB8KrmixIorLyKDPlCdIwi5TPCTRUIdc5c/NLwldHUZR/PSdlxPIIiGlLkeV
         A6CA==
X-Gm-Message-State: APjAAAVRGV7eCO61fNIWfndRIgYdRFZ8+4OfWAYxdgc0aiaqp6vzumOj
        zrc42RK1tBuMTId/wI75NGsEzGrpESrsL1vfYQSE8Q==
X-Google-Smtp-Source: APXvYqz322KPWE0McOPQ2HU7vzGL4faH1DPYPThcfro4U804rY+815CpZXkhVTFxQRmu8DE2tmavfFznwplkC4fdonI=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr3543339oih.0.1573063474058;
 Wed, 06 Nov 2019 10:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20191106170727.14457-1-sean.j.christopherson@intel.com> <20191106170727.14457-2-sean.j.christopherson@intel.com>
In-Reply-To: <20191106170727.14457-2-sean.j.christopherson@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Nov 2019 10:04:22 -0800
Message-ID: <CAPcyv4gJk2cXLdT2dZwCH2AssMVNxUfdx-bYYwJwy1LwFxOs0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: MMU: Do not treat ZONE_DEVICE pages as being reserved
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 9:07 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Explicitly exempt ZONE_DEVICE pages from kvm_is_reserved_pfn() and
> instead manually handle ZONE_DEVICE on a case-by-case basis.  For things
> like page refcounts, KVM needs to treat ZONE_DEVICE pages like normal
> pages, e.g. put pages grabbed via gup().  But KVM needs special handling
> in other flows where ZONE_DEVICE pages lack the underlying machinery,
> e.g. when setting accessed/dirty bits and shifting refcounts for
> transparent huge pages.
>
> This fixes a hang reported by Adam Borowski[*] in dev_pagemap_cleanup()
> when running a KVM guest backed with /dev/dax memory, as KVM straight up
> doesn't put any references to ZONE_DEVICE pages acquired by gup().
>
> [*] http://lkml.kernel.org/r/20190919115547.GA17963@angband.pl
>
> Reported-by: Adam Borowski <kilobyte@angband.pl>
> Debugged-by: David Hildenbrand <david@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu.c       |  8 ++++----
>  include/linux/kvm_host.h |  1 +
>  virt/kvm/kvm_main.c      | 19 +++++++++++++++----
>  3 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 24c23c66b226..bf82b1f2e834 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -3306,7 +3306,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
>          * here.
>          */
>         if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
> -           level == PT_PAGE_TABLE_LEVEL &&
> +           !kvm_is_zone_device_pfn(pfn) && level == PT_PAGE_TABLE_LEVEL &&
>             PageTransCompoundMap(pfn_to_page(pfn)) &&
>             !mmu_gfn_lpage_is_disallowed(vcpu, gfn, PT_DIRECTORY_LEVEL)) {
>                 unsigned long mask;
> @@ -5914,9 +5914,9 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
>                  * the guest, and the guest page table is using 4K page size
>                  * mapping if the indirect sp has level = 1.
>                  */
> -               if (sp->role.direct &&
> -                       !kvm_is_reserved_pfn(pfn) &&
> -                       PageTransCompoundMap(pfn_to_page(pfn))) {
> +               if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
> +                   !kvm_is_zone_device_pfn(pfn) &&
> +                   PageTransCompoundMap(pfn_to_page(pfn))) {
>                         pte_list_remove(rmap_head, sptep);
>
>                         if (kvm_available_flush_tlb_with_range())
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index a817e446c9aa..4ad1cd7d2d4d 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -966,6 +966,7 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu);
>  void kvm_vcpu_kick(struct kvm_vcpu *vcpu);
>
>  bool kvm_is_reserved_pfn(kvm_pfn_t pfn);
> +bool kvm_is_zone_device_pfn(kvm_pfn_t pfn);
>
>  struct kvm_irq_ack_notifier {
>         struct hlist_node link;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index b8534c6b8cf6..0a781b1fb8f0 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -151,12 +151,23 @@ __weak int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>
>  bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
>  {
> +       /*
> +        * ZONE_DEVICE pages currently set PG_reserved, but from a refcounting
> +        * perspective they are "normal" pages, albeit with slightly different
> +        * usage rules.
> +        */
>         if (pfn_valid(pfn))
> -               return PageReserved(pfn_to_page(pfn));
> +               return PageReserved(pfn_to_page(pfn)) &&
> +                      !is_zone_device_page(pfn_to_page(pfn));

This is racy unless you can be certain that the pfn and resulting page
has already been pinned by get_user_pages(). This is why I told David
to steer clear of adding more is_zone_device_page() usage, it's
difficult to audit. Without an existing pin the metadata to determine
whether a page is ZONE_DEVICE or not could be in the process of being
torn down. Ideally KVM would pass around a struct { struct page *page,
unsigned long pfn } tuple so it would not have to do this "recall
context" dance on every pfn operation.
