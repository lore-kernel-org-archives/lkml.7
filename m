Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8441FC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5288B2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfGDMPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:15:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51415 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfGDMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:15:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so5548289wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 05:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8JdSYBAH2R4iWrp9AtOPbWAInLP5rvqtz8MW15QLPWQ=;
        b=e/4C/p8VgEsri8UBrfvL42COuywMwjca7YzUAzsBinb3fQs+VanVfain93vj0z05z4
         RYuP6V3Tri/FV6fJfAdEL6jhI+trqRSM/vJEZME/YuRDw0mmAHAXrSrF4PAV/Um+co4g
         TOIYeH9G4mU7VKhG8rUlqnLeazedC66vhRX8omJaUWC70DZBZ8DUxyFpu8fXQa9j6B0s
         tPVA1G5UzhOpZd4dVD/uE2MmvBY4AmYPUhxd5fhvl6u0i4Xg6eIqI45w7oCOn/ilw3k7
         fnxmSnzXh/ZPrmz/DzsOrSj7ypGiDH8VzkLpVOEC5kvNauMVQMdiIoqcQuyIayfwEgrv
         z5oQ==
X-Gm-Message-State: APjAAAWt4Yvd19fcR6z5F5hETHgdPYxQS1UQm/jPw6mbm6BHPmA149zh
        lpoTHgvEd+wAbzAstdhyY2MK3g==
X-Google-Smtp-Source: APXvYqy/XHnwIGPw3Dn1ZxQ7L3TYQ6Pb9iT7u8RaTpass6DNag8j7SGxnuaZVAoXb/QEGM7J2cMXWg==
X-Received: by 2002:a7b:cb94:: with SMTP id m20mr11914655wmi.144.1562242515927;
        Thu, 04 Jul 2019 05:15:15 -0700 (PDT)
Received: from [10.201.49.68] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id n14sm11624948wra.75.2019.07.04.05.15.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 05:15:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] kvm: x86: add likely to sched_info_on()
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        xue.zhihong@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn
References: <1562240775-16086-1-git-send-email-wang.yi59@zte.com.cn>
 <1562240775-16086-2-git-send-email-wang.yi59@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <59ce6a26-f35f-8bb9-7392-13bcce6434e3@redhat.com>
Date:   Thu, 4 Jul 2019 14:15:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562240775-16086-2-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/19 13:46, Yi Wang wrote:
> The condition to test is likely() to be true when make defconfig.
> Add the hint.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 4992e7c..64fff41 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -642,7 +642,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT) |
>  			     (1 << KVM_FEATURE_PV_SEND_IPI);
>  
> -		if (sched_info_on())
> +		if (likely(sched_info_on()))
>  			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);

This is not a fast path, so adding likely/unlikely is unnecessary.

Paolo

>  		entry->ebx = 0;
> 

