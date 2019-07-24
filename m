Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D0AC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2F62182B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUzlEFxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfGXHEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:04:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55628 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGXHEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:04:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so40700164wmj.5;
        Wed, 24 Jul 2019 00:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SgB/LN6qxAiqZqDXD7MESa7fWo999T9KOe+bNiah86o=;
        b=fUzlEFxNZnKWldkB/3DAtX/BaMGxHoTAiL9k/3WWXLrH8fjFtZjQbroFWwfMrmG2pl
         1VwKV6XUjnRU/gHMh28BtnQVrzUXc2XEQZN7wzfBd8c+u+AaGdMcwrvl/nmJefNe+XOg
         gxXaayL/BxUpZ+Nom8MZLJpb0TeacnqvLBQjm0RpqYcuT8Y/Gj9aBzbD3kaBZPzjzY/L
         JWkF9+AOZWlgy71IXap2b5x2ldWTrVvsMnVs1xOAJm0m+LepYaL2Jh8nwyuUS0NEkyaX
         NFEzAOq82uhHBwknpWHjL9qdIyvF60UDzNycQ0qGQ0b0tfSyQXYfZv9nGlICB2//ofed
         Pwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SgB/LN6qxAiqZqDXD7MESa7fWo999T9KOe+bNiah86o=;
        b=cWgdJh0f8MZaSsxUVh4tsqDv8ZAFQM2NbfJOYCK+YNcT+MlKJIT5cEAnJXdzQ/ju5A
         a5ibfuL5lRCitZ3KBmA0eOk1T3suXAS/yDwzu+Cr2WgQMGvP7L2w84glVOaDp53DcQA5
         n1IL494fzOz4pgElP33DZD0zHCVxR/LqSABoRq5WPh4llT333gG+iwejoyLgsUKjfh3A
         ypFAXtnm35sJI9TbUAii04oEsQBu6fNYS30q/sdrPsUj3wPRaCFbV1N1xdp5AemRKPQD
         rASuL4lMJYXnB88UVY7kIz1oBbgHcwqw7+Qaebjkzyq/VE2k2Nkly+4JhV4evyHHfHIa
         WAeA==
X-Gm-Message-State: APjAAAWp4JNh3MYWYNzR47wWycyWP9h9pOd5i+UITALDLF/784NUBRdL
        k9iht8MrtPInpqZaH/dn+v8nSq7P+oudpmBP/Go=
X-Google-Smtp-Source: APXvYqwujrjuUCST+4uHnfpiYapTDsc3Rcz/pOsAMrXR8roxISrHIXdcPXz2AvuYfVD9HHTRiTzbd0DLEH+IWal/aSI=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr71152413wmc.25.1563951889935;
 Wed, 24 Jul 2019 00:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190723084104.12639-1-daniel.baluta@nxp.com> <20190723084104.12639-4-daniel.baluta@nxp.com>
 <d85909d6-c7cb-c64b-dfa9-6cee6c0da2cb@linux.intel.com>
In-Reply-To: <d85909d6-c7cb-c64b-dfa9-6cee6c0da2cb@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 24 Jul 2019 10:04:38 +0300
Message-ID: <CAEnQRZDr+gj_eiESLNbVUVy1rreRE1nnDgtb3g=CjaRF5Aq9Vw@mail.gmail.com>
Subject: Re: [Sound-open-firmware] [PATCH v2 3/5] ASoC: SOF: Add DT DSP device support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Olaru <paul.olaru@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 6:19 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> > diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
> > index 61b97fc55bb2..2aa3a1cdf60c 100644
> > --- a/sound/soc/sof/Kconfig
> > +++ b/sound/soc/sof/Kconfig
> > @@ -36,6 +36,15 @@ config SND_SOC_SOF_ACPI
> >         Say Y if you need this option
> >         If unsure select "N".
> >
> > +config SND_SOC_SOF_DT
> > +     tristate "SOF DT enumeration support"
> > +     select SND_SOC_SOF
> > +     select SND_SOC_SOF_OPTIONS
> > +     help
> > +       This adds support for Device Tree enumeration. This option is
> > +       required to enable i.MX8 devices.
> > +       Say Y if you need this option. If unsure select "N".
> > +
>
> [snip]
>
> > diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> > index fff64a9970f0..fa35994a79c4 100644
> > --- a/sound/soc/sof/imx/Kconfig
> > +++ b/sound/soc/sof/imx/Kconfig
> > @@ -12,6 +12,7 @@ if SND_SOC_SOF_IMX_TOPLEVEL
> >
> >   config SND_SOC_SOF_IMX8
> >       tristate "SOF support for i.MX8"
> > +     select SND_SOC_SOF_DT
>
> This looks upside down. You should select SOF_DT first then include the
> NXP stuff.
>
> >       help
> >             This adds support for Sound Open Firmware for NXP i.MX8 platforms
> >             Say Y if you have such a device.
> > diff --git a/sound/soc/sof/sof-dt-dev.c b/sound/soc/sof/sof-dt-dev.c
> > new file mode 100644
> > index 000000000000..31429bbb5c7e
> > --- /dev/null
> > +++ b/sound/soc/sof/sof-dt-dev.c
> > @@ -0,0 +1,159 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +//
> > +// Copyright 2019 NXP
> > +//
> > +// Author: Daniel Baluta <daniel.baluta@nxp.com>
> > +//
> > +
> > +#include <linux/firmware.h>
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> > +#include <sound/sof.h>
> > +
> > +#include "ops.h"
> > +
> > +extern struct snd_sof_dsp_ops sof_imx8_ops;
> > +
> > +static char *fw_path;
> > +module_param(fw_path, charp, 0444);
> > +MODULE_PARM_DESC(fw_path, "alternate path for SOF firmware.");
> > +
> > +static char *tplg_path;
> > +module_param(tplg_path, charp, 0444);
> > +MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
> > +
> > +/* platform specific devices */
> > +#if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8)
> > +static struct sof_dev_desc sof_dt_imx8qxp_desc = {
> > +     .default_fw_path = "imx/sof",
> > +     .default_tplg_path = "imx/sof-tplg",
> > +     .nocodec_fw_filename = "sof-imx8.ri",
> > +     .nocodec_tplg_filename = "sof-imx8-nocodec.tplg",
> > +     .ops = &sof_imx8_ops,
> > +};
> > +#endif
> > +
> > +static const struct dev_pm_ops sof_dt_pm = {
> > +     SET_SYSTEM_SLEEP_PM_OPS(snd_sof_suspend, snd_sof_resume)
> > +     SET_RUNTIME_PM_OPS(snd_sof_runtime_suspend, snd_sof_runtime_resume,
> > +                        NULL)
> > +};
> > +
> > +static void sof_dt_probe_complete(struct device *dev)
> > +{
> > +     /* allow runtime_pm */
> > +     pm_runtime_set_autosuspend_delay(dev, SND_SOF_SUSPEND_DELAY_MS);
> > +     pm_runtime_use_autosuspend(dev);
> > +     pm_runtime_enable(dev);
> > +}
> > +
> > +static int sof_dt_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     const struct sof_dev_desc *desc;
> > +     /*TODO: create a generic snd_soc_xxx_mach */
> > +     struct snd_soc_acpi_mach *mach;
>
> I wonder if you really need to use the same structures. For Intel we get
> absolutely zero info from the firmware so rely on an ACPI codec ID as a
> key to find information on which firmware and topology to use, and which
> machine driver to load. You could have all this information in a DT blob?

Yes. I see your point. I will still need to make a generic structure for
snd_soc_acpi_mach so that everyone can use sof_nocodec_setup function.

Maybe something like this:

struct snd_soc_mach {
  union {
  struct snd_soc_acpi_mach acpi_mach;
  struct snd_soc_of_mach of_mach;
  }
};

and then change the prototype of sof_nocodec_setup.
