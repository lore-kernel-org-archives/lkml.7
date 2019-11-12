Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3071C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803F521925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLUIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:08:36 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55641 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLUIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:08:35 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N0Fl9-1higyr1zj5-00xID3 for <linux-kernel@vger.kernel.org>; Tue, 12 Nov
 2019 21:08:34 +0100
Received: by mail-qt1-f174.google.com with SMTP id o11so21152997qtr.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:08:34 -0800 (PST)
X-Gm-Message-State: APjAAAXz43Um5obq/zTqmXz/Ql4aFZOuLS4EfrbbeGjJp8N9a8GafiJ1
        jnka7PE3APLMH0X9AxH6kHevvXP87wEVrH/k+uU=
X-Google-Smtp-Source: APXvYqy6WDtN0kyefSVskwvyTaVRgD8eTS4RnVNusDWhrPxsHPli8rDwtqG+OjX/Sb98lfp4nNr3KxTDQp3XRFCTxg4=
X-Received: by 2002:aed:3e41:: with SMTP id m1mr24440779qtf.142.1573589313436;
 Tue, 12 Nov 2019 12:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de> <20191112151642.680072-3-arnd@arndb.de>
 <s5hblthp0di.wl-tiwai@suse.de>
In-Reply-To: <s5hblthp0di.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Nov 2019 21:08:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1fsC+05i-i77g2aR3bkzprnhbhROLkMPcy=UFfsV3GMw@mail.gmail.com>
Message-ID: <CAK8P3a1fsC+05i-i77g2aR3bkzprnhbhROLkMPcy=UFfsV3GMw@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] ALSA: Avoid using timespec for struct snd_timer_status
To:     Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:B2OtIH0U59TKgQl8RTb3yjMK5RiLw/ubtkhw+Ip77ePsu61sAUG
 KAQrAJkDIOrc6c/wLMmRGgjssjjVUDCxNQee/k1VIgdDnG4zRsRrgtfV2zC+q/lCampRvMN
 fXNp276UtoCbJU5j234ZLo7BAMW4rMPAX4AQb0pbQUHEh9HBKbe/mq2v31w21Ai3hKPKv7I
 5bHNqJjbcspsy8cA9Mhsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U0vH3+zzWfc=:CcirlqD55N4wBIDjpq1sRE
 RMe9k0Jg5DtgaYxPWVlxYjFC5UAQblbUv7eISWD77IGahjlcZp1lmgOCWB4K8Sl4cgf1Bq7DS
 JYYef6edInrLuZu7FJ/ZSARIg5SKB+IzEXXDlVCEVpUVVD/b03jGrwisuCAEYRdyQ4pcmK4gq
 CogbgNlLuBH4WSPs0FcN6YMSuqz/vGe1VzyRX77xMmNQSSlhRBR8XA3mEm++AnEMDDM5hrHAV
 AHSEFkSySc6q/VyIQrrJ54jfEaxuOg7D4g5t1D6JRGhBFmmxfoXp4jOQz3VxCPEsGsXvJyD5I
 8vhZVsPSGlSZVGtlOo3Tr6trgI3/myvrUz92MBKWBQD4dc/DwNh23owWvR0qkVK4nnPhvMJ7l
 Cw5p0avMV2UXn+ZfEQod7Zd6k+6cpQMPFCAVobz08I7xJ3CJp4+bRPHoSjBENA5YmKCb4F8E1
 fOSxELjkuS+4nsbc+3a6IhMrLlVixkA5bm4s/3wiVAIsxttFhbSmpqa8EJq4PgPKIh5Acm9X8
 AXEUpzWw7FNZzqF4a4Ex4IW1nsKiwGpYzv0k/r14t/wecWs63uLJQ9kteekncI0y5VIiw7boE
 hgkXPNLzBecF2Vhhk1ayBBp/PwU2UWyeqAAFdq0DNSVghcZa2cIDJ4mgk99gmbE6mBZnZvnl+
 NwH4h6EW58eSsyjr6iHq/2MaYsjK4aSWZp4toQAMD+m4+vXFBcQUOZPwrJZYIfP7HjvdQlmno
 02Wrn4fc++sB7bYG3/jiCFhgPwMAGXfwZtsG5jwE0SlbvvNn/r1x1AqavVVmZuy9m95LXxtRt
 8/OYNc/DbuVHF0fpkpXj5LTiPuH4eKK2zScGKzd6hgO21zzSM/8lu72GEpGBISgoREQfcvBbS
 n0cohdKWA3N/LW8aLrLQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 4:42 PM Takashi Iwai <tiwai@suse.de> wrote:

> > @@ -761,6 +761,7 @@ struct snd_timer_params {
> >       unsigned char reserved[60];     /* reserved */
> >  };
> >
> > +#ifndef __KERNEL__
> >  struct snd_timer_status {
> >       struct timespec tstamp;         /* Timestamp - last update */
> >       unsigned int resolution;        /* current period resolution in ns */
>
> Do we need this ifndef?  Is it for stopping the reference of struct
> snd_timer_status from the kernel code but only 32 and 64 variants?

Well spotted, this is indeed a very recent change I did to the patch.
The idea here is to hide any use of 'time_t', 'timespec' and 'timeval'
from kernel compilation. These types are now defined in an incompatible
way by libc, so we have to remove them from the kernel's uapi headers.
I would prefer to remove them completely from the kernel (rather than
moving them from uapi to internal headers) to make it harder to write
y2038-incompatible code, and with the 90 patches I sent this week,
all users are gone from the kernel (this series was the last part).

Interestingly, hiding snd_timer_status from the drivers /also/ caught
a but in a file when I had missed a reference that needed to be converted
to snd_timer_status64.

     Arnd
