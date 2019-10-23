Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33500CA9EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADF32086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APOUMKFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfJWTK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 15:10:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33451 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732234AbfJWTK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:10:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id c184so3994434pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wedy5pGJORyqF9ETWtu/bm70wj9Mpmh0YPkLpaSld18=;
        b=APOUMKFtctD5mY/VLWicGv14AHP8YF2RxE9lCloG3iKAFDrN2TtgQYlXhplVkq163N
         LahF9pSBs/3XYq7f8DGrOA1pelXIB7/QHExaqDdYo0/XRURQ2dR6PNv+6orquAaoe27d
         Nv7Lr9mA4iCCfG5Gc0spya7J6B+m86iFUAXTJdlAL3PYLRAdGGvJ7S19DM6eF5WSGOFI
         09fL00QiV6pGErDbntOxAwVofo2iag6NLtRnv4XyjEj1mZJAnN2D99AKHUe4gPfAH3zT
         Q81sQY7T/i9g0npiSm+X2rZ825QvJnwpQVbFHA19Oa0XaojLBCe9PekB0jgj9W5HMNLt
         HFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wedy5pGJORyqF9ETWtu/bm70wj9Mpmh0YPkLpaSld18=;
        b=SbjLRd0E+inUpMdMluDAictauS2JUeSa2K7q4VYDTzwC7xzK81M27/JZLIWIZn1Z9H
         cXJn/03r1BZqHuNOFkpWvm635wOkWClfF0CzZhmnLPtuKLEqCSjxtYO5eW8odxZqQUoL
         6tTlkkbFzSKR0fDJlecGEl24ewnwqet2hIxsqKyUAQrubmuAeiqX5aCAzRxNTIIAZ/fV
         uWZq7m+MvKXGFiEThPhbYPCoRgSkNfTuPpiVhYDjORv4/4t3ldPMLRZ99rOWqnM96pfw
         FKh7XsrRyAkX0UW6TRz7Cg7UcQOqBMrhI1XTs5624Tdrj98/8iASozdqsEjusEgi/yGp
         r6zA==
X-Gm-Message-State: APjAAAV+K8ScbmaytNQBn13tcxhwWXvHPlhA8ZpX0Z7NipjQXD6P1SSL
        LyAM4Okz55YDspk+iZfdpBlE4q0Vcj8=
X-Google-Smtp-Source: APXvYqwSZez+2yq+w1FWUCzo61I7MRI0T+B0lXJzyoigx6N9h9tZfgWThfcHw5zU+lftX9TnLkY/3g==
X-Received: by 2002:a62:a50b:: with SMTP id v11mr12690945pfm.164.1571857827268;
        Wed, 23 Oct 2019 12:10:27 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id m102sm52695pje.5.2019.10.23.12.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 12:10:26 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:10:06 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_asrc: refine the setting of internal clock
 divider
Message-ID: <20191023191002.GB16043@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB647949BE7BDB9CD2B1B2C521E36B0@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB647949BE7BDB9CD2B1B2C521E36B0@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 06:25:20AM +0000, S.j. Wang wrote:
> > On Thu, Oct 17, 2019 at 02:21:08PM +0800, Shengjiu Wang wrote:
> > > For P2P output, the output divider should align with the output sample
> > 
> > I think we should avoid "P2P" (or "M2M") keyword in the mainline code as
> > we know M2M will never get merged while somebody working with the
> > mainline and caring about new feature might be confused.
> 
> Ok. But we still curious that is there a way to upstream m2m?

Hmm..I would love to see that happening. Here is an old discussion
that you may want to take a look:
https://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/076797.html

> > It makes sense to me, yet I feel that the delay at the beginning of the audio
> > playback might be longer as a compromise. I am okay with this decision
> > though...
> > 
> > > The maximum divider of asrc clock is 1024, but there is no judgement
> > > for this limitaion in driver, which may cause the divider setting not
> > > correct.
> > >
> > > For non-ideal ratio mode, the clock rate should divide the sample rate
> > > with no remainder, and the quotient should be less than 1024.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

> > > @@ -351,7 +352,9 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair
> > *pair)
> > >       /* We only have output clock for ideal ratio mode */
> > >       clk = asrc_priv->asrck_clk[clk_index[ideal ? OUT : IN]];
> > >
> > > -     div[IN] = clk_get_rate(clk) / inrate;
> > > +     clk_rate = clk_get_rate(clk);
> > 
> > The fsl_asrc.c file has config.inclk being set to INCLK_NONE and this sets the
> > "ideal" in this function to true. So, although we tend to not use ideal ratio
> > setting for p2p cases, yet the input clock is still not physically connected, so
> > we still use output clock for div[IN] calculation?
> 
> For p2p case, it can be ideal or non-ideal.  For non-ideal, we still use
> Output clock for div calculation.
> 
> > 
> > I am thinking something simplier: if we decided not to use ideal ratio for
> > "P2P", instead of adding "bool p2p" with the confusing "ideal" in this
> > function, could we just set config.inclk to the same clock as the output one
> > for "P2P"? By doing so, "P2P" won't go through ideal ratio mode while still
> > having a clock rate from the output clock for div[IN] calculation here.
> 
> Bool p2p is to force output rate to be sample rate, no impact to ideal
> Ratio mode.

I just realized that the function has a bottom part for ideal mode
exclusively -- if we treat p2p as !ideal, those configurations will
be missing. So you're right, should have an extra boolean variable.

> > 
> > > +     rem[IN] = do_div(clk_rate, inrate);
> > > +     div[IN] = (u32)clk_rate;
> > >       if (div[IN] == 0) {
> > 
> > Could we check div[IN] and rem[IN] here? Like:
> >         if (div[IN] == 0 || div[IN] > 1024) {
> >                 pair_err();
> >                 goto out;
> >         }
> > 
> >         if (!ideal && rem[IN]) {
> >                 pair_err();
> >                 goto out;
> >         }
> > 
> > According to your commit log, I think the max-1024 limitation should be
> > applied to all cases, not confined to "!ideal" cases right? And we should
> > add some comments also, indicating it is limited by hardware.
> 
> For ideal mode,  my test result is  the divider not impact the output result.
> Which means it is ok for ideal mode even divider is not correct... 

OK.

> > 
> > >               pair_err("failed to support input sample rate %dHz by
> > asrck_%x\n",
> > >                               inrate, clk_index[ideal ? OUT : IN]); @@
> > > -360,11 +363,20 @@ static int fsl_asrc_config_pair(struct
> > > fsl_asrc_pair *pair)
> > >
> > >       clk = asrc_priv->asrck_clk[clk_index[OUT]];
> > >
> > > -     /* Use fixed output rate for Ideal Ratio mode (INCLK_NONE) */
> > > -     if (ideal)
> > > -             div[OUT] = clk_get_rate(clk) / IDEAL_RATIO_RATE;
> > > -     else
> > > -             div[OUT] = clk_get_rate(clk) / outrate;
> > > +     /*
> > > +      * When P2P mode, output rate should align with the out samplerate.
> > > +      * if set too high output rate, there will be lots of Overload.
> > > +      * When M2M mode, output rate should also need to align with the
> > > + out
> > 
> > For this "should", do you actually mean "M2M could also"? Sorry, I'm just
> > trying to understand everyting here, not intentionally being picky at words.
> > My understanding is that we still keep the ideal ratio setting because
> > "M2M" still uses it.
> 
> We use IDEAL_RATIO_RATE as output rate for m2m mode, it likes a
> Tricky operation, in order to improve the performance. I think
> The correct operation is to use the real output rate, but the performance
> Is bad.  So it is a compromise.

I see.

> > 
> > > +      * samplerate, but M2M must use less time to achieve good
> > performance.
> > > +      */
> > > +     clk_rate = clk_get_rate(clk);
> > > +     if (p2p || !ideal) {
> > > +             rem[OUT] = do_div(clk_rate, outrate);
> > > +             div[OUT] = clk_rate;
> > > +     } else {
> > > +             rem[OUT] = do_div(clk_rate, IDEAL_RATIO_RATE);
> > > +             div[OUT] = clk_rate;
> > > +     }
> > >
> > >       if (div[OUT] == 0) {
> > >               pair_err("failed to support output sample rate %dHz by
> > > asrck_%x\n", @@ -372,6 +384,16 @@ static int fsl_asrc_config_pair(struct
> > fsl_asrc_pair *pair)
> > >               return -EINVAL;
> > >       }
> > >
> > > +     if (!ideal && (div[IN] > 1024 || div[OUT] > 1024 ||
> > > +                    rem[IN] != 0 || rem[OUT] != 0)) {
> > > +     if (!ideal && (div[IN] > 1024 || div[OUT] > 1024 || rem[IN] ||
> > > + rem[OUT] != 0)) {
> > 
> > So for ideal == true, these limitaions are not applied any more?
> > Remember that the "ideal" is true for "p2p == true" cases here.
> 
> No, not applied.  for ideal, the div don't impact the output result
> Even it is not accurate.

I see.

> > 
> > > +             pair_err("The divider can't be used for non ideal mode\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     /* Divider range is [1, 1024] */
> > > +     div[IN] = min_t(u32, 1024, div[IN]);
> > > +     div[OUT] = min_t(u32, 1024, div[OUT]);
> > 
> > Hmm, this looks like we want to allow ideal ratio cases and p2p cases to
> > operate any way, even if the divider wasn't within the range to get the
> > in/out rates from the output clock?
> 
> Yes. We still allow the p2p = true,  ideal = false.  Note that p2p is not
> Equal to ideal.

Got it.

Overall, I feel it's better to have a naming to state the purpose
of using ideal configurations without the IDEAL_RATIO_RATE setup.
	bool use_ideal_rate;
And we can put into the asrc_config structure if there's no major
problem.

So the condition check for the calculation would be:
+	if (ideal && config->use_ideal_rate)
+		rem[OUT] = do_div(clk_rate, IDEAL_RATIO_RATE);
+	else
+		rem[OUT] = do_div(clk_rate, outrate);
+	div[OUT] = clk_rate;

And for that if (!ideal && div[IN]....rem[OUT]), I feel it would
be clear to have them separately, as the existing "div[IN] == 0"
and "div[OUT] == 0" checks, so that we can tell users which side
of the divider is out of range and what the sample rate and clock
rate are.

Thanks
Nicolin
