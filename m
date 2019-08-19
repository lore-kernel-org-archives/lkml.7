Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A55C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2C1206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfHSPlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:41:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfHSPlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:41:23 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 966D111A13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:41:22 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id h3so5432186wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+2urDoQQb7wRsJCEAVPq+MCyS4Og2E5SQlROH1kJHAg=;
        b=blz9RNQgrerI6wZ24mCKd5h5OXU+laQTDCWK3gEANRr8o7YB6tl6cRtotzyj1USNnA
         RnH2zG8lTHuzCABLAtjAbDdbIU0KdRYsvirY3Uzx3Qkbj0iVKn2aJ7LIgpad+mPqSTIK
         bboF21nI5ptMrcC2KBQq6zVdFfkUW8Z6ET3QoBVNkrh7Yvt7/ANK5e7hQlyKI6XfvKwM
         WnS8AtnLUPIWr8RJBrghCbox1Zs/KaDBvpAKJZGfui2TyztJQFFaizKOWkitGX7zVua/
         5b/JjqZezJ3gNZvngvLiYrsWRW0t5F2AJ98zWKSqm0QbtQUwUuN0VIrfXIkWXN8vm1CE
         tbtQ==
X-Gm-Message-State: APjAAAVj3MWX6j/HSp8ajwrmV1mYSi4p4hw7KDlPfYqpJ59qlo0Cfnk7
        XJpse21CoYF3wOjpN6R/Sw7U9V2IBn8cvb5bShhbHHwtMk/24f+oKbnHW5kltL6kNQzxti9sKKr
        frB7DHL9wsXUsCuBOFyhgZ6Ix
X-Received: by 2002:a7b:cbd3:: with SMTP id n19mr16884020wmi.112.1566229281277;
        Mon, 19 Aug 2019 08:41:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXrtziC4pwiiWc6YsHWf6HCM+IBZ85DkcjdCrraoIwl47e8rYcjXkU8W3v5tXs0TOBf6XFbA==
X-Received: by 2002:a7b:cbd3:: with SMTP id n19mr16883981wmi.112.1566229280992;
        Mon, 19 Aug 2019 08:41:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f? ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
        by smtp.gmail.com with ESMTPSA id e15sm7249653wrj.74.2019.08.19.08.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:41:20 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86: always expose VIRT_SSBD to guests
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <1565854883-27019-1-git-send-email-pbonzini@redhat.com>
 <1565854883-27019-3-git-send-email-pbonzini@redhat.com>
 <20190815171454.GV3908@habkost.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dadab484-68f8-1588-534b-c2a90c3b7fe4@redhat.com>
Date:   Mon, 19 Aug 2019 17:41:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815171454.GV3908@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/19 19:14, Eduardo Habkost wrote:
> On Thu, Aug 15, 2019 at 09:41:23AM +0200, Paolo Bonzini wrote:
>> Even though it is preferrable to use SPEC_CTRL (represented by
>> X86_FEATURE_AMD_SSBD) instead of VIRT_SPEC, VIRT_SPEC is always
>> supported anyway because otherwise it would be impossible to
>> migrate from old to new CPUs.  Make this apparent in the
>> result of KVM_GET_SUPPORTED_CPUID as well.
>>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  arch/x86/kvm/cpuid.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 145ec050d45d..5865bc73bbb5 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -747,11 +747,13 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>>  		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
>>  		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
>>  		/*
>> -		 * The preference is to use SPEC CTRL MSR instead of the
>> -		 * VIRT_SPEC MSR.
>> +		 * VIRT_SPEC is only implemented for AMD processors,
>> +		 * but the host could set AMD_SSBD if it wanted even
>> +		 * for Intel processors.
>>  		 */
>> -		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
>> -		    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
>> +		if ((boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
>> +		     boot_cpu_has(X86_FEATURE_AMD_SSBD)) &&
>> +		    boot_cpu_has(X86_FEATURE_SVM))
> 
> Would it be desirable to move this code to
> svm_set_supported_cpuid(), or is there a reason for keeping this
> in cpuid.c?

Yes, of course.  Forgot about it.

Paolo

