Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D19C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A625322467
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfKMOdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:33:03 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:60981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfKMOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:33:03 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M2ep5-1iSQj42oM3-004Fql for <linux-kernel@vger.kernel.org>; Wed, 13 Nov
 2019 15:33:01 +0100
Received: by mail-qt1-f177.google.com with SMTP id g50so2784185qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 06:33:01 -0800 (PST)
X-Gm-Message-State: APjAAAUeOrh/x1ZdPEHEpTpmZ1GyOCYI6a54Q7CUcBQcVNMSB7ApbtXI
        oecx94FUW7zXcFJx7wYStJLHU3l6l1BJ3cTl4SE=
X-Google-Smtp-Source: APXvYqz+NQ3szRq7ultpigH8h2DRxd7RVxK5NJkwffgwZnkBYVjsay5MymzE3H4vFL1qe/jNlYuVA1/LMaohhg43P3E=
X-Received: by 2002:ac8:2e57:: with SMTP id s23mr2862709qta.204.1573655580605;
 Wed, 13 Nov 2019 06:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de> <s5hk1847rvm.wl-tiwai@suse.de>
In-Reply-To: <s5hk1847rvm.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 15:32:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2TMEUhzxH7RKvAW9STk33KrbCriUaQawOMffoFC6UTQw@mail.gmail.com>
Message-ID: <CAK8P3a2TMEUhzxH7RKvAW9STk33KrbCriUaQawOMffoFC6UTQw@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Fix year 2038 issue for sound subsystem
To:     Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qwRt3oLZdIBKV6GulKVqVXE3qKnOQkaP/imQuEIOK8q/InHpeg5
 PRhT2Dn61unSfy9cFkOaHsN/YmTbaft/zv33zlHNIxmUuDT0E19ucy8YMHIi9oNAe39GM3n
 tdAeWfUHyyjskC6S0w6pjaCF6feJRFQu9rlEL8fYy6681KWdNhuu5u0LMwxdwYvrCWaMygX
 2kLbV4jkEoeiRGw0tjCVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:prl9kaqppwE=:atvZwNTQP/OxBJQTgiZsj1
 79qp+pl9vhguXmzRtEhFGtMr7nEONZ1KpWWN4JmG5AUPzWjYysyjA7r8uGgF4T/fbaqypJBpf
 u0gbYIFkgec/EUrqLH3LMG0sP80jnr0t1+GwCZYkSN4oESvjZZStHI4xem2Vl1hssLDAiyTt3
 FCXaBdMU6Ew4R2o55Q0znQmfaAnJb4O73btMqL0m9o+Ht2bD95FmLYDs0EggTcnVCrLh7xyp4
 gZu2BNvUE8TJTJa0T14eUZxADd9pTZapL4IcXVUh2Je6BMDVrGRhjfIRDeI/LoOEruezD9GoV
 kxLg0XlMcgSEjnnPKozO9f/UeFd1Gfu25wHcpU2sMzJFwf6MgTqaR+8Zu2/0by5qZKvqMb/tN
 0cMsKmHHUbhMumPc/gMD4Z3S/zfH5cAeAKHVKhvINba8fPZVrVfQHxZf8omuUdgn25DH1Ta41
 SDx9eXYKW1NDdtTHDF4bD/DfeByPpO5y4n9NGlcHe3cSDtO4splr/HvF7m1Gnmkgr2hVM60Vb
 xBitMaEP2Ej3uO9uLYemUr2+jrV7ExGhhghq5eA3phwpWCy/TF2I61NTUxFxoFrKEX87fbQAF
 HW5PsiL3Jkd/mo7EKpXg7iZrBg7ne6QygzSQzcklvMmQdOjClNYAehDHpC2lV5n/oMxmYDENv
 upN3BngQfGVr9YcYkGCkWOUY2d4PsIFgW/bWetTcQ+thsvWJXX97t717xsHH5ncoEmyaxffdE
 BzuMCvek3jPU3C1l5r3gRH7D7TdWPX9vjKByc2MYWJdsGny6lhUDdoXyHS+f0uGCAjmc0ng04
 LVTiFNDL559YgbJ0HvxHO6j7DviWGqqSp80V5I3tYKDC1bt8yjRXiFJNGs0wqallXmK8daCFs
 cnLzhI/gNTdIz27osrFw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 9:37 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 12 Nov 2019 16:16:34 +0100, Arnd Bergmann wrote:
> > I would like to propose merging this into the alsa tree after
> > the v5.5 merge window for inclusion into v5.6, to allow a good
> > amount of testing, in particular for the header changes that
> > may cause problems for user space applications.
>
> Agreed, it's still no urgent problem.

I actually do think it's getting urgent, anything that touches
the ABI must be done carefully and not rushed.

The urgency at the moment is that developers are starting to
deploy systems with 64-bit time_t with musl-libc making this
the default now, and 32-bit risc-v not offering 32-bit time_t at all.

At the moment, this means that audio support is broken for
them, and that needs to be fixed.

The other reason why lots of people care about moving all user
space to 64-bit time_t is that 32-bit hardware is slowly starting
to become less common. We know there will still be many
32-bit ARM systems operational in 2038, but most of them will
be on (then) 10+ year old hardware, running even older software
that already being worked on today. The longer it takes us to
stop using 32-bit time_t in user space, the more systems will
end up having to be thrown away rather than fixed.

> So now taking a quick look through the series, I find this approach is
> the way to go.  Although one might get a bit more optimization after
> squeeze, it's already a good compromise between the readability and
> the efficiency.

Thanks!

> A slight uncertain implementation is the timer tread stuff, especially
> the conditional definition of SNDRV_TIMER_IOCTL_TREAD (IIRC, I already
> complained it in the past, too).  But I have no other idea as well, so
> unless someone else gives a better option, we can live with that.

We had discussed alternatives for this one last time, and decided
to go with the solution I posted here. The main alternative would
be to change the 'timespec' in snd_timer_tread to a fixed-length
structure based on two 'long' members. This would avoid the
need to match the command with the time_t type, but the cost would
be requiring CLOCK_MONOTONIC timestamps to avoid the
overflow, and changing all application source code that requires
the type to be compatible with 'timespec'.

     Arnd
