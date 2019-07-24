Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42631C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134FC214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWt/IW5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfGXGmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:42:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33426 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXGmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:42:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so32676285wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhhTks9k7nEzj+aqUPzjcgfPfrYu7EH2vLu4ISBiDtk=;
        b=DWt/IW5iTiJuFdKySxXe/u8ZM2xivsOCZIeSJPaLQseWNAb2LGlkoIeWzw4rDAztHh
         lGWzWEf5e3Xetp9zUbH80REkydjclSSLXwv5fn9dKednX+X44gs0TBvY0T4bWC2R22hZ
         rc0GxARNjAv5hZB/Xw898dmY091/0pot9hn9hMaGHeeAZNELSzvJLTuhNdblrjv25ZZ1
         /nRgFF2G7a5lm3FuKTwDZjFnFHi/6GAK2lqF0hhXJ0dUl9vCY/t3GMgYCH7PigSbAJ4h
         QxW9esCoWqGFKlASOpemnAmG90MTPBdhAIGa6VYbAlL0OuUTC87dmwXOUcbYFdmmmrw6
         DxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhhTks9k7nEzj+aqUPzjcgfPfrYu7EH2vLu4ISBiDtk=;
        b=TjHC30TXpkR/Q/P3G5G7nsuWpWE6vfd9MIlvpBfF+LQG50ltErY0yWZtNJr/toSi+8
         lU8RfXGFE/o9D3WqqreWS60vXuo/iu3cNPeosEsOOWQwQ8oNMqDx0u2ZyaQq/bdWbysl
         vodOhI8U8FtQg0SPlB9ZZBWd0MWk7TKvexsqas/KwZBhanWkZPVu+fxpCSGUQ7/5BPfs
         zCpJzUw5ogc2ZNr+wIra2hLiSrgKShiW6vRazOFMauIUp3SpRxtH5ch9AmryeBmGQkIe
         yP4rhjTQIM6xxI/BXycAa21Xk5eKH1yitKNc5tnjDgUKTcvj8zx36jCJTBsOdP562zWy
         3whQ==
X-Gm-Message-State: APjAAAVev+/qIEDjjS9LTDhcL1QBGArTU1joPaTvMc3nun+WYrhjFBvL
        cxuPZP99QJdtC1ilhrFnR32dJTTkysjXiVbmqnk=
X-Google-Smtp-Source: APXvYqwdVUJE/2oWoyFAfBzcKEi4mRXrXogdySO7cGxwUbUTLuzL6gabc5kqGwLm/BmR7O6IXFq3v2LF0AqX/kj3+dg=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr71032749wmc.25.1563950564848;
 Tue, 23 Jul 2019 23:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190722124833.28757-1-daniel.baluta@nxp.com> <20190722124833.28757-2-daniel.baluta@nxp.com>
 <20190723170035.GO5365@sirena.org.uk>
In-Reply-To: <20190723170035.GO5365@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 24 Jul 2019 09:42:33 +0300
Message-ID: <CAEnQRZC_mNnwYkpdiX2d_ccT_L-hivWdxQTMEUojjDWv+NCiQg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 01/10] ASoC: fsl_sai: add of_match data
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 8:01 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jul 22, 2019 at 03:48:24PM +0300, Daniel Baluta wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > New revisions of the SAI IP block have even more differences that need
> > be taken into account by the driver. To avoid sprinking compatible
> > checks all over the driver move the current differences into of_match_data.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 22 ++++++++++++++--------
>
> You need to supply your own signoff if you're sending someone else's
> patch - see submitting-patches.rst for details on what signoffs mean and
> why they're required.

Ack. Sorry for missing this.
