Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA092C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65B6222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfKMPQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:16:44 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:33143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKMPQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:16:44 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M9nAB-1iYSkg0OmL-005nZq for <linux-kernel@vger.kernel.org>; Wed, 13 Nov
 2019 16:16:43 +0100
Received: by mail-qt1-f173.google.com with SMTP id i17so2968573qtq.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 07:16:42 -0800 (PST)
X-Gm-Message-State: APjAAAW3D6yVxfoyLvJXQpUultoZXV0ZBULSBuenL0otp2zf7NU+n93p
        5EuEeRrfvFx1QRWkgkdfp6LzmdpxN282FdQBxf4=
X-Google-Smtp-Source: APXvYqyehADfYKSO2+PD82fjNQhlUg+YenUlni8gjYwpgnn1wwsKDRbqkoOHEizWW6rShGLfKQvAB5dcAbI2A6sp3mA=
X-Received: by 2002:ac8:18eb:: with SMTP id o40mr3132571qtk.304.1573658202039;
 Wed, 13 Nov 2019 07:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de> <20191112151642.680072-6-arnd@arndb.de>
 <s5hv9rpnj6m.wl-tiwai@suse.de> <CAK8P3a0esv0T6ALMXJW40B45Qy5BqVSV9rhSD_sVNUc1T+suEg@mail.gmail.com>
 <s5hmud07sfb.wl-tiwai@suse.de>
In-Reply-To: <s5hmud07sfb.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 16:16:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1gJAjyNK4R3k560VjC+sN=haWjhEX4SpgroRoMDQANiA@mail.gmail.com>
Message-ID: <CAK8P3a1gJAjyNK4R3k560VjC+sN=haWjhEX4SpgroRoMDQANiA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v6 5/8] ALSA: Avoid using timespec for struct snd_rawmidi_status
To:     Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:w8c9J836yo6UZO6KmrpyRuUqxnMbTWuYDwcpYfTS33uXwX/7qDE
 pMpgCGmLSrJQOAtBDKcVVpyZlnfxxkS4QyRVrrVOmUf+HLu0sVKHscKClROkQ1u4xE9Wqm6
 JVDzXYvuO6SERvf3MbK7LCLBg0v5asfrb1mhT58ICiCpEtC+zvfIYVax+3MJNDouDnVx+8G
 SHSQmlnFfmM2fJ88pX1ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mBoUOayJ3iE=:U0repeU/EoKSthIy62jAdR
 UM3EMmAqqq4NY17ljyK/+GxsdoeRyTVlWLzKpdKP2qxj1+k2R/EBazdXfpnvSazLjjPmum3X1
 1ka2F9XDL6vEARYcwktRtUW0F2l608xw3ncLht/+6Il0Y7yqhl0yzL+dgb4kr7qjULqFyds3t
 pdnLnHpSglJTWS8fmIOLMBy/wURnY2DPCuEPWues9GQCOHuxn1/mPBS4vSGo20ID7WnB6s2QY
 +1o8vwk4AR+zkPh08CG9Waf8Cr0L/2hVowFOc1ubNuzxyhso2Q6dW0MI3vCBX64kUJF7IQxvS
 r/xfFBYpkFddfMKYDXSLJJR4lTqTLM3mBCPJNlpR6gb4Bo+/HrD6z5GRXRrBOO5hPfSk67P8T
 fUhBrG/Jeck6Lpqirn0N0He4kUaLG0x86BNeY17zjlpQWdsPNn9K/E5KhY0x/8oWuUfP5TOcb
 dzwV9RdoYKqb7tA7g5qYq/HpEXW7DV8pDAU9SVmgEqYhIoTFovI76/O64Og4m1k7RB1TqvD/V
 gWGgl5SEHdPOPepehOP5h7gHdfobfO7QgLERdVrsemsB5BDS51X0cbAzKa/Cs6GldfALnu46B
 ILB4xRPRUpehEHygGBsrRn7MYSpDIoI1Qh8ODAsglIdu6/07TJWH2vpKH1ClNZmLOdgqk+Y05
 A2OwuTM4xQLz6XPXKoPvDvXKTNvna932Gnt5syEDe2tGIVevNaq7oxzedIqrk1vvZTV3JQwMx
 Av7S6RKy8Qz5feOMzkKlcgkIVUg2SLRFkiV/JCtaBYjAtPkPTco3WLpIpbonxHQO2in/ofRvW
 ojO8NgDA5DA8h5jLmttfv/WFH9FlkmBYPY1wK2u5mnfU0SW7UhVtzjUFan/96nHc2r5lEDod9
 ns5ZQcn28elIKBWeXdsA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 9:26 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 12 Nov 2019 21:04:10 +0100, Arnd Bergmann wrote:
> >
> > On Tue, Nov 12, 2019 at 5:38 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > On Tue, 12 Nov 2019 16:16:39 +0100, Arnd Bergmann wrote:
> > If you feel there is a problem with the padding syntax, how about enclosing
> > it in a typedef like:
> >
> > typedef struct { char pad[sizeof(time_t) - sizeof(int)]; } __time_pad;
> >
> > This typedef could be used in several structures from the other patches
> > as well.
>
> Yes, that improves the readability.

Ok, added this change to all instances, along with a description in
the changelog
when I add the typedef.

       Arnd
