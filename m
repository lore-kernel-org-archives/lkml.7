Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9827C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11EE20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmbEN2pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfKNMNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:13:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60332 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfKNMNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573733601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GZnck4rX9SmE/n51pQrh/Xw2Zl6hoiU/UzHDNQl/qbU=;
        b=TmbEN2pTpuV/5ZekE6bnUoeVl+4IqYFzzsWx/eDp4L6WZIH13bEjimcMdGBjgOmGrQ8lZq
        t51JFQg8WJOO6vGQlzyZ9ohwJrxY8lx5X8S5z3IXbTbqjGkJTHO+3eEfBuQfRLpjaqCr81
        09/xhbf8ZINiSHwWTIUoM93lIWJAvSg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-V6zreZ7nMbyvmEp4J4wXBA-1; Thu, 14 Nov 2019 07:13:20 -0500
Received: by mail-wm1-f69.google.com with SMTP id 2so3816991wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 04:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qm2WmHmzUm5vMMu5JnWcwUEqIaPgt1IyJyPsTjQ0eyE=;
        b=I8qH38eaPrYCIPiNfIOISwbvPamhNN1uTCUVz4zZREr3CMF31bp10dIjrMDKGQEpg0
         iq9QLtP5+hHLJC3KGgGfT/1U/eEcgRtzg1HZToYw9GEqYLJN+x6RgCCFGW/kkeADG8la
         uBtvX2w+uZPVAJpK36XipN3G/e6ZUfmaS09jaP6Runx2gk52WCDS/3fecsGruTQDMDA0
         cWLR752AlJ7ddw4t5qMZ3RmiTDyk1RoyGIKrkskku5UUGGA94Nq5UdSDSinwPRuTTW4h
         D1ZJuU9Ez3aEXUmEUGjnql5OVgIRO4EFiIgCM+OM1YF9CKYbqAq8Zm2rF0j0hGp/WZWz
         KFdQ==
X-Gm-Message-State: APjAAAWk0R4yCNpl8JIW1Gv7ug3eXZOO7N3Uiv+0s7TxohC2E4lCf3qc
        6EdXYQJtacrOdS+56oGLKjn3flJs4jZV7mP5Y5lScFOwmX9bkqzbh9jlaoX+3TCDfvaNJwAJbFQ
        dm2+7NiY3G3SBkEorgyufcKcp
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr7652730wrn.393.1573733599253;
        Thu, 14 Nov 2019 04:13:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAQfF/ixJELPI3bg1TknQFZhcvASKK15bDOHZYTUubk4Xqo3xC5XlmX6NljWPMtAhyqiBBwA==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr7652706wrn.393.1573733598925;
        Thu, 14 Nov 2019 04:13:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc? ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
        by smtp.gmail.com with ESMTPSA id l26sm5412622wme.6.2019.11.14.04.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 04:13:18 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: Take slots_lock when using
 kvm_mmu_zap_all_fast()
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191113193032.12912-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8d80118-9a8c-fb98-158d-cfd741eb0033@redhat.com>
Date:   Thu, 14 Nov 2019 13:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191113193032.12912-1-sean.j.christopherson@intel.com>
Content-Language: en-US
X-MC-Unique: V6zreZ7nMbyvmEp4J4wXBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/19 20:30, Sean Christopherson wrote:
> Acquire the per-VM slots_lock when zapping all shadow pages as part of
> toggling nx_huge_pages.  The fast zap algorithm relies on exclusivity
> (via slots_lock) to identify obsolete vs. valid shadow pages, e.g. it
> uses a single bit for its generation number.  Holding slots_lock also
> obviates the need to acquire a read lock on the VM's srcu.
>=20
> Failing to take slots_lock when toggling nx_huge_pages allows multiple
> instances of kvm_mmu_zap_all_fast() to run concurrently, as the other
> user, KVM_SET_USER_MEMORY_REGION, does not take the global kvm_lock.
> Concurrent fast zap instances causes obsolete shadow pages to be
> incorrectly identified as valid due to the single bit generation number
> wrapping, which results in stale shadow pages being left in KVM's MMU
> and leads to all sorts of undesirable behavior.
>=20
> The bug is easily confirmed by running with CONFIG_PROVE_LOCKING and
> toggling nx_huge_pages via its module param.
>=20
> Note, the fast zap algorithm could use a 64-bit generation instead of
> relying on exclusivity for correctness, but all callers except the
> recently added set_nx_huge_pages() need to hold slots_lock anyways.
> Given that toggling nx_huge_pages is by no means a fast path, force it
> to conform to the current approach instead of reworking the algorithm to
> support concurrent calls.
>=20
> Fixes: b8e8c8303ff28 ("kvm: mmu: ITLB_MULTIHIT mitigation")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index cf718fa23dff..2ce9da58611e 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -6285,14 +6285,13 @@ static int set_nx_huge_pages(const char *val, con=
st struct kernel_param *kp)
> =20
>  =09if (new_val !=3D old_val) {
>  =09=09struct kvm *kvm;
> -=09=09int idx;
> =20
>  =09=09mutex_lock(&kvm_lock);
> =20
>  =09=09list_for_each_entry(kvm, &vm_list, vm_list) {
> -=09=09=09idx =3D srcu_read_lock(&kvm->srcu);
> +=09=09=09mutex_lock(&kvm->slots_lock);
>  =09=09=09kvm_mmu_zap_all_fast(kvm);
> -=09=09=09srcu_read_unlock(&kvm->srcu, idx);
> +=09=09=09mutex_unlock(&kvm->slots_lock);
> =20
>  =09=09=09wake_up_process(kvm->arch.nx_lpage_recovery_thread);
>  =09=09}
>=20

Queued, thanks.

Paolo

