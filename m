Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D648C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DB72086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 16:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfrGMEr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfF2QUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 12:20:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43615 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfF2QT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 12:19:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so3956017pgv.10;
        Sat, 29 Jun 2019 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CBrs5ps8bWQKn2BdzZgJUjjnHTpYnZjyDq8xBYs3zc8=;
        b=AfrGMEr1TwMhD87qo1+RjPwtUokeAPMVXLvItnQng/Ld6hlF9X356VmWslLvCYJCzX
         gwhBjUxvhQIevO+RxJVBYvwHbHiz1Rjzf2kOXCY//Y/KWPEbKvr08KW9dwl6qqRZdi20
         Q0+4/GObqdNudf96kwAlxi1W/XzPylXLg5LXGPVyh1sgfWL3GJITzueTcCEcuDqhlqBr
         YjtLoXw33DbOgTIknB/Wyxr14t4SUboKjPGWARjlJeWvjogDwGOBD07hUamgz2UbGjiS
         a0eCC6d4gxzhg8d1QUr2PkVvSwH8WAHLnMaAglBEWZOypWqevvPX8U2ScVZfst8hV/Bv
         swNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CBrs5ps8bWQKn2BdzZgJUjjnHTpYnZjyDq8xBYs3zc8=;
        b=ioVmXXfEiIejjMKwYnAj9idAgbn7zqnuBho4gsdV1ZPN3p19XzgrdojnjRrjFXRCkX
         e9DYwwKiJDlFHrKz/HqEkBFEhtYwke3zkMNz5dJhzOrZq0wVJx7W0U6X0Bfn4lR7er1e
         sznnyLHDYqW8rHHtdxNyGH/ni3bgzf2my6R4Wo3IPwQc6wYlnQFKyTCswQuBtBm9vutP
         eDKZeg8nA1JKiF9uP8NVei7hlZNUZXWgJRoH/7bgzXhmFZDd/ay7hnYR4prh4VVaoeL0
         +8nj3/0xKxEoZN1qInkaN+1MbAyfFKnELsnkYJv1s8PX/IMeyg8Z+vnBXcG2RwtiujS3
         uQHQ==
X-Gm-Message-State: APjAAAXx59EGxfcE2aDaAsqRQeemN/j+yop0Cpvuxz9CnGh/T7GQhioL
        LP1XWLNlbQzul3qxpJvWh33jRHILRT4Aww==
X-Google-Smtp-Source: APXvYqxw6r0UdkFBaw0K48fog1pBku92oiQ2Pth8VP2YPrj3IDDvH1rSj8UsADCtPBvtcGwEyS38GQ==
X-Received: by 2002:a63:1208:: with SMTP id h8mr14587309pgl.377.1561825198337;
        Sat, 29 Jun 2019 09:19:58 -0700 (PDT)
Received: from [192.168.1.10] ([117.241.203.223])
        by smtp.gmail.com with ESMTPSA id t32sm13660018pgk.29.2019.06.29.09.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 09:19:57 -0700 (PDT)
Subject: Re: [PATCH v4] Documentation:sh:convert register-banks.txt and
 new-machine.txt to rst format.
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20190627063347.11137-1-bnvandana@gmail.com>
 <20190629143245.3580-1-bnvandana@gmail.com>
 <20190629115014.4aec058d@coco.lan>
 <4549aead-e916-a889-6c18-f695086fb72c@gmail.com>
 <20190629130242.413b4672@coco.lan>
From:   Vandana BN <bnvandana@gmail.com>
Message-ID: <3cf4fe7c-1ed4-8052-fab3-2a8d9794bb29@gmail.com>
Date:   Sat, 29 Jun 2019 21:49:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190629130242.413b4672@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/06/19 9:32 PM, Mauro Carvalho Chehab wrote:
> Em Sat, 29 Jun 2019 21:26:29 +0530
> Vandana BN <bnvandana@gmail.com> escreveu:
>
>> On 29/06/19 8:20 PM, Mauro Carvalho Chehab wrote:
>>> Em Sat, 29 Jun 2019 20:02:45 +0530
>>> Vandana BN <bnvandana@gmail.com> escreveu:
>>>  
>>>> This patch converts new-machine.txt and register-banks.txt
>>>> to ReST format, No content change.
>>>> Added interfaces.rst to contain kernel-doc markups from index.rst
>>>> Added interfaces.rst,new-machine.rst and register-banks.rst to sh/index.rst
>>>> Added SPDX tag in index.rst
>>>>
>>>> Signed-off-by: Vandana BN <bnvandana@gmail.com>  
>>> Looks good to me. Just a final thing to do.
>>>
>>> Be sure to run:
>>>
>>> 	./scripts/documentation-file-ref-check
>>>
>>> in order to check that you're not breaking any references to the file.
>>> If it breaks, please adjust the reference to reflect the file
>>> rename.
>>>
>>> After fixing the broken reference, feel free do add:
>>>
>>> Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>  
>> Thanks Mauro,
>>
>> i don't not see any broken references.
> Then maybe the script is broken. A simple grep here (linux-next) shows
> one such reference:
>
> git grep Documentation/sh/
> MAINTAINERS:F:  Documentation/sh/
> arch/sh/Kconfig.cpu:      See <file:Documentation/sh/register-banks.txt> for further
>
Oh ok, yes i see it now..

Will fix and send a patch.

>>>> ---
>>>>  Documentation/sh/index.rst                    |  65 +------
>>>>  Documentation/sh/interface.rst                |  59 ++++++
>>>>  .../sh/{new-machine.txt => new-machine.rst}   | 171 +++++++++---------
>>>>  ...{register-banks.txt => register-banks.rst} |   8 +-
>>>>  4 files changed, 163 insertions(+), 140 deletions(-)
>>>>  create mode 100644 Documentation/sh/interface.rst
>>>>  rename Documentation/sh/{new-machine.txt => new-machine.rst} (79%)
>>>>  rename Documentation/sh/{register-banks.txt => register-banks.rst} (90%)
>>>>
>>>> diff --git a/Documentation/sh/index.rst b/Documentation/sh/index.rst
>>>> index bc8db7ba894a..fec3c405b6b9 100644
>>>> --- a/Documentation/sh/index.rst
>>>> +++ b/Documentation/sh/index.rst
>>>> @@ -1,59 +1,14 @@
>>>> -=======================
>>>> -SuperH Interfaces Guide
>>>> -=======================
>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>>
>>>> -:Author: Paul Mundt
>>>> -
>>>> -Memory Management
>>>> -=================
>>>> -
>>>> -SH-4
>>>> -----
>>>> -
>>>> -Store Queue API
>>>> -~~~~~~~~~~~~~~~
>>>> -
>>>> -.. kernel-doc:: arch/sh/kernel/cpu/sh4/sq.c
>>>> -   :export:
>>>> -
>>>> -SH-5
>>>> -----
>>>> -
>>>> -TLB Interfaces
>>>> -~~~~~~~~~~~~~~
>>>> -
>>>> -.. kernel-doc:: arch/sh/mm/tlb-sh5.c
>>>> -   :internal:
>>>> -
>>>> -.. kernel-doc:: arch/sh/include/asm/tlb_64.h
>>>> -   :internal:
>>>> +====================
>>>> +SuperH Documentation
>>>> +====================
>>>>
>>>> -Machine Specific Interfaces
>>>> -===========================
>>>> -
>>>> -mach-dreamcast
>>>> ---------------
>>>> -
>>>> -.. kernel-doc:: arch/sh/boards/mach-dreamcast/rtc.c
>>>> -   :internal:
>>>> -
>>>> -mach-x3proto
>>>> -------------
>>>> -
>>>> -.. kernel-doc:: arch/sh/boards/mach-x3proto/ilsel.c
>>>> -   :export:
>>>> -
>>>> -Busses
>>>> -======
>>>> -
>>>> -SuperHyway
>>>> -----------
>>>> -
>>>> -.. kernel-doc:: drivers/sh/superhyway/superhyway.c
>>>> -   :export:
>>>> +:Author: Paul Mundt
>>>>
>>>> -Maple
>>>> ------
>>>> +.. toctree::
>>>> +   :maxdepth: 2
>>>>
>>>> -.. kernel-doc:: drivers/sh/maple/maple.c
>>>> -   :export:
>>>> +   interface
>>>> +   new-machine
>>>> +   register-banks
>>>> diff --git a/Documentation/sh/interface.rst b/Documentation/sh/interface.rst
>>>> new file mode 100644
>>>> index 000000000000..bc8db7ba894a
>>>> --- /dev/null
>>>> +++ b/Documentation/sh/interface.rst
>>>> @@ -0,0 +1,59 @@
>>>> +=======================
>>>> +SuperH Interfaces Guide
>>>> +=======================
>>>> +
>>>> +:Author: Paul Mundt
>>>> +
>>>> +Memory Management
>>>> +=================
>>>> +
>>>> +SH-4
>>>> +----
>>>> +
>>>> +Store Queue API
>>>> +~~~~~~~~~~~~~~~
>>>> +
>>>> +.. kernel-doc:: arch/sh/kernel/cpu/sh4/sq.c
>>>> +   :export:
>>>> +
>>>> +SH-5
>>>> +----
>>>> +
>>>> +TLB Interfaces
>>>> +~~~~~~~~~~~~~~
>>>> +
>>>> +.. kernel-doc:: arch/sh/mm/tlb-sh5.c
>>>> +   :internal:
>>>> +
>>>> +.. kernel-doc:: arch/sh/include/asm/tlb_64.h
>>>> +   :internal:
>>>> +
>>>> +Machine Specific Interfaces
>>>> +===========================
>>>> +
>>>> +mach-dreamcast
>>>> +--------------
>>>> +
>>>> +.. kernel-doc:: arch/sh/boards/mach-dreamcast/rtc.c
>>>> +   :internal:
>>>> +
>>>> +mach-x3proto
>>>> +------------
>>>> +
>>>> +.. kernel-doc:: arch/sh/boards/mach-x3proto/ilsel.c
>>>> +   :export:
>>>> +
>>>> +Busses
>>>> +======
>>>> +
>>>> +SuperHyway
>>>> +----------
>>>> +
>>>> +.. kernel-doc:: drivers/sh/superhyway/superhyway.c
>>>> +   :export:
>>>> +
>>>> +Maple
>>>> +-----
>>>> +
>>>> +.. kernel-doc:: drivers/sh/maple/maple.c
>>>> +   :export:
>>>> diff --git a/Documentation/sh/new-machine.txt b/Documentation/sh/new-machine.rst
>>>> similarity index 79%
>>>> rename from Documentation/sh/new-machine.txt
>>>> rename to Documentation/sh/new-machine.rst
>>>> index e0961a66130b..b16c33342642 100644
>>>> --- a/Documentation/sh/new-machine.txt
>>>> +++ b/Documentation/sh/new-machine.rst
>>>> @@ -1,8 +1,8 @@
>>>> +================================
>>>> +Adding a new board to LinuxSH
>>>> +================================
>>>>
>>>> -                Adding a new board to LinuxSH
>>>> -               ================================
>>>> -
>>>> -               Paul Mundt <lethal@linux-sh.org>
>>>> +Paul Mundt <lethal@linux-sh.org>
>>>>
>>>>  This document attempts to outline what steps are necessary to add support
>>>>  for new boards to the LinuxSH port under the new 2.5 and 2.6 kernels. This
>>>> @@ -19,65 +19,67 @@ include/asm-sh/. For the new kernel, things are broken out by board type,
>>>>  companion chip type, and CPU type. Looking at a tree view of this directory
>>>>  hierarchy looks like the following:
>>>>
>>>> -Board-specific code:
>>>> -
>>>> -.
>>>> -|-- arch
>>>> -|   `-- sh
>>>> -|       `-- boards
>>>> -|           |-- adx
>>>> -|           |   `-- board-specific files
>>>> -|           |-- bigsur
>>>> -|           |   `-- board-specific files
>>>> -|           |
>>>> -|           ... more boards here ...
>>>> -|
>>>> -`-- include
>>>> -    `-- asm-sh
>>>> -        |-- adx
>>>> -        |   `-- board-specific headers
>>>> -        |-- bigsur
>>>> -        |   `-- board-specific headers
>>>> -        |
>>>> -	.. more boards here ...
>>>> -
>>>> -Next, for companion chips:
>>>> -.
>>>> -`-- arch
>>>> -    `-- sh
>>>> -        `-- cchips
>>>> -            `-- hd6446x
>>>> -                `-- hd64461
>>>> -                    `-- cchip-specific files
>>>> +Board-specific code::
>>>> +
>>>> + .
>>>> + |-- arch
>>>> + |   `-- sh
>>>> + |       `-- boards
>>>> + |           |-- adx
>>>> + |           |   `-- board-specific files
>>>> + |           |-- bigsur
>>>> + |           |   `-- board-specific files
>>>> + |           |
>>>> + |           ... more boards here ...
>>>> + |
>>>> + `-- include
>>>> +     `-- asm-sh
>>>> +         |-- adx
>>>> +         |   `-- board-specific headers
>>>> +         |-- bigsur
>>>> +         |   `-- board-specific headers
>>>> +         |
>>>> +       	 .. more boards here ...
>>>> +
>>>> +Next, for companion chips::
>>>> +
>>>> + .
>>>> + `-- arch
>>>> +     `-- sh
>>>> +         `-- cchips
>>>> +             `-- hd6446x
>>>> +                 `-- hd64461
>>>> +                     `-- cchip-specific files
>>>>
>>>>  ... and so on. Headers for the companion chips are treated the same way as
>>>>  board-specific headers. Thus, include/asm-sh/hd64461 is home to all of the
>>>>  hd64461-specific headers.
>>>>
>>>> -Finally, CPU family support is also abstracted:
>>>> -.
>>>> -|-- arch
>>>> -|   `-- sh
>>>> -|       |-- kernel
>>>> -|       |   `-- cpu
>>>> -|       |       |-- sh2
>>>> -|       |       |   `-- SH-2 generic files
>>>> -|       |       |-- sh3
>>>> -|       |       |   `-- SH-3 generic files
>>>> -|       |       `-- sh4
>>>> -|       |           `-- SH-4 generic files
>>>> -|       `-- mm
>>>> -|           `-- This is also broken out per CPU family, so each family can
>>>> -|               have their own set of cache/tlb functions.
>>>> -|
>>>> -`-- include
>>>> -    `-- asm-sh
>>>> -        |-- cpu-sh2
>>>> -        |   `-- SH-2 specific headers
>>>> -        |-- cpu-sh3
>>>> -        |   `-- SH-3 specific headers
>>>> -        `-- cpu-sh4
>>>> -            `-- SH-4 specific headers
>>>> +Finally, CPU family support is also abstracted::
>>>> +
>>>> + .
>>>> + |-- arch
>>>> + |   `-- sh
>>>> + |       |-- kernel
>>>> + |       |   `-- cpu
>>>> + |       |       |-- sh2
>>>> + |       |       |   `-- SH-2 generic files
>>>> + |       |       |-- sh3
>>>> + |       |       |   `-- SH-3 generic files
>>>> + |       |       `-- sh4
>>>> + |       |           `-- SH-4 generic files
>>>> + |       `-- mm
>>>> + |           `-- This is also broken out per CPU family, so each family can
>>>> + |               have their own set of cache/tlb functions.
>>>> + |
>>>> + `-- include
>>>> +     `-- asm-sh
>>>> +         |-- cpu-sh2
>>>> +         |   `-- SH-2 specific headers
>>>> +         |-- cpu-sh3
>>>> +         |   `-- SH-3 specific headers
>>>> +         `-- cpu-sh4
>>>> +             `-- SH-4 specific headers
>>>>
>>>>  It should be noted that CPU subtypes are _not_ abstracted. Thus, these still
>>>>  need to be dealt with by the CPU family specific code.
>>>> @@ -112,18 +114,20 @@ setup code, we're required at the very least to provide definitions for
>>>>  get_system_type() and platform_setup(). For our imaginary board, this
>>>>  might look something like:
>>>>
>>>> -/*
>>>> - * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
>>>> - */
>>>> -#include <linux/init.h>
>>>> +.. code-block:: c
>>>> +
>>>> +    /*
>>>> +     * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
>>>> +     */
>>>> +    #include <linux/init.h>
>>>>
>>>> -const char *get_system_type(void)
>>>> -{
>>>> -	return "FooTech Vaporboard";
>>>> -}
>>>> +    const char *get_system_type(void)
>>>> +    {
>>>> +        return "FooTech Vaporboard";
>>>> +    }
>>>>
>>>> -int __init platform_setup(void)
>>>> -{
>>>> +    int __init platform_setup(void)
>>>> +    {
>>>>    	/*
>>>>  	 * If our hardware actually existed, we would do real
>>>>  	 * setup here. Though it's also sane to leave this empty
>>>> @@ -136,7 +140,8 @@ int __init platform_setup(void)
>>>>  	/* And whatever else ... */
>>>>
>>>>  	return 0;
>>>> -}
>>>> +    }
>>>> +
>>>>
>>>>  Our new imaginary board will also have to tie into the machvec in order for it
>>>>  to be of any use.
>>>> @@ -172,16 +177,17 @@ sufficient.
>>>>     vector.
>>>>
>>>>     Note that these prototypes are generated automatically by setting
>>>> -   __IO_PREFIX to something sensible. A typical example would be:
>>>> +   __IO_PREFIX to something sensible. A typical example would be::
>>>>
>>>>  	#define __IO_PREFIX vapor
>>>>     	#include <asm/io_generic.h>
>>>>
>>>> +
>>>>     somewhere in the board-specific header. Any boards being ported that still
>>>>     have a legacy io.h should remove it entirely and switch to the new model.
>>>>
>>>>   - Add machine vector definitions to the board's setup.c. At a bare minimum,
>>>> -   this must be defined as something like:
>>>> +   this must be defined as something like::
>>>>
>>>>  	struct sh_machine_vector mv_vapor __initmv = {
>>>>  		.mv_name = "vapor",
>>>> @@ -202,11 +208,11 @@ Large portions of the build system are now entirely dynamic, and merely
>>>>  require the proper entry here and there in order to get things done.
>>>>
>>>>  The first thing to do is to add an entry to arch/sh/Kconfig, under the
>>>> -"System type" menu:
>>>> +"System type" menu::
>>>>
>>>> -config SH_VAPOR
>>>> -	bool "Vapor"
>>>> -	help
>>>> + config SH_VAPOR
>>>> +	 bool "Vapor"
>>>> +	 help
>>>>  	  select Vapor if configuring for a FooTech Vaporboard.
>>>>
>>>>  next, this has to be added into arch/sh/Makefile. All boards require a
>>>> @@ -232,6 +238,8 @@ space restating it here. After this is done, you will be able to use
>>>>  implicit checks for your board if you need this somewhere throughout the
>>>>  common code, such as:
>>>>
>>>> +::
>>>> +
>>>>  	/* Make sure we're on the FooTech Vaporboard */
>>>>  	if (!mach_is_vapor())
>>>>  		return -ENODEV;
>>>> @@ -253,12 +261,13 @@ build target, and it will be implicitly listed as such in the help text.
>>>>  Looking at the 'make help' output, you should now see something like:
>>>>
>>>>  Architecture specific targets (sh):
>>>> -  zImage                  - Compressed kernel image (arch/sh/boot/zImage)
>>>> -  adx_defconfig           - Build for adx
>>>> -  cqreek_defconfig        - Build for cqreek
>>>> -  dreamcast_defconfig     - Build for dreamcast
>>>> -...
>>>> -  vapor_defconfig         - Build for vapor
>>>> +
>>>> + - zImage                  - Compressed kernel image (arch/sh/boot/zImage)
>>>> + - adx_defconfig           - Build for adx
>>>> + - cqreek_defconfig        - Build for cqreek
>>>> + - dreamcast_defconfig     - Build for dreamcast
>>>> + - ...
>>>> + - vapor_defconfig         - Build for vapor
>>>>
>>>>  which then allows you to do:
>>>>
>>>> diff --git a/Documentation/sh/register-banks.txt b/Documentation/sh/register-banks.rst
>>>> similarity index 90%
>>>> rename from Documentation/sh/register-banks.txt
>>>> rename to Documentation/sh/register-banks.rst
>>>> index a6719f2f6594..acccfaf80355 100644
>>>> --- a/Documentation/sh/register-banks.txt
>>>> +++ b/Documentation/sh/register-banks.rst
>>>> @@ -1,8 +1,9 @@
>>>> -	Notes on register bank usage in the kernel
>>>> -	==========================================
>>>> +==========================================
>>>> +Notes on register bank usage in the kernel
>>>> +==========================================
>>>>
>>>>  Introduction
>>>> -------------
>>>> +============
>>>>
>>>>  The SH-3 and SH-4 CPU families traditionally include a single partial register
>>>>  bank (selected by SR.RB, only r0 ... r7 are banked), whereas other families
>>>> @@ -30,4 +31,3 @@ Presently the kernel uses several of these registers.
>>>>  		- The SR.IMASK interrupt handler makes use of this to set the
>>>>  		  interrupt priority level (used by local_irq_enable())
>>>>  	- r7_bank (current)
>>>> -
>>>> --
>>>> 2.17.1
>>>>  
>>>
>>> Thanks,
>>> Mauro  
>> Regards,
>>
>> Vandana.
>>
>
>
> Thanks,
> Mauro

Thanks,

Vandana.

