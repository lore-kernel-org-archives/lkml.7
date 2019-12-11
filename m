Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42823C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E59824671
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idAqrZS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfLKSYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:24:48 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38800 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLKSYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:24:48 -0500
Received: by mail-il1-f196.google.com with SMTP id f5so1825831ilq.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9tA+Tr9ovbWOXuGiYbM0B2FW2ZyDkx7Yvdcfc6MPLs=;
        b=idAqrZS5yOYwdeK/lgm7YpOyYtpiEJT5h1P6uhhaane+g2Xn7IV2dkSWP53z017gAQ
         /AlG0kqHi/x8IM6vj96WukdMd3t7bSnKbqp5avoga1TPrk8lNOneJRYi9DrVcClaM5rV
         uMgh5WkX8h3tYuTaK69vJOzJm8f0+V4ZPUEOhI47JT+9C8E3vc27FsRZS2QoQ5OC8p33
         kbpTVseXf9aflsmpw57dqgtpsIZKmbXYkuNctxJ6lcFkdTeQNFXDHSSF5LUtNox/2mDw
         OXWH7XGEe8tn/Bqh0f1qD3KYZ0F3d9lblN/7QzTO+cw7ICLs84AwE3dnQQJ8lYLgRFxE
         SRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9tA+Tr9ovbWOXuGiYbM0B2FW2ZyDkx7Yvdcfc6MPLs=;
        b=CtbHxQtbO3Pl77vhvt2ChDsWZfeR3c94n7vQtyUthy6BSh6K3/XAzEs7ZSIUkOEyIV
         DUG1vu25SSVi/XMSuCqb+GM9dyA/nUwjoJ8Ie/qf7EREMFD9sDWRZc5QQVcRkcQiOEtE
         AaiSWZjr+Vf6z1BJZNtE3gtqeYPx82BxfGvrFe3ValyoI85OrAIv/3no3tEAbbXtSbvO
         e5+yaCbRkR+fvNqJflA4COdQ1SLkwY06YgWXTtA5dVEvKR14Suxxd0AUlLSX6AwrCQW4
         3I+cFtOBI3aN7yPx2nmXApG0FxP70dx3F7HuE+aSK+rxsqLM/35FElLPHx3bjs2JfUuS
         2JRA==
X-Gm-Message-State: APjAAAWyaHDUB3TusW+F8KCYUtmygw7L+YDrELtW1nVuBVG1IybW9KBl
        9acTaia7Qv6drQNwjEb7PRziN8t/9LySeqqaHFeE8w==
X-Google-Smtp-Source: APXvYqxOHiPfhWhJpgBQfI8f+K8kysFSEhs5Wj6CkL1K/PdLyHuY9O+4ujMgXwhSuP9+2dxlkR4HblBXuFY0uukuZlg=
X-Received: by 2002:a05:6e02:8eb:: with SMTP id n11mr4519653ilt.26.1576088687084;
 Wed, 11 Dec 2019 10:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20191211175822.1925-1-sean.j.christopherson@intel.com> <20191211175822.1925-2-sean.j.christopherson@intel.com>
In-Reply-To: <20191211175822.1925-2-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 11 Dec 2019 10:24:36 -0800
Message-ID: <CALMp9eR93otezrDot23oODV1S6M9kUAF9oB5UD7+E765cHRXjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: Add build-time assertion on usage of bit()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 9:58 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Add build-time checks to ensure KVM isn't trying to do a reverse CPUID
> lookup on Linux-defined feature bits, along with comments to explain
> the gory details of X86_FEATUREs and bit().
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>
> Note, the premature newline in the first line of the second comment is
> intentional to reduce churn in the next patch.
>
>  arch/x86/kvm/x86.h | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index cab5e71f0f0f..4ee4175c66a7 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -144,9 +144,28 @@ static inline bool is_pae_paging(struct kvm_vcpu *vcpu)
>         return !is_long_mode(vcpu) && is_pae(vcpu) && is_paging(vcpu);
>  }
>
> -static inline u32 bit(int bitno)
> +/*
> + * Retrieve the bit mask from an X86_FEATURE_* definition.  Features contain
> + * the hardware defined bit number (stored in bits 4:0) and a software defined
> + * "word" (stored in bits 31:5).  The word is used to index into arrays of
> + * bit masks that hold the per-cpu feature capabilities, e.g. this_cpu_has().
> + */
> +static __always_inline u32 bit(int feature)
>  {
> -       return 1 << (bitno & 31);
> +       /*
> +        * bit() is intended to be used only for hardware-defined
> +        * words, i.e. words whose bits directly correspond to a CPUID leaf.
> +        * Retrieving the bit mask from a Linux-defined word is nonsensical
> +        * as the bit number/mask is an arbitrary software-defined value and
> +        * can't be used by KVM to query/control guest capabilities.
> +        */
> +       BUILD_BUG_ON((feature >> 5) == CPUID_LNX_1);
> +       BUILD_BUG_ON((feature >> 5) == CPUID_LNX_2);
> +       BUILD_BUG_ON((feature >> 5) == CPUID_LNX_3);
> +       BUILD_BUG_ON((feature >> 5) == CPUID_LNX_4);
> +       BUILD_BUG_ON((feature >> 5) > CPUID_7_EDX);

What is magical about CPUID_7_EDX?

> +
> +       return 1 << (feature & 31);

Why not BIT(feature & 31)?

>  }
>
>  static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
> --
> 2.24.0
>
