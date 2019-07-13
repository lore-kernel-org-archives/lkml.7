Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F7C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC07C20838
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfGMKhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 06:37:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43718 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfGMKhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 06:37:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so12298300wru.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 03:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RIERtSWLuUXYtMroEl+mS0+iuLoYEFR1Z90hq7V+lMw=;
        b=E8ZQ1+gMwgg9EjO5iqTi74uJJ+t9QytMFMlfgfJEsynssbuigPyeLrW41DjtR2n0Gw
         fAs90jK9nlqZK+Z8v6aTuV6KUlDnWlVnPVTv0RiW9TSAbLkp/DS8oGxjwCTSL7whyPmE
         VZY63WInq879WyE6ZZpvqFYqh49mDFNJYc37Cksnrb2h/tiwkTfZVc4CdACwq2EvRODt
         ra5iX5GdY3Ldt1yYRr/TntnWLwJPBYLsOuEe15Yo9ov04CExr5f99dR8S9sp02t+6NSX
         B2Fy2KkEU6rUpEDJCaU5X1cL7OjJrTDBk91BwIz6CsCdEnqQHoWXKXnR0pmtbJHpnH65
         uoVA==
X-Gm-Message-State: APjAAAXOIVp7j8RSroYzX9yC1x4U/vaQd8Oyh+Dfh7BsOVT7D2l2gnRU
        omACQfJ6bQpXe9MM8tvMheN7R+5a580=
X-Google-Smtp-Source: APXvYqwu8+C8A/lDArwKIf94RhR02N1s5AVEtyGqiXPcTEQ7+mjaL0gQcpS8sfYAIu9u8uHS3EzxEQ==
X-Received: by 2002:adf:ba85:: with SMTP id p5mr17109473wrg.146.1563014272538;
        Sat, 13 Jul 2019 03:37:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c1b9:e491:30e8:c02? ([2001:b07:6468:f312:c1b9:e491:30e8:c02])
        by smtp.gmail.com with ESMTPSA id e6sm11836504wrw.23.2019.07.13.03.37.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 03:37:51 -0700 (PDT)
Subject: Re: [PATCH v1] KVM: x86: expose AVX512_BF16 feature to guest
To:     Jing Liu <jing2.liu@linux.intel.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1562824197-13658-1-git-send-email-jing2.liu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <305e2a40-93a3-23ed-71a2-d3f2541e837a@redhat.com>
Date:   Sat, 13 Jul 2019 12:37:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562824197-13658-1-git-send-email-jing2.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/19 07:49, Jing Liu wrote:
> AVX512 BFLOAT16 instructions support 16-bit BFLOAT16 floating-point
> format (BF16) for deep learning optimization.
> 
> Intel adds AVX512 BFLOAT16 feature in CooperLake, which is CPUID.7.1.EAX[5].
> 
> Detailed information of the CPUID bit can be found here,
> https://software.intel.com/sites/default/files/managed/c5/15/\
> architecture-instruction-set-extensions-programming-reference.pdf.
> 
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---
> 
> This patch depends on kernel patch https://lkml.org/lkml/2019/6/19/912
> and Paolo's patch set https://lkml.org/lkml/2019/7/4/468.
> 
>  arch/x86/kvm/cpuid.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 8fc6039..0c125dd 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -358,9 +358,13 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry, int index)
>  		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP) |
>  		F(MD_CLEAR);
>  
> +	/* cpuid 7.1.eax */
> +	const u32 kvm_cpuid_7_1_eax_x86_features =
> +		F(AVX512_BF16);
> +
>  	switch (index) {
>  	case 0:
> -		entry->eax = 0;
> +		entry->eax = min(entry->eax, 1);
>  		entry->ebx &= kvm_cpuid_7_0_ebx_x86_features;
>  		cpuid_mask(&entry->ebx, CPUID_7_0_EBX);
>  		/* TSC_ADJUST is emulated */
> @@ -384,6 +388,12 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry, int index)
>  		 */
>  		entry->edx |= F(ARCH_CAPABILITIES);
>  		break;
> +	case 1:
> +		entry->eax &= kvm_cpuid_7_1_eax_x86_features;
> +		entry->ebx = 0;
> +		entry->ecx = 0;
> +		entry->edx = 0;
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  		entry->eax = 0;
> 

Queued, thanks.

Paolo
