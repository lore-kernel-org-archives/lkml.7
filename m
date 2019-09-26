Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC131C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC78A2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iarHionm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfIZXjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 19:39:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42889 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfIZXjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 19:39:40 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so11165278iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0cBEf365i2Hkj00ueJY/8kNVMVGUzDIUvSusdb3iJo=;
        b=iarHionmZ9hxwjfPzym+mw593rsAWn5IDAtGQYDnR0d5TvGKCgO/lHCDVGMyzbW3mm
         g/K1kzkctO0jKXs9GvJCm55o4g6zyX/YN6/dQH8/scep3dO5DDYqW7orr6sxEJldh/mv
         w0e3pJQ9raKn55fkuT6Q1W6N+niCNrT1lVipTCRSdmnYXP/coS2UZ2ItssxmJeFSkxaW
         S/ZlveFepDjGeQ54C/Ogt146Hrah1lxDJpdXcIgUypdqU+h/vkNdUcT6PcNmG0YbmajW
         KOQ6LnlZAtbNV0RwWUYYUK+NXGFUGjL9kJuCM8yWuqZp/lVdrkYFF//VXHSUU6ywODUL
         +zsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0cBEf365i2Hkj00ueJY/8kNVMVGUzDIUvSusdb3iJo=;
        b=d0ZW6f3IfborAtN28TJBmIcscrAuRXQqb8lbtQevKSVa0tfXOWaKZ0BMr7gbE3067S
         prHFmnJM8EXxEg15kv+N+V3l2X1JhtVZVVJP7FVSpSeVMk9ygGBnGx7Hr2+IKD2LQEhY
         zjooErkLmosBE4GeQeNaK93jgKWQqKPvf7op9IiUqMVXs+hucUfWCqIbD2h6B0t0h+7A
         Si4OFxkY/EKsye6zRc4GySBh9GQVojt5tHCQViSOuRzfuc1oVNO9iKqTLhgR/6KL6uzg
         Q+FNRrzzxu8qzmqnXmPkTjkbJGqPnTe79QUcUO5NTPSALXr5kJL0WlLbTH3ktkZcmH9K
         X9XA==
X-Gm-Message-State: APjAAAU6FWQCrqlCBjtjqht0r94+2mcNmoaIFEAIoMJbcdrUIELZV+sp
        BGrntB1ls1NRwnHd8BBm6lWQI1plL35GXA4awyfB2w==
X-Google-Smtp-Source: APXvYqzS8RUe6oPVXctBY/skc+t9TIP2rzSRNe+yUzDgHWAywit66NVUBpgLR9dqI6JeXV2cYn+jdNcfTDtptuX4YFY=
X-Received: by 2002:a92:5a10:: with SMTP id o16mr1596339ilb.296.1569541179334;
 Thu, 26 Sep 2019 16:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190926214302.21990-1-sean.j.christopherson@intel.com> <20190926214302.21990-2-sean.j.christopherson@intel.com>
In-Reply-To: <20190926214302.21990-2-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 26 Sep 2019 16:39:28 -0700
Message-ID: <CALMp9eQVSg31uPy+RKAnsEZixtwix55CijC1DKKbmH-iNiJw9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: nVMX: Always write vmcs02.GUEST_CR3 during
 nested VM-Enter
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Reto Buerki <reet@codelabs.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 2:43 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Write the desired L2 CR3 into vmcs02.GUEST_CR3 during nested VM-Enter
> isntead of deferring the VMWRITE until vmx_set_cr3().  If the VMWRITE
> is deferred, then KVM can consume a stale vmcs02.GUEST_CR3 when it
> refreshes vmcs12->guest_cr3 during nested_vmx_vmexit() if the emulated
> VM-Exit occurs without actually entering L2, e.g. if the nested run
> is squashed because L2 is being put into HLT.
>
> In an ideal world where EPT *requires* unrestricted guest (and vice
> versa), VMX could handle CR3 similar to how it handles RSP and RIP,
> e.g. mark CR3 dirty and conditionally load it at vmx_vcpu_run().  But
> the unrestricted guest silliness complicates the dirty tracking logic
> to the point that explicitly handling vmcs02.GUEST_CR3 during nested
> VM-Enter is a simpler overall implementation.
>
> Cc: stable@vger.kernel.org
> Reported-by: Reto Buerki <reet@codelabs.ch>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 8 ++++++++
>  arch/x86/kvm/vmx/vmx.c    | 9 ++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 41abc62c9a8a..971a24134081 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2418,6 +2418,14 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>                                 entry_failure_code))
>                 return -EINVAL;
>
> +       /*
> +        * Immediately write vmcs02.GUEST_CR3.  It will be propagated to vmcs12
> +        * on nested VM-Exit, which can occur without actually running L2, e.g.
> +        * if L2 is entering HLT state, and thus without hitting vmx_set_cr3().
> +        */
> +       if (enable_ept)
> +               vmcs_writel(GUEST_CR3, vmcs12->guest_cr3);
> +

This part of the change I can definitely confirm, since we have a
similar change in our fetid pile of commits that have yet to be
upstreamed. Thanks for taking care of this one!

>         /* Late preparation of GUEST_PDPTRs now that EFER and CRs are set. */
>         if (load_guest_pdptrs_vmcs12 && nested_cpu_has_ept(vmcs12) &&
>             is_pae_paging(vcpu)) {
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d4575ffb3cec..b530950a9c2b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2985,6 +2985,7 @@ void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
>  {
>         struct kvm *kvm = vcpu->kvm;
>         unsigned long guest_cr3;
> +       bool skip_cr3 = false;
>         u64 eptp;
>
>         guest_cr3 = cr3;
> @@ -3000,15 +3001,17 @@ void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
>                         spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
>                 }
>
> -               if (enable_unrestricted_guest || is_paging(vcpu) ||
> -                   is_guest_mode(vcpu))
> +               if (is_guest_mode(vcpu))
> +                       skip_cr3 = true;
> +               else if (enable_unrestricted_guest || is_paging(vcpu))
>                         guest_cr3 = kvm_read_cr3(vcpu);
>                 else
>                         guest_cr3 = to_kvm_vmx(kvm)->ept_identity_map_addr;
>                 ept_load_pdptrs(vcpu);
>         }
>
> -       vmcs_writel(GUEST_CR3, guest_cr3);
> +       if (!skip_cr3)
> +               vmcs_writel(GUEST_CR3, guest_cr3);

Is this part of the change necessary, or is it just an optimization to
save a redundant VMWRITE?

>  }
>
>  int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
> --
> 2.22.0
>
