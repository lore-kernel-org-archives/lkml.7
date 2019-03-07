Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE2DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FFE20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCGPMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:12:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40724 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:12:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id h28so9191756qkk.7;
        Thu, 07 Mar 2019 07:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuB+eKhOohoUbVxZYxrPClYT2o/k+7FcRmsLbgoXczk=;
        b=rOYrjJEmHeznem683K10o8Zy+LmJ1qm5Xu3YZx0oNCRWfE3Bo86CItItHoscL8Z8h7
         QqD1LZcJE+PPD4M7g2mH2oBomxHdK11Ard6satpC54JmZW6xfaqBt1XN5hJu+2TEU/yg
         IszPEm65IwZGdGxaaJ4rrlkPRYjU0vdUBWcTA2t+hnrgfGMdsWinYae+BrPA9aUfr03R
         JyO7RyruJlS02uf6DAUZqQljT/ke8bkeaTtwAJ5I9UeyOStrzJoMF7w2wdLaV2QP3tPJ
         bnfcPAbi99rTP7lugKOLisoONOZRjukkF0e9V8JZh1xzx0xiHgjbFoOGaxP7bvefFehH
         SpZg==
X-Gm-Message-State: APjAAAU9yXZOdTFK0gZsoLvQsPVYKFTquqfCYdf7JgrNqr51u9JCzW9H
        XR4UNtQkrRmnUCu16nQxZ0XhPefrcbtw92tomQU=
X-Google-Smtp-Source: APXvYqzfG69+K6eT88HwD1z/ZSOCY8on0TiTvIMMgXl9097igQfIpkNZ0I4y3LN8BwvM1LJhxhnR4JuxZpnIBIcsenc=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr9846900qkf.107.1551971551420;
 Thu, 07 Mar 2019 07:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20190304203114.1894822-1-arnd@arndb.de> <20190304203114.1894822-2-arnd@arndb.de>
 <865ffc6e-c6f7-a30a-1c0c-14194b3458ef@ti.com>
In-Reply-To: <865ffc6e-c6f7-a30a-1c0c-14194b3458ef@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 16:12:05 +0100
Message-ID: <CAK8P3a2kbHU2TLNebO9vvqh6uim7p8EU7DWQssfOd1TtdJHDXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: ti: remove compat dma probing
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Tony Lindgren <tony@atomide.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:22 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> Hi Arnd,
>
> On 04/03/2019 22.30, Arnd Bergmann wrote:
> > After running into a link error:
> >
> > sound/soc/ti/edma-pcm.o:(.rodata+0x18): undefined reference to `edma_filter_fn'
> >
> > I checked all users of this, and they have new-style 'dma_slave_map' tables,
> > so none of them should still need it. Removing the associated lines
> > simplifies the code and avoids the build-time dependency on the
> > respective dmaengine drivers.
>
> Thank you for the patch!
>
> Yes, I believe I have covered all possible legacy uses for both edma and
> sdma with dma_slave_map
>
> With the two comments addressed:
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks!

> > @@ -43,14 +43,12 @@ static const struct snd_pcm_hardware edma_pcm_hardware = {
> >  static const struct snd_dmaengine_pcm_config edma_dmaengine_pcm_config = {
> >       .pcm_hardware = &edma_pcm_hardware,
> >       .prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> > -     .compat_filter_fn = edma_filter_fn,
>
> We can also remove the
> #include <linux/edma.h>
>
> as it is no longer needed.

> Here we can remove the
> #include <linux/omap-dmaengine.h>

Ah, perfect!

I also see that linux/edma.h can be completely removed afterwards, and the
filter function made static. linux/omap-dmaengine.h too, but it is included
from linux/omap.h, of which at least parts are still needed for omap_udc.c

       Arnd
