Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F301FC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08A4208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU2rDFdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfGRGiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:38:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41449 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfGRGiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:38:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so24112107wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 23:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2NnsxHalTFFT0d2ugA84iA0C6unTFDCXxJpmFCZMDg=;
        b=mU2rDFdHqqyMoewMCLooVx5uKTiCYayKKBLfWUX8Dgg5gXoroHS4qdTUOUM2FLZKD4
         17yUnokEo/X/I4X+Q3NWDdqKgP5kJDkou5Sazt40bpBHtabab/e4+tQMuh+qc5F5HwR5
         M8WtZImqd4/Hr8k6rtB1WWn+TIZI7gXMMcVov9HbXodmBhxu8CmdSqhAGC6wF9lK5K5P
         WeVE/Aq4XpJqkVwRdpH4Tjsf1sGgFtb6AtIBrbNddZg1wMxTEq+XmtNJ42PuftltArzz
         5tEROO7cdZxwUn6cZpUG1u8kkVasWSz40rn8iUKe6UFIG5ZWozSHhin9eqlO2asjdCEm
         u4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2NnsxHalTFFT0d2ugA84iA0C6unTFDCXxJpmFCZMDg=;
        b=TU4P0/BhEcal0a6VJLWRq36p4O21gd1AJXxYbODsBJ8Gl0BS3zUt5xtx1Vim6WklKh
         3zheIhyZ8eKZGuNp9+SzMKurB2R/g8RzuiVz7eXowF7/AA4h+KTOx/Ox3WbePsJm/Prt
         Wl9HiHezfkGPyVW4KwwM/x6PVaqAd9x+dbS/J4kAzgCLllIF+4XOcAB+2MAUnI5PBWIZ
         /eIknMNdA4RRHgLR/WsOtgR+sO8bx25F7c9nXwO622pe53RU17YJCNo8gSXnFv0RM7PI
         hbIIAXF2AiJn8pPog4tiFKz4BsLm47thoReUzXvEAOIEGe5dPyP8CeByexx7qys6c688
         5zGA==
X-Gm-Message-State: APjAAAX3SaQFESkr2nWjThLxMz8IwjVXDyKg62kYVTFDnlugqsFVVuEF
        VwRndtibY5gEycthqZSW9YlFGkGubOg3Swu7r18=
X-Google-Smtp-Source: APXvYqxUwHrtJKmu5n1SW9b0UpwbGBaVe46KpI2iRZpTMEgoEse0M/DfOakllhKIekqXAIC5t8aZJB40FbIb1aR8M1k=
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr47876504wrx.196.1563431903288;
 Wed, 17 Jul 2019 23:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190703190404.21136-1-daniel.baluta@nxp.com> <20190703190404.21136-3-daniel.baluta@nxp.com>
 <AM0PR04MB42114DD325C5DB2E06011A4A80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42114DD325C5DB2E06011A4A80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 18 Jul 2019 09:38:11 +0300
Message-ID: <CAEnQRZDrx9tAiE5OnOkudy4eVLxjvhpHYg=ipPn6qo1hTVw5Aw@mail.gmail.com>
Subject: Re: [PATCH 2/3] firmware: imx: scu-pd: Add mu_b side PD range
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 6:30 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> > Sent: Thursday, July 4, 2019 3:04 AM
> > Subject: [PATCH 2/3] firmware: imx: scu-pd: Add mu_b side PD range
> >
> > LSIO subsystem contains 14 MU instances.
> >
> > 5 MUs to communicate between AP <-> SCU
> >   - side-A PD range managed by AP
> >   - side-B PD range managed by SCU
> >
> > 9 MUs to communicate between AP <-> M4
>
> The left 9MUs are general and can be used by all cores,
> e.g AP/M4/DSP.
> So below description is not correct.
>
Indeed. In the particular case of the DSP it is true.

I don't know exactly who will use MUs 5..12. I only
know that MU 13 is assigned to DSP and we prefer
to power up side-b from AP because powering up
from DSP would be a pain.

This means that DSP needs a way to communicate with SCU
so basically it needs another MU for that.

> >   - side-A PD range managed by AP
> >   - side-B PD range managed by AP
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  drivers/firmware/imx/scu-pd.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
> > index 950d30238186..30adc3104347 100644
> > --- a/drivers/firmware/imx/scu-pd.c
> > +++ b/drivers/firmware/imx/scu-pd.c
> > @@ -93,6 +93,7 @@ static const struct imx_sc_pd_range
> > imx8qxp_scu_pd_ranges[] = {
> >       { "kpp", IMX_SC_R_KPP, 1, false, 0 },
> >       { "fspi", IMX_SC_R_FSPI_0, 2, true, 0 },
> >       { "mu_a", IMX_SC_R_MU_0A, 14, true, 0 },
> > +     { "mu_b", IMX_SC_R_MU_5B, 9, true, 0 },
>
> Should start from 5?
> { "mu_b", IMX_SC_R_MU_5B, 9, true, 5 },

I guess you are right. I think start_from is used
to form the pd name, because the actual rsrc
is computed as follows:

sc_pd->rsrc = pd_ranges->rsrc + idx;

So, I think for this reason it just worked for me.

Anyhow, I'm thinking about powering up only MU13_B from AP side
and let the user of other MU sides B to decide from themselves.

So, the change will be:

> > +     { "mu_b", IMX_SC_R_MU_13B, 1, true, 13 },

Will send v2 asap.
