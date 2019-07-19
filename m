Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92647C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D4021849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="0EAYC1tR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGSAKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:10:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44540 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfGSAKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:10:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so13324974pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fFoYMXbgkLyImkyiPR85e/LWs0d1ApwxQXfa0WN+oEE=;
        b=0EAYC1tRo8ME/2G3iSq7FtnpcVhybbdcYHddpWCWAeLXa3tjYucjA+Q9MWulSm2IN3
         D6/8c2bYhweapxKcISQ+gOB5YdefwYGDQ7B/RiSY52fgUtMzMRIs5NXU9KCf20n/tPao
         Y/giYLnCqn1V/kbTF8RW1bmqRaxOkBHfvtGWrrWwp01Z1PnVShxZRXV2M66SKXWUDetE
         qjz+q+GdhQ+4oaO4BnwtVFbcv1BtxK+7Z/ni5LEcjO+rYWxMI7awKaJZoGOEFBsDy3lY
         BNLt90jcY885u2imdndNgrJsgmvu/1n8E0+JR8Ywb47x/TIAc5QvDPsbnZl/EJ+cCabk
         Ytlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fFoYMXbgkLyImkyiPR85e/LWs0d1ApwxQXfa0WN+oEE=;
        b=LyFP1n9euxLSR/FFYDAsvSVLw15e25U7+Pilwgej09joizA3X/iOZLdjIN0CvAqF4J
         ZoJgmxQZhjHWC84T7MHEb1nQlW7JjsNRb8QqIWnBQT5D0f5eS/wusHkxiXIB8yidp1gd
         6vh/vOB3yiPjmjgmGK2aV5SRUtPOrNM14t1AigNovmoUMkw56zGelj2priTmT8Z3lL66
         zsTgE8n02V1lmBDuOVF0i5MYk8C5kfq2slp51csOz7l5rB5X7Ri69Ly/2VLwIEz2H3RS
         CnDSGEarLVzYXxhVTt/XsAmV3Uc23+5QQmfUk5nKnXbyDJEb/uYUtAl+jdnmFjybzodm
         //pg==
X-Gm-Message-State: APjAAAUvVs5Yek+HysEw+0E8L8kfuC3IjVD6eqNfLj6QOtpSznqnA9+d
        Fq6KQjMb5pC82HuEtdghLYg=
X-Google-Smtp-Source: APXvYqzpYHWrPvsO31+ael8IJn2Nps6aYiIVECtFcMVCZg+Aa+th0QJmhwSh9oqlQafyybQhD/Vgkw==
X-Received: by 2002:a63:f941:: with SMTP id q1mr51054323pgk.350.1563495002829;
        Thu, 18 Jul 2019 17:10:02 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id f12sm25771388pgo.85.2019.07.18.17.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 17:10:01 -0700 (PDT)
Subject: Re: [PATCH v2 03/13] powerpc/prom_init: Add the ESM call to prom_init
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>
References: <20190713060023.8479-1-bauerman@linux.ibm.com>
 <20190713060023.8479-4-bauerman@linux.ibm.com>
 <70f8097f-7222-fe18-78b4-9372c21bfc9d@ozlabs.ru>
 <20190718195850.GU20882@gate.crashing.org>
 <875znz3ud7.fsf@morokweng.localdomain>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f4cba627-8c40-ce95-0ede-b01edf3546dc@ozlabs.ru>
Date:   Fri, 19 Jul 2019 10:09:56 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <875znz3ud7.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/2019 07:28, Thiago Jung Bauermann wrote:
> 
> Hello Segher,
> 
> Thanks for your review and suggestions!
> 
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> 
>> (Sorry to hijack your reply).
>>
>> On Thu, Jul 18, 2019 at 06:11:48PM +1000, Alexey Kardashevskiy wrote:
>>> On 13/07/2019 16:00, Thiago Jung Bauermann wrote:
>>>> From: Ram Pai <linuxram@us.ibm.com>
>>>> +static int enter_secure_mode(unsigned long kbase, unsigned long fdt)
>>>> +{
>>>> +	register uint64_t func asm("r3") = UV_ESM;
>>>> +	register uint64_t arg1 asm("r4") = (uint64_t)kbase;
>>>> +	register uint64_t arg2 asm("r5") = (uint64_t)fdt;
>>>
>>> What does UV do with kbase and fdt precisely? Few words in the commit
>>> log will do.


What about this one? :)


>>>
>>>> +
>>>> +	asm volatile("sc 2\n"
>>>> +		     : "=r"(func)
>>>> +		     : "0"(func), "r"(arg1), "r"(arg2)
>>>> +		     :);
>>>> +
>>>> +	return (int)func;
>>>
>>> And why "func"? Is it "function"? Weird name. Thanks,
> 
> Yes, I believe func is for function. Perhaps ucall would be clearer
> if the variable wasn't reused for the return value as Segher points out.
> 
>> Maybe the three vars should just be called "r3", "r4", and "r5" --
>> r3 is used as return value as well, so "func" isn't a great name for it.
> 
> Yes, that does seem simpler.
> 
>> Some other comments about this inline asm:
>>
>> The "\n" makes the generated asm look funny and has no other function.
>> Instead of using backreferences you can use a "+" constraint, "inout".
>> Empty clobber list is strange.
>> Casts to the return type, like most other casts, are an invitation to
>> bugs and not actually useful.
>>
>> So this can be written
>>
>> static int enter_secure_mode(unsigned long kbase, unsigned long fdt)
>> {
>> 	register uint64_t r3 asm("r3") = UV_ESM;
>> 	register uint64_t r4 asm("r4") = kbase;
>> 	register uint64_t r4 asm("r5") = fdt;
>>
>> 	asm volatile("sc 2" : "+r"(r3) : "r"(r4), "r"(r5));
>>
>> 	return r3;
>> }
> 
> I'll adopt your version, it is cleaner inded. Thanks for providing it!
> 
>> (and it probably should use u64 instead of both uint64_t and unsigned long?)
> 
> Almost all of prom_init.c uses unsigned long, with u64 in just a few
> places. uint64_t isn't used anywhere else in the file. I'll switch to
> unsigned long everywhere, since this feature is only for 64 bit.
> 

-- 
Alexey
