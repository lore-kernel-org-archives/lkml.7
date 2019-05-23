Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C561C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79542168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAsZi7nZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbfEWWwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:52:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47084 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfEWWwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:52:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so4036367pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6sNQBO0ShsOiyXm56ZAi0h5L7rJJmlpKkNelQHUJj+w=;
        b=HAsZi7nZ8gveH237kWeKnke3dDxr+y2gwyQ7UKnpPqhx9d5PwmMZdVn7AXJnbNNKxS
         ePDFO1IpN8iZHALaZ59urWJKkwTEjRYeKIbeaa5XlK6YazplFpVh3yQoNM2SreXoytPY
         btxUuPLWLnazqWiEtgybRKS/JgvW7Ksg6tagpdJUc2j9vKOTSJ7wYNlwfPPVjGSV974J
         8KoWA9zxDazLNvw1zkaTwiMaMQcUGxh/ANi8nkvxE5Fa1teN6vQn88J0xnGyo/nrpr4m
         imIzmRVIX8eS7v6OXmI02YsKDallHF64R30gSIuSWrHTWujRe7yWJmNXLOOIOAJsBNSa
         npYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6sNQBO0ShsOiyXm56ZAi0h5L7rJJmlpKkNelQHUJj+w=;
        b=Okf+sbBBZKUqxVOBEb9wEErApIrUoRy0rFtk4fBv7F+BCwgLt1zyAoqGvQgTp9du+/
         RgQKs8P/VzqG3j51vUqB1GE0AMYYzIT7TIgiCap6xm8tR+KOLQS3Nc0CVLBKpyZZjbur
         C9DIL3NvtZ+QSdCeFJJOHyGJ4IrA3Ot0eSex/aU5j9VoQX3KKeSyj+7H7p7+yFtjccnp
         H+ozJGeYkadVpKUvifg1zfDyErZIHEGI2hZOAM8J4wjHsUUEwHIrkzZ0wwo/6URFn/KD
         iA7fb9HyDL8k8v9ejygKqH6Hl2SuEBVDeymf8GKsu5n3UbCIeaD7GNM5SrHruXr3CD71
         QnuA==
X-Gm-Message-State: APjAAAU3IhtK+ZHCdBeLVXXSZVgf3OdwKAtH5hH9eN4IrWRA2IecSOfX
        PvoWEv7EphtSWYyNq6egnZgpG+hNhpBT7g==
X-Google-Smtp-Source: APXvYqyuBQiscdYr7VRVcYBJKBnh5BshxJM8AvZKv6cszmjJhESCIjuXtoiy1ZJAGyWPkAkAtziQ5w==
X-Received: by 2002:a62:2506:: with SMTP id l6mr107019907pfl.250.1558651929550;
        Thu, 23 May 2019 15:52:09 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x17sm341603pgh.47.2019.05.23.15.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 15:52:09 -0700 (PDT)
Date:   Thu, 23 May 2019 15:50:52 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Message-ID: <20190523225052.GA29562@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB6479FF8E1B55E9BE67E7B0ECE3010@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479FF8E1B55E9BE67E7B0ECE3010@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:04:03AM +0000, S.j. Wang wrote:
> > On Thu, May 23, 2019 at 09:53:42AM +0000, S.j. Wang wrote:
> > > > > +     /*
> > > > > +      * Add fifo reset here, because the regcache_sync will
> > > > > +      * write one more data to ETDR.
> > > > > +      * Which will cause channel shift.
> > > >
> > > > Sounds like a bug to me...should fix it first by marking the data
> > > > registers as volatile.
> > > >
> > > The ETDR is a writable register, it is not volatile. Even we change it
> > > to Volatile, I don't think we can't avoid this issue. for the
> > > regcache_sync Just to write this register, it is correct behavior.
> > 
> > Is that so? Quoting the comments of regcache_sync():
> > "* regcache_sync - Sync the register cache with the hardware.
> >  *
> >  * @map: map to configure.
> >  *
> >  * Any registers that should not be synced should be marked as
> >  * volatile."
> > 
> > If regcache_sync() does sync volatile registers too as you said, I don't mind
> > having this FIFO reset WAR for now, though I think this mismatch between
> > the comments and the actual behavior then should get people's attention.
> > 
> > Thank you
> 
> ETDR is not volatile,  if we mark it is volatile, is it correct?

Well, you have a point -- it might not be ideally true, but it sounds
like a correct fix to me according to this comments.

We can wait for Mark's comments or just send a patch to the mail list 
for review.

Thanks you
