Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A398C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A49206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKUOYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:24:16 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:39615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKUOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:24:16 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MZl1l-1iJIoD2KLX-00WmYZ for <linux-kernel@vger.kernel.org>; Thu, 21 Nov
 2019 15:24:14 +0100
Received: by mail-qt1-f175.google.com with SMTP id y10so3867350qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:24:14 -0800 (PST)
X-Gm-Message-State: APjAAAVt8PEPg9vcPcEcDnanxHqg8ddOE0vbddz1ysqLg4T+vCpiKMVT
        2dGjB/Xqo9RTR4lp3ic6PF1h+kGEeDabDgPjhyc=
X-Google-Smtp-Source: APXvYqxFuJH0j+fTO645LFq3XWUle+OVKIIWeKTMT9rd4eBnk7TfSc6qphGLOOeNOrVmq3kG2kK5oJwj2Q5qEsXSZb8=
X-Received: by 2002:ac8:2e57:: with SMTP id s23mr8721925qta.204.1574346253447;
 Thu, 21 Nov 2019 06:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108210824.1534248-7-arnd@arndb.de>
 <4faa78cd0a86cf5d0aea9bb16d03145c5745450b.camel@codethink.co.uk>
In-Reply-To: <4faa78cd0a86cf5d0aea9bb16d03145c5745450b.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Nov 2019 15:23:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1nRq98ngfKnR2Du+7_vOxSRFD9AyjHyUCsAtk_gLR_Uw@mail.gmail.com>
Message-ID: <CAK8P3a1nRq98ngfKnR2Du+7_vOxSRFD9AyjHyUCsAtk_gLR_Uw@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 07/23] y2038: vdso: powerpc: avoid timespec references
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Allison Randal <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:thaGe92lauKzvGRpUcTnzklgacYNQOLlCOIaImyQHuC4rJ3uDLN
 ypAEvW2QRbIGLU2U6yNMSoGFVZgSbbvAIE1H/55ebeflCeLoVt5NksysZV5SnZmg3PAzJJz
 j4lWdzBt817cHj9RVYZsQf+cYAo2cEs8wYE4sohCC+6ShB9iJ096ncjz7mFrrbM6veakI5N
 laJteiTExGWpydD7G52tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P9YvcJrdvJc=:+xITPrYapp+AP8gREjnW0y
 YFp+4U3kjPJ7Ne/+pH1AGbYUiFCdQZAcZyJLicyQdmQHnP5qRLcNT2cEWtg0omdfzQCIHfiOa
 oU9bu8b3EypstVblmHiU/HbIqmbaBIwfomcQ8KtjcxWPIIfS0ufWjK5xownN6OrGqB8oz/Bhj
 woWUgwMId9h3+WJU5N8z/TcjE8nkAquMrlJKnmN6zRh6PHxE+IDsNplHIyeoXxMqp5QMBCXD5
 JKkUa5czzUghrH/aoDCA/ZIBwhLeWdibAQpnP6+ApjktFqzWT8lY1iqKQee+ALb5QtybwbuEw
 leYHU8pJeeWE7yANkgX/98JkYan4LvDomWIin8vuZvzvuTM5V5uALZqVSiyMcuhvFmmzaysXl
 POAc9+DnaeHVeyTXpmk9Wx2JGkXlSJ7STw1xo+vMR/TBqc/X+eBqkEODc5/9Zuw41ooP5nSQ9
 NePK9J12HbYW0isX8PQYYVi18f0NK829xItxjqbIVZMah0LAU5ISaFbUHDrUauLMdjlD3TXD+
 lNkprUP6E/H1UmTY+B26JgE34hx7wNrgtBqyMIpseOmnwTKtz5b9Cg9JiX6r6zZYXbDyDqTEX
 Hk0Z8M8xtw1uXZnWARTlkZe59NZt0tDL+FsC4M3KTmNuOfWhsF+Hqugajzmkx8fK6/+LidreD
 /lz+eWYHG8zjnVqPva/GgZJJhow2b9+MDOZTbBH7UXgIjVVXYTJIBmmADBoJt4oHA29U3XRNc
 dQtv/DEcFxK9/GzKbeCt1kUixr7LSHyCiDES1OiEWqojpxMEJ0d+R+hW/v16Kt1swyADEG/1M
 hZVq5NKUAk/Lre3p0QJCnHJ2BEVtQYuaN2rSBnBK+wnrqsumQjaAmmHb5iO1S1kx7f8g61S6B
 XvaaRJlsftCBUWTm4ubw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 11:43 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
> [...]
> > --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
> > +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
> > @@ -15,10 +15,8 @@
> >  /* Offset for the low 32-bit part of a field of long type */
> >  #if defined(CONFIG_PPC64) && defined(CONFIG_CPU_BIG_ENDIAN)
> >  #define LOPART       4
> > -#define TSPEC_TV_SEC TSPC64_TV_SEC+LOPART
> >  #else
> >  #define LOPART       0
> > -#define TSPEC_TV_SEC TSPC32_TV_SEC
> >  #endif
> >
> >       .text
> > @@ -192,7 +190,7 @@ V_FUNCTION_BEGIN(__kernel_time)
> >       bl      __get_datapage@local
> >       mr      r9, r3                  /* datapage ptr in r9 */
> >
> > -     lwz     r3,STAMP_XTIME+TSPEC_TV_SEC(r9)
> > +     lwz     r3,STAMP_XTIME_SEC+LOWPART(r9)
>
> "LOWPART" should be "LOPART".
>

Thanks, fixed both instances in a patch on top now. I considered folding
it into the original patch, but as it's close to the merge window I'd
rather not rebase it, and this way I also give you credit for finding the bug.

I'm surprised that the 0-day bot did not report this already.

Thanks fro the careful review!

        Arnd

commit 1c11ca7a0584ddede5b8c93057b40d31e8a96d3d (HEAD)
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Nov 21 15:19:49 2019 +0100

    y2038: fix typo in powerpc vdso "LOPART"

    The earlier patch introduced a typo, change LOWPART back to
    LOPART.

    Fixes: 176ed98c8a76 ("y2038: vdso: powerpc: avoid timespec references")
    Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S
b/arch/powerpc/kernel/vdso32/gettimeofday.S
index a7180b0f4aa1..c8e6902cb01b 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -190,7 +190,7 @@ V_FUNCTION_BEGIN(__kernel_time)
        bl      __get_datapage@local
        mr      r9, r3                  /* datapage ptr in r9 */

-       lwz     r3,STAMP_XTIME_SEC+LOWPART(r9)
+       lwz     r3,STAMP_XTIME_SEC+LOPART(r9)

        cmplwi  r11,0                   /* check if t is NULL */
        beq     2f
@@ -266,7 +266,7 @@ __do_get_tspec:
         * as a 32.32 fixed-point number in r3 and r4.
         * Load & add the xtime stamp.
         */
-       lwz     r5,STAMP_XTIME_SEC+LOWPART(r9)
+       lwz     r5,STAMP_XTIME_SEC+LOPART(r9)

        lwz     r6,STAMP_SEC_FRAC(r9)
        addc    r4,r4,r6
        adde    r3,r3,r5
