Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E3AECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE982086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbfJAPlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:41:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45168 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfJAPlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:41:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so11633378qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 08:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYNED/gHAQZWO+3A/3UN+zfY12A/7ApPwVWXSrVnRe4=;
        b=a3TMZmfnbJjCLYH1LB9WvSN/CCMSEoVs0M+szws6OvlSCT5HBQObqMnFTKhGPP1dHJ
         OFYMZaBdIgnnBZuy4leXBK2LbwiLMMxG7oRmlQ3ECe12jBWtDVqG9CptKgLNTn35oR/J
         8zqBlw1NIjHugDpzt7bVq10smPnqhHC3d1wfYteN5+/FkviDyBS+nDxeyE39IW/sOyHu
         vaVzM2zBHqh8cn2XD1LJo5ZGboKKr02RrA2xaodu5IGBb95yTFi2BhxVukf9J6r6h6rr
         H0qaXMOuldQo3JwcC8mdnXc4/+kSZFvCxrFWlF5GpdpzGug6DGVuo9f1qbvK8Ljd1Gwi
         zE0Q==
X-Gm-Message-State: APjAAAV9OmnsUtuX0+DV20FgGgm/1ChEsvShWQTTORJJRBQBg0hAXs7t
        jIgGCIFw/f/paE9aLWMDPBtlg4/hkOd5LiCXibA=
X-Google-Smtp-Source: APXvYqzYVsIwghV1g7M189GjA1p2gl/d+MucD1KvbEioKPUwygJiOOw9tiSuacOJf+g/Fbf9+E9jGyNtKXcZR+sjTxc=
X-Received: by 2002:a37:a858:: with SMTP id r85mr6681072qke.394.1569944495423;
 Tue, 01 Oct 2019 08:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191001142026.1124917-1-arnd@arndb.de> <bb58c7cc-209d-7a2f-0e5b-95a9605ffe7b@linux.intel.com>
In-Reply-To: <bb58c7cc-209d-7a2f-0e5b-95a9605ffe7b@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Oct 2019 17:41:19 +0200
Message-ID: <CAK8P3a3Js2dNhnRhP7PLadWZ69DZr1mz6DowN9HDJL4CFDAAFw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: imx: fix reverse
 CONFIG_SND_SOC_SOF_OF dependency
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 5:32 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 10/1/19 9:20 AM, Arnd Bergmann wrote:
> > CONFIG_SND_SOC_SOF_IMX depends on CONFIG_SND_SOC_SOF, but is in
> > turn referenced by the sof-of-dev driver. This creates a reverse
> > dependency that manifests in a link error when CONFIG_SND_SOC_SOF_OF
> > is built-in but CONFIG_SND_SOC_SOF_IMX=m:
> >
> > sound/soc/sof/sof-of-dev.o:(.data+0x118): undefined reference to `sof_imx8_ops'
> >
> > Make the latter a 'bool' symbol and change the Makefile so the imx8
> > driver is compiled the same way as the driver using it.
> >
> > A nicer way would be to reverse the layering and move all
> > the imx specific bits of sof-of-dev.c into the imx driver
> > itself, which can then call into the common code. Doing this
> > would need more testing and can be done if we add another
> > driver like the first one.
>
> Or use something like
>
> config SND_SOC_SOF_IMX8_SUPPORT
>         bool "SOF support for i.MX8"
>         depends on IMX_SCU
>         depends on IMX_DSP
>
> config SND_SOC_SOF_IMX8
>         tristate
>         <i.mx selects>
>
> config SND_SOC_SOF_OF
>         depends on OF
>         select SND_SOC_SOF_IMX8 if SND_SOC_SOF_IMX8_SUPPORT
>
> That way you propagate the module/built-in information. That's how we
> fixed those issues for the Intel parts.

Yes, I think that would work here as well, but it keeps even more
information about the specific drivers in the generic code. It also
requires adding more 'select' statements that tend to cause more
problems.

The same could be done with a Kconfig-only solution avoiding
'select' such as:

config SND_SOC_SOF_IMX8_SUPPORT
         bool "SOF support for i.MX8"
         depends on IMX_SCU
         depends on IMX_DSP

 config SND_SOC_SOF_IMX8
         def_tristate SND_SOC_SOF_OF
         depends on SND_SOC_SOF_IMX8_SUPPORT

      Arnd
