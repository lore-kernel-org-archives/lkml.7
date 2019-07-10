Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E22FC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F262F214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N9XqQaAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfGJXPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:15:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46031 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfGJXPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 19:15:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so3746999lje.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 16:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQboB9+e5px7PkIQYt9TxvsS0wLCuRZrok0YN+xW9qU=;
        b=N9XqQaAoPIac0JgRLKRl24GB5pv/laq9/aLbMTAMPG3ugr4LWVOZT31hk9asJq2PbT
         4vbRER2CYPSpBipbp6megRSlHCqNJlQDHS6DIHW8KXk5qcQB1oYqNHmHvRK3CDE41AoQ
         KEElx4br0/fmL3uJ3KZjwiQChE+aU6reGumrPGx6/rnfvrzPpeTl2hoCtaeMgj/3jDfS
         N6aOulMiEveT0MBg8c+bNMd7dLPA3chriCRktpHuLXq7iUBcd9JufPpb7Ch78NSDaUbM
         L6+dE+/INbvwqYLzXVPt0uFUdJjehkjavB871hg4vQ6vOnN5/vcLB10xqGY0pWLh9xHv
         KOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQboB9+e5px7PkIQYt9TxvsS0wLCuRZrok0YN+xW9qU=;
        b=eqbO2qwcYIhssTMXsOsThFbre1hwwv6mZR2kV5fkdJM3afGWBpPG+pUl8EV2mZImir
         SBaVfdzul1IJoS1zV7ZiSX5BZAtglYI2zyVPamdmH+AS6GzrffiL4Cl7uWv/wrgfLH43
         AQ54WrZcOLg9fCHtrrmOBfF8kN2k3/32dMSbhn0Cu8MeHFNGyiX0zbnbku6cA/I3o9R7
         9U2KkKTu8wC7CtFzazmZAzKd5giER2qb5qiRIcxypJujnBN/+futYgQuygviMCQGp5+y
         5DDeYoFFuyCxKwkC+Bh+ZsNEAlT47N371FdPkJTVo2p4nuIV6e7inU0V11N/jKzlluyb
         GH0g==
X-Gm-Message-State: APjAAAXFnUGf3K/cYdW6klFGlSFEg2ZKp+H7W4FuEL6nz7hI8R7B6Tql
        lZBbSweJWzxSWx2xgIUIkDmNjn53aSPsDYYRKUaaBg==
X-Google-Smtp-Source: APXvYqwdA4hJIQGF0PNM45a6g8O+FEFfKyJo3wL3XhbJp0NMRVgo11Jh/3mf/hNrzNIKK4AkK0jZ9VZODakhNdWe6b8=
X-Received: by 2002:a2e:890a:: with SMTP id d10mr411931lji.145.1562800514229;
 Wed, 10 Jul 2019 16:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190709040147.111927-1-levinale@chromium.org> <20190709114519.GW9224@smile.fi.intel.com>
In-Reply-To: <20190709114519.GW9224@smile.fi.intel.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Wed, 10 Jul 2019 16:15:03 -0700
Message-ID: <CAOReqxirZdKJQ59Z4789wT5Cxh2fyQrUcuB1pm9AidYLiPEs1A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: Atom: read timestamp moved to period_elapsed
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alex Levin <levinale@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Zhang <benzh@chromium.org>,
        Curtis Malainey <cujomalainey@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 4:45 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jul 08, 2019 at 09:01:47PM -0700, Alex Levin wrote:
> > sst_platform_pcm_pointer is called from both snd_pcm_period_elapsed and
> > from snd_pcm_ioctl. Calling read timestamp results in recalculating
> > pcm_delay and buffer_ptr (sst_calc_tstamp) which consumes buffers in a
> > faster rate than intended.
> > In a tested BSW system with chtrt5650, for a rate of 48000, the
> > measured rate was sometimes 10 times more than that.
> > After moving the timestamp read to period elapsed, buffer consumption is
> > as expected.
>
> From code prospective it looks good. You may take mine
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Though I'm not an expert in the area, Pierre and / or Liam should give
> their blessing.
>
Agreed, Liam or Pierre should also give their ok since this is one of
the closed source firmware drivers.

Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
> >
> > Signed-off-by: Alex Levin <levinale@chromium.org>
> > ---
> >  sound/soc/intel/atom/sst-mfld-platform-pcm.c | 23 +++++++++++++-------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> > index 0e8b1c5eec88..196af0b30b41 100644
> > --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> > +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> > @@ -265,16 +265,28 @@ static void sst_period_elapsed(void *arg)
> >  {
> >       struct snd_pcm_substream *substream = arg;
> >       struct sst_runtime_stream *stream;
> > -     int status;
> > +     struct snd_soc_pcm_runtime *rtd;
> > +     int status, ret_val;
> >
> >       if (!substream || !substream->runtime)
> >               return;
> >       stream = substream->runtime->private_data;
> >       if (!stream)
> >               return;
> > +
> > +     rtd = substream->private_data;
> > +     if (!rtd)
> > +             return;
> > +
> >       status = sst_get_stream_status(stream);
> >       if (status != SST_PLATFORM_RUNNING)
> >               return;
> > +
> > +     ret_val = stream->ops->stream_read_tstamp(sst->dev, &stream->stream_info);
> > +     if (ret_val) {
> > +             dev_err(rtd->dev, "stream_read_tstamp err code = %d\n", ret_val);
> > +             return;
> > +     }
> >       snd_pcm_period_elapsed(substream);
> >  }
> >
> > @@ -658,20 +670,15 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
> >                       (struct snd_pcm_substream *substream)
> >  {
> >       struct sst_runtime_stream *stream;
> > -     int ret_val, status;
> > +     int status;
> >       struct pcm_stream_info *str_info;
> > -     struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >
> >       stream = substream->runtime->private_data;
> >       status = sst_get_stream_status(stream);
> >       if (status == SST_PLATFORM_INIT)
> >               return 0;
> > +
> >       str_info = &stream->stream_info;
> > -     ret_val = stream->ops->stream_read_tstamp(sst->dev, str_info);
> > -     if (ret_val) {
> > -             dev_err(rtd->dev, "sst: error code = %d\n", ret_val);
> > -             return ret_val;
> > -     }
> >       substream->runtime->delay = str_info->pcm_delay;
> >       return str_info->buffer_ptr;
> >  }
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
