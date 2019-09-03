Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F4C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C2021881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="kKTFo/ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfICFan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 01:30:43 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42370 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfICFan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:30:43 -0400
Received: by mail-ua1-f68.google.com with SMTP id n13so5076120uap.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 22:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5e8NU11wQpmTZzAjPbjvXoRys0WzexQTxIerJ/JngOQ=;
        b=kKTFo/ciFR3y8rsCb/3oMmwxdLxzWMn/U2BLuhSX1IqNRJwKjGyH8rIQwTjkFpcIPs
         mbAJc58qo4xJZphXnUkhwLwnY/oaLXcZ1C3YRE80gPSe0vCj4IwcLRsrfaTWpKtTNIlA
         3oLxW7JjiWwAsGppKCKbumbyi2uLsDe5Bno0Lv4M285ZUGV6PwKVTflcGoPd5I54M6ul
         uv5yrH15T0Fww42W5k9+zyESOGlzrJPR+laywzITD9TAa2cDqCihLylh8pY2cM5ZM25l
         xp2/19ZNAG2xa5O398xEckEbT6QxHJYbnSbbEJFW7PE2E/Z443aay1OQzyle9/GPG7Ck
         UW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5e8NU11wQpmTZzAjPbjvXoRys0WzexQTxIerJ/JngOQ=;
        b=TjwnNNfqTF9CBDAgrXEUZj0SZLK3pXoBszmbUImTkwnCj2nOK9pZn4S167ttZEWYVi
         urttE7MPe4BgSd9SzYazd+qMLDDqa7YRNKv2Ujfmrvf7GHhyB1sVVzK53r6WZXY1Pd87
         CoalHpfNRQTHvlYR7616Qxg7wly4iU6jQeZFV4xACxTjZo8+Ss9WMAg9YnThHJNKlD5y
         76GTKs/Iv+vIYVumNaPTBJSEfSKQLyQp+vDX5FLgh3xd7n7KAOHHinE9znUDns012wqQ
         9E2+LaAfHJsBAL1JAHh5nXLi+2WA97B/uaaBByV9GBJ+bHLO7PD+pyPi5iWOMeq6MLeQ
         +CnQ==
X-Gm-Message-State: APjAAAXqK2sY46pqdkLDbcguZc4heRcoRhjJ7YeRr54pAGJ8AfB0+x5P
        t2WtlgrJ7XTvBFE0UZ/aJzzc9q8iOdZRsCZAH4/gww==
X-Google-Smtp-Source: APXvYqxTAZ/MUoUZk3D1f36VHOazK37aILZfgkD3ZURYmQHRaepUGoeGfgD90m4zsVbCX/fUrHBVP/rGwbWTR9yjq2g=
X-Received: by 2002:ab0:6358:: with SMTP id f24mr2531680uap.72.1567488641754;
 Mon, 02 Sep 2019 22:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190902100054.6941-1-jian-hong@endlessm.com> <s5hwoerx6wf.wl-tiwai@suse.de>
In-Reply-To: <s5hwoerx6wf.wl-tiwai@suse.de>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Tue, 3 Sep 2019 13:30:04 +0800
Message-ID: <CAPpJ_edbfN_6yfxjBSV5dnp40ufCeWeMiF_QdsPmWmHubagCQw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek - Enable internal speaker & headset mic
 of ASUS UX431FL
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> =E6=96=BC 2019=E5=B9=B49=E6=9C=882=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 02 Sep 2019 12:00:56 +0200,
> Jian-Hong Pan wrote:
> >
> > Original pin node values of ASUS UX431FL with ALC294:
> >
> > 0x12 0xb7a60140
> > 0x13 0x40000000
> > 0x14 0x90170110
> > 0x15 0x411111f0
> > 0x16 0x411111f0
> > 0x17 0x90170111
> > 0x18 0x411111f0
> > 0x19 0x411111f0
> > 0x1a 0x411111f0
> > 0x1b 0x411111f0
> > 0x1d 0x4066852d
> > 0x1e 0x411111f0
> > 0x1f 0x411111f0
> > 0x21 0x04211020
> >
> > 1. Has duplicated internal speakers (0x14 & 0x17) which makes the outpu=
t
> >    route become confused. So, the output volume cannot be changed by
> >    setting.
> > 2. Misses the headset mic pin node.
> >
> > This patch disables the confusing speaker (NID 0x14) and enables the
> > headset mic (NID 0x19).
>
> Is 0x14 really a dead pin?  Or is a surround/bass speaker or such?

I checked Windows (updated to latest and including Realtek MEDIA) on
ASUS UX431FL laptop again.  Although it has two internal speaker pins,
there is only one set of internal speaker including left/right
channels.  And the audio test (Speaker Setup) only shows left/right
channels.  So, NID 0x14 can be disabled.

Jain-Hong Pan

> >
> > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > ---
> >  sound/pci/hda/patch_realtek.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realte=
k.c
> > index e333b3e30e31..0a1fa99a6723 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -5797,6 +5797,7 @@ enum {
> >       ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
> >       ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
> >       ALC299_FIXUP_PREDATOR_SPK,
> > +     ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC,
> >  };
> >
> >  static const struct hda_fixup alc269_fixups[] =3D {
> > @@ -6837,6 +6838,16 @@ static const struct hda_fixup alc269_fixups[] =
=3D {
> >                       { }
> >               }
> >       },
> > +     [ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC] =3D {
> > +             .type =3D HDA_FIXUP_PINS,
> > +             .v.pins =3D (const struct hda_pintbl[]) {
> > +                     { 0x14, 0x411111f0 }, /* disable confusing intern=
al speaker */
> > +                     { 0x19, 0x04a11150 }, /* use as headset mic, with=
out its own jack detect */
> > +                     { }
> > +             },
> > +             .chained =3D true,
> > +             .chain_id =3D ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
> > +     },
> >  };
> >
> >  static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {
> > @@ -6995,6 +7006,7 @@ static const struct snd_pci_quirk alc269_fixup_tb=
l[] =3D {
> >       SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXU=
P_ASUS_ZENBOOK),
> >       SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXU=
P_ASUS_ZENBOOK_UX31A),
> >       SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DM=
IC),
> > +     SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_I=
NTSPK_HEADSET_MIC),
> >       SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73=
JW),
> >       SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MI=
C),
> >       SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC=
),
> > --
> > 2.20.1
> >
> >
