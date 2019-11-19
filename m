Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78699C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F35222DC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMxIfQJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfKSVGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:06:42 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33636 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSVGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:06:41 -0500
Received: by mail-il1-f195.google.com with SMTP id m5so1641166ilq.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 13:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGwHKktdHWfe1wudNntoyFI8byqQVxr7vbzvHkvedAo=;
        b=rMxIfQJnnWLaY9kXb4aYVfV+q/5OV1uxc/T+Xk0Djbnesr+k9pFXkrrnXtmzoY4l7J
         0n9UZ2EXzCEBM478DLvp2ZKyrgfEGvF3FQ9xCR2eNd/SBHe9B9nBgF7VYtg0/GUlkyAx
         dANimp8QfAuXJtwlbE88NQSRgWAvHQFX1tkxG8pKJD0qux065mOr9BIzA+mcygzJnZPK
         9WxR0TRUQ3/zF5E0I/FSYkxacmI1x5fllRPv3HUzSN+tC7fJ7k8j7sZE1VUkfm18gWu7
         b3hn7M6T0Y516mbkPuyuFbsAE0QqQbAXGjvyGMtfcIm4TsXeBsC+pFoCRcRCWQCzNrXD
         HKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGwHKktdHWfe1wudNntoyFI8byqQVxr7vbzvHkvedAo=;
        b=Stzm/vsJQTr9MJSGEzzhA5HbFvY3R8Pk2ZZNjXZlznPoVSRSDJheYDuf1ldMLWHDJ2
         G7+dteUGI1xG8Yx8TfNdIklUfMawxVbzjWATvr9Um3bUUHTB9nE+X5+/KPRK4wVpoDyU
         gdGOXBjT9vEKRD12ML6abgd+2xAWoKjnlz1l0cY60AQclds4uldraakL8Y51chHZVaMp
         1Gk3R1Afnck3JW5qmt+lDw5CbFnXtyK69hZpK3JxuNoB+S6XQYjFwAv5Skxoi/+SfOaK
         9kRPZnmT3FeMra/tt2DQqtA8IkkNBlO8Kb+NxNMJIQ0zPE7K+irvoXNXhksBkpzLCln3
         gRRQ==
X-Gm-Message-State: APjAAAWKVuX4jiiVdXcn7qTc2tUVdhdthSSkz4V1hNSUS1CMVzdHE/FK
        /RZxVmpKun5rguFkxtzkpMvXgu8qHtnkqlStA5QjOgip
X-Google-Smtp-Source: APXvYqzeMnsNbcW39YM71C6lXnjfG2cyRu9l9m8Nv+Dxku4yXqeHbPqemUzbbrb8tx99n/J0VLeno+7xSccST/M4c3s=
X-Received: by 2002:a92:85:: with SMTP id 127mr25151196ila.118.1574197599779;
 Tue, 19 Nov 2019 13:06:39 -0800 (PST)
MIME-Version: 1.0
References: <1574101067-5638-1-git-send-email-pbonzini@redhat.com> <1574101067-5638-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1574101067-5638-5-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 19 Nov 2019 13:06:28 -0800
Message-ID: <CALMp9eQ=QXD5sFCADtFY0Bc9wWcn2nhq7XdahD-g4DBSgARYJw@mail.gmail.com>
Subject: Re: [PATCH 4/5] KVM: vmx: implement MSR_IA32_TSX_CTRL disable RTM functionality
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:17 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The current guest mitigation of TAA is both too heavy and not really
> sufficient.  It is too heavy because it will cause some affected CPUs
> (those that have MDS_NO but lack TAA_NO) to fall back to VERW and
> get the corresponding slowdown.  It is not really sufficient because
> it will cause the MDS_NO bit to disappear upon microcode update, so
> that VMs started before the microcode update will not be runnable
> anymore afterwards, even with tsx=on.
>
> Instead, if tsx=on on the host, we can emulate MSR_IA32_TSX_CTRL for
> the guest and let it run without the VERW mitigation.  Even though
> MSR_IA32_TSX_CTRL is quite heavyweight, and we do not want to write
> it on every vmentry, we can use the shared MSR functionality because
> the host kernel need not protect itself from TSX-based side-channels.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 34 +++++++++++++++++++++++++++++++---
>  arch/x86/kvm/x86.c     | 23 +++++------------------
>  2 files changed, 36 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 04a8212704c1..ed25fe7d5234 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -450,6 +450,7 @@ noinline void invept_error(unsigned long ext, u64 eptp, gpa_t gpa)
>         MSR_SYSCALL_MASK, MSR_LSTAR, MSR_CSTAR,
>  #endif
>         MSR_EFER, MSR_TSC_AUX, MSR_STAR,
> +       MSR_IA32_TSX_CTRL,
>  };
>
>  #if IS_ENABLED(CONFIG_HYPERV)
> @@ -1683,6 +1684,9 @@ static void setup_msrs(struct vcpu_vmx *vmx)
>         index = __find_msr_index(vmx, MSR_TSC_AUX);
>         if (index >= 0 && guest_cpuid_has(&vmx->vcpu, X86_FEATURE_RDTSCP))
>                 move_msr_up(vmx, index, save_nmsrs++);
> +       index = __find_msr_index(vmx, MSR_IA32_TSX_CTRL);
> +       if (index >= 0)
> +               move_msr_up(vmx, index, save_nmsrs++);
>
>         vmx->save_nmsrs = save_nmsrs;
>         vmx->guest_msrs_ready = false;
> @@ -1782,6 +1786,11 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  #endif
>         case MSR_EFER:
>                 return kvm_get_msr_common(vcpu, msr_info);
> +       case MSR_IA32_TSX_CTRL:
> +               if (!msr_info->host_initiated &&
> +                   !(vcpu->arch.arch_capabilities & ARCH_CAP_TSX_CTRL_MSR))
> +                       return 1;
> +               goto find_shared_msr;
>         case MSR_IA32_UMWAIT_CONTROL:
>                 if (!msr_info->host_initiated && !vmx_has_waitpkg(vmx))
>                         return 1;
> @@ -1884,8 +1893,9 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                 if (!msr_info->host_initiated &&
>                     !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
>                         return 1;
> -               /* Else, falls through */
> +               goto find_shared_msr;
>         default:
> +       find_shared_msr:
>                 msr = find_msr_entry(vmx, msr_info->index);
>                 if (msr) {
>                         msr_info->data = msr->data;
> @@ -2001,6 +2011,13 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                                               MSR_IA32_SPEC_CTRL,
>                                               MSR_TYPE_RW);
>                 break;
> +       case MSR_IA32_TSX_CTRL:
> +               if (!msr_info->host_initiated &&
> +                   !(vcpu->arch.arch_capabilities & ARCH_CAP_TSX_CTRL_MSR))
> +                       return 1;
> +               if (data & ~(TSX_CTRL_RTM_DISABLE | TSX_CTRL_CPUID_CLEAR))
> +                       return 1;
> +               goto find_shared_msr;
>         case MSR_IA32_PRED_CMD:
>                 if (!msr_info->host_initiated &&
>                     !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
> @@ -2152,8 +2169,10 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                 /* Check reserved bit, higher 32 bits should be zero */
>                 if ((data >> 32) != 0)
>                         return 1;
> -               /* Else, falls through */
> +               goto find_shared_msr;
> +
>         default:
> +       find_shared_msr:
>                 msr = find_msr_entry(vmx, msr_index);
>                 if (msr) {
>                         u64 old_msr_data = msr->data;
> @@ -4234,7 +4253,16 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
>                         continue;
>                 vmx->guest_msrs[j].index = i;
>                 vmx->guest_msrs[j].data = 0;
> -               vmx->guest_msrs[j].mask = -1ull;
> +
> +               switch (index) {
> +               case MSR_IA32_TSX_CTRL:
> +                       /* No need to pass TSX_CTRL_CPUID_CLEAR through.  */
> +                       vmx->guest_msrs[j].mask = ~(u64)TSX_CTRL_CPUID_CLEAR;
> +                       break;

Why even bother with the special case here? Does this make the wrmsr faster?

> +               default:
> +                       vmx->guest_msrs[j].mask = -1ull;
> +                       break;
> +               }
>                 ++vmx->nmsrs;
>         }
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 648e84e728fc..fc54e3905fe3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1314,29 +1314,16 @@ static u64 kvm_get_arch_capabilities(void)
>                 data |= ARCH_CAP_MDS_NO;
>
>         /*
> -        * On TAA affected systems, export MDS_NO=0 when:
> -        *      - TSX is enabled on the host, i.e. X86_FEATURE_RTM=1.
> -        *      - Updated microcode is present. This is detected by
> -        *        the presence of ARCH_CAP_TSX_CTRL_MSR and ensures
> -        *        that VERW clears CPU buffers.
> -        *
> -        * When MDS_NO=0 is exported, guests deploy clear CPU buffer
> -        * mitigation and don't complain:
> -        *
> -        *      "Vulnerable: Clear CPU buffers attempted, no microcode"
> -        *
> -        * If TSX is disabled on the system, guests are also mitigated against
> -        * TAA and clear CPU buffer mitigation is not required for guests.
> +        * On TAA affected systems:
> +        *      - nothing to do if TSX is disabled on the host.
> +        *      - we emulate TSX_CTRL if present on the host.
> +        *        This lets the guest use VERW to clear CPU buffers.
>          */
>         if (!boot_cpu_has(X86_FEATURE_RTM))
> -               data &= ~ARCH_CAP_TAA_NO;
> +               data &= ~(ARCH_CAP_TAA_NO | ARCH_CAP_TSX_CTRL_MSR);
>         else if (!boot_cpu_has_bug(X86_BUG_TAA))
>                 data |= ARCH_CAP_TAA_NO;
> -       else if (data & ARCH_CAP_TSX_CTRL_MSR)
> -               data &= ~ARCH_CAP_MDS_NO;
>
> -       /* KVM does not emulate MSR_IA32_TSX_CTRL.  */
> -       data &= ~ARCH_CAP_TSX_CTRL_MSR;
>         return data;
>  }
>  EXPORT_SYMBOL_GPL(kvm_get_arch_capabilities);
> --
> 1.8.3.1
>
>
