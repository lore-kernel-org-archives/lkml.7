Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58059C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82F1216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="JTRaeYOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfETVWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:22:00 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34016 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfETVV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:21:59 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0419A886BF
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 09:21:55 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1558387315;
        bh=SK7aHFkquxfk/MAClvJERYuUb851/XyeRmz0MwsxtCQ=;
        h=From:To:CC:Subject:Date:References;
        b=JTRaeYOHW4QIcOkZiHmH82c/rLPybZ18wIf60TPxk22cyJ4fFkK4h2r7wMMSF/H96
         rjUvM8G6u4QEr8IX5ySsvA9f9iljnUW5Suy69pOVMdrbE8JIL6EXc/l0HyzNutiaZI
         xExFfoImwSVOHB8qhjF/N5g13C/mAHqU6RyeQ7jEhklHPrxTZfOG23/V4CLUVZO/5O
         dndf4foua4KW9IWDInqEGvmuGmf6ydlHeu/ArhxsoB/g1NM2yY2T8sudqQbZgoGgPq
         kjrVwMOcZpIY1Ht0GiIidIo9WjL8gS5jOnKYao3mupgL6PMw4pF/Z5Hp8VRuj7JsVO
         TET8cJeeIepRw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ce31a730001>; Tue, 21 May 2019 09:21:55 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Tue, 21 May 2019 09:21:54 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Tue, 21 May 2019 09:21:54 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Kees Cook <keescook@chromium.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG v5.2-rc1] ARM build broken
Thread-Topic: [BUG v5.2-rc1] ARM build broken
Thread-Index: AQHVDz1jcyWtimRaYka0QV8JvnzTqg==
Date:   Mon, 20 May 2019 21:21:54 +0000
Message-ID: <3610cb7ca542479d8eb124e9c9dd6796@svr-chch-ex1.atlnz.lc>
References: <4DB08A04-D03A-4441-85DE-64A13E6D709C@goldelico.com>
 <201905200855.391A921AB@keescook>
 <D8F987B2-8F41-46DE-B298-89541D7A9774@goldelico.com>
 <201905201142.CF71598A@keescook>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/19 6:54 AM, Kees Cook wrote:=0A=
> [Adding Chris and Ard, who might have more compiler versions that me...]=
=0A=
=0A=
Late to the thread but ...=0A=
=0A=
> =0A=
> On Mon, May 20, 2019 at 07:08:39PM +0200, H. Nikolaus Schaller wrote:=0A=
>>> Am 20.05.2019 um 17:59 schrieb Kees Cook <keescook@chromium.org>:=0A=
>>>=0A=
>>> On Mon, May 20, 2019 at 05:15:02PM +0200, H. Nikolaus Schaller wrote:=
=0A=
>>>> Hi,=0A=
>>>> it seems as if ARM build is broken since ARM now hard enables CONFIG_H=
AVE_GCC_PLUGINS=0A=
>>>> which indirectly enables CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK. Compiling=
 this breaks=0A=
>>>> on my system (Darwin build host) due to conflicts in system headers an=
d Linux headers.=0A=
>>>>=0A=
>>>> So how can I turn off all these GCC_PLUGINS?=0A=
>>>>=0A=
>>>> The offending patch seems to be=0A=
>>>>=0A=
>>>> 	security: Create "kernel hardening" config area=0A=
>>>>=0A=
>>>> especially the new "default y" for GCC_PLUGINS. After removing that li=
ne from=0A=
>>>> scripts/gcc-plugins/Kconfig makes my compile succeed.=0A=
>>>=0A=
>>> The intention is to enable it _if_ the plugins are available as part of=
=0A=
>>> the build environment. The "default y" on GCC_PLUGINS is mediated by:=
=0A=
>>>         depends on HAVE_GCC_PLUGINS=0A=
>>=0A=
>> HAVE_GCC_PLUGINS has the following description:=0A=
>>=0A=
>> 	An arch should select this symbol if it supports building with=0A=
>>            GCC plugins.=0A=
>>=0A=
>> So an ARCH (ARM) selects it unconditionally of the build environment.=0A=
>>=0A=
>>>         depends on PLUGIN_HOSTCC !=3D ""=0A=
>>=0A=
>> Well, we have it set to "g++" for ages and it was not a problem.=0A=
>> So both conditions are true.=0A=
> =0A=
> PLUGIN_HOSTCC should have passed the scripts/gcc-plugin.sh test, so=0A=
> that's correct. And the result (CONFIG_GCC_PLUGINS) is correct: it=0A=
> doesn't enable or disable anything itself.=0A=
> =0A=
> What you want is to disable CONFIG_STACKPROTECTOR_PER_TASK, which=0A=
> is the knob for the feature:=0A=
> =0A=
> config STACKPROTECTOR_PER_TASK=0A=
>          bool "Use a unique stack canary value for each task"=0A=
>          depends on GCC_PLUGINS && STACKPROTECTOR && SMP && !XIP_DEFLATED=
_DATA=0A=
>          select GCC_PLUGIN_ARM_SSP_PER_TASK=0A=
>          default y=0A=
> =0A=
>> Build error:=0A=
>>=0A=
>>   HOSTCXX -fPIC scripts/gcc-plugins/arm_ssp_per_task_plugin.o - due to: =
scripts/gcc-plugins/gcc-common.h=0A=
>> In file included from scripts/gcc-plugins/arm_ssp_per_task_plugin.c:3:0:=
=0A=
>> scripts/gcc-plugins/gcc-common.h:153:0: warning: "__unused" redefined=0A=
>> #define __unused __attribute__((__unused__))=0A=
>> ^=0A=
> =0A=
> Does the following patch fix your build? (I assume that line is just a=0A=
> warning, but if not...)=0A=
> =0A=
> diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-c=
ommon.h=0A=
> index 552d5efd7cb7..17f06079a712 100644=0A=
> --- a/scripts/gcc-plugins/gcc-common.h=0A=
> +++ b/scripts/gcc-plugins/gcc-common.h=0A=
> @@ -150,8 +150,12 @@ void print_gimple_expr(FILE *, gimple, int, int);=0A=
>   void dump_gimple_stmt(pretty_printer *, gimple, int, int);=0A=
>   #endif=0A=
>   =0A=
> +#ifndef __unused=0A=
>   #define __unused __attribute__((__unused__))=0A=
> +#endif=0A=
> +#ifndef __visible=0A=
>   #define __visible __attribute__((visibility("default")))=0A=
> +#endif=0A=
>   =0A=
>   #define DECL_NAME_POINTER(node) IDENTIFIER_POINTER(DECL_NAME(node))=0A=
>   #define DECL_NAME_LENGTH(node) IDENTIFIER_LENGTH(DECL_NAME(node))=0A=
> =0A=
>>   HOSTLLD -shared scripts/gcc-plugins/arm_ssp_per_task_plugin.so - due t=
o target missing=0A=
>> Undefined symbols for architecture x86_64:=0A=
>>   "gen_reg_rtx(machine_mode)", referenced from:=0A=
>>       (anonymous namespace)::arm_pertask_ssp_rtl_pass::execute() in arm_=
ssp_per_task_plugin.o=0A=
> =0A=
> However, this part sounds more like what was fixed with=0A=
> 259799ea5a9a ("gcc-plugins: arm_ssp_per_task_plugin: Fix for older GCC < =
6")=0A=
> =0A=
> And maybe some additional fixes for 4.9 are needed?=0A=
> =0A=
>> This is because CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK became automatically =
enabled and was never=0A=
>> before. So the compiler may lack some library search path for building t=
his plugin (which we=0A=
>> did never miss).=0A=
> =0A=
> Right -- maybe CONFIG_STACKPROTECTOR_PER_TASK doesn't work with old gcc=
=0A=
> 4.9.2? I'll see if I can find that compiler version...=0A=
> =0A=
=0A=
My build environment is based on debian-jessie=0A=
=0A=
$ g++ --version=0A=
g++ (Debian 4.9.2-10) 4.9.2=0A=
=0A=
After the fix I posted (which is now commit 259799ea5a9a ("gcc-plugins: =0A=
arm_ssp_per_task_plugin: Fix for older GCC < 6")) I wasn't having any =0A=
more problems.=0A=
=0A=
=0A=
