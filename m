Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D296FC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C28214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569430065;
	bh=ctzzg3cNvcsgUCJ4kjZ68qjc1Xi7whKF3KcSVcFkZMI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=DdyypmGqP7ByPNkV81Kb0QI9VHF8K8zeLHNZJDhjXwgRA3BrvAYWnQs0eb39fmQ7f
	 H7wxoVF2tNFfJDgvJXAoq5w/ssUe+CfSwSBAvfCcjlOde8pAzdUfLXhGZeQj/1hRA4
	 Iv2NMFU0ytfihlRAgXjfgOMa1w7qkTrdgwlrmZ3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502094AbfIYQrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:47:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46127 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392039AbfIYQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:47:44 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so386094ioo.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NkXsROJEqHRyKdQlVbGyAe4U+SjsHNVLF9ZqIX8Inqc=;
        b=cvIb5jN5ZNe3gcMhopMVIXvHGnL0ia+pw5VgYZdzsGtBj2PWdLn+6/6Xk9jV6bzT9o
         h1LVnt9n0pL1jIZHv576RNKWXcxrLcUvyr2BwcIJic2f8GCwC3zB44tI4JW8yP/3Mpu3
         gud32+/+nqFYxOuwA86a4BFK5VZcMfTsermAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NkXsROJEqHRyKdQlVbGyAe4U+SjsHNVLF9ZqIX8Inqc=;
        b=sYGunLcmvqxFIRpZu9wAeKY2s8pfSS2ds83WLJRIL5tl2SHUrGrOtbYc8EIOT88Cf3
         LNaZ+hX1AH4XHBeX1JAxT1W0UnKV2Ky5xegKFCH9wdTqbKGl7A9B56EmHEiMC24scnQ3
         Fh21JGytsFWzuA3QJuU9ntjR+8UjwcRrQ45cJ87d6QMBkQBHpZ2KJ1cES8W9krNR4XPH
         rfjkbjD7nZtw9kYZc+mMc8X6okiMGMBxsJTc008a4IBVGQfJZgT+lXcIPrZB3aPY5Oit
         j10CvOQ/IBBsGvZuMvCz5ARKfOyPs6DlU2H2HGs7OogTlCkwIuF+7JNVw7z068QHRw2z
         sJ3Q==
X-Gm-Message-State: APjAAAWezNeOsvv45mq4nfGJOfxnf19QzuZHTFdKLh1msq15qHEsDdqd
        OnhLQysmJufD6d3O56nJTNqiuASS0YU=
X-Google-Smtp-Source: APXvYqzdSzByx/7StFCVjxm7mpWRvxuckLEoPCZv+n1Qfdo3taMQ72Ag4Z6qoA4O/vT1bqCJUSjskw==
X-Received: by 2002:a5d:8911:: with SMTP id b17mr267767ion.287.1569430063967;
        Wed, 25 Sep 2019 09:47:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s24sm75616iog.26.2019.09.25.09.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 09:47:43 -0700 (PDT)
Subject: Re: [PATCH] selftests: kvm: Fix libkvm build error
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190924201451.31977-1-skhan@linuxfoundation.org>
 <dbfb9d46-488a-b940-c86f-79ad750a324a@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5fecb8a8-8a6a-1e2b-78e3-5660597a02e4@linuxfoundation.org>
Date:   Wed, 25 Sep 2019 10:47:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dbfb9d46-488a-b940-c86f-79ad750a324a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/19 1:48 AM, Paolo Bonzini wrote:
> On 24/09/19 22:14, Shuah Khan wrote:
>> Fix the following build error:
>>
>> libkvm.a(assert.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIC
>>
>> Add -fPIC to CFLAGS to fix it.
> 
> This is wrong, these testcases cannot be position-independent
> executables.  Can you include the failing command line from "V=1"
> output?
> 

You are right. This isn't correct.

> The problem seems to be that these definitions are not working properly:
> 
> no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
>          $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
> 
> LDFLAGS += -pthread $(no-pie-option)
> 

Yup. That is what is happening, when I build using

"make TARGETS=kvm kselftest"

You can see this below:

gcc -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 
-fno-stack-protector -fno-PIE -I../../../../tools/include 
-I../../../../usr/include/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I.. 
-pthread    x86_64/cr4_cpuid_sync_test.c


vs.

Running make in kvm directory:

gcc -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 
-fno-stack-protector -fPIC -fno-PIE -I../../../../tools/include 
-I../../../../usr/include/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I.. 
-pthread  -no-pie   x86_64/cr4_cpuid_sync_test.c

I was playing with both options yesterday and totally confused myself
thinking that adding fPIC helps. It doesn't.

I am looking into this to see how we can make "make kselftest" work.
Once I figure it out, will send v2. I think for some reason in the
failing case, no-pie-option and pgste-option are null strings.

thanks,
-- Shuah
