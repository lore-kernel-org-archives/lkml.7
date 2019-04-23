Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE158C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFE6218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="R32ku6tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfDWUhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:37:16 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:37206 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfDWUhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:37:15 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D47F35C06C8;
        Tue, 23 Apr 2019 22:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1556051831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6D2lDRCpX07MomiNoc1MU3sZP8AgBKwh5CiaDUSfa0g=;
        b=R32ku6tbh1iiLlVhAKujlE6ULR9MQyticr68e79LPevahgf0VnHxJapO6BWxnwCK1TcCPU
        TmFY6oHfkjWvvO8uJWRsVfZI5vAK4XGIGVMEjGZ9UvNuM0dqtY8E79B91yMSWCZROwQSAH
        t5rLX7ODQ6FRrCNPHtA45xKUd069ojw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Apr 2019 22:37:11 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jeremyfertic@gmail.com
Subject: Re: Kconfig dependency issue on function-graph tracer and frame
 pointer on arm
In-Reply-To: <CAK8P3a2xf9Lp=apuAE5zo+4GHQHjDTeJUh8gkCOWeotsQXRaNA@mail.gmail.com>
References: <20190414194705.2e10802aca2df36c8f27f349@kernel.org>
 <20190414133458.zxdekgx6qwd562qa@shell.armlinux.org.uk>
 <CAK8P3a2xf9Lp=apuAE5zo+4GHQHjDTeJUh8gkCOWeotsQXRaNA@mail.gmail.com>
Message-ID: <7333cd3b85b47d5f28d7652031b2b1b1@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.2019 14:28, Arnd Bergmann wrote:
> On Sun, Apr 14, 2019 at 3:35 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> 
>> The subsequent hunks remove the defaulting of the choice according to
>> the function graph tracer - this is not a "hint" where the user can
>> still choose either option irrespective of the state of the function
>> graph tracer.  They should only be able to select the frame pointer
>> option in that case.
>>
>> Another way forward would be for someone to put the work in to making
>> the function graph tracer work without frame pointers.
> 
> I think Stefan was already looking into making CONFIG_FUNCTION_TRACER
> work with clang. I don't know what the status of that work is, but I
> think getting
> FUNCTION_GRAPH_TRACER working at the same time would be best.

Function Tracer is currently blocked by buggy mcount implemention on
Clang side. I do have a hacked up version which works with the buggy
Clang implementation, but not something we want to merge IMHO. see also:
https://bugs.llvm.org/show_bug.cgi?id=33845

> 
> I never noticed the Kconfig issue here, because I was using a patch to
> turn off FUNCTION_TRACER on ARM with clang to make it build, and that
> turns off FUNCTION_GRAPH_TRACER in the process.
> 
>> So, how about this:
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 850b4805e2d1..9aed25a6019b 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -73,7 +73,7 @@ config ARM
>>         select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
>>         select HAVE_EXIT_THREAD
>>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>> -       select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL
>> +       select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
>>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL

I think due to the fact above, we should add  && !CC_IS_CLANG here too.

>>         select HAVE_GCC_PLUGINS
>>         select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 6d6e0330930b..e388af4594a6 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -47,8 +47,8 @@ config DEBUG_WX
>>
>>  choice
>>         prompt "Choose kernel unwinder"
>> -       default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
>> -       default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER
>> +       default UNWINDER_ARM if AEABI
>> +       default UNWINDER_FRAME_POINTER if !AEABI
>>         help
>>           This determines which method will be used for unwinding kernel stack
>>           traces for panics, oopses, bugs, warnings, perf, /proc/<pid>/stack,
>> @@ -65,7 +65,7 @@ config UNWINDER_FRAME_POINTER
>>
>>  config UNWINDER_ARM
>>         bool "ARM EABI stack unwinder"
>> -       depends on AEABI
>> +       depends on AEABI && !FUNCTION_GRAPH_TRACER
>>         select ARM_UNWIND
>>         help
>>           This option enables stack unwinding support in the kernel
> 
> This looks good to me in the meantime, at least if there is any
> way to get the non-graph FUNCTION_TRACER to build with clang.

Looks sensible to me too.

Note that a similar issue came up a while ago on the mailing list:
https://marc.info/?l=linux-arm-kernel&m=154739414703313&w=2
[added Jeremy]

Unfortunately this never really materialized in a mergeable patch.

--
Stefan




