Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E14B2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2L2g2zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfCKHYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:24:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44226 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCKHYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:24:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id b20so3079302edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aV/cUVgbGWGxibnwypCyB9ESGN4jVDwD4uDibonXMAI=;
        b=q2L2g2zlBuSbd2oXuIb/JUbscQp6sHjo06K/jJG/5at4RvuQaDsDpKjrcRzTnoS+mn
         cCBzJjZMYSSRg+yDUcih8/KfgZM99MKukhJBifi7SygXj2zKx8MjQC5ZDgZ0Xzq3J4b7
         wXlp/kMzZL2UX0pcr2v/KvzFb5ESQHMvnGsU/upJqxhfzM1L2Gg008GFSaPBJmgL4Nwj
         dYlXK34XPwHVx0nrZ2psnvy3oyn5k3ttvQVZdnw7pELJWGiZOy/RPUTl07EY9xw4EK8l
         mFdo95FccMHZBVYMMh2h7GaxiR1LohRcCX1CPwzvs9t6CxdaeXQi3J6BfMwx3efznITB
         RpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aV/cUVgbGWGxibnwypCyB9ESGN4jVDwD4uDibonXMAI=;
        b=pU/qx8byVVQoPRbkl9yDWQbfPSJbSsYMO/D74PPHQMY6/OPnbutbqQRId2Be0Ko9Ny
         CQuNCvR868Yjke5VV8wrVBKDt1oDFA2NxlQufZwgEXZJj/0MPonc8YgjRobPTMf3MuWJ
         rF6hs/uiafJdSDHL4CyB7G7iSk2iXD4duopnIVgak4ZZe9y/M4Fs/1fL37W+qkvVN0mM
         egxhfnFu2tLTlhdPB/mKMPpD7Wpi+Tk39WmTgDXBOIOnGpffMHDktQwaAOyZ2+1JxE3j
         96lRErelpyeZaBiEoxsSojKpk6ULAk7FRqbu19OD/6jhfZemxZpzuOHtK8b0BHPedMXx
         TGag==
X-Gm-Message-State: APjAAAVfKxNp1nL5RgSIaC+84WsEEVycpjJn8z26d7OFAF1wto5+/PzN
        2VPdakKG/arjC3zvu/fMQfDHYmkPiJoZLu4lGIY=
X-Google-Smtp-Source: APXvYqx1Li52XSK9Eiv1stojO/RwSlfoAslhYjOuRLHa4gZAd70tfNWL5EJGxHXeQsZ0PUP1efA3pZas6M7y9MoJiI0=
X-Received: by 2002:a50:d8ce:: with SMTP id y14mr42860856edj.101.1552289050558;
 Mon, 11 Mar 2019 00:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190308173904.27298-1-daniel.baluta@nxp.com> <20190308205805.GA8912@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190308205805.GA8912@Asurada-Nvidia.nvidia.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 11 Mar 2019 09:23:59 +0200
Message-ID: <CAEnQRZBpqgKAXBXrRQ9e-1Vj7hTZiqFbj1oghj9+pf0RKXN1EA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl: sai: Fix underrrun for playback stream start
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 10:59 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Mar 08, 2019 at 05:39:30PM +0000, Daniel Baluta wrote:
>
> > @@ -542,6 +544,11 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
> >       case SNDRV_PCM_TRIGGER_START:
> >       case SNDRV_PCM_TRIGGER_RESUME:
> >       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +             for (i = 0; tx && i < channels; i++)
> > +                     regmap_write(sai->regmap, FSL_SAI_TDR, 0x0);
>
> Though it could reduce underrrun for sure, I don't feel it's a
> thorough fix, especially when dealing with a duplex case where
> RX is the first stream while the driver enables both TE and RE
> at the same time. So the transmitter might have started before
> TX DMA request gets enabled.

I see your point here. This is trickier than I expected.
>
> We actually have something similar in the ESAI driver as that
> one is well documented. But SAI is apparently more tricky at
> the trigger() function. And the paragraph you pasted from the
> RM doesn't explicitly sound like we should do this.
>
> Btw, Instead of writing dummy data, have you tried polling the
> WFP pointer of the TFR0 register to make sure data is copied
> by the DMA?

This is a good suggestion. Will give it a try.

>
> > +             if (tx)
> > +                     udelay(10);
>
> Any justification for the delay? Missing a line of comments? I
> guess it's to address the 3-bit clocks timing. However, putting
> it before enabling DMA request doesn't make much sense to me.

Indeed. Will come back with a better patch in v3.

thanks,
Daniel.
