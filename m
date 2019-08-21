Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E151C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B85A22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfHURGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:06:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfHURGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:06:15 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0530511A04
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 17:06:15 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r9so1434757wme.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 10:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W24D/eGxTc+6J2y3EbaYEs8JehLWl+BD786rxzrTCtM=;
        b=TdQQ4lUS1tiZcZkeg9c2fhjbmdUlzBXvxgwhBtAObXJs2pDGZiWYSP7x+YlWT1sejo
         D758AJKXgn1aH44lqFdgFHTE7NFsakOC3Mi106HdVJwYghJ4ewrKq1ILv9DmQlFsMoWe
         2fZ5kzrZW0eFvY8mUUT0eFd1pfdswX8OVVv3ok7wHdOHOvf+qeu+lGBvhCk8Va9ouv+t
         sGKznIn4oo4CTyStj0wChbZPEYXW7PYIkyEhMZrI0FpmVivCkbsQyusa23FS2EYNbe0a
         gip+3DXOw95gPi/vKrq+Fd05QcDAIfRiLNbM3nQnb6T8KBtljYbh8HKYBeLXY7h8fJFR
         O+Tg==
X-Gm-Message-State: APjAAAUFcLR6FE2fibMLhJhSDtxJQnkAzm2c+4yzrfqz2nvgjU0Vf2qm
        KiuiLNWWqANlOkXwKNX3fvzm82go4fSXRrvsSWSjk3qqaYfCfF+TqTnAtkm1HA+vTIt1LxphFJf
        v4EM4xgAXongUHVBPINrV3GhP
X-Received: by 2002:a05:600c:d9:: with SMTP id u25mr1230374wmm.26.1566407173632;
        Wed, 21 Aug 2019 10:06:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwuQfx1XaberyFNitFoFJZeqA2WoDq201lvGolt2CImLLnqThhrovfYHtbz1QDSuPhoyHzTsA==
X-Received: by 2002:a05:600c:d9:: with SMTP id u25mr1230352wmm.26.1566407173334;
        Wed, 21 Aug 2019 10:06:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3? ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
        by smtp.gmail.com with ESMTPSA id a19sm68979449wra.2.2019.08.21.10.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 10:06:12 -0700 (PDT)
Subject: Re: [PATCH] selftests/kvm: make platform_info_test pass on AMD
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190610172255.6792-1-vkuznets@redhat.com>
 <87a7c2qz1x.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <023eb523-9767-3239-b6eb-cba3769bbd0f@redhat.com>
Date:   Wed, 21 Aug 2019 19:06:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87a7c2qz1x.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/19 18:10, Vitaly Kuznetsov wrote:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> 
>> test_msr_platform_info_disabled() generates EXIT_SHUTDOWN but VMCB state
>> is undefined after that so an attempt to launch this guest again from
>> test_msr_platform_info_enabled() fails. Reorder the tests to make test
>> pass.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  tools/testing/selftests/kvm/x86_64/platform_info_test.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/x86_64/platform_info_test.c b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
>> index 40050e44ec0a..f9334bd3cce9 100644
>> --- a/tools/testing/selftests/kvm/x86_64/platform_info_test.c
>> +++ b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
>> @@ -99,8 +99,8 @@ int main(int argc, char *argv[])
>>  	msr_platform_info = vcpu_get_msr(vm, VCPU_ID, MSR_PLATFORM_INFO);
>>  	vcpu_set_msr(vm, VCPU_ID, MSR_PLATFORM_INFO,
>>  		msr_platform_info | MSR_PLATFORM_INFO_MAX_TURBO_RATIO);
>> -	test_msr_platform_info_disabled(vm);
>>  	test_msr_platform_info_enabled(vm);
>> +	test_msr_platform_info_disabled(vm);
>>  	vcpu_set_msr(vm, VCPU_ID, MSR_PLATFORM_INFO, msr_platform_info);
>>  
>>  	kvm_vm_free(vm);
> 
> Ping!
> 

Queued, thanks.

Paolo
