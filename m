Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9567AC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7375921A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfIZLM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:12:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfIZLM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:12:29 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 099E4155E0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 11:12:29 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f63so883907wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 04:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPVi3tI8CEMemOHf/10he6CY8X+DfeIz3MO+IJsehU0=;
        b=jNrvTA8rrWkf+u82f2nAWumDhMh6lmg91/xYy/kTV7bpyA3bwA1Q0QHyxsqKAPRAT6
         9Fx4gEsz5+JOANKrVx5QxhZBiHNjQsz00qJcLAsuqse5C75A7lgik9ZhF96WhB2hPiVU
         tBuduJLZiBjogap0GNYArLnL2AYfFx4UsN3i2c3LXD/0Xp52IzssqTapJxqKBceABDmV
         nykFMShdSawCzwWSP8S8Ua/IYLVmgJbdJ8yZptaehGzcfRhqMv7L5rASym13xzGSv8Br
         teZz8Kpf4W+wvpUn5hPVBz/5eVnK8KucGmde4Jtr4lTJBLGYwG+BLCILZTtzJQ3+kH7o
         umYw==
X-Gm-Message-State: APjAAAU084XJk+SoL7lwVeCcR41ArwzebqQkSRm75jHX4B7e/QVnzgCZ
        3DmCL7okxBM6G3I4UNSaRY5Q3RpAa3iDtkRKRiHIGPWwYtyzfz+IQpSkfFF5LSQTsTYNIYTJRHB
        DzsnL0o2lpa6YPgu4IM6qLm7B
X-Received: by 2002:a7b:cd08:: with SMTP id f8mr2301015wmj.87.1569496347645;
        Thu, 26 Sep 2019 04:12:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYAIxJxco55ohaG5xtpGpLhZETW7NdZfp6F+5aWwyURr6YjlwB8rYcUNivGMCuXE7oSiCKkw==
X-Received: by 2002:a7b:cd08:: with SMTP id f8mr2300996wmj.87.1569496347377;
        Thu, 26 Sep 2019 04:12:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id r18sm1705421wme.48.2019.09.26.04.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:12:26 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86: Expose CLZERO and XSAVEERPTR to the guest
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20190925213721.21245-1-bigeasy@linutronix.de>
 <20190925213721.21245-3-bigeasy@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dedea670-ca42-738e-a5ab-bdf87646fc5f@redhat.com>
Date:   Thu, 26 Sep 2019 13:12:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925213721.21245-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/19 23:37, Sebastian Andrzej Siewior wrote:
> I was surprised to see that the guest reported `fxsave_leak' while the
> host did not. After digging deeper I noticed that the bits are simply
> masked out during enumeration.
> The XSAVEERPTR feature is actually a bug fix on AMD which means the
> kernel can disable a workaround.
> While here, I've seen that CLZERO is also masked out. This opcode is
> unprivilged so exposing it to the guest should not make any difference.
> 
> Pass CLZERO and XSAVEERPTR to the guest if available on the host.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kvm/cpuid.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 22c2720cd948e..0ae9194d0f4d2 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -473,6 +473,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>  
>  	/* cpuid 0x80000008.ebx */
>  	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
> +		F(CLZERO) | F(XSAVEERPTR) |
>  		F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
>  		F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON);
>  
> 

Applied (on top of Jim's CLZERO patch, so removing the CLZERO reference
in the commit message).

Paolo
