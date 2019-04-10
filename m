Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B588C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6E42083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4OuWGjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfDJGs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:48:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37838 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfDJGs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:48:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id l20so990748edv.4;
        Tue, 09 Apr 2019 23:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flRuh9bHQFZIbByfoeIgE1Z7A8kc8C3hbrbhRaH/cMw=;
        b=l4OuWGjCTqDiCw8tcK3t1wrHcXDHqloHA6+GQyHFpI0xoiBzaME/AeOg1FQ7sGRhuU
         FYzIYiOcQe2SOMFRcIDMkKgNkIShBUWVW/l8KqAtPXYe6gwhIpZAC0QuVH+TN1tDU+V2
         obfn9uy4bmqlBTO7AkvUsJxalkeP1VJFIbKwP8HATya+7miEz3AP31aHsfSn7Thz8quO
         SF7spTas3raK/nop20U90ZPg3plOZZDTqmnrpVOaKquzPFMQIrsf15ShAKmL1RrP5U//
         +Ct7+cj7MGAcLhBrkvkuKJMDZ+ONWJvluQK8rTPBYYZU1kMkTqhn9Bd34PkW2kOiRayO
         f93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flRuh9bHQFZIbByfoeIgE1Z7A8kc8C3hbrbhRaH/cMw=;
        b=Wp8nOxQEphA2uRLaYalJl2i2eplekzQCpve4tprc6H05NR1HofcbAWreYCeAtWZeEM
         1Lp3pyv3UklRcaKano+9s0f/7jGOtHibHc7y6BvibkTtp4Rmd3Huy3KqEY4IJIBF04bB
         L1Gcv5dy8P8rKDuy6HSLKC4TGxMf5KNv3AkBH96mgpMxAzmn3Q2hg3wCco8rDyUyOnlg
         hAVZkEcx3Gf0r4hcUbdPrgkfVbbf8GdqqVtSedvY5GmL7rB8gp/+Hf1q1Qo2Q48yfaNp
         3Z5uugwc5AZsQWeh7DF57B+wU8QFcsvlUhq3NPCxlN1x8xkyNiB3+aDr6bgP1mH1rcoR
         t6KQ==
X-Gm-Message-State: APjAAAX0WsyNY9DxCGSpvMF5TyQSSjFxxJeBYxL/3wNk7D3Dk4jH2K5x
        HneTK1gVKoJyqLqMIz4dEnbj/gvIoMnqXbp7Ceg=
X-Google-Smtp-Source: APXvYqwoahLpsxixg3+GMsNRY6g7PezqJqQLfIljHOC0YMHHGbMfnJx2drSXaeTlK6nJR8F4ejk3aFel+Ja738C6eNs=
X-Received: by 2002:a50:bdc4:: with SMTP id z4mr25711024edh.199.1554878935147;
 Tue, 09 Apr 2019 23:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com> <20190410042906.GC3032@Asurada>
 <CAEnQRZBDSrpje2-ML0zr+oJkwMbbkxV5hUNc_HzZtPZv-et8mA@mail.gmail.com> <20190410063714.GA4156@Asurada>
In-Reply-To: <20190410063714.GA4156@Asurada>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 10 Apr 2019 09:48:43 +0300
Message-ID: <CAEnQRZAKC93vJnirvSxyJMpaoXdht83ikJz3LYFFbeBd4w__zA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: fsl_audmix: remove "model" attribute
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Viorel Suman <viorel.suman@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 9:37 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Wed, Apr 10, 2019 at 09:20:29AM +0300, Daniel Baluta wrote:
> > Hi Nicolin,
> >
> > On Wed, Apr 10, 2019 at 7:30 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> > > > Use "of_device_id.data" to specify the machine driver
> > > > instead of "model" DTS attribute.
> > > >
> > > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > >
> > > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > >
> > > > ---
> > > >  sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++--------------------
> > > >  1 file changed, 23 insertions(+), 20 deletions(-)
> > >
> > > > +     priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
> > > > +                                                0);
> > >
> > > Would you please send a separate patch to replace "pdev->dev"?
> >
> > I am not sure exactly how to explain this change in the commit message. It does
> > make code easier to read and avoids dereferencing pdev pointer each time.
> >
> > Is it enough for commit description?
>
> You mean this? https://lore.kernel.org/patchwork/patch/862610/

Yes! Thanks.
