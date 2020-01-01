Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B02EC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 17:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1885207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 17:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5h4TOkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgAAR2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 12:28:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38452 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgAAR2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 12:28:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so20985636pfc.5;
        Wed, 01 Jan 2020 09:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AD/HrvCXyBMqbCwXJfBLDLjC/lvvltW4aPvXtIv1Yqs=;
        b=k5h4TOkXEPAuus8ebUkfM3bpTWC8rhbM8RwQAp36f4fxlSuQmB1EX2eguHlk7MfIox
         RfJHvtExPm02S0dhTZzE6Tm48XRko/uogUBUtgkxS8nXbJy75CEtCUlIZwN2OCcQg7wJ
         m7Q62iwFTsKFrNC6KgGOPrqCw4R7B7mriedPKgeJDWXHv96bnfZtn6m450wX0e8WyNCh
         3Z7JHWMimB0XD2pBGo/9EIpZOcrGX6MgMOd5s2XZ1yRVb5X0Rtmo6Ggq51nn7BAZpxYJ
         3ZLy/0T5W/ZYUnRI77ZZ4P+okOhxFTJTxEYbh8508lyfPCb6HdgZZs4KdnXmqmo2Uk+H
         GPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AD/HrvCXyBMqbCwXJfBLDLjC/lvvltW4aPvXtIv1Yqs=;
        b=TdfqMKnNsux+2+GO8Qg2PtJcSNM2IuPl/BkR2vU0g3lnABurBcFvpnWfWriGnIE005
         qArLR4ixnfnEOTnPvX3qPlE1VRzkXmos3KVpLmicXGpjOtCY/A1Qe8TxaiXxbPuyBRAy
         qOa09iTkjbJBqBZ1NjZrkyZTy1b2/lZwlKo0s72dLtOSwENWAMMHwA9eDYfKerkSJPlH
         oRfinweRgaLOxe+gr96b8qbFyA7iO9ZLm312dwHXEEDWQNWT6rkQEzjfv3lze4cdsVAc
         gcfAUtM8CM7PYWWIR6XVAhnglf6yEqN4k+ndUpyB8GDjos70RDTkPUZVhIbpL+fzDXVZ
         90TA==
X-Gm-Message-State: APjAAAWC0t7aVAkOHZEsQrfveazc4dzH6Y6NJoCfZoqGrTHZCKMQoJX1
        GhSskeQ9jiz/m7SjrwcQkhGosSgr
X-Google-Smtp-Source: APXvYqz9PEBoBd0OpMuGUmgPrLJT9jC4D0bs7i4pk7nhL338o1SZUujoVSXYC5ycmEUE55Suj3C7ZQ==
X-Received: by 2002:aa7:988e:: with SMTP id r14mr85400862pfl.126.1577899711919;
        Wed, 01 Jan 2020 09:28:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g2sm47510736pgn.59.2020.01.01.09.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2020 09:28:30 -0800 (PST)
Subject: Re: [PATCH 4.19 000/219] 4.19.92-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, mpe@ellerman.id.au,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191229162508.458551679@linuxfoundation.org>
 <20191230171959.GC12958@roeck-us.net> <20191230173506.GB1350143@kroah.com>
 <7c5b2866-39d9-5c5f-0282-eef2f34c7fe8@roeck-us.net>
 <20200101162413.GA2682113@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5454eee6-a94b-9254-512e-e8e685778b26@roeck-us.net>
Date:   Wed, 1 Jan 2020 09:28:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200101162413.GA2682113@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/20 8:24 AM, Greg Kroah-Hartman wrote:
> On Tue, Dec 31, 2019 at 06:01:12PM -0800, Guenter Roeck wrote:
>> On 12/30/19 9:35 AM, Greg Kroah-Hartman wrote:
>>> On Mon, Dec 30, 2019 at 09:19:59AM -0800, Guenter Roeck wrote:
>>>> On Sun, Dec 29, 2019 at 06:16:42PM +0100, Greg Kroah-Hartman wrote:
>>>>> This is the start of the stable review cycle for the 4.19.92 release.
>>>>> There are 219 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Tue, 31 Dec 2019 16:17:25 +0000.
>>>>> Anything received after that time might be too late.
>>>>>
>>>> Build results:
>>>> 	total: 156 pass: 141 fail: 15
>>>> Failed builds:
>>>> 	i386:tools/perf
>>>> 	<all mips>
>>>> 	x86_64:tools/perf
>>>> Qemu test results:
>>>> 	total: 381 pass: 316 fail: 65
>>>> Failed tests:
>>>> 	<all mips>
>>>> 	<all ppc64_book3s_defconfig>
>>>>
>>>> perf as with v4.14.y.
>>>>
>>>> arch/mips/kernel/syscall.c:40:10: fatal error: asm/sync.h: No such file or directory
>>>
>>> Ah, will go drop the offending patch and push out a -rc2 with both of
>>> these issues fixed.
>>>
>>>> arch/powerpc/include/asm/spinlock.h:56:1: error: type defaults to ‘int’ in declaration of ‘DECLARE_STATIC_KEY_FALSE’
>>>> and similar errors.
>>>>
>>>> The powerpc build problem is inherited from mainline and has not been fixed
>>>> there as far as I can see. I guess that makes 4.19.y bug-for-bug "compatible"
>>>> with mainline in that regard.
>>>
>>> bug compatible is fun :(
>>>
>>
>> Not really. It is a terrible idea and results in the opposite of what I would
>> call a "stable" release.
>>
>> Anyway, turns out the offending commit is 14c73bd344d ("powerpc/vcpu: Assume
>> dedicated processors as non-preempt"), which uses static_branch_unlikely().
> 
> It does?  I see:
> 
> +               if (lppaca_shared_proc(get_lppaca()))
> +                       static_branch_enable(&shared_processor);
> 
>> This function does not exist for ppc in v4.19.y and v5.4.y. Thus, the _impact_
>> of the error in v4.19.y and v5.4.y is the same as in mainline, but the _cause_
>> is different. Upstream commit 14c73bd344d should not have been applied to
>> v4.19.y and v5.4.y and needs to be reverted from those branches.
> 
> I'll go revert this patch, but as it was marked for stable by the
> authors of the patch, as relevant back to 4.18, I would have hoped that
> they knew what they were doing :)
> 

I probably didn't have enough champagne last night when I wrote my previous e-mail.
No, the problem is the same as with the upstream kernel, so feel free to drop
the revert if you prefer "bug-for-bug compatibility". Given where we are, that
is probably better than dropping the patch and re-applying it after its fix
is available.

The underlying problem is that the offending patch introduces the use of
jump label code into arch/powerpc/include/asm/spinlock.h without including
linux/jump_label.h. Depending on the configuration, this results in the observed
build errors.

Patches were submitted upstream to fix the problem, but the fix has not been
applied to mainline, and I don't see a maintainer reaction. Maybe everyone
is off for the holidays.

https://patchwork.ozlabs.org/patch/1215380/
https://patchwork.ozlabs.org/patch/1214954/

Guenter
