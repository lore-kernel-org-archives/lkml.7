Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D628C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D343321BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pko8c1D1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbfHGP2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:28:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34180 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbfHGP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:28:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id e8so1612599wme.1;
        Wed, 07 Aug 2019 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J2AxcJjTu4Em2coCWWa3ZaD+BRTicwzIxGa7Qvvd3rw=;
        b=pko8c1D1aNeK/Wvm+bO/5XEEt4y6uMaXC6vj+i+eNuI9tg6Uie6LjG7sAOcNEHYoOk
         mYHbOpwvmIGq91Ky9OIaoq465kLZkBefxD2SuHoGpQ1wdbxLSizqITWpsjPzP/XQKLrQ
         nDSvlTxMLqD5kUrn6FftauflqcjP4FXSt6T+d34I32aGNTctXvhgAbt/cFgv2HSiVHrO
         lGjRV7s1wjwkbHTgciB7d23c+3ylZPOmAIY+p017qY3Ll2rcCkpZhVm8ONKBZd8irT7e
         lIGabt0+pkI1YymwB+hZnffI/I8eDAYfYVLI6aFrMvsuYQqyO35K4yiJJKj1bt3fGasB
         mouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J2AxcJjTu4Em2coCWWa3ZaD+BRTicwzIxGa7Qvvd3rw=;
        b=Ul6oef+sR/lj72Dn8WRVsv9ncZ6BVbb59RSun0oI5CJ0aDRnJ7/5UL7BFdDDQ5Twkx
         +1qCZTIcjZmM8FlK24GcU96c12NWa30umd3l9EdPb0/29E9McJnD2cBUzZhDb6WUxT+g
         pv3VmrKzESjtQsNYRcUlYN2/6LcjRmgAY6MWcVaRM6lsuPAo+JarFdYqX6/y/cd75ugj
         CA046X/eR8ot4uyt05sALBclHieMDqc8kYDDXvN7Ed9CWGyY/i241rY8yrh3MaNnCSKq
         QVJ4jh867ji8W51tYI7g4ZcA/aF8FwsZ2xAlF7fDb3hFnJCPrCVYejhiu7ojHCEHHfM8
         Kyyg==
X-Gm-Message-State: APjAAAUjOZAiKV6gIDVyXXK/fmTpg6FBbA3weUpDqOruC7DWbIQOK0M5
        jxVrqqxGJ1ijm1Pq/iEywiHFARABejcrwEep/5E=
X-Google-Smtp-Source: APXvYqwW5WCgzinAjb7xq61mUOt92YHJ1JbOQnTpyr7Jy8pOLiPx/RMXO6UztD9op0ES3Y54p/AuIMtAs4mN+LKyH0E=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr496286wmc.25.1565191716999;
 Wed, 07 Aug 2019 08:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190723084104.12639-1-daniel.baluta@nxp.com> <20190723084104.12639-4-daniel.baluta@nxp.com>
 <d85909d6-c7cb-c64b-dfa9-6cee6c0da2cb@linux.intel.com> <CAEnQRZDr+gj_eiESLNbVUVy1rreRE1nnDgtb3g=CjaRF5Aq9Vw@mail.gmail.com>
 <CAEnQRZDctjdzQ2RjJXhQh+s=d0y_j3Taa51hDaR4bqJ62C=7iQ@mail.gmail.com> <85b4a2c4-761e-bdcf-f05e-2fb16c06f11e@linux.intel.com>
In-Reply-To: <85b4a2c4-761e-bdcf-f05e-2fb16c06f11e@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 7 Aug 2019 18:28:25 +0300
Message-ID: <CAEnQRZCE3mxorYpL_nPXiU4MezGDaqUfuFDx8ci0WdXzDa68JA@mail.gmail.com>
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

On Wed, Aug 7, 2019 at 6:22 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >>>> +static int sof_dt_probe(struct platform_device *pdev)
> >>>> +{
> >>>> +     struct device *dev =3D &pdev->dev;
> >>>> +     const struct sof_dev_desc *desc;
> >>>> +     /*TODO: create a generic snd_soc_xxx_mach */
> >>>> +     struct snd_soc_acpi_mach *mach;
> >>>
> >>> I wonder if you really need to use the same structures. For Intel we =
get
> >>> absolutely zero info from the firmware so rely on an ACPI codec ID as=
 a
> >>> key to find information on which firmware and topology to use, and wh=
ich
> >>> machine driver to load. You could have all this information in a DT b=
lob?
> >>
> >> Yes. I see your point. I will still need to make a generic structure f=
or
> >> snd_soc_acpi_mach so that everyone can use sof_nocodec_setup function.
> >>
> >> Maybe something like this:
> >>
> >> struct snd_soc_mach {
> >>    union {
> >>    struct snd_soc_acpi_mach acpi_mach;
> >>    struct snd_soc_of_mach of_mach;
> >>    }
> >> };
> >>
> >> and then change the prototype of sof_nocodec_setup.
> >
> > Hi Pierre,
> >
> > I fixed all the comments except the one above. Replacing snd_soc_acpi_m=
ach
> > with a generic snd_soc_mach is not trivial task.
> >
> > I wonder if it is acceptable to get the initial patches as they are
> > now and later switch to
> > generic ACPI/OF abstraction.
> >
> > Asking this because for the moment on the i.MX side I have only
> > implemented no codec
> > version and we don't probe any of the machine drivers we have.
> >
> > So, there is this only one member of snd_soc_acpi_mach that imx
> > version is making use of:
> >
> >    mach->drv_name =3D "sof-nocodec";
> >
> > That's all.
> >
> > I think the change as it is now is very clean and non-intrusive. Later
> > we will get options to
> > read firmware name and stuff from DT.
> >
> > Anyhow, I don't think we can get rid of snd_dev_desc structure on
> > i.MX. This will be used
> > to store the information read from DT:
> >
> > static struct sof_dev_desc sof_of_imx8qxp_desc =3D {
> > =C2=BB       .default_fw_path =3D "imx/sof",
> > =C2=BB       .default_tplg_path =3D "imx/sof-tplg",
> > =C2=BB       .nocodec_fw_filename =3D "sof-imx8.ri",
> > =C2=BB       .nocodec_tplg_filename =3D "sof-imx8-nocodec.tplg",
> > =C2=BB       .ops =3D &sof_imx8_ops,
> > };
> >
> > For the moment we will only use the default values.
>
> Yes, that's fine for now. If you don't have a real machine driver then
> there's nothing urgent to change.
>
> Is the new version on GitHub?

Not yet, will push it today and ping you.
