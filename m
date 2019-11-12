Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30380C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E892067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPmRPQPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKLHHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:07:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44341 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbfKLHHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573542421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNKPnmulP0WbsGXdxyN2B3pxVSzA6iLxN4YA5kzzs7Y=;
        b=SPmRPQPpPJ7SR8nm1umT6FlNJCS2UXRa+78Y5VBs7soBHP+mOYIAgfIoA002pvUdC3vIkF
        eKD8JQBwZfZRfdn2mmVoEP+aC6rAf7Vx44TyBVhk5v5YAoP0LlHlwvrDgZc5XzCp8+o2w+
        sofgz8bEiKwS8rFGXDNbaASqqcjC+2M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-4AERrfDKMDy_EjTb4YFXhA-1; Tue, 12 Nov 2019 02:07:00 -0500
Received: by mail-wr1-f69.google.com with SMTP id 4so11429991wrf.19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=89X1z6SSjUHkMGZjWPoQHPiMSM5vQ74+X3VJnDeNJTg=;
        b=Ewqz78lKCahE6ObyL1H4KAFw1SoMzoSK6c+CSR6u7bw5ABVsWtmaqZtu2q40HYjyFR
         fA9ruyuis7RHCClrhmyVEPJXMwXmrh1o3M5bHsjnycntvxow5zSOaiiyIqG22CDFVnCC
         eTuwX5iqJILeLWO625u4z7fxp5jiHcJxaUumdKTpTHaK4Kg69DJmzYvl6bgVjZK6msJY
         7xWmQgEuJwGbyoOX/sg2kwQpndc3FQVxeCLjwascBYqwSu2fid3dMBvzQJ9BnOOdTn3t
         z+j2gxiNTgqdOXs33sdLbQ+z+9/v7YQ+/gmciNspbL4158ekUixX4bdi5GrgvO3NEokF
         /2+g==
X-Gm-Message-State: APjAAAUl+kYwnfSTtGo+zuhMBj1yERf78I9HoGoMF+rlFQKUqVeChhTO
        tVz/t17b1B9lAkPW1XjwXZDNf++HMnPb2NiXSYp1dMYIPBGZNmt7Z+kpF7zN5vU98YgONAWamgt
        4LxA5ydUgiSpwa62tes8K+eb+
X-Received: by 2002:a1c:7d94:: with SMTP id y142mr2636374wmc.168.1573542418721;
        Mon, 11 Nov 2019 23:06:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKXKnRSk2wHe1+q1H5MRGlBpxkseIi2o9czkie0vzbGqrRs1YStaJAcOA/gsny2ZzDEW53Ig==
X-Received: by 2002:a1c:7d94:: with SMTP id y142mr2636344wmc.168.1573542418411;
        Mon, 11 Nov 2019 23:06:58 -0800 (PST)
Received: from [192.168.3.122] (p4FF23E69.dip0.t-ipconnect.de. [79.242.62.105])
        by smtp.gmail.com with ESMTPSA id 5sm1692276wmk.48.2019.11.11.23.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 23:06:57 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/3] KVM: MMU: Do not treat ZONE_DEVICE pages as being reserved
Date:   Tue, 12 Nov 2019 08:06:57 +0100
Message-Id: <EB13AC8B-377E-4647-A374-9868F0C64292@redhat.com>
References: <20191111221229.24732-2-sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
In-Reply-To: <20191111221229.24732-2-sean.j.christopherson@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: 4AERrfDKMDy_EjTb4YFXhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 11.11.2019 um 23:12 schrieb Sean Christopherson <sean.j.christopherson=
@intel.com>:
>=20
> =EF=BB=BFExplicitly exempt ZONE_DEVICE pages from kvm_is_reserved_pfn() a=
nd
> instead manually handle ZONE_DEVICE on a case-by-case basis.  For things
> like page refcounts, KVM needs to treat ZONE_DEVICE pages like normal
> pages, e.g. put pages grabbed via gup().  But for flows such as setting
> A/D bits or shifting refcounts for transparent huge pages, KVM needs to
> to avoid processing ZONE_DEVICE pages as the flows in question lack the
> underlying machinery for proper handling of ZONE_DEVICE pages.
>=20
> This fixes a hang reported by Adam Borowski[*] in dev_pagemap_cleanup()
> when running a KVM guest backed with /dev/dax memory, as KVM straight up
> doesn't put any references to ZONE_DEVICE pages acquired by gup().
>=20
> Note, Dan Williams proposed an alternative solution of doing put_page()
> on ZONE_DEVICE pages immediately after gup() in order to simplify the
> auditing needed to ensure is_zone_device_page() is called if and only if
> the backing device is pinned (via gup()).  But that approach would break
> kvm_vcpu_{un}map() as KVM requires the page to be pinned from map() 'til
> unmap() when accessing guest memory, unlike KVM's secondary MMU, which
> coordinates with mmu_notifier invalidations to avoid creating stale
> page references, i.e. doesn't rely on pages being pinned.
>=20
> [*] http://lkml.kernel.org/r/20190919115547.GA17963@angband.pl
>=20
> Reported-by: Adam Borowski <kilobyte@angband.pl>
> Debugged-by: David Hildenbrand <david@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> arch/x86/kvm/mmu.c       |  8 ++++----
> include/linux/kvm_host.h |  1 +
> virt/kvm/kvm_main.c      | 26 +++++++++++++++++++++++---
> 3 files changed, 28 insertions(+), 7 deletions(-)
>=20

Thanks for taking care of this! Other KVM related code (PPC, vfio) also has=
 a reserved check (see my series), I didn=E2=80=98t have a look yet at the =
details, how reserved pages are treated. Will do so in the next weeks, afte=
r hollidays.

Acked-by: David Hildenbrand <david@redhat.com>

> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 24c23c66b226..bf82b1f2e834 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -3306,7 +3306,7 @@ static void transparent_hugepage_adjust(struct kvm_=
vcpu *vcpu,
>     * here.
>     */
>    if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
> -        level =3D=3D PT_PAGE_TABLE_LEVEL &&
> +        !kvm_is_zone_device_pfn(pfn) && level =3D=3D PT_PAGE_TABLE_LEVEL=
 &&
>        PageTransCompoundMap(pfn_to_page(pfn)) &&
>        !mmu_gfn_lpage_is_disallowed(vcpu, gfn, PT_DIRECTORY_LEVEL)) {
>        unsigned long mask;
> @@ -5914,9 +5914,9 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm=
 *kvm,
>         * the guest, and the guest page table is using 4K page size
>         * mapping if the indirect sp has level =3D 1.
>         */
> -        if (sp->role.direct &&
> -            !kvm_is_reserved_pfn(pfn) &&
> -            PageTransCompoundMap(pfn_to_page(pfn))) {
> +        if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
> +            !kvm_is_zone_device_pfn(pfn) &&
> +            PageTransCompoundMap(pfn_to_page(pfn))) {
>            pte_list_remove(rmap_head, sptep);
>=20
>            if (kvm_available_flush_tlb_with_range())
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index a817e446c9aa..4ad1cd7d2d4d 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -966,6 +966,7 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu);
> void kvm_vcpu_kick(struct kvm_vcpu *vcpu);
>=20
> bool kvm_is_reserved_pfn(kvm_pfn_t pfn);
> +bool kvm_is_zone_device_pfn(kvm_pfn_t pfn);
>=20
> struct kvm_irq_ack_notifier {
>    struct hlist_node link;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index b8534c6b8cf6..bc9d10a0a334 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -149,10 +149,30 @@ __weak int kvm_arch_mmu_notifier_invalidate_range(s=
truct kvm *kvm,
>    return 0;
> }
>=20
> +bool kvm_is_zone_device_pfn(kvm_pfn_t pfn)
> +{
> +    /*
> +     * The metadata used by is_zone_device_page() to determine whether o=
r
> +     * not a page is ZONE_DEVICE is guaranteed to be valid if and only i=
f
> +     * the device has been pinned, e.g. by get_user_pages().  WARN if th=
e
> +     * page_count() is zero to help detect bad usage of this helper.
> +     */
> +    if (!pfn_valid(pfn) || WARN_ON_ONCE(!page_count(pfn_to_page(pfn))))
> +        return false;
> +
> +    return is_zone_device_page(pfn_to_page(pfn));
> +}
> +
> bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
> {
> +    /*
> +     * ZONE_DEVICE pages currently set PG_reserved, but from a refcounti=
ng
> +     * perspective they are "normal" pages, albeit with slightly differe=
nt
> +     * usage rules.
> +     */
>    if (pfn_valid(pfn))
> -        return PageReserved(pfn_to_page(pfn));
> +        return PageReserved(pfn_to_page(pfn)) &&
> +               !kvm_is_zone_device_pfn(pfn);
>=20
>    return true;
> }
> @@ -1865,7 +1885,7 @@ EXPORT_SYMBOL_GPL(kvm_release_pfn_dirty);
>=20
> void kvm_set_pfn_dirty(kvm_pfn_t pfn)
> {
> -    if (!kvm_is_reserved_pfn(pfn)) {
> +    if (!kvm_is_reserved_pfn(pfn) && !kvm_is_zone_device_pfn(pfn)) {
>        struct page *page =3D pfn_to_page(pfn);
>=20
>        SetPageDirty(page);
> @@ -1875,7 +1895,7 @@ EXPORT_SYMBOL_GPL(kvm_set_pfn_dirty);
>=20
> void kvm_set_pfn_accessed(kvm_pfn_t pfn)
> {
> -    if (!kvm_is_reserved_pfn(pfn))
> +    if (!kvm_is_reserved_pfn(pfn) && !kvm_is_zone_device_pfn(pfn))
>        mark_page_accessed(pfn_to_page(pfn));
> }
> EXPORT_SYMBOL_GPL(kvm_set_pfn_accessed);
> --=20
> 2.24.0
>=20

