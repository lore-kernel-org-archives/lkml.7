Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006AAC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 18:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABC72070D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 18:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBs53eZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfG1SNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 14:13:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41262 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1SNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 14:13:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so26498316pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RIjzwybHVJjj4K9rrnwHbB6apuOFTKW1P0/fQJKLKCM=;
        b=ZBs53eZje1qMfc8h5yZTZ+qg7TYvFOfkRUvww12NSykklV+VTIrR3v94RJHyYWjuoE
         1rnNJ3uPTmbT8E9emHpN0GMsJcIFp+I/mZIiux38gIcZgKlLiAR34Z93+zc5QkkjqnFP
         Kxy3N9EupnyL7CPbFqykn/U0AGyyF0w1xTxWmrU35eqvJQJDxEQ/A+6ph8H65G07KL5d
         fAdt37aX/KUHCuXYgTUd6727Ktj2wU/ZEQ6O0wlgWWCN36a+Sg8yUvj+IdCt5BJbphVg
         3nAVaWiXYpOBXXkoVeGB0zTv+DJXzLITjcl3Uswg0yENWqP0WN5yzGpc4UeIW4wG69DM
         bl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RIjzwybHVJjj4K9rrnwHbB6apuOFTKW1P0/fQJKLKCM=;
        b=ePReo5yqTGQgD1ORw0vDbS7PawNqZN6hBT8FWXl8IBzP6aWmCJkclamHgG+Vlcno/P
         QnMjaOfJ22l5LxL7iFBitJ5e/i/0fXLeeAb9BiKzF0Eas/SaEH0t4Tsd82y46lrcdTZM
         Wtqs2AA3PR9vXBkqMAQPlxA3KhanEJdjT/41BqVxF1inohBYRX2ikt3oezBo2yN3chGW
         pHzxNYVANmmDOhMWUu50QsRjjCOU3eKAuYYqGJWOA+BTzU7Kos8jErfz+GprF+zlDi9g
         mExPWHI+isfEQczGdEx6oZp+h8hHBKFIubKILNT6S4YB6S/SkX1ClZOCsDDUsQOp+8Wl
         nmbg==
X-Gm-Message-State: APjAAAXNmbRnzvN024d8Qy3PfQ6ApzuhgT3cQpZ6gKTBLDINlVf3Dfxw
        U7sjspubDv+xryRW5SMKLzQ=
X-Google-Smtp-Source: APXvYqyNylMC3cYFnsLwDkI4bhujU449ly13dp4OuehK4jbmEphvZXWynmcOFeSDSw8Bxh+b4at/7g==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr111487267plb.25.1564337580732;
        Sun, 28 Jul 2019 11:13:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s11sm56966423pgv.13.2019.07.28.11.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 11:12:59 -0700 (PDT)
Subject: Re: [PATCH] Makefile: Globally enable fall-through warning
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20190728135826.GA10262@roeck-us.net>
 <a0e789dd-5244-6af3-56c2-970b03d264a8@embeddedor.com>
 <20190728171448.GB29181@roeck-us.net>
 <aae318fa-970c-48a6-ac7a-ceb96ef146ee@embeddedor.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c5140ba1-5971-2158-4aaa-5999a66ba0ec@roeck-us.net>
Date:   Sun, 28 Jul 2019 11:12:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <aae318fa-970c-48a6-ac7a-ceb96ef146ee@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/19 10:31 AM, Gustavo A. R. Silva wrote:
> 
> 
> On 7/28/19 12:14 PM, Guenter Roeck wrote:
>> Hi Gustavo,
>>
>> On Sun, Jul 28, 2019 at 11:42:28AM -0500, Gustavo A. R. Silva wrote:
>>> Hi Guenter,
>>>
>>> On 7/28/19 8:58 AM, Guenter Roeck wrote:
>>>> On Thu, Jun 06, 2019 at 07:46:17PM -0500, Gustavo A. R. Silva wrote:
>>>>> Now that all the fall-through warnings have been addressed in the
>>>>> kernel, enable the fall-through warning globally.
>>>>>
>>>>
>>>> Not really "all".
>>>>
>>>> powerpc:85xx/sbc8548_defconfig:
>>>>
>>>> arch/powerpc/kernel/align.c: In function ‘emulate_spe’:
>>>> arch/powerpc/kernel/align.c:178:8: error: this statement may fall through
>>>>
>>>> Plus many more similar errors in the same file.
>>>>
>>>> All sh builds:
>>>>
>>>> arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
>>>> arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
>>>>
>>>> Again, this is seen in several places.
>>>>
>>>> mips:cavium_octeon_defconfig:
>>>>
>>>> arch/mips/cavium-octeon/octeon-usb.c: In function 'dwc3_octeon_clocks_start':
>>>> include/linux/device.h:1499:2: error: this statement may fall through
>>>>
>>>> None of those are from recent changes. And this is just from my small
>>>> subset of test builds.
>>>>
>>>
>>> Thank you for letting me know about this. I don't have access to build
>>> infrastructure like yours.
>>>
>>
>> I am always happy to run test builds on my infrastructure.
>>
> 
> Thank you!
> 
>>> My build infrastructure is similar to that of Linus.
>>>
>>> But if you send me all of those I can create a patch and send it back
>>> to you to make sure what you see is addressed. If we can coordinate for
>>> this it'd be great for everybody. :)
>>>
>>
>> Just have a look at the output of https://kerneltests.org/builders/,
>> in the 'master' and/or 'next' column. There are many additional warnings
>> in 'next'. Only downside is that you won't see the warnings unless there
>> are also build errors, but -next tends to have lots of those.
>>
> 
> I see.
> 
> mm... for some reason I'm not able to establish connection with that site...
> 

What is your host's IP address ? It might be auto-filtered; the site is hosted
on my own server and is under constant attack. Any subnet originating a sequence
of attacks will be blocked automatically.

Thanks,
Guenter

>> Just wondering ... wouldn't it be possible to run a coccinelle script
>> to identify those problems automatically, without depending on compile
>> warnings ? Or smatch/sparse, maybe ?
>>
> 
> That was a common question from people along the whole process. The short
> answer is: no. The reason for that is that Coccinelle is not a sophisticated
> enough tool to determine if we are dealing with a false positive or an actual
> bug.
> 
> That's why a code audit was needed.
> 
> Thanks
> --
> Gustavo
> 
> 
> 
> 
> 
> 

