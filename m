Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6713C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8086C22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389550AbfGYPsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:48:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35788 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbfGYPsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:48:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so51337803wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 08:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I4QDjchJ1/9s6J6Y1a0RgnIiWEEdaEcTSin7dYrxSRw=;
        b=IZHZ9F8EViWMc5hFLrRaV/DjjLUbgI8xfwp1iv4xrSvbtRfRIOnmwTqfWBRuv6CcoW
         DFLNtVG8yrXe8NIzPalJnWtD0xpnwaLQoVssMmOg7rO058nexU47tD/kPw9YKZvDsPBu
         iABP7cRcbY/WX1whakCAhSbcAHbEK6qhGcK3hiOgK1lRPGmyqDalE7DRs8QiZn94uKaI
         wcIRfjtMEjZtFwMvNWzvw7rfahDjrUD2MWEGW7fVrcYMdSCLNtoEbsqc1a/kB3UUxr3T
         a/lzB04ELYUTQ94wUXyz2SgLz+glqUHgkvikeiv7+kK+z4fulP1aBAh7musIy8QL55qV
         r7oA==
X-Gm-Message-State: APjAAAWNAirAd4nCBRhDsm/YIco6rAHw57cAWN8DNuU6rJrpxBXFWC8O
        pKPj2mhLZFUyhiRSP9vDpwokOQ==
X-Google-Smtp-Source: APXvYqyX97fVHoHfJDtU+40WfznB31tygbJh3/z14EvSWABjQetB6WlOQaGguH0KUd8uaKnQ79Oh4w==
X-Received: by 2002:adf:e841:: with SMTP id d1mr15978720wrn.204.1564069697484;
        Thu, 25 Jul 2019 08:48:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee? ([2001:b07:6468:f312:cc23:f353:392:d2ee])
        by smtp.gmail.com with ESMTPSA id z7sm47618849wrh.67.2019.07.25.08.48.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 08:48:16 -0700 (PDT)
Subject: Re: [PATCH stable-5.1 0/3] KVM: x86: FPU and nested VMX guest reset
 fixes
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, stable@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190725114938.3976-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <60cb964f-7866-0da7-8ea2-ba51eab7a57c@redhat.com>
Date:   Thu, 25 Jul 2019 17:48:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725114938.3976-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/19 13:49, Vitaly Kuznetsov wrote:
> Few patches were recently marked for stable@ but commits are not
> backportable as-is and require a few tweaks. Here is 5.1 stable backport.
> 
> [PATCH2 of the series applies as-is, I have it here for completeness]
> 
> Jan Kiszka (1):
>   KVM: nVMX: Clear pending KVM_REQ_GET_VMCS12_PAGES when leaving nested
> 
> Paolo Bonzini (2):
>   KVM: nVMX: do not use dangling shadow VMCS after guest reset
>   Revert "kvm: x86: Use task structs fpu field for user"
> 
>  arch/x86/include/asm/kvm_host.h |  7 ++++---
>  arch/x86/kvm/vmx/nested.c       | 10 +++++++++-
>  arch/x86/kvm/x86.c              |  4 ++--
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
