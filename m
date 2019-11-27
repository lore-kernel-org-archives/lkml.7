Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D2DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82445206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfK0LDa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:03:30 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:55873 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfK0LDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:03:30 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MRTAj-1iD0MU3YvN-00NVDI for <linux-kernel@vger.kernel.org>; Wed, 27 Nov
 2019 12:03:28 +0100
Received: by mail-qv1-f46.google.com with SMTP id n4so8669365qvq.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 03:03:27 -0800 (PST)
X-Gm-Message-State: APjAAAWBS2JeH5+w66y0ypTHecbulDc0BjDCxZIGa4CmsGlF1Ej6FkVt
        Ns47rY5nRCHXrDyAr/BsqF2NV+zZwo5WkdyaJBo=
X-Google-Smtp-Source: APXvYqwmp0jMVDNBAg5Ce+DrmGPMsvhfoXfGimwzPrdDUyP5QLgu2P8EbsdO2pJC6f5IQpMB/jWTwEPfCh84ScTptRw=
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr4010401qvp.210.1574852606738;
 Wed, 27 Nov 2019 03:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108210824.1534248-7-arnd@arndb.de>
 <4faa78cd0a86cf5d0aea9bb16d03145c5745450b.camel@codethink.co.uk>
 <CAK8P3a1nRq98ngfKnR2Du+7_vOxSRFD9AyjHyUCsAtk_gLR_Uw@mail.gmail.com> <20191121172529.Horde.0uDMS4xQ-xexjp4a2mIoXQ5@messagerie.si.c-s.fr>
In-Reply-To: <20191121172529.Horde.0uDMS4xQ-xexjp4a2mIoXQ5@messagerie.si.c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Nov 2019 12:03:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1UmAYTx=Vv06xP=O-oYD8_HzNqMG0-p7GPP2xgzs+75w@mail.gmail.com>
Message-ID: <CAK8P3a1UmAYTx=Vv06xP=O-oYD8_HzNqMG0-p7GPP2xgzs+75w@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 07/23] y2038: vdso: powerpc: avoid timespec references
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Allison Randal <allison@lohutok.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:KLBBNemZSjNC+oKZynuooVbZo1d1aCfMnaeopGCWMy6uQ9Cv1kt
 7vodX9PPh2ltodXRy+Y5czyxJKvISXPy3v1CXZO2UOdRZhbVe3y5bxQxolS93cKFfYe1Jjh
 6n8vi4qXYWtyeooERKjLzNK88RoEczOtSjaaLVie31WrhE7LPmNXviptHrfVYya02LK7qTz
 P/6ceKDa1VJfLr71vjUFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bpVHpxornUE=:JgYt47+lOVLRGKgW1IHbTm
 HcGlvM+81BcWGJijFYmTQ8f2p+pucTCyzFdhIinCdPKdRndQcNubgHuCNziaWnM0vd5Tcrdz8
 mM6XpBR7Ph9bjjhizKQ+roqlC1B/U9yiz7RksiqZ0riF0kSO4VgU7lzOwKlJvnt3knCnk8wm3
 CsQx6imxyMlj1VlOhbpGhISjanv5MOKitK+Y4Sp+Nq0iA5uJNWEQ3yMGJFy1k9akYcTUwqUiu
 Mo+R6hu2SzWNvaSuFNMs2zPFx51UoAxNumEBTYzwg9ke1kIvJweRRIQA9gwfRLKx01xX5VeYC
 mHHYLhT6OegiHq71HVQhGvhWSUsHXh0DWvXOhnmt+3bYs1EBWsEo78fChDi60M6c1xZ6PpxSC
 uuFjoxR8eP6JwfQrsOwkWorbSP8KLKyH1eoG9ezCrlTLnPtfzhjjasiuRl3JyOxdHx4OwiJRy
 zR2wHTffqEn5dsEtZm3KcmnbVqjHuAKcg1iKUZgRcqBhfPvt6nCKWmYAPAc+WlabgAvOpSJ/l
 Wa+wQXcprW4ZNDbbfhgxzfbH883yZe216iF5Sf3aq9HLTQdt4Y/WTjlrm03O0YQkXpZKbpHY8
 JzBQqR7WkLc4aa36giGZp3wKwIUKDTrY8dN9l9Naj5l57HOS5vIfJNyj7WEUVxZUE+lPyGs9r
 rihZh0EPft5SScQos8APgqFPv8uDmVw1/dqIrNudmPvQ2HVZ153o8XVowSboyQTx0OwdEpCW7
 HChUGJbV4/ZOcQ+Ky8UNd3DumbuliYYeVDzjHROREblMzoDBaqb9ukLf8zSCfyZIAJaU5GN0O
 k4oPQ8VmDcH4UmMp580qKmisCtFV1zgr2EXy8+zQZkeU8Th3LV7/wAiyjuBp2s5TMT2dHaKBh
 OuOelbuZsclYcAGiMC9g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 5:25 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Arnd Bergmann <arnd@arndb.de> a écrit :
> > On Wed, Nov 20, 2019 at 11:43 PM Ben Hutchings
> > <ben.hutchings@codethink.co.uk> wrote:
> >>
> >> On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
> >> > @@ -192,7 +190,7 @@ V_FUNCTION_BEGIN(__kernel_time)
> >> >       bl      __get_datapage@local
> >> >       mr      r9, r3                  /* datapage ptr in r9 */
> >> >
> >> > -     lwz     r3,STAMP_XTIME+TSPEC_TV_SEC(r9)
> >> > +     lwz     r3,STAMP_XTIME_SEC+LOWPART(r9)
> >>
> >> "LOWPART" should be "LOPART".
> >>
> >
> > Thanks, fixed both instances in a patch on top now. I considered folding
> > it into the original patch, but as it's close to the merge window I'd
> > rather not rebase it, and this way I also give you credit for
> > finding the bug.
>
> Take care, might conflict with
> https://github.com/linuxppc/linux/commit/5e381d727fe8834ca5a126f510194a7a4ac6dd3a

Sorry for my late reply. I see this commit and no other variant of it has
made it into linux-next by now, so I assume this is not getting sent for v5.5
and it's not stopping me from sending my own pull request.

Please let me know if I missed something and this will cause problems.

On a related note: are you still working on the generic lib/vdso support for
powerpc? Without that, future libc implementations that use 64-bit time_t
will have to use the slow clock_gettime64 syscall instead of the vdso,
which has a significant performance impact.

       Arnd
