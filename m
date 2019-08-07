Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBE5C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63E42199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2l7rU7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfHGOjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:39:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51304 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbfHGOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:39:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so313769wma.1;
        Wed, 07 Aug 2019 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K3Yjg+xwVoamXkqxN6/Mo8Ar1gX/X1ON888J6lxpDb0=;
        b=B2l7rU7IPu+JXRGMl8QfJUzpwZ28LjIHxm8XnVXNq0gwva0s9ictzM6X7F5r5lOaRh
         W/9M+aS5PF/moOqTNrvL8PTWBrU1OChSRHHYD5Gl26UM2c/XJuQSj+zUSqeyx5mHw9KV
         JxrV/PASdpePmtAV2LgSlO1jODiKVEaxrkvNE2zyoUpKD+57HAIz9G0Vt+cbffnZAB8y
         KMOyQ4wYUJL7Jx8aRRqsfh5HCuPKEioi/X+yVVB2YYKKRmop624g3uv1OSnQn1OiZcbN
         X7xXbq5SabV5/H+oo/rTqQLcX1gftqHyjyL3W23xdeYYUU5gpEjxvNqmpl2XC+ZUVEHH
         O57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K3Yjg+xwVoamXkqxN6/Mo8Ar1gX/X1ON888J6lxpDb0=;
        b=LAdtyg3usgfdDS3poRyY/OauNQ74eMXhcHlYLT+urFEZaJ3Aqm1M7GAHDMqRGB7l9d
         9CoQDVeD3XXRrHm4ZankySwXpy2dE1i9fWGS+qM9NigS6uUPIgDYEHctwO0BodrKFoP7
         rdlsS4iEmxSIoGFsE6LAErXknVVGXNExsCPlnlU+QXTJu1QzotIzwCdGFT1Ru6rMdTqD
         1orGUXSTfxESwC/El7YPmADTvu+qta325KLsCocvGrCW92UWfUYqkSpH5YgaNUCB2mEl
         S2kjlzkzmdc4QXoQx8BOz+xQXu+qf7ORSGbkFUPV3uFb7lFvI6EiWjCbIDBzn0tU4EB5
         RuDg==
X-Gm-Message-State: APjAAAXXA6YJ5TpIgE33qv7OuRew4g393DU4cMD8AXQLMdSFzdqdnLWW
        6pARjaB6+PWE2LMKc9oHmHK85Lgiuvg6nNo6vfBLnRzKALo=
X-Google-Smtp-Source: APXvYqwZNSmFBi3BN7qPlFo9Y+mrgNDxC+IKDcfat8O3sJ6OJz8/ng2g2yNHMqSIvOfg0Ag2R+8W+Stu5hZuRd9Xt3k=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr290648wmc.25.1565188753002;
 Wed, 07 Aug 2019 07:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190723084104.12639-1-daniel.baluta@nxp.com> <20190723084104.12639-4-daniel.baluta@nxp.com>
 <d85909d6-c7cb-c64b-dfa9-6cee6c0da2cb@linux.intel.com> <CAEnQRZDr+gj_eiESLNbVUVy1rreRE1nnDgtb3g=CjaRF5Aq9Vw@mail.gmail.com>
In-Reply-To: <CAEnQRZDr+gj_eiESLNbVUVy1rreRE1nnDgtb3g=CjaRF5Aq9Vw@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 7 Aug 2019 17:39:00 +0300
Message-ID: <CAEnQRZDctjdzQ2RjJXhQh+s=d0y_j3Taa51hDaR4bqJ62C=7iQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:04 AM Daniel Baluta <daniel.baluta@gmail.com> wr=
ote:
>
> On Tue, Jul 23, 2019 at 6:19 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
> >
> >
> > > diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
> > > index 61b97fc55bb2..2aa3a1cdf60c 100644
> > > --- a/sound/soc/sof/Kconfig
> > > +++ b/sound/soc/sof/Kconfig
> > > @@ -36,6 +36,15 @@ config SND_SOC_SOF_ACPI
> > >         Say Y if you need this option
> > >         If unsure select "N".
> > >
> > > +config SND_SOC_SOF_DT
> > > +     tristate "SOF DT enumeration support"
> > > +     select SND_SOC_SOF
> > > +     select SND_SOC_SOF_OPTIONS
> > > +     help
> > > +       This adds support for Device Tree enumeration. This option is
> > > +       required to enable i.MX8 devices.
> > > +       Say Y if you need this option. If unsure select "N".
> > > +
> >
> > [snip]
> >
> > > diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> > > index fff64a9970f0..fa35994a79c4 100644
> > > --- a/sound/soc/sof/imx/Kconfig
> > > +++ b/sound/soc/sof/imx/Kconfig
> > > @@ -12,6 +12,7 @@ if SND_SOC_SOF_IMX_TOPLEVEL
> > >
> > >   config SND_SOC_SOF_IMX8
> > >       tristate "SOF support for i.MX8"
> > > +     select SND_SOC_SOF_DT
> >
> > This looks upside down. You should select SOF_DT first then include the
> > NXP stuff.
> >
> > >       help
> > >             This adds support for Sound Open Firmware for NXP i.MX8 p=
latforms
> > >             Say Y if you have such a device.
> > > diff --git a/sound/soc/sof/sof-dt-dev.c b/sound/soc/sof/sof-dt-dev.c
> > > new file mode 100644
> > > index 000000000000..31429bbb5c7e
> > > --- /dev/null
> > > +++ b/sound/soc/sof/sof-dt-dev.c
> > > @@ -0,0 +1,159 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > > +//
> > > +// Copyright 2019 NXP
> > > +//
> > > +// Author: Daniel Baluta <daniel.baluta@nxp.com>
> > > +//
> > > +
> > > +#include <linux/firmware.h>
> > > +#include <linux/module.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <sound/sof.h>
> > > +
> > > +#include "ops.h"
> > > +
> > > +extern struct snd_sof_dsp_ops sof_imx8_ops;
> > > +
> > > +static char *fw_path;
> > > +module_param(fw_path, charp, 0444);
> > > +MODULE_PARM_DESC(fw_path, "alternate path for SOF firmware.");
> > > +
> > > +static char *tplg_path;
> > > +module_param(tplg_path, charp, 0444);
> > > +MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
> > > +
> > > +/* platform specific devices */
> > > +#if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8)
> > > +static struct sof_dev_desc sof_dt_imx8qxp_desc =3D {
> > > +     .default_fw_path =3D "imx/sof",
> > > +     .default_tplg_path =3D "imx/sof-tplg",
> > > +     .nocodec_fw_filename =3D "sof-imx8.ri",
> > > +     .nocodec_tplg_filename =3D "sof-imx8-nocodec.tplg",
> > > +     .ops =3D &sof_imx8_ops,
> > > +};
> > > +#endif
> > > +
> > > +static const struct dev_pm_ops sof_dt_pm =3D {
> > > +     SET_SYSTEM_SLEEP_PM_OPS(snd_sof_suspend, snd_sof_resume)
> > > +     SET_RUNTIME_PM_OPS(snd_sof_runtime_suspend, snd_sof_runtime_res=
ume,
> > > +                        NULL)
> > > +};
> > > +
> > > +static void sof_dt_probe_complete(struct device *dev)
> > > +{
> > > +     /* allow runtime_pm */
> > > +     pm_runtime_set_autosuspend_delay(dev, SND_SOF_SUSPEND_DELAY_MS)=
;
> > > +     pm_runtime_use_autosuspend(dev);
> > > +     pm_runtime_enable(dev);
> > > +}
> > > +
> > > +static int sof_dt_probe(struct platform_device *pdev)
> > > +{
> > > +     struct device *dev =3D &pdev->dev;
> > > +     const struct sof_dev_desc *desc;
> > > +     /*TODO: create a generic snd_soc_xxx_mach */
> > > +     struct snd_soc_acpi_mach *mach;
> >
> > I wonder if you really need to use the same structures. For Intel we ge=
t
> > absolutely zero info from the firmware so rely on an ACPI codec ID as a
> > key to find information on which firmware and topology to use, and whic=
h
> > machine driver to load. You could have all this information in a DT blo=
b?
>
> Yes. I see your point. I will still need to make a generic structure for
> snd_soc_acpi_mach so that everyone can use sof_nocodec_setup function.
>
> Maybe something like this:
>
> struct snd_soc_mach {
>   union {
>   struct snd_soc_acpi_mach acpi_mach;
>   struct snd_soc_of_mach of_mach;
>   }
> };
>
> and then change the prototype of sof_nocodec_setup.

Hi Pierre,

I fixed all the comments except the one above. Replacing snd_soc_acpi_mach
with a generic snd_soc_mach is not trivial task.

I wonder if it is acceptable to get the initial patches as they are
now and later switch to
generic ACPI/OF abstraction.

Asking this because for the moment on the i.MX side I have only
implemented no codec
version and we don't probe any of the machine drivers we have.

So, there is this only one member of snd_soc_acpi_mach that imx
version is making use of:

  mach->drv_name =3D "sof-nocodec";

That's all.

I think the change as it is now is very clean and non-intrusive. Later
we will get options to
read firmware name and stuff from DT.

Anyhow, I don't think we can get rid of snd_dev_desc structure on
i.MX. This will be used
to store the information read from DT:

static struct sof_dev_desc sof_of_imx8qxp_desc =3D {
=C2=BB       .default_fw_path =3D "imx/sof",
=C2=BB       .default_tplg_path =3D "imx/sof-tplg",
=C2=BB       .nocodec_fw_filename =3D "sof-imx8.ri",
=C2=BB       .nocodec_tplg_filename =3D "sof-imx8-nocodec.tplg",
=C2=BB       .ops =3D &sof_imx8_ops,
};

For the moment we will only use the default values.

thanks,
Daniel.
