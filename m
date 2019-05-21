Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06383C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AD3216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="tgVJYRM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfEULXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:23:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:22632 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfEULXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1558437817;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=rpbeDq7wzqmt9ft7sRkHSisqWNEwxI9L5yEX6LlBXnk=;
        b=tgVJYRM7IetLtTdQ7X3IEEBR/3XGIOedL5CRzFh3CKsswYG7eUSGhBd+DtKcbhgegt
        +N1R/KTgUy9bT17QMk2LhJ9Kr9P26uSGB0vl14FlLjJ2XyRqvG1U5tRbKOS8MZQGLhv8
        LmA8gIjEriyrTKBiR1WpEP5vzF+PVi4/sVhXTeM1IioI7fRzwRvHbFyFYU1LWZJp3FBg
        /NBdDHjVq/H1XwwtdJHQ8N7iz41ZStSZqvTu4R6cdbyHMTITOLFc6pWja/O9YhpvwMKB
        11s8XHWpJ6OqNDjXK0L/8w2ZIbHiUTdkhXTjs+7s1o47uiy8fCyeQsd5gGfI4bjCDJXy
        x/Sg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMkw43tdeo="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id j04dc1v4LBNNHTA
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 21 May 2019 13:23:23 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [BUG v5.2-rc1] ARM build broken
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <3610cb7ca542479d8eb124e9c9dd6796@svr-chch-ex1.atlnz.lc>
Date:   Tue, 21 May 2019 13:23:36 +0200
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A22646AB-300F-4E0A-95DE-06633C2A2986@goldelico.com>
References: <4DB08A04-D03A-4441-85DE-64A13E6D709C@goldelico.com> <201905200855.391A921AB@keescook> <D8F987B2-8F41-46DE-B298-89541D7A9774@goldelico.com> <201905201142.CF71598A@keescook> <3610cb7ca542479d8eb124e9c9dd6796@svr-chch-ex1.atlnz.lc>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Kees Cook <keescook@chromium.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

> Am 20.05.2019 um 23:21 schrieb Chris Packham =
<Chris.Packham@alliedtelesis.co.nz>:
>=20
> On 21/05/19 6:54 AM, Kees Cook wrote:
>> [Adding Chris and Ard, who might have more compiler versions that =
me...]
>=20
> Late to the thread but ...
>=20
>>=20
>> On Mon, May 20, 2019 at 07:08:39PM +0200, H. Nikolaus Schaller wrote:
>>>> Am 20.05.2019 um 17:59 schrieb Kees Cook <keescook@chromium.org>:
>>>>=20
>>>> On Mon, May 20, 2019 at 05:15:02PM +0200, H. Nikolaus Schaller =
wrote:
>>>>> Hi,
>>>>> it seems as if ARM build is broken since ARM now hard enables =
CONFIG_HAVE_GCC_PLUGINS
>>>>> which indirectly enables CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK. =
Compiling this breaks
>>>>> on my system (Darwin build host) due to conflicts in system =
headers and Linux headers.
>>>>>=20
>>>>> So how can I turn off all these GCC_PLUGINS?
>>>>>=20
>>>>> The offending patch seems to be
>>>>>=20
>>>>> 	security: Create "kernel hardening" config area
>>>>>=20
>>>>> especially the new "default y" for GCC_PLUGINS. After removing =
that line from
>>>>> scripts/gcc-plugins/Kconfig makes my compile succeed.
>>>>=20
>>>> The intention is to enable it _if_ the plugins are available as =
part of
>>>> the build environment. The "default y" on GCC_PLUGINS is mediated =
by:
>>>>        depends on HAVE_GCC_PLUGINS
>>>=20
>>> HAVE_GCC_PLUGINS has the following description:
>>>=20
>>> 	An arch should select this symbol if it supports building with
>>>           GCC plugins.
>>>=20
>>> So an ARCH (ARM) selects it unconditionally of the build =
environment.
>>>=20
>>>>        depends on PLUGIN_HOSTCC !=3D ""
>>>=20
>>> Well, we have it set to "g++" for ages and it was not a problem.
>>> So both conditions are true.
>>=20
>> PLUGIN_HOSTCC should have passed the scripts/gcc-plugin.sh test, so
>> that's correct. And the result (CONFIG_GCC_PLUGINS) is correct: it
>> doesn't enable or disable anything itself.
>>=20
>> What you want is to disable CONFIG_STACKPROTECTOR_PER_TASK, which
>> is the knob for the feature:
>>=20
>> config STACKPROTECTOR_PER_TASK
>>         bool "Use a unique stack canary value for each task"
>>         depends on GCC_PLUGINS && STACKPROTECTOR && SMP && =
!XIP_DEFLATED_DATA
>>         select GCC_PLUGIN_ARM_SSP_PER_TASK
>>         default y
>>=20
>>> Build error:
>>>=20
>>>  HOSTCXX -fPIC scripts/gcc-plugins/arm_ssp_per_task_plugin.o - due =
to: scripts/gcc-plugins/gcc-common.h
>>> In file included from =
scripts/gcc-plugins/arm_ssp_per_task_plugin.c:3:0:
>>> scripts/gcc-plugins/gcc-common.h:153:0: warning: "__unused" =
redefined
>>> #define __unused __attribute__((__unused__))
>>> ^
>>=20
>> Does the following patch fix your build? (I assume that line is just =
a
>> warning, but if not...)
>>=20
>> diff --git a/scripts/gcc-plugins/gcc-common.h =
b/scripts/gcc-plugins/gcc-common.h
>> index 552d5efd7cb7..17f06079a712 100644
>> --- a/scripts/gcc-plugins/gcc-common.h
>> +++ b/scripts/gcc-plugins/gcc-common.h
>> @@ -150,8 +150,12 @@ void print_gimple_expr(FILE *, gimple, int, =
int);
>>  void dump_gimple_stmt(pretty_printer *, gimple, int, int);
>>  #endif
>>=20
>> +#ifndef __unused
>>  #define __unused __attribute__((__unused__))
>> +#endif
>> +#ifndef __visible
>>  #define __visible __attribute__((visibility("default")))
>> +#endif
>>=20
>>  #define DECL_NAME_POINTER(node) IDENTIFIER_POINTER(DECL_NAME(node))
>>  #define DECL_NAME_LENGTH(node) IDENTIFIER_LENGTH(DECL_NAME(node))
>>=20
>>>  HOSTLLD -shared scripts/gcc-plugins/arm_ssp_per_task_plugin.so - =
due to target missing
>>> Undefined symbols for architecture x86_64:
>>>  "gen_reg_rtx(machine_mode)", referenced from:
>>>      (anonymous namespace)::arm_pertask_ssp_rtl_pass::execute() in =
arm_ssp_per_task_plugin.o
>>=20
>> However, this part sounds more like what was fixed with
>> 259799ea5a9a ("gcc-plugins: arm_ssp_per_task_plugin: Fix for older =
GCC < 6")
>>=20
>> And maybe some additional fixes for 4.9 are needed?
>>=20
>>> This is because CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK became =
automatically enabled and was never
>>> before. So the compiler may lack some library search path for =
building this plugin (which we
>>> did never miss).
>>=20
>> Right -- maybe CONFIG_STACKPROTECTOR_PER_TASK doesn't work with old =
gcc
>> 4.9.2? I'll see if I can find that compiler version...
>>=20
>=20
> My build environment is based on debian-jessie
>=20
> $ g++ --version
> g++ (Debian 4.9.2-10) 4.9.2
>=20
> After the fix I posted (which is now commit 259799ea5a9a =
("gcc-plugins:=20
> arm_ssp_per_task_plugin: Fix for older GCC < 6")) I wasn't having any=20=

> more problems.

Ok, fine.

So it indeed looks as if my host-g++ can not properly build gcc-plugins =
for
the arm cross-gcc. This may come from using Darwin as the build host... =
So
it may have/use/need a different gcc for building the gcc-plugin for
cross-building the kernel.

Hm. Yes. The cross-toolchain was bootstrapped from scratch. The HOSTCC
comes from Macports and may be a different version. So it is likely that
the HOSTCC from Macports can not build a compatible gcc-plugin for the
cross-gcc.

That seems to be a significant assumption about the build infrastructure
which now became permanently enabled by the "default y" for GCC_PLUGINS.

I am not sure what the right way forward is. Probably for me it is to =
find
out if I can fix my cross-toolchain. Or if the kernel should better =
check
if gcc-plugins can really be built, if they are automatically enabled.
Or keep all gcc-plugins disabled until explicitly configured for?

BR and thanks,
Nikolaus

