Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA95C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015E22184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="VIcUcS0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfCTFE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:04:26 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45241 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCTFEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:04:25 -0400
Received: by mail-vk1-f193.google.com with SMTP id v187so244385vkf.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rK7t3TnHuKaR+TBsU+HUhoAK3+roKKtGkZrEDN32xiQ=;
        b=VIcUcS0lFCMtlXcvDBIL4K/VqTXV60edsQ1/lYeqLV7x2HxhomvoSla6j87VAe2Oyc
         H5xTVCVfN4dpjNNfQRieKZR7VwcCw0nBHMJ2A0wIb3o15+i8q7CJjM41kMe5wDEvWCbR
         8b/cBEi7zLuraqc7Qv1qd1hUwxZc+pmnauUlkGtYIdRWCWk33hv3chKL3swIw29uQAN6
         kU/H9hMy29m4fins9hqrmbA6fJy6Xs74kdGhwZLLeumYjfBaM3d1Oja84toLOVg+WNyH
         LlIspUKk+tFvi6DWD5Uo2+htmASCquO9HBLDKtzjW7K/gxrpHqnE8FCZUMMsFHoG/ZPf
         K8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rK7t3TnHuKaR+TBsU+HUhoAK3+roKKtGkZrEDN32xiQ=;
        b=fhqW6+vOZt+yd66nD3n8hiNj1O5laFVVP2OivL4lW4QZk3/+1FNze41jwSFQG0NyhL
         omqoRe54fnaru0uolPGcWcW08K90+eiFNvcco/kxtADp23yDQ71U5IwUNJzi9pcghSdP
         DoxpG9JQeIT9Kf0xvNt2vrhBj+plbdZ4jg/lMxZmL7h0Evlbz6fdawRYHeymNUb+BkIT
         87ERWKA7mbLTkztzdyMkRXjFcnQ0D1hnUZaorWTXVj/zJuJ6sR3EbXwnRBeck1iHvfxf
         9ndin4KGD6m1ThcUoH7LOCg1t64CVbC6MjFtB1EKw9SqjD/2DN1x+aPJImWTrY5Jx7Ae
         lEvg==
X-Gm-Message-State: APjAAAXk1TbE5s1gXAZFGx3uqjW4Gm911qPtaWLjpHzsF3WB8YhjrccT
        nGdiLoUO4i4tq7ILTK0Ws3kph1vRU+wrZkMypfs9Pg==
X-Google-Smtp-Source: APXvYqwbpXSLP383uh064BpC4hXr9L4DlltgGQDNmPa5bqBp6r5+jonsKHtXQNZkEvMixYC6+oxT+a6B8Vlz1Nw4M4w=
X-Received: by 2002:a1f:8750:: with SMTP id j77mr3567585vkd.56.1553058264090;
 Tue, 19 Mar 2019 22:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190315095108.9195-1-jian-hong@endlessm.com> <s5himwkpehk.wl-tiwai@suse.de>
In-Reply-To: <s5himwkpehk.wl-tiwai@suse.de>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Wed, 20 Mar 2019 13:05:33 +0800
Message-ID: <CAPpJ_ec7oWi+ymtHXVwBMWS7=WtGmtPX6GNd+VOKX9xFzGZEVA@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> =E6=96=BC 2019=E5=B9=B43=E6=9C=8815=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 15 Mar 2019 10:51:09 +0100,
> Jian-Hong Pan wrote:
> >
> > Some Acer AIO desktops like Veriton Z6860G, Z4860G and Z4660G cannot
> > record sound from headset MIC.  This patch adds the
> > ALC286_FIXUP_ACER_AIO_HEADSET_MIC quirk to fix this issue.
> >
> > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > ---
> > v2: According to Realtek's suggestion, change the COEF 0x4f from 0xd429=
 to
> >     0x5029.  Thanks to Realtek!
>
> It'd be nicer if we get either Acked-by or Reviewed-by tag from
> Realtek.  Kailang?

Hi Kailang,

May we have your Acked-by or Reviewed-by tag for this patch?
Signed-off will also be great!

Thank you
Jian-Hong Pan

> thanks,
>
> Takashi
>
> >
> >  sound/pci/hda/patch_realtek.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realte=
k.c
> > index 384719d5c44e..191830d4fa40 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -5687,6 +5687,7 @@ enum {
> >       ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE,
> >       ALC225_FIXUP_WYSE_AUTO_MUTE,
> >       ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
> > +     ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
> >  };
> >
> >  static const struct hda_fixup alc269_fixups[] =3D {
> > @@ -6685,6 +6686,16 @@ static const struct hda_fixup alc269_fixups[] =
=3D {
> >               .chained =3D true,
> >               .chain_id =3D ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
> >       },
> > +     [ALC286_FIXUP_ACER_AIO_HEADSET_MIC] =3D {
> > +             .type =3D HDA_FIXUP_VERBS,
> > +             .v.verbs =3D (const struct hda_verb[]) {
> > +                     { 0x20, AC_VERB_SET_COEF_INDEX, 0x4f },
> > +                     { 0x20, AC_VERB_SET_PROC_COEF, 0x5029 },
> > +                     { }
> > +             },
> > +             .chained =3D true,
> > +             .chain_id =3D ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE
> > +     },
> >  };
> >
> >  static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {
> > @@ -6701,9 +6712,9 @@ static const struct snd_pci_quirk alc269_fixup_tb=
l[] =3D {
> >       SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP=
_ASPIRE_V5_PINS),
> >       SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP=
_ACER_AIO_MIC_NO_PRESENCE),
> >       SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_C=
HROME_BOOK),
> > -     SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP=
_ACER_AIO_MIC_NO_PRESENCE),
> > -     SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP=
_ACER_AIO_MIC_NO_PRESENCE),
> > -     SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP=
_ACER_AIO_MIC_NO_PRESENCE),
> > +     SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP=
_ACER_AIO_HEADSET_MIC),
> > +     SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP=
_ACER_AIO_HEADSET_MIC),
> > +     SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP=
_ACER_AIO_HEADSET_MIC),
> >       SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_=
FIXUP_ACER_HEADSET_MIC),
> >       SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M10=
1Z),
> >       SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_D=
ELL_XPS),
> > --
> > 2.20.1
> >
> >
