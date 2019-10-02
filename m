Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6120C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F77E218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0kAE/IA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfJBTFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:05:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34050 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfJBTFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:05:36 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so59553107ion.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpb4WgkPmWUTkRVSpOHj/p+ZluKtlvnqbYlL5hWyYz0=;
        b=I0kAE/IAXqqlKuq1P6lWWyONMkXidKiaRq0vFyU1CR3sSTsuoNUNFNVzWEgZdNCks/
         M1eeyImGPXFnsqCic1v2LON7yy5UkzsIuoltIUEyZ5HgXA1C+rn4gcMjs1EZn+pZ+9qp
         1+uHiIzsG+/fwvIcVLgAmYf7v1TwYYiwh2/B7msOLchuXLm22Wng/TvYdDCYP275SCAm
         rSnQy1omR9td3DlSlHrZX0PxKNHlo423ZALzaBs0N6rXe2zW+/ehFPDSfbn15psPZc2h
         poE6KLfF+YTAGQbsKh3gr0dwczURAt9GcmUH1e4jE+v+k2EXnuOQVnB/C8q8iWjcWgRr
         ESlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpb4WgkPmWUTkRVSpOHj/p+ZluKtlvnqbYlL5hWyYz0=;
        b=hA7GqxfwCGt70ugbe4Ez+Q1KX2M4ZhROI2Y4I/3SisYA39JrZiKoIiwJPZqhySJui6
         LnQWXWI/DZYkeZDGn2OhGLPj7A4yZNV9nZlBsYddsmQrNG11ZCLIeU2YV9XbY7FgNADg
         uCxR3jpH/MMGW19T0NQjB1AUTUFxJ6vzDXBEQy9h0KoSvChHwqg8mSWVuWyDxSGnzm5C
         NzOHyD/YIzP8TjNJFaALJpCxJKmVfr2nYzfNkosxcb132b6HCfU3uwSyqYwn5Wt39AyJ
         qY0p3kHPCKr1oBrCNyN/yGoK40UR/78eRO4uqeKf1oD4ZLiUYJx4hWp+GX4tC8D447Ge
         dZPg==
X-Gm-Message-State: APjAAAXzn/X2JI7Z4hNDcIFoaI3ReFQBH4O/+qUDHraV9kHeN0M4xGjT
        TKQKnryO+kcZbNsb2ekAL3YlmmYUSJwODeUrhxUAWg==
X-Google-Smtp-Source: APXvYqzs8ceRiBPVCP0/ZNbxEA4UnFKcvpd7xrewIhVU8YRDsflFexOmJryKOoBp0Jc/l+FQYkc1LTc/4YkcSZfr40I=
X-Received: by 2002:a02:b782:: with SMTP id f2mr5637473jam.48.1570043134772;
 Wed, 02 Oct 2019 12:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190927021927.23057-1-weijiang.yang@intel.com> <20190927021927.23057-6-weijiang.yang@intel.com>
In-Reply-To: <20190927021927.23057-6-weijiang.yang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 2 Oct 2019 12:05:23 -0700
Message-ID: <CALMp9eStz-VCv5G60KFtumQ8W1Jqf9bOcK_=KwL1P3LLjgajnQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] kvm: x86: Add CET CR4 bit and XSS support
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 7:17 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
>
> CR4.CET(bit 23) is master enable bit for CET feature.
> Previously, KVM did not support setting any bits in XSS
> so it's hardcoded to check and inject a #GP if Guest
> attempted to write a non-zero value to XSS, now it supports
> CET related bits setting.
>
> Co-developed-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  4 +++-
>  arch/x86/kvm/cpuid.c            | 11 +++++++++--
>  arch/x86/kvm/vmx/vmx.c          |  6 +-----
>  3 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index d018df8c5f32..8f97269d6d9f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -90,7 +90,8 @@
>                           | X86_CR4_PGE | X86_CR4_PCE | X86_CR4_OSFXSR | X86_CR4_PCIDE \
>                           | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
>                           | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
> -                         | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP))
> +                         | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
> +                         | X86_CR4_CET))
>
>  #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
>
> @@ -623,6 +624,7 @@ struct kvm_vcpu_arch {
>
>         u64 xcr0;
>         u64 guest_supported_xcr0;
> +       u64 guest_supported_xss;
>         u32 guest_xstate_size;
>
>         struct kvm_pio_request pio;
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 0a47b9e565be..dd3ddc6daa58 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -120,8 +120,15 @@ int kvm_update_cpuid(struct kvm_vcpu *vcpu)
>         }
>
>         best = kvm_find_cpuid_entry(vcpu, 0xD, 1);
> -       if (best && (best->eax & (F(XSAVES) | F(XSAVEC))))
> -               best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
> +       if (best && (best->eax & (F(XSAVES) | F(XSAVEC)))) {

Is XSAVEC alone sufficient? Don't we explicitly need XSAVES to
save/restore the extended state components enumerated by IA32_XSS?

> +               u64 kvm_xss = kvm_supported_xss();
> +
> +               best->ebx =
> +                       xstate_required_size(vcpu->arch.xcr0 | kvm_xss, true);

Shouldn't this size be based on the *current* IA32_XSS value, rather
than the supported IA32_XSS bits? (i.e.
s/kvm_xss/vcpu->arch.ia32_xss/)

> +               vcpu->arch.guest_supported_xss = best->ecx & kvm_xss;

Shouldn't unsupported bits in best->ecx be masked off, so that the
guest CPUID doesn't mis-report the capabilities of the vCPU?

> +       } else {
> +               vcpu->arch.guest_supported_xss = 0;
> +       }
>
>         /*
>          * The existing code assumes virtual address is 48-bit or 57-bit in the
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ba1a83d11e69..44913e4ab558 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1973,11 +1973,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                      !(guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
>                        guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))))
>                         return 1;
> -               /*
> -                * The only supported bit as of Skylake is bit 8, but
> -                * it is not supported on KVM.
> -                */
> -               if (data != 0)
> +               if (data & ~vcpu->arch.guest_supported_xss)
>                         return 1;
>                 vcpu->arch.ia32_xss = data;
>                 if (vcpu->arch.ia32_xss != host_xss)
> --
> 2.17.2
>
