Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32DBC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15A422BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389509AbfGYPrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:47:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33315 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGYPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:47:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so51407469wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 08:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8E/W+J79L+KYsv7Uh31e54tPI2Vvux5yVJ3FL+wNPf4=;
        b=cdm5O5Glrfb1dTOYT/OZVJwMiDENIt4q6NcnGFrmHrguO2l8ZvuseHdXs4xQabNrRY
         owV4Ct3etLzjzDPvoiSMdh+fy2LqXkqyweQEDLb79CDNcxX9LEZ5wcoO3/8BIy7R2L5S
         0TeG1xEzo9fhENFT6s8UivmEKbcsTHqZ9u+Fl0yxQzh0P/q+9TpqEWxiy6KwQ909hyk8
         vzK+Z2QVk3CdkxwfB1OslNzHX0fT5b1/1VkiKqaYGkM8UtmP+0fNV5UdzOMl/QcJskSr
         o19VfNl67iN8wZjMGVHsqBHNxZjNIorYOsZS0kKyQHBOW8pLp88tEEdwZwqbdKcL6us9
         ZjHw==
X-Gm-Message-State: APjAAAW1k2/WY6T6FeYZgsGDS98wQ47lXFPBYdrBqv6ndj8Utbksipv6
        CNyHAXFYhJhY+KyqWMKrf0flEQ==
X-Google-Smtp-Source: APXvYqx8F4rl5cD7W/KK+pbOY5/EcnFeHrrid7MBUlv1f7jQoc3usw2wMBNEimIgXyzH9Mg8NMGD3g==
X-Received: by 2002:adf:f046:: with SMTP id t6mr10549790wro.307.1564069664285;
        Thu, 25 Jul 2019 08:47:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee? ([2001:b07:6468:f312:cc23:f353:392:d2ee])
        by smtp.gmail.com with ESMTPSA id n5sm38864628wmi.21.2019.07.25.08.47.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 08:47:43 -0700 (PDT)
Subject: Re: [PATCH stable-5.2 0/3] KVM: x86: FPU and nested VMX guest reset
 fixes
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, stable@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190725120436.5432-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5c3736e4-4987-5396-c3a7-c5c97241eb2d@redhat.com>
Date:   Thu, 25 Jul 2019 17:47:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725120436.5432-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/19 14:04, Vitaly Kuznetsov wrote:
> Few patches were recently marked for stable@ but commits are not
> backportable as-is and require a few tweaks. Here is 5.2 stable backport.
> 
> [PATCHes 2/3 of the series apply as-is, I have them here for completeness]
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
