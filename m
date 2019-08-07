Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB2BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E26221E73
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnJXIanO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbfHGP3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:29:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34265 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbfHGP3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:29:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id e8so1614807wme.1;
        Wed, 07 Aug 2019 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VG/v2EcjQtU+cEfTNI3UprkTRn21iUqihlnLWb3k5us=;
        b=XnJXIanO6DT+z/NNIAJBl2xdwwXc1b4c28EKcSXn8OpDji0A83SN/+NDdoqHQVCuwa
         48kvieuPJwwLoIYqdfm3qNiBVfVLY2VXlnkCzZrvMh20GTh9o8LoI/n8Bo32IglogZy6
         w8Bn7wDDaOvt8mlIKKa9Otk6kIj6aE/bziEpUioS+gsrcJJA2W1361dahPaaXM9C0+LP
         +rofKoHfx/q9k6ztoeNdSQeLv+3t9vjjthUN9O+kWt7tOR99fIsarJHV0w/33utSVMrs
         tc7eZoz8HTz6Yictyamd6QKjw639q3obifcvSOgwJGGmDQdE+oOTqEDE0Y3OX7xTv2Dm
         w5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VG/v2EcjQtU+cEfTNI3UprkTRn21iUqihlnLWb3k5us=;
        b=Dv/rqdlc37BkBD/CHNkyphdAJH7kdGiTHQMlYNBu53t/g8LxisobA/FuyYKmwvAVhE
         lmUdGMIyqC/bLc8dZLIhnNNtbUV/+TcSK44IxJEyRUR7PAEWlqK6X9xMFCmbIc5EomH1
         3eMn4HxcCg0f5vtOtlx0xRE+Z9rgfG1VZubNflDdtzFT8FkNm1W3TFd3noOgILB2UxW9
         5GvKqRoscfnw+KoeySBY21LbSp3Fe+SS6o6hj8vDi72kVGQ53QzoNj0q+Gz5mmPKZF2w
         Nh+cxghkNnYOO86XCsUFS+DsASvrsEw2Z+OGmFivvT1sMd8xkv1WValw6gxZ01boWs6u
         8ozA==
X-Gm-Message-State: APjAAAXBlVCtauUSDiuND/IPW5adKAIjDqY2E3XQoPkETeWVfejZuVlS
        WGBO1hwWg6OT3XxAv1CW7DSxRzCd/ENRa0zzBx0zDECI
X-Google-Smtp-Source: APXvYqw2rwj2dbTOShRFHhRt4TkyI57KEtaj4B82n3AdjyeJjOGYe3gvF3lE/vwP9WXD9jGhm5Rr8vb2SW0mV/cQFcQ=
X-Received: by 2002:a7b:c247:: with SMTP id b7mr535018wmj.13.1565191787233;
 Wed, 07 Aug 2019 08:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190723084104.12639-1-daniel.baluta@nxp.com> <20190723084104.12639-4-daniel.baluta@nxp.com>
 <d85909d6-c7cb-c64b-dfa9-6cee6c0da2cb@linux.intel.com>
In-Reply-To: <d85909d6-c7cb-c64b-dfa9-6cee6c0da2cb@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 7 Aug 2019 18:29:36 +0300
Message-ID: <CAEnQRZARFQjutkvW3_xkQAQznNm8c5jSjtAG715VtrZnDxztoA@mail.gmail.com>
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

One more thing: So this should be 'depends on SND_SOC_SOF_DT' right?
