Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B1DCA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7168820867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD7VplAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393212AbfJYGys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:54:48 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:45218 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733098AbfJYGys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:54:48 -0400
Received: by mail-pf1-f169.google.com with SMTP id x28so909083pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 23:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m+VkYOgB7cCdSZGNDZmPasUQ1M1DmEk9SPAL9l8GP1A=;
        b=MD7VplAMSnE6eBcOxhBncJ1w7gZgL2vajru9wAqudsdqaQdHSjaosigKCexVhSgoKE
         Nq9j/jeyMN+LeTVVmmAoP0z/DFE4hUYz9NCVTZMKqbSqX+i3ZAtgwb7gGHg+p4X7+TEo
         3kiESUbManeemJ3xCExgKIBZWb6+cHq4shtvyoPft8qTN7pMtV8ZWbnQUD2XM4XdY7Rv
         loSwM9UinPzIrmZwAFqKpGadpFiLSvlbq7vDyppqk/Uv5sf04RsliKidoTQAgdRVtUfz
         RAZdpGYb6zsW5Uu31WIZHN9C6A5UeFjipvLod8tVE4H1EvCHExEQKbX315/EAQDHfeGM
         9Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m+VkYOgB7cCdSZGNDZmPasUQ1M1DmEk9SPAL9l8GP1A=;
        b=hhzSnF51MAjkUWxOidFL7X1PqHDwE1Ll5IqjQcb+NGH+udp/n/YgyjZYBvVrOA+85z
         JTovrdvUVxet+pv5TJXXG3urM3gGY8+zBG+9SdsUt2CkqubESly6q23qP5ruYVhfqwT/
         nOhXkpuizdxdjxJQs8T8zgC+nPmNM0XRbDif3UpolASB32ndGggYH7tz9sotY6Ft9ksq
         yq5xKoESi87L0ssDKIGRpb6MNpRh2Fd/zBBGuSe/6BCArGXXm23sWyyWRKmQPXIproOD
         e0mtgcWh2LHIRG28wtPI8gJZZAo4ntScLQcgkIyqv851TDorIHtgCwL2HvIIQmVFTY9i
         +02Q==
X-Gm-Message-State: APjAAAW1DNvESfgPOR7UtNLvLr9yGMn5sxW8Y/mc+N2MqkEhqZTsGYNX
        N9yl/yIB5tJD5KnI5BUu6Go=
X-Google-Smtp-Source: APXvYqwQ2i3psJ0yIsvpXC4E8x2YWCDuJQPZ1N62DtBq1Tv3B55wCjarX0d9MG67laCjyfLsu1WfCA==
X-Received: by 2002:a17:90a:fe04:: with SMTP id ck4mr2048608pjb.90.1571986487460;
        Thu, 24 Oct 2019 23:54:47 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id d14sm1800708pfh.36.2019.10.24.23.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 23:54:47 -0700 (PDT)
Date:   Thu, 24 Oct 2019 23:54:34 -0700
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
Message-ID: <20191025065433.GA4632@Asurada>
References: <VE1PR04MB6479AC63FFE5D57B4E2C33D2E3650@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479AC63FFE5D57B4E2C33D2E3650@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 05:33:17AM +0000, S.j. Wang wrote:
> > > > > +             pair_err("The divider can't be used for non ideal mode\n");
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > > +     /* Divider range is [1, 1024] */
> > > > > +     div[IN] = min_t(u32, 1024, div[IN]);
> > > > > +     div[OUT] = min_t(u32, 1024, div[OUT]);
> > > >
> > > > Hmm, this looks like we want to allow ideal ratio cases and p2p
> > > > cases to operate any way, even if the divider wasn't within the
> > > > range to get the in/out rates from the output clock?
> > >
> > > Yes. We still allow the p2p = true,  ideal = false.  Note that p2p is
> > > not Equal to ideal.
> > 
> > Got it.
> > 
> > Overall, I feel it's better to have a naming to state the purpose of using
> > ideal configurations without the IDEAL_RATIO_RATE setup.
> >         bool use_ideal_rate;
> > And we can put into the asrc_config structure if there's no major problem.
> > 
> 
> Asrc_config may exposed to user, I don't think user need to care about
> The using of ideal rate or not. 

Given that M2M could use output rate instead of ideal ratio rate
as well, it could be a configuration from my point of view. Yet,
we may just add it as a function parameter like you did, for now
to ease the situation, until we have such a need someday.

> 
> > So the condition check for the calculation would be:
> > +       if (ideal && config->use_ideal_rate)
> > +               rem[OUT] = do_div(clk_rate, IDEAL_RATIO_RATE);
> > +       else
> > +               rem[OUT] = do_div(clk_rate, outrate);
> > +       div[OUT] = clk_rate;
> > 
> > And for that if (!ideal && div[IN]....rem[OUT]), I feel it would be clear to
> > have them separately, as the existing "div[IN] == 0"
> > and "div[OUT] == 0" checks, so that we can tell users which side of the
> > divider is out of range and what the sample rate and clock rate are.
> > 
> Do you mean need to combine this judgement with "div[IN] == 0"
> Or "div[OUT] == 0"?

Not necessarily. Could put in the else path so its error message
would be more ideal ratio configuration specific.

Thanks
