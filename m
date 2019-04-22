Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD5FC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDB72077C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWyy+Co0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfDVMLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 08:11:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39936 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDVMLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 08:11:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so15571924wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 05:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B2qxBX6Ax2GUE8PgKNrD2I3+bRNsLRzllJn6cStUQNk=;
        b=KWyy+Co0tP/ANnwncf1nmpR2A+QxmjqW8ifWDleASve/1lF7/luSUW2pJc5qzHESMT
         PAdwrtjOfny3hFD6OiV8rW+6OgSLAMZeynUjNh0VQkPWkZ+eusa5TV2/JGbbFZbQ82Jo
         /GNgsth0afIM2NKmjKi98KG9c8oLQmOqRcIJnZEFiwvRwjimYuV7+EpB7bRE362cxSep
         6vFRcvM6eI7bM2GLNv7uE+F3Lz0hOL0XJOaSfSe/YD5gw2oBP7I2RhF3vXqIfhrBFef9
         d0XaJ0l1h6AB4d5J6oFyIlo6OaCQzL0gNAVqCQD1AmcF3yCC7cpdTgaxqjDLvePc5T2K
         Ix/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B2qxBX6Ax2GUE8PgKNrD2I3+bRNsLRzllJn6cStUQNk=;
        b=aLjwYusD+gc2J5W5Yt2hTdpyv7fyoGOkqJ63EFGmPmvjxQ4sySWfZOLJu6WNqE7JDW
         cVvPv3hKmH0cNBpjWyV42S8H4C+vm9rZAh9JBvCMAKjeVefXvZsaZPSW3OTmRkMhBO0D
         NTpPZDxGJZRjO45qNJF36NlrinOrDgY1QZY7Lc7cHb9kQuhX0YMrk4IcCtcBkzzukiNy
         0NndtLjRZ7WaeJygN8faAOI7qm8tAj0SKBQIV6/ZgQXCclJ5DiSjUyD3bjtTKcIwsbpf
         Bp6qjwKXK0cIOpSeTg6RxBaS/jk8TA12Ylqhu8kdinoOw4jtGpofxGezZyXv5nkeGe7o
         2ezw==
X-Gm-Message-State: APjAAAXLMiaGktuzXmX9MHErZFt+m4RNA+63q2fYSDBGFcmPTmMKjalT
        tBn5UgxMTYoQm8EOgekuLPGqVQ==
X-Google-Smtp-Source: APXvYqxzkvUtNCmgWvsMP6IdarWSK9jSmSNhZVcRl5tWyhhrp8EoSkI5zR5T3DUGVnwuS2Yt+isx3Q==
X-Received: by 2002:adf:f051:: with SMTP id t17mr12109734wro.73.1555935069857;
        Mon, 22 Apr 2019 05:11:09 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 62sm9172701wrm.18.2019.04.22.05.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 05:11:09 -0700 (PDT)
Subject: Re: [PATCH 3/7] thermal/drivers/core: Add init section table for
 self-encapsulation
To:     Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
 <20190402161256.11044-3-daniel.lezcano@linaro.org>
 <1555922585.26198.19.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fb45157c-38c4-7940-3252-af459d446323@linaro.org>
Date:   Mon, 22 Apr 2019 14:11:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555922585.26198.19.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Zhang,


On 22/04/2019 10:43, Zhang Rui wrote:
> Hi, Daniel,
> 
> Thanks for the patches, it looks good to me except this one and patch
> 4/7.
> 
> First, I don't think this is a cyclic dependency issue as they are in
> the same module.

The governors have to export their [un]register functions in order to
have the core to use them.

The core has to export the [un]register function in order to have the
governors to use them.

From my point of view it is a cyclic dependency. In any other
subsystems, the plugins/governor/drivers/whatever don't have to export
their functions to the core, they use the core's exported functions.

> Second, I have not read include/asm-generic/vmlinux.lds.h before, it
> seems that it is used for architecture specific stuff. Fix a thermal
> issue in this way seems overkill to me.

It is not architecture specific, it belongs to asm-generic. All init
calls are defined in it and more. It is a common way to define static
tables from different files without adding dependency and unload it
after init.

All clk, timers, acpi tables, irq chip, cpuidle and cpu methods are
defined this way.

When the thermal_core.c uses at the end fs_initcall it uses the same
mechanism.


> IMO, to make the code clean, we can build the governors as separate
> modules just like we do for cpu governors.
> This brings to the old commit 80a26a5c22b9("Thermal: build thermal
> governors into thermal_sys module"), and that was introduced to fix a
> problem when CONFIG_THERMAL is set to 'm'. So I think we can switch
> back to the old way as the problem is gone now.
> 
> what do you think?

IMO, having the governors built as module is not a good thing because
the SoC needs the governor to be ready as soon as possible at boot time.
I've been told some boards reboot at boot time because the governor
comes too late with the userspace governor for example.

If you don't like the vmlinuz.lds.h approch (but again it is a common
way to initialize table and I wrote it to extend to more thermal table
in the future) we can change the thermal core to replace fs_initcall()
by core_initcall() and use postcore_initcall() in the governor.



> Patch 1,2,5,6,7 applied first.
> 
> thanks,
> rui
> 
> On 二, 2019-04-02 at 18:12 +0200, Daniel Lezcano wrote:
>> Currently the governors are declared in their respective files but
>> they
>> export their [un]register functions which in turn call the
>> [un]register
>> the governors core's functions. That implies a cyclic dependency
>> which is
>> not desirable. There is a way to self-encapsulate the governors by
>> letting
>> them to declare themselves in a __init section table.
>>
>> Define the table in the asm generic linker description like the other
>> tables and provide the specific macros to deal with.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/thermal_core.h    | 16 ++++++++++++++++
>>  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
>>  2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_core.h
>> b/drivers/thermal/thermal_core.h
>> index 0df190ed82a7..28d18083e969 100644
>> --- a/drivers/thermal/thermal_core.h
>> +++ b/drivers/thermal/thermal_core.h
>> @@ -15,6 +15,22 @@
>>  /* Initial state of a cooling device during binding */
>>  #define THERMAL_NO_TARGET -1UL
>>  
>> +/* Init section thermal table */
>> +extern struct thermal_governor * __governor_thermal_table[];
>> +extern struct thermal_governor * __governor_thermal_table_end[];
>> +
>> +#define THERMAL_TABLE_ENTRY(table, name)			\
>> +        static typeof(name) * __thermal_table_entry_##name	\
>> +	__used __section(__##table##_thermal_table)		\
>> +		= &name;
>> +
>> +#define THERMAL_GOVERNOR_DECLARE(name)	THERMAL_TABLE_ENTRY(go
>> vernor, name)
>> +
>> +#define for_each_governor_table(__governor)		\
>> +	for (__governor = __governor_thermal_table;	\
>> +	     __governor < __governor_thermal_table_end;	\
>> +	     __governor++)
>> +
>>  /*
>>   * This structure is used to describe the behavior of
>>   * a certain cooling device on a certain trip point
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-
>> generic/vmlinux.lds.h
>> index f8f6f04c4453..9893a3ed242a 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -239,6 +239,16 @@
>>  #define ACPI_PROBE_TABLE(name)
>>  #endif
>>  
>> +#ifdef CONFIG_THERMAL
>> +#define THERMAL_TABLE(name)						
>> \
>> +        . = ALIGN(8);						
>> 	\
>> +        __##name##_thermal_table = .;				
>> 	\
>> +        KEEP(*(__##name##_thermal_table))				
>> \
>> +        __##name##_thermal_table_end = .;
>> +#else
>> +#define THERMAL_TABLE(name)
>> +#endif
>> +
>>  #define KERNEL_DTB()							
>> \
>>  	STRUCT_ALIGN();						
>> 	\
>>  	__dtb_start = .;						
>> \
>> @@ -609,6 +619,7 @@
>>  	IRQCHIP_OF_MATCH_TABLE()					
>> \
>>  	ACPI_PROBE_TABLE(irqchip)					
>> \
>>  	ACPI_PROBE_TABLE(timer)					
>> 	\
>> +	THERMAL_TABLE(governor)					
>> 	\
>>  	EARLYCON_TABLE()						
>> \
>>  	LSM_TABLE()
>>  


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

