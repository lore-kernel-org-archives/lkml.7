Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A497EC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894BC2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfGITGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:06:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43108 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfGITGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:06:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so19628310qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 12:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5BEQLx/j9iUYUUOthHrxVyxhb7oPlthNbHALl7L1pMQ=;
        b=MxGwWARuu7Xzi0zD6240qbGirpR/R9x9J7o5YM5P6dGmTgfrfBDaIBP2nG9TNaeC0N
         kid5FaOTkLp2xTaMqagYqysd52QEAWfGWu1NYTRR1HPStXqfNz4JWAkn4Nljmw7EbbAI
         BkhWVB07SaaUreaKpVX0YKP2m7iwEmhnP7C4Or9eSdX7lKPeOwD1KfUU6IjlaXgU1A4k
         C2hqkFaArB9vW9UilX9S54ILV0eMhe33Ps8YBgPjL75nGF4OtX/KcKm48sslaeDQ86qd
         OpHQ2e0885CaJbb82KyoSpu40S5pOD3ez3rBuxgf5JEXGaSZq/8s+yqnjgvC0FAWK6kl
         Qmww==
X-Gm-Message-State: APjAAAV9bxq0oiDpN1tSGqf/2WMwTq+WmBwNPbnQXb4UZes0Flfdtba8
        QBsOCRfArv8iIuJfBQoouUzh19wKuN0=
X-Google-Smtp-Source: APXvYqwNn/o8ArAnGAByvJh0ou5Guy+O49yI3g7QKjHuYiSmHDeAPIPt47grBQnEP3jq1ND1AtAHzw==
X-Received: by 2002:a0c:8a43:: with SMTP id 3mr21585759qvu.138.1562699210756;
        Tue, 09 Jul 2019 12:06:50 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id m10sm6759642qka.43.2019.07.09.12.06.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 12:06:50 -0700 (PDT)
Subject: Re: [PATCH] arm64/sve: fix genksyms generation
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190617104237.2082388-1-arnd@arndb.de>
 <20190617112652.GB30800@fuggles.cambridge.arm.com>
 <CAK8P3a2aJNiLTyfRDqazJa2sAc-Jf-QShSZ7+4-whHSxKbLUVQ@mail.gmail.com>
 <20190617161330.GD30800@fuggles.cambridge.arm.com>
 <CAKv+Gu9Fh3anh6-TeDWZ+pL7rs7EBWZqvLXASRNjicGu7k+WKw@mail.gmail.com>
 <20190617164553.GI30800@fuggles.cambridge.arm.com>
 <20190618120259.GA31041@fuggles.cambridge.arm.com>
 <CAK8P3a2NQSm3sPcJq=6=Espa5da_L+2RNtyS=jkkzD3tx-4ehA@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <95d721d1-2ccc-321c-f688-15e5bb53c30b@redhat.com>
Date:   Tue, 9 Jul 2019 15:06:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2NQSm3sPcJq=6=Espa5da_L+2RNtyS=jkkzD3tx-4ehA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/19 10:15 AM, Arnd Bergmann wrote:
> On Tue, Jun 18, 2019 at 2:03 PM Will Deacon <will.deacon@arm.com> wrote:
>>
>>  From 6e004b8824d4eb6a4e61cd794fbc3a761b50135b Mon Sep 17 00:00:00 2001
>> From: Will Deacon <will.deacon@arm.com>
>> Date: Tue, 18 Jun 2019 12:56:49 +0100
>> Subject: [PATCH] genksyms: Teach parse about __uint128_t built-in type
>>
>> __uint128_t crops up in a few files that export symbols to modules, so
>> teach genksyms about it so that we don't end up skipping the CRC
>> generation for some symbols due to the parser failing to spot them:
>>
>>    | WARNING: EXPORT symbol "kernel_neon_begin" [vmlinux] version
>>    |          generation failed, symbol will not be versioned.
>>    | ld: arch/arm64/kernel/fpsimd.o: relocation R_AARCH64_ABS32 against
>>    |     `__crc_kernel_neon_begin' can not be used when making a shared
>>    |     object
>>    | ld: arch/arm64/kernel/fpsimd.o:(.data+0x0): dangerous relocation:
>>    |     unsupported relocation
>>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Looks good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I've added this to my randconfig build setup, replacing my earlier
> patch, and will let you know if any problems with it remain.
> 
>           Arnd
> 

I just hit this on 5ad18b2e60b75c7297a998dea702451d33a052ed on Linus'
branch. The fix works for me (feel free to add Tested-by). Is this
already queued up for Linus?

Thanks,
Laura
