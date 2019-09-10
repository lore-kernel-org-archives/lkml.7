Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569BCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3556D2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfIJHwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:52:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37868 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfIJHwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:52:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so13131587qkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 00:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9GytuQLzyYATbhV+IjgAeDxZXKzpVILhMpRGkoLMn0=;
        b=D+laph0HAW3LL7Cn7tr3nQwem8/i5L+nkMBTDoNcj/4ejhkSQS6u9WQLZrdzc0TkQ9
         M5gEATxmb4HO7SFmImjWgi98gSYfqGnEMQ5Psj83Psrlqpw6q7q/WF1UO1+Ld9xhvURw
         4hUFmEBr9goOq2ocUklKklyEbHPwXP2OrDcspwfSGJjAgNrMjdwJT3W7l8bwUvfhkIv0
         pHbiRrreQ9ibVEPS+SrwJaIlNE5+levUiPSQufQ3E8ZUkpn8MQozEGcVHgi3kciTjGKh
         yTVuAg0lW+XbEh1RtF2QjXZWS1vl33LsMH7yFYvOMhHYOeE4AZDOHS2ALjGkEROz4cBw
         1c3A==
X-Gm-Message-State: APjAAAVuJE81ApN15Vn0NfM58OXBk+Waz5q9Y6G7OLSHRSBeyyXQZ9q6
        Nkp61sf7rO/w8iGFArXjphrgidQkOChtUeWmmTE=
X-Google-Smtp-Source: APXvYqxln7Q1Hrqv0ev3shLxwwtKOqlgoIIxBQOyHa8+xJM7nUB9taTaEV46rFMYCch7AxGOs2gefPx1RVZCtak+A8o=
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr7307279qkg.3.1568101949751;
 Tue, 10 Sep 2019 00:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190909195159.3326134-1-arnd@arndb.de> <3b69e0ec-63cb-4888-9faa-acb7638d71dc@linux.intel.com>
 <CAK8P3a0WDB_UvAnwfPDyR_maEefE4Qh++fHxAP61=8JfOFmy6w@mail.gmail.com> <s5hef0oaav5.wl-tiwai@suse.de>
In-Reply-To: <s5hef0oaav5.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Sep 2019 09:52:13 +0200
Message-ID: <CAK8P3a2-gMbuN-17MC6ZsDwvPGCHmbJojKYGnrUshxhazATPRg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: Intel: work around
 snd_hdac_aligned_read link failure
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 9:06 AM Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 09 Sep 2019 22:51:23 +0200, Arnd Bergmann wrote:
> >
> > On Mon, Sep 9, 2019 at 10:39 PM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> > >
> > > On 9/9/19 2:51 PM, Arnd Bergmann wrote:
> > > > When CONFIG_SND_HDA_ALIGNED_MMIO is selected by another driver
> > > > (i.e. Tegra) that selects CONFIG_SND_HDA_CORE as a loadable
> > > > module, but SND_SOC_SOF_HDA_COMMON is built-in, we get a
> > > > link failure from some functions that access the hda register:
> > > >
> > > > sound/soc/sof/intel/hda.o: In function `hda_ipc_irq_dump':
> > > > hda.c:(.text+0x784): undefined reference to `snd_hdac_aligned_read'
> > > > sound/soc/sof/intel/hda-stream.o: In function `hda_dsp_stream_threaded_handler':
> > > > hda-stream.c:(.text+0x12e4): undefined reference to `snd_hdac_aligned_read'
> > > > hda-stream.c:(.text+0x12f8): undefined reference to `snd_hdac_aligned_write'
> > > >
> > > > Add an explicit 'select' statement as a workaround. This is
> > > > not a great solution, but it's the easiest way I could come
> > > > up with.
> > >
> > > Thanks for spotting this, I don't think anyone on the SOF team looked at
> > > this. Maybe we can filter with depends on !TEGRA or
> > > !SND_HDA_ALIGNED_MMIO at the SOF Intel top-level instead?
> >
> > That doesn't sound much better than my approach, but could also work.
> > One idea that I had but did not manage to implement was to move out
> > the snd_hdac_aligned_read/write functions from the core hda code
> > into a separate file. I think that would be the cleanest solution,
> > as it decouples the problem from any drivers.
>
> Yeah, that's a tricky problem because of the reverse-selection, as
> usual...
>
> Another solution would be to just avoid byte/word access but use only
> long access, i.e. replace snd_hdac_chip_readb() with
> snd_hdac_chip_readl() with the aligned register and bit shift.
> The aligned access helper is needed only for the register that isn't
> aligned with 4 bytes offset.

Ok, so basically open-coding the aligned access to RIRBSTS?
That sounds like a much nicer workaround. So in place of

                        sd_status = snd_hdac_stream_readb(s, SD_STS);
                        dev_vdbg(bus->dev, "stream %d status 0x%x\n",
                                 s->index, sd_status);
                        snd_hdac_stream_writeb(s, SD_STS, sd_status);

I suppose one could just readl/writel SOF_HDA_ADSP_REG_CL_SD_CTL
and print the shifted value, right?

While I know nothing about the underlying requirements, I wonder
about two things that stick out to me:

1. the existing code just writes back the same byte it has read. If
    this write has no side-effects, why write it at all? OTOH, if it has
    side-effects, isn't the aligned implementation of writing the whole
    word in snd_hdac_aligned_write()  fundamentally flawed?

2. Doesn't the read-modify-write cycle in snd_hdac_aligned_write()
   need locking to work correctly?

          Arnd
