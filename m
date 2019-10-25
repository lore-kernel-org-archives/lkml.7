Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34A221D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504013AbfJYMCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38047 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502539AbfJYMCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:02:23 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51DF677323
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:02:23 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id a81so1019212wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nhnGjNYl34BBej/G9IX/zdJYT44shCWthBnaow9hDa0=;
        b=g1dYTTVYRlnM/iM+4jeX+Texf207jbABhAVpIVBEM0bUS1amuF+SwiFxzyPIo06r0k
         kBLeYgPQwodexL9mNJR2gqAfUO8ZkBoE3ekTlCsYu11kczxcBMm7WtfIqrl85ybkwklh
         YziFODkSWJpGRmJ/36LNjiakX6IOiHKBCLb5ZZmgnIUIRqcVjh0HETOjAbIEI//pCpU4
         iSMQUVPLbP0w7xFacXoeu2E/q+jFI3RaqZBpgc1kJBVVfqLFDxKuKN/LUF3gHpGOXblh
         kpiBrk74G3pTOgQfYtxk+n/fJf8sgtipHAq0fnYQXZq1jsa8YeuMSEEfcTe0DTDHmK0A
         m5Iw==
X-Gm-Message-State: APjAAAVC6rl1nRsCfhAxrHh3Rd7UFVmAO37grmJI0SWG7mpI1mVCbeAi
        o2fv37SDKbuhOIliH/6U9yqb9STY4psH7igYFx/9lw9K1R3BpdxY+OxXtlCfF2pLgr7JmdAYMGA
        WqEgv4befRTQX9VsGkREGOepg
X-Received: by 2002:a1c:9847:: with SMTP id a68mr3155391wme.18.1572004941654;
        Fri, 25 Oct 2019 05:02:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwsMVOR60a0YiZNHpidmA8uSmWVIC5eakJiKfRUewwkkwxWAf6JFvuj/ZwuF4qfke5tp78TQ==
X-Received: by 2002:a1c:9847:: with SMTP id a68mr3155367wme.18.1572004941369;
        Fri, 25 Oct 2019 05:02:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9c7b:17ec:2a40:d29? ([2001:b07:6468:f312:9c7b:17ec:2a40:d29])
        by smtp.gmail.com with ESMTPSA id 79sm2637628wmb.7.2019.10.25.05.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 05:02:20 -0700 (PDT)
Subject: Re: [PATCH] x86/kvm: Fix -Wmissing-prototypes warnings
To:     wang.yi59@zte.com.cn, kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn
References: <201910250958273740534@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <07bbeb02-e8fe-36d5-a761-402a48fe076f@redhat.com>
Date:   Fri, 25 Oct 2019 14:02:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201910250958273740534@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.  It may not appear on git.kernel.org until after KVM
Forum though.

Paolo

On 25/10/19 03:58, wang.yi59@zte.com.cn wrote:
> Gentle Ping :)
> 
>> We get two warning when build kernel with W=1:
>> arch/x86/kernel/kvm.c:872:6: warning: no previous prototype for ‘arch_haltpoll_enable’ [-Wmissing-prototypes]
>> arch/x86/kernel/kvm.c:885:6: warning: no previous prototype for ‘arch_haltpoll_disable’ [-Wmissing-prototypes]
>>
>> Including the missing head file can fix this.
>>
>> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
>> ---
>>  arch/x86/kernel/kvm.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index e820568..32ef1ee 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -33,6 +33,7 @@
>>  #include <asm/apicdef.h>
>>  #include <asm/hypervisor.h>
>>  #include <asm/tlb.h>
>> +#include <asm/cpuidle_haltpoll.h>
>>
>>  static int kvmapf = 1;
> 
> 
> ---
> Best wishes
> Yi Wang
> 

