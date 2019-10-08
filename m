Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30987C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 05:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0471A206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 05:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfJHF5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 01:57:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfJHF5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 01:57:51 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42DB579705
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 05:57:51 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id y21so10473392edr.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 22:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=96PxzNS/roeRm2gnd1um4lvGRp5P7xMQ5XDPc+SliqQ=;
        b=kSL8PVE2JuIctMwlx3RDbcB5sn6+ozvufAMZmFVab5VEEJKpq7/rfkWqa1NJigJwg4
         /lPQPbPCEFTYeBfJnr+8lTziosnpuhjnLFwADHhH2SV4e97H7GVaRG8+w7F/W1v3atrC
         8H3bYb6t/9hed2J2VIbt0I2+GKsBSkO+zIRyFmJBIz1TfxgKCK6EUlD6XAtvJW00Cj71
         BkKbLsj5TMJr/7Ud6gI7SwAcGrgKWkeKklw2o6h7GealnuN8Xxc1WcIRB3l3lRBkwe/V
         TYAvOkQEkr8WMllwcxrTsX0vFkcH614MrACGTW0qf+zDVzENpGGqzxvyanRxTPv/LeIi
         h5wA==
X-Gm-Message-State: APjAAAUXKenS07WA7Bgd1c4nzjsZWk8KGgXTLtWHAYRUB/QoU8b7Zna1
        2k9j4KjBkJsTT0wLGexBIbIFm4jygXU2zq0dzcPXfa0jdAhujlrRPfYiPsRxHCZmJJ4CtAt1QcI
        GVTWmQm9JoByvqIp+XT8MOTOv
X-Received: by 2002:a17:906:f204:: with SMTP id gt4mr27096779ejb.299.1570514269678;
        Mon, 07 Oct 2019 22:57:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx3U72vwx+ilSVM+U/JcTu2VVTOZWnYOUMfNyZ1EEw36wc7BQoqVIOWD5GL/LaI+ccISeLIjg==
X-Received: by 2002:a17:906:f204:: with SMTP id gt4mr27096740ejb.299.1570514268755;
        Mon, 07 Oct 2019 22:57:48 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id gl4sm2147160ejb.6.2019.10.07.22.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 22:57:47 -0700 (PDT)
Subject: Re: [PATCH] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20191007175546.3395-1-hdegoede@redhat.com>
 <20191007200529.GA716619@archlinux-threadripper>
 <c24d8bef-ad76-4986-0c16-268e7d09bf7c@redhat.com>
 <20191007215213.GA405660@rani.riverdale.lan>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2b54d142-a2e9-2caa-8ff1-b419ed880601@redhat.com>
Date:   Tue, 8 Oct 2019 07:57:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007215213.GA405660@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 07-10-2019 23:52, Arvind Sankar wrote:
> On Mon, Oct 07, 2019 at 10:31:49PM +0200, Hans de Goede wrote:
>> HI,
>>
>> On 07-10-2019 22:05, Nathan Chancellor wrote:
>>> On Mon, Oct 07, 2019 at 07:55:46PM +0200, Hans de Goede wrote:
>>>> Since we link purgatory.ro with -r aka we enable "incremental linking"
>>>> no checks for unresolved symbols is done while linking purgatory.ro.
>>>>
>>>> Changes to the sha256 code has caused the purgatory in 5.4-rc1 to have
>>>> a missing symbol on memzero_explicit, yet things still happily build.
>>>>
>>>> This commit adds an extra check for unresolved symbols by calling ld
>>>> without -r before running bin2c to generate kexec-purgatory.c.
>>>>
>>>> This causes a build of 5.4-rc1 with this patch added to fail as it should:
>>>>
>>>>     CHK     arch/x86/purgatory/purgatory.ro
>>>> ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
>>>> sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
>>>> make[2]: *** [arch/x86/purgatory/Makefile:72:
>>>>       arch/x86/purgatory/kexec-purgatory.c] Error 1
>>>> make[1]: *** [scripts/Makefile.build:509: arch/x86/purgatory] Error 2
>>>> make: *** [Makefile:1650: arch/x86] Error 2
>>>>
>>>> This will help us catch missing symbols in the purgatory sooner.
>>>>
>>>> Note this commit also removes --no-undefined from LDFLAGS_purgatory.ro
>>>> as that has no effect.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>    arch/x86/purgatory/Makefile | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
>>>> index fb4ee5444379..0da0794ef1f0 100644
>>>> --- a/arch/x86/purgatory/Makefile
>>>> +++ b/arch/x86/purgatory/Makefile
>>>> @@ -14,7 +14,7 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
>>>>    
>>>>    CFLAGS_sha256.o := -D__DISABLE_EXPORTS
>>>>    
>>>> -LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
>>>> +LDFLAGS_purgatory.ro := -e purgatory_start -r -nostdlib -z nodefaultlib
>>>>    targets += purgatory.ro
>>>>    
>>>>    KASAN_SANITIZE	:= n
>>>> @@ -60,10 +60,16 @@ $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>>>>    
>>>>    targets += kexec-purgatory.c
>>>>    
>>>> +# Since we link purgatory.ro with -r unresolved symbols are not checked,
>>>> +# so we check this before generating kexec-purgatory.c instead
>>>> +quiet_cmd_check_purgatory = CHK     $<
>>>> +      cmd_check_purgatory = ld -e purgatory_start $<
>>>
>>> I think this should be $(LD) -e ... so that using a cross compile prefix
>>> (like x86_64-linux-) or an alternative linker like ld.lld works properly.
>>
>> Good point, also the ld command is actually outputting an a.out file
>> which is also something which we do not want.
>>
>> I will prepare a new version fixing both.
>>
>> Regards,
>>
>> Hans
> 
> We could just use $(NM) -u, right?

That would require wrapping it in some shell code like this (untested):

SHOULD_BE_EMPTY=$(nm -u purgatory.ro); if [ "$SHOULD_BE_EMPTY" == "" ]; then true; else false; fi

And then escaping the $ in there and in injecting $(NM) into it, IMHO
it is easier to just do:

$(LD) $PURGATORY_LDFLAGS) purgatory.ro -o /dev/null

Also it seems better to actually use the linker for this test then usig an other
tool which may have subtly different semantics.

Regards,

Hans

