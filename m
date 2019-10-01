Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C888AECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D572053B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbfJAQEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:04:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45072 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfJAQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:04:51 -0400
Received: by mail-qk1-f196.google.com with SMTP id z67so11712292qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVA9zycwwTmxrHgzivoqyA4S7B6/Ae12ZgJJqfTA6ZE=;
        b=kWH65QgR1OnL1d/VL5esb0Smyk1Yxa+TKxJc4tpUoNbw5E3yiPBDeFGYZiKctajWlf
         EHb0HubwEQNxAVO4KLB8KNg2+uywkP8/3Zf/FSJuHvRXGcnUbAtQehWPogic3TH4nXx5
         SB4/Yc+2dnC2ibYAXZP0SWECWTAUgs+vuMnO9jhBck7lLlGq1Jk0vJtluiVPzw0LHNok
         gZ+M599nwfmiHZuIsNRqrQrONeYkztA2q7I/ciXO/O+gRZAKlABHGCvju37xpBotvvPy
         jGT870SfegHi9lxVvV2mJ0uTSHI7ZmTxbkhDjcjlStaOlZppRawgM/AZcw7/2SIXTghv
         cXVQ==
X-Gm-Message-State: APjAAAUzDKV68GYRIuV/ADPFQJ5y/wulJjcSxOfh3lOHd6RnGT+YWK2p
        T7j8wOe41EEr04JZmHl7GGUDTL3eWM/LlZvuLFA=
X-Google-Smtp-Source: APXvYqw8OSzTRQKAtzD5yJNb3X/TKsuG58PVn13xDbhiPbbzHk02DUCmHWqaGsNg1xN9FhUJmk9LIa3wCb6Y08Qz7k8=
X-Received: by 2002:ae9:ef8c:: with SMTP id d134mr1425740qkg.286.1569945569712;
 Tue, 01 Oct 2019 08:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191001142116.1172290-1-arnd@arndb.de> <20191001142734.GD4106@piout.net>
In-Reply-To: <20191001142734.GD4106@piout.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Oct 2019 17:59:13 +0200
Message-ID: <CAK8P3a3ovgR4THuXb17Fh7DDts188jWRqP3OAZ7cknNUsWQ-dg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: atmel: fix atmel_ssc_set_audio link failure
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 4:27 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> > -obj-$(CONFIG_SND_ATMEL_SOC_PDC) += snd-soc-atmel-pcm-pdc.o
> > -obj-$(CONFIG_SND_ATMEL_SOC_DMA) += snd-soc-atmel-pcm-dma.o
> > +# pdc and dma need to both be built-in if any user of
> > +# ssc is built-in.
> > +ifdef CONFIG_SND_ATMEL_SOC_PDC
> > +obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel-pcm-pdc.o
> > +endif
> > +ifdef CONFIG_SND_ATMEL_SOC_DMA
> > +obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel-pcm-dma.o
> > +endif
>
> Doesn't that prevent them to be built as a module at all?
> I'm not sure there is a use case though.

It should not: the idea was that snd-soc-atmel-pcm-{pdc,dma}.o
get built as modules if CONFIG_SND_ATMEL_SOC_SSC=m.

      arnd
