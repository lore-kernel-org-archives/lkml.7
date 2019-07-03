Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C874C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C4420665
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rP81x57R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfGCO6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:58:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35316 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:58:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so3703527qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a662vhOsHnFz4Y9zmRoUex7/pczenDh3Ci8ob4LVgWw=;
        b=rP81x57RHiIoDvcKVdfIbI/IQmaDCgy02rwGpu2kDqCq/2Q/CmGgOYVBSDgdPj5NqO
         Q22F551Om9gMJ3buc/dpsYgF056TZqQtazDNTq51WT0Qtr1r3bJm6MegqUoNvoPwl2wA
         IlbGTyBo9mW3MkrKqEc4APDhZjmLkytwqBCS3o1sotAOxt8khT/yv/Rj3HvL3XZEYOXr
         RgkZ7lrtEvSpUe/+Vgr658ndHwH2JwzfGkOgEOZ3v3HlYmkAZdwzvuOuHqkmwb4IF3vh
         moQLKrCoyGtW7tLKbUmL4Bh/Re5kskFzUggF2tZ5SOGdppJDDW/M3iy1kNT7HemDkcMA
         LcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a662vhOsHnFz4Y9zmRoUex7/pczenDh3Ci8ob4LVgWw=;
        b=F6vmxhyVHrZWsBa3mZpV+6uCz+Mh2wj1r3flW1zzNx/kfHNl8G6DgpukgT/hEWG8MZ
         wMZi9+p1JECZTklw7SoXmlIxgnkrTurJ9h8ObQb/JAieebkbLsC8iV8u6mGSzMS9Aq/B
         GTzZU3W5f3jEJ2gOWp/P8OKmiEtc8MkIrIVdh73CHmzwGqhiQ0NA2zZWAT8jQdvm9rqx
         2MVl6EFc1gjyq6MbttEVA99nJ+M8dYdA4T8nbUZIAvPCWo7Y7nJseS/5w1R9Dl0kYxhh
         rIWyZ+NSgqCYToJExHamRVe7+UCpXXCndQJzL94qdXXKNwSkxGfBCOQjH1KENzAPSFAO
         10Ig==
X-Gm-Message-State: APjAAAUdssNBqkVWn96Hn22uMYfoQc/33jep4D8nOaEL/QrHKsu6NiCX
        W5uO3wcyjbufixXLXyQbyfddqt2gK2N1d/XOziw=
X-Google-Smtp-Source: APXvYqxuXD87vqmtFZRsgM0sSJGQpOtEVCvP3zGJTMc+/6qxBmr7IWKbLwZaGtgj9SKgfDlnbGfxR2NsASeWpOD5DkE=
X-Received: by 2002:a25:768f:: with SMTP id r137mr12406439ybc.8.1562165928725;
 Wed, 03 Jul 2019 07:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190703131842.26082-1-huangfq.daxian@gmail.com> <547c68b0-f55f-ca1d-c5b3-f6a5f89d93a9@opensource.cirrus.com>
In-Reply-To: <547c68b0-f55f-ca1d-c5b3-f6a5f89d93a9@opensource.cirrus.com>
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Date:   Wed, 3 Jul 2019 22:58:43 +0800
Message-ID: <CABXRUiQH2c5knAxnegNc1J2uyqy3OVU=qEorcZkUtMoJhvb_8Q@mail.gmail.com>
Subject: Re: [PATCH 30/30] sound/soc: Use kmemdup rather than duplicating its implementation
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I will separate them into two patches in the v2 patch set. Also,
there is a typo in the v1(memset should be memcpy).

Richard Fitzgerald <rf@opensource.cirrus.com> =E6=96=BC 2019=E5=B9=B47=E6=
=9C=883=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:55=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On 03/07/19 14:18, Fuqian Huang wrote:
> > kmemdup is introduced to duplicate a region of memory in a neat way.
> > Rather than kmalloc/kzalloc + memset, which the programmer needs to
> > write the size twice (sometimes lead to mistakes), kmemdup improves
> > readability, leads to smaller code and also reduce the chances of mista=
kes.
> > Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.
> >
> > Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> > ---
> >   sound/soc/codecs/wm0010.c             | 4 +---
> >   sound/soc/intel/atom/sst/sst_loader.c | 3 +--
>
> Should be one patch per file as the drivers are not related to each
> other at all, and if one needed a revert you couldn't revert this
> patch because it would revert both drivers.
>
> But apart from that, for wm0010.c:
> Acked-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>
> >   2 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
> > index 727d6703c905..807826f30f58 100644
> > --- a/sound/soc/codecs/wm0010.c
> > +++ b/sound/soc/codecs/wm0010.c
> > @@ -515,7 +515,7 @@ static int wm0010_stage2_load(struct snd_soc_compon=
ent *component)
> >       dev_dbg(component->dev, "Downloading %zu byte stage 2 loader\n", =
fw->size);
> >
> >       /* Copy to local buffer first as vmalloc causes problems for dma =
*/
> > -     img =3D kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > +     img =3D kmemdup(&fw->data[0], fw->size, GFP_KERNEL | GFP_DMA);
> >       if (!img) {
> >               ret =3D -ENOMEM;
> >               goto abort2;
> > @@ -527,8 +527,6 @@ static int wm0010_stage2_load(struct snd_soc_compon=
ent *component)
> >               goto abort1;
> >       }
> >
> > -     memcpy(img, &fw->data[0], fw->size);
> > -
> >       spi_message_init(&m);
> >       memset(&t, 0, sizeof(t));
> >       t.rx_buf =3D out;
> > diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/at=
om/sst/sst_loader.c
> > index ce11c36848c4..cc95af35c060 100644
> > --- a/sound/soc/intel/atom/sst/sst_loader.c
> > +++ b/sound/soc/intel/atom/sst/sst_loader.c
> > @@ -288,14 +288,13 @@ static int sst_cache_and_parse_fw(struct intel_ss=
t_drv *sst,
> >   {
> >       int retval =3D 0;
> >
> > -     sst->fw_in_mem =3D kzalloc(fw->size, GFP_KERNEL);
> > +     sst->fw_in_mem =3D kmemdup(fw->data, fw->size, GFP_KERNEL);
> >       if (!sst->fw_in_mem) {
> >               retval =3D -ENOMEM;
> >               goto end_release;
> >       }
> >       dev_dbg(sst->dev, "copied fw to %p", sst->fw_in_mem);
> >       dev_dbg(sst->dev, "phys: %lx", (unsigned long)virt_to_phys(sst->f=
w_in_mem));
> > -     memcpy(sst->fw_in_mem, fw->data, fw->size);
> >       retval =3D sst_parse_fw_memcpy(sst, fw->size, &sst->memcpy_list);
> >       if (retval) {
> >               dev_err(sst->dev, "Failed to parse fw\n");
> >
>
