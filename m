Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF7CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14DD217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU1Ig+FC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391077AbfJ1QfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:35:16 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41810 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfJ1QfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:35:16 -0400
Received: by mail-il1-f193.google.com with SMTP id z10so8728346ilo.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21j/dEL0woCR7rVyFBJA5jrlm9GOTcbrkftyZXegyKo=;
        b=aU1Ig+FCiz7v2IaiVq8NhUuGtv0bCBMp3YsGpTDegyuWP+LJPtteTZlzwPwajX8jCv
         NRz4cASxes89dYC6sB0CbiJxU/1CaUWgP7M34Cky4H6G6hxoEdT4OV4YIrB4r4FgHBmg
         5mQ15GrEag5lIB+QOYnvkJWdLW053YG6Ivi4+z853DDikUjFGGKLm4OPisECfiH+my7Z
         gN2OD5tu8Hd5h8meTBFNmA2I3Ykf7ci8D8kC6KC95b/1meOlz3l8pWGmww+XIK+vVvrQ
         UybrDCU6sLgBPJ485nRSyr3ZVTP69vtt89S4QiUmL3yOSOe/2T2//dKXaeedoG5hjdPq
         nHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21j/dEL0woCR7rVyFBJA5jrlm9GOTcbrkftyZXegyKo=;
        b=GNyjLLeIXD8SV9824wfOmp0xxbx6olxUaX5NNZxk8Fy3vSNac3lFM+Q95cQ5TUeifJ
         95ZYg9A62rCesawPNdYGMw5iFTppCmQkYl41ZwuCE6OpdhzibgXhPuOUJJYvJNOuv4Ab
         ErrdAnIFk8nf3fVNIwt7SAnVti9BD2ze9jAhJwBpXakfxxGoBSynRwGKAHGbnjMDuX0c
         67eA2pzqVqpvdClc7KOiu6WFl/88Xg9H12PYkcj9XnZ9RCvkUZKZLcAnH5rEEXEIn0im
         bBGHGT0DYuqCwQ+fa4ZtPv9ZFMrW4+MJDbsP4mrmDFrrfrkpHyLHQyl+t2qPH21bNvLG
         c68g==
X-Gm-Message-State: APjAAAWEYutuDsrF0WXTBY+6pue1m/7QqDviCrvOhyrwwOn6/Ax5+KgD
        fz3zUNP2RZ6ZESfKtcsvi0XQ7AcfhNLFExDE/Bg=
X-Google-Smtp-Source: APXvYqxZHTQgUs3vZ4EyKxk1J2VBxbW1V/6qsk4AKLh6jW/960J5msDNOgE9rFT9PBlWL6y2v0qTQSUQ5QvAY+3DS7Q=
X-Received: by 2002:a92:d94a:: with SMTP id l10mr17910669ilq.227.1572280515345;
 Mon, 28 Oct 2019 09:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191027215330.12729-1-navid.emamdoost@gmail.com> <fb4fa7f3-fefb-e2d0-da4d-842396a7c251@linux.intel.com>
In-Reply-To: <fb4fa7f3-fefb-e2d0-da4d-842396a7c251@linux.intel.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 28 Oct 2019 11:35:04 -0500
Message-ID: <CAEkB2ETrEu6SxBC+OfPNe_DqNn-=4c9p=1d9Cz5XR3NbbcD2OQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: ipc: Fix memory leak in sof_set_get_large_ctrl_data
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Slawomir Blauciak <slawomir.blauciak@linux.intel.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 9:15 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 10/27/19 4:53 PM, Navid Emamdoost wrote:
> > In the implementation of sof_set_get_large_ctrl_data() there is a memory
> > leak in case an error. Release partdata if sof_get_ctrl_copy_params()
> > fails.
> >
> > Fixes: 54d198d5019d ("ASoC: SOF: Propagate sof_get_ctrl_copy_params() error properly")
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
> May I ask which tool you used to find those issues, looks like we have a
> gap here?

We are developing a research tool to find such cases. Not sure what
gap you are referring to, but we statically track the allocation and
look for an appropriate release/assignment of the pointer.


>
> > ---
> >   sound/soc/sof/ipc.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
> > index b2f359d2f7e5..086eeeab8679 100644
> > --- a/sound/soc/sof/ipc.c
> > +++ b/sound/soc/sof/ipc.c
> > @@ -572,8 +572,10 @@ static int sof_set_get_large_ctrl_data(struct snd_sof_dev *sdev,
> >       else
> >               err = sof_get_ctrl_copy_params(cdata->type, partdata, cdata,
> >                                              sparams);
> > -     if (err < 0)
> > +     if (err < 0) {
> > +             kfree(partdata);
> >               return err;
> > +     }
> >
> >       msg_bytes = sparams->msg_bytes;
> >       pl_size = sparams->pl_size;
> >



--
Navid.
