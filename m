Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D412206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us+uzDqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLJIXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:23:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37818 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfLJIXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:23:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so1714618plz.4;
        Tue, 10 Dec 2019 00:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hmr8rjn6U3tumEScYIjT/0XkqE121FE3es2/36sADFE=;
        b=Us+uzDqVf20qnBiT2ZqtcM2CVaucGD8IMZvxe1CItqcingDyyT1WkEEPJRfgGC5Gz8
         dDnY8K1lJqs1cm1JhdMo7wNVOtjb2rkEIih4VNnLvZHV6uRCpixyB++HrRc9eqMdZ/fr
         doUV7kAyazpljj4/M9ryYE5YcNt1AJB9lrhYaywbGCawWw2chRVPPzo1PreZCnjo4jO6
         U9+1/ZlCYen0F6trcfhcAmKQUz/v3fLQ97jHwsAF6qjmp+O7TGHNP/fX5/Dk/nHT1gHZ
         gKutat4kfaIPbzIBf+QzMs56uLfj5IsRnpeBdwABG3KgfNo+AxnqQMUMR2ws0sgupkxX
         mgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hmr8rjn6U3tumEScYIjT/0XkqE121FE3es2/36sADFE=;
        b=g+SrgxCfr9YwWuq3R6dezFdiN+xSAAoN05Q3qECFSgooLPTmVWNQC1W89KoKXHpJVT
         jPQcCKSisgEvog2Qb/suI5fMopybXGjd+JaDM42dJyA7o2Dfbv0ctTBnIye5qwHHC5Sw
         TTgsx7yG+1tWLRwXyrN7wQGQxM7ZN8XKMr1Ty2MEsrcDazixQcuZg71NSzRvCowOakXB
         bNCle/jUNe3gkQU+oAhENSMPxAcXXa44jq59jXNuMrmbhaz/dRLNn++zhUlSATuWuiZZ
         8sw43Hs9e2F0qsR/hg3YNTf4upCaGKXsPXfnY5zaXkQdNvmXe1RpsLhGLUvhX413wN5v
         Agzg==
X-Gm-Message-State: APjAAAWHYO3cTFHhzwwIht6He5WlKQoVGVdqId6YnQtMAtu67CZCoY8N
        IjROgaB54JTFU0+sfPX4TIBLAEDv
X-Google-Smtp-Source: APXvYqyZVVCLCPAfclKFq8vb588kB2D6CN1HFfBPllKWqPb9k3iMVnU1IsZUQQKz0876hmAQ7MrWdw==
X-Received: by 2002:a17:902:7045:: with SMTP id h5mr34584616plt.245.1575966232501;
        Tue, 10 Dec 2019 00:23:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 200sm2228277pfz.121.2019.12.10.00.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 00:23:50 -0800 (PST)
Subject: Re: [PATCH] hexagon: io: Define ioremap_uc to fix build error
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Brian Cain <bcain@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tuowen Zhao <ztuowen@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
References: <20191204133328.18668-1-linux@roeck-us.net>
 <CAMuHMdXwJUzuSNS7CBpU5J6ofOZGrWMStJU9VaT2gp3m5U5=Lw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <42cb2e14-a2d7-8e53-509f-da201f0624a0@roeck-us.net>
Date:   Tue, 10 Dec 2019 00:23:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXwJUzuSNS7CBpU5J6ofOZGrWMStJU9VaT2gp3m5U5=Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 12:09 AM, Geert Uytterhoeven wrote:
> On Wed, Dec 4, 2019 at 2:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> ioremap_uc is now mandatory.
>>
>> lib/devres.c:44:3: error: implicit declaration of function 'ioremap_uc'
>>
>> Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
>> Cc: Tuowen Zhao <ztuowen@gmail.com>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   arch/hexagon/include/asm/io.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
>> index 539e3efcf39c..39e5605c5d42 100644
>> --- a/arch/hexagon/include/asm/io.h
>> +++ b/arch/hexagon/include/asm/io.h
>> @@ -173,7 +173,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
>>
>>   void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
>>   #define ioremap_nocache ioremap
>> -
>> +#define ioremap_uc ioremap
>>
>>   #define __raw_writel writel
> 
> Do we really need this? There is only one user of ioremap_uc(), which
> Christoph is trying hard to get rid of, and the new devres helper that
> triggers all of this :-(
> https://lore.kernel.org/dri-devel/20191112105507.GA7122@lst.de/
> 


One may ask why we needed a devres helper in the first place if there
is indeed just one user.

Either case, I don't really care, as long as the problem is fixed.

Guenter
