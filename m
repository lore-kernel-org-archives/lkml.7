Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7E9C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA792214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rriZVFpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfE1NZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:25:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41273 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfE1NZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:25:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so6378798pgp.8;
        Tue, 28 May 2019 06:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sK7QsZOgGwCN6QQZlRx/S03lo3cL5E7tJbIXs4eQLZA=;
        b=rriZVFpGrBYoSkG5KSg36LqTk2R1kx44WID9jNFkshZ4oVe1bjCC9Ee9x3fqL/1+O2
         RQIvI4jL16Z03+M7lZflyMjUi6kA17EH0pGWo7urK1b+Rmxc/jEfDa/IK/bAY8SrKOrC
         CkxcyjDyG+ipbG6UcxvDJKK+8CC09+mMZ89MukhV+Z9r1tFReIt0+iBJVov9NMZIYWlp
         SCPAKeyewtT7kxqwhWazzrBGAcwL3Xu0kQ+0Hn9ZGCfK5viJk3j2ws+Sv7r6+tCMJyO5
         1MkGdtKNH5ILK3dbFP/kNRBZSbD854hbfzkjIUVChT+2tqcMbm3i1FPjJ2919FJQS3hj
         SVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sK7QsZOgGwCN6QQZlRx/S03lo3cL5E7tJbIXs4eQLZA=;
        b=rF5LCEr4ZKFOo8JaTLGMCprwIrNquPwRqPFN06A1CxIe+7DEIX1WpVnDfn/hhUssHJ
         UOW4SrrItv4EIPMWryAxYTe2nm4NjoEEoIY6rKmAvXBSEQ0QEs2+Vm8yGOdgVKQkxUoJ
         qtwR1XmMJqlPSNkmSTSjHV76HFWK7XdcGRWXI1dolHWYiAxL9U79jX0GZOET8tZG8Yf/
         eQEuxya2XBHhmGRsYl5NhBDv9FW0NweGIOMDvxmQiAHq0QSggrIgJHrTqcaI0qlKrz3I
         DtGq1Wu0naIZ51iJITCjd03AZeOlvFmGOgJ38PKIrjmf3VVRJuoe8nUVBa4o1LwMluO+
         qBsg==
X-Gm-Message-State: APjAAAUe3f8D9HgwSiOTZHQPGG8Xg/dTGsfTq9HDzUYvhnsg7cJkOq5/
        kvVQbL5o56ub/BBoUUILyztFchvE
X-Google-Smtp-Source: APXvYqzh2QdWJ6CHkAK0UbtpK87a+5+j38rRR3Cz/+snA3Nh62EF+w5vn1/Rhyf8o/kts7lyA83VRA==
X-Received: by 2002:a17:90a:5d0a:: with SMTP id s10mr5972440pji.94.1559049922261;
        Tue, 28 May 2019 06:25:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t11sm12734854pgp.1.2019.05.28.06.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 06:25:21 -0700 (PDT)
Subject: Re: [PATCH] hwmon: (smsc47m1) fix outside array bounds warnings
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jean Delvare <jdelvare@suse.de>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190521044456.26431-1-yamada.masahiro@socionext.com>
 <20190522170848.198ccea6@endymion>
 <d5b1d8f4-af0a-03e7-8480-3caf593214ee@roeck-us.net>
 <CAK7LNAT6Ctms0um5LybNP9nG3fZ+cQxoDcnoqgCjr8q1aCcq0g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a8e072bc-6ab5-700b-7d04-14887b1062ab@roeck-us.net>
Date:   Tue, 28 May 2019 06:25:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT6Ctms0um5LybNP9nG3fZ+cQxoDcnoqgCjr8q1aCcq0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/19 8:09 PM, Masahiro Yamada wrote:
> On Tue, May 28, 2019 at 10:25 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 5/22/19 8:08 AM, Jean Delvare wrote:
>>> Hi Masahiro,
>>>
>>> On Tue, 21 May 2019 13:44:56 +0900, Masahiro Yamada wrote:
>>>> Kbuild test robot reports outside array bounds warnings:
>>>>
>>>>     CC [M]  drivers/hwmon/smsc47m1.o
>>>> drivers/hwmon/smsc47m1.c: In function 'fan_div_store':
>>>> drivers/hwmon/smsc47m1.c:370:49: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
>>>>     tmp = 192 - (old_div * (192 - data->fan_preload[nr])
>>>>                                   ~~~~~~~~~~~~~~~~~^~~~
>>>> drivers/hwmon/smsc47m1.c:372:19: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
>>>>     data->fan_preload[nr] = clamp_val(tmp, 0, 191);
>>>>     ~~~~~~~~~~~~~~~~~^~~~
>>>> drivers/hwmon/smsc47m1.c:373:53: warning: array subscript [0, 2] is outside array bounds of 'const u8[3]' {aka 'const unsigned char[3]'} [-Warray-bounds]
>>>>     smsc47m1_write_value(data, SMSC47M1_REG_FAN_PRELOAD[nr],
>>>>                                ~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>>>
>>> These messages are pretty confusing. Subscript [0, 2] would refer to a
>>> bi-dimensional array, while these are 1-dimension arrays. If [0, 2]
>>> means something else, I still don't get it, because both indexes 0 and
>>> 2 are perfectly within bounds of a 3-element array. So what do these
>>> messages mean exactly? Looks like a bogus checker to me.
>>>
>>>> The index field in the SENSOR_DEVICE_ATTR_R* defines is 0, 1, or 2.
>>>> However, the compiler never knows the fact that the default in the
>>>> switch statement is unreachable.
>>>>
>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> ---
>>>>
>>>>    drivers/hwmon/smsc47m1.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
>>>> index 5f92eab24c62..e00102e05666 100644
>>>> --- a/drivers/hwmon/smsc47m1.c
>>>> +++ b/drivers/hwmon/smsc47m1.c
>>>> @@ -364,6 +364,10 @@ static ssize_t fan_div_store(struct device *dev,
>>>>               tmp |= data->fan_div[2] << 4;
>>>>               smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
>>>>               break;
>>>> +    default:
>>>> +            WARN_ON(1);
>>>> +            mutex_unlock(&data->update_lock);
>>>> +            return -EINVAL;
>>>>       }
>>>
>>> So basically the code is fine, the checker (which checker, BTW?)
>>> incorrectly thinks it isn't, and you propose to add dead code to make
>>> the checker happy?
>>>
>>> I disagree with this approach. Ideally the checker must be improved to
>>
>> Me too. I understand and accept that we sometimes initialize variables
>> to make he compiler happy, but this goes a bit too far. We really should
>> not add dead code - it creates the impression that it can be reached,
>> and would live forever for no good reason.
>>
>>> understand that the code is correct. If that's not possible, we should
>>> be allowed to annotate the code to skip that specific check on these
>>> specific lines, because it has been inspected by a knowledgeable human
>>> and confirmed to be correct.
>>>
>> Agreed.
>>
>>> And if that it still not "possible", then the least intrusive fix would > be to make one of the valid cases the default. But adding new code
>>> which will never be executed, but must still be compiled and stored,
>>> no, thank you. Another code checker could legitimately complain about
>>> that actually.
>>>
>>> IMHO if code checkers return false positives then they are not helping
>>> us and should not be used in the first place.
>>>
>> Checkers are always only providing guidelines and should never be taken
>> at face value.
>>
>> In summary - NACK.
>>
>> Guenter
>>
> 
> What you guys repeatedly called "checker" is GCC 8.
> 
> Intel's 0day bot reported this, and I was also able to reproduce the warnings
> by using the kernel.org toolchain available at:
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-sh4-linux.tar.xz
> 
> 
> I also checked "git log --grep=Warray-bounds",
> and I saw people were fixing this kind of warnings.
> And, I am really annoyed by the 0day bot.
> 
> That's why I sent this patch
> despite I have no interest in this driver.
> 
> 
> Having said that, I cannot reproduce these warnings
> by other compilers than sh4-linux-gcc.
> 
> So, probably these warnings are false positive.
> 
> 
> 
> Currently, I have 3 options I can do:
> 
> [1]  I will send an alternative patch to
>       clarify the unreachable path for both compilers and humans
>       without adding dead code.
> 
>    |@@ -351,6 +351,8 @@ static ssize_t fan_div_store(struct device *dev,
>    |                tmp |= data->fan_div[2] << 4;
>    |                smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
>    |                break;
>    |+       default:
>    |+               unreachable();
>    |        }
>    |
>    |        /* Preserve fan min */
> 
> [2] I will send your feed-backs to the maintainer of 0day bot,
>      and persuade him to stop reporting this.
> 
> [3] I will accept that 0day bot will continue sending this report forever.
>      So, I will configure my mailer so that this report
>      will immediately go to the trash box.
> 
> 
> 
> 
> As I already said, I have _zero_ interest in this driver.
> 
> Only the problem I have is, I repeatedly receive annoying reports
> from 0day bot, where my patch is not the root cause of the warnings at all.
> 
I know, happens all the time to me as well. Worse is that in some cases
I don't even know how to fix it (it is not always as easy as it is here).

> Looks like you both believe the current code is OK as-is,
> so I am not sure you are happy with [1].
> 
I am not exactly happy about it, but I would accept it. Just add to the
description that this is to make the compiler happy.

Guenter

> I can try [2] first.
> 
> [3] is the last resort for me.
> 
> 

