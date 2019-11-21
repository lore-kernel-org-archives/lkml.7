Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0BAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8934820692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKUQZ3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:25:29 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:30567 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUQZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:25:29 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47JlKK4v2fz9tyYX;
        Thu, 21 Nov 2019 17:25:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZzcxYupBwo2Z; Thu, 21 Nov 2019 17:25:25 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47JlKK3y07z9tyYW;
        Thu, 21 Nov 2019 17:25:25 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 38943C08; Thu, 21 Nov 2019 17:25:29 +0100 (CET)
Received: from 37-167-57-154.coucou-networks.fr
 (37-167-57-154.coucou-networks.fr [37.167.57.154]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Thu, 21 Nov 2019 17:25:29 +0100
Date:   Thu, 21 Nov 2019 17:25:29 +0100
Message-ID: <20191121172529.Horde.0uDMS4xQ-xexjp4a2mIoXQ5@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Allison Randal <allison@lohutok.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 07/23] y2038: vdso: powerpc: avoid timespec
 references
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108210824.1534248-7-arnd@arndb.de>
 <4faa78cd0a86cf5d0aea9bb16d03145c5745450b.camel@codethink.co.uk>
 <CAK8P3a1nRq98ngfKnR2Du+7_vOxSRFD9AyjHyUCsAtk_gLR_Uw@mail.gmail.com>
In-Reply-To: <CAK8P3a1nRq98ngfKnR2Du+7_vOxSRFD9AyjHyUCsAtk_gLR_Uw@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> a écrit :

> On Wed, Nov 20, 2019 at 11:43 PM Ben Hutchings
> <ben.hutchings@codethink.co.uk> wrote:
>>
>> On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
>> [...]
>> > --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
>> > +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
>> > @@ -15,10 +15,8 @@
>> >  /* Offset for the low 32-bit part of a field of long type */
>> >  #if defined(CONFIG_PPC64) && defined(CONFIG_CPU_BIG_ENDIAN)
>> >  #define LOPART       4
>> > -#define TSPEC_TV_SEC TSPC64_TV_SEC+LOPART
>> >  #else
>> >  #define LOPART       0
>> > -#define TSPEC_TV_SEC TSPC32_TV_SEC
>> >  #endif
>> >
>> >       .text
>> > @@ -192,7 +190,7 @@ V_FUNCTION_BEGIN(__kernel_time)
>> >       bl      __get_datapage@local
>> >       mr      r9, r3                  /* datapage ptr in r9 */
>> >
>> > -     lwz     r3,STAMP_XTIME+TSPEC_TV_SEC(r9)
>> > +     lwz     r3,STAMP_XTIME_SEC+LOWPART(r9)
>>
>> "LOWPART" should be "LOPART".
>>
>
> Thanks, fixed both instances in a patch on top now. I considered folding
> it into the original patch, but as it's close to the merge window I'd
> rather not rebase it, and this way I also give you credit for  
> finding the bug.

Take care, might conflict with  
https://github.com/linuxppc/linux/commit/5e381d727fe8834ca5a126f510194a7a4ac6dd3a

Christophe

>
> I'm surprised that the 0-day bot did not report this already.
>
> Thanks fro the careful review!
>
>         Arnd
>
> commit 1c11ca7a0584ddede5b8c93057b40d31e8a96d3d (HEAD)
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Thu Nov 21 15:19:49 2019 +0100
>
>     y2038: fix typo in powerpc vdso "LOPART"
>
>     The earlier patch introduced a typo, change LOWPART back to
>     LOPART.
>
>     Fixes: 176ed98c8a76 ("y2038: vdso: powerpc: avoid timespec references")
>     Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S
> b/arch/powerpc/kernel/vdso32/gettimeofday.S
> index a7180b0f4aa1..c8e6902cb01b 100644
> --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
> @@ -190,7 +190,7 @@ V_FUNCTION_BEGIN(__kernel_time)
>         bl      __get_datapage@local
>         mr      r9, r3                  /* datapage ptr in r9 */
>
> -       lwz     r3,STAMP_XTIME_SEC+LOWPART(r9)
> +       lwz     r3,STAMP_XTIME_SEC+LOPART(r9)
>
>         cmplwi  r11,0                   /* check if t is NULL */
>         beq     2f
> @@ -266,7 +266,7 @@ __do_get_tspec:
>          * as a 32.32 fixed-point number in r3 and r4.
>          * Load & add the xtime stamp.
>          */
> -       lwz     r5,STAMP_XTIME_SEC+LOWPART(r9)
> +       lwz     r5,STAMP_XTIME_SEC+LOPART(r9)
>
>         lwz     r6,STAMP_SEC_FRAC(r9)
>         addc    r4,r4,r6
>         adde    r3,r3,r5


