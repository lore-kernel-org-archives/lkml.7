Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D33C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C93E2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/9FVwqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfILXzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 19:55:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39765 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfILXzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 19:55:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id i1so8100509pfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 16:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MKg9N5Ak/mqK4Z77OiWZOmXzQbsQdtgDZRsUGqX7iZY=;
        b=N/9FVwqw2HM4pjK9/KOapQ6CrsHfOWXlQZf5cbvJspNfr5YemTKwvog5nEJquW6vNB
         dhb8QaktoUZb+TX2cX2BqUb5r+E1dvNebQMcdWPh/J4FiNdPstJmUUdAZAD1kJgmW/Af
         08haBzhalAZIsIPN29D7lBbgQjrl1RU3GRGrgJdxIgO8NdK32r7OiRK33X1bLBEwmewl
         /p4DtShHDsmPP7cb7nbP08iwxYdtD9Nblw29H3yAzefARKSyVftxzo39jEpvRvonGGXr
         bQ3TDRfX6z+Ezlf2vy3/BzFYT04GPSrPvMtEkR8C4ti0MnH3JYOzQyBeGGZ9FcbwOba6
         REbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MKg9N5Ak/mqK4Z77OiWZOmXzQbsQdtgDZRsUGqX7iZY=;
        b=kxMGLIe2UdHcs5QDn70R2mYXVA5rMhinmNLz4gCnLW/nWhZzK+tTB2Oj3umbS/dggP
         5/VbhiW5XIXsygiRabeIC/BjFkXK/cDm3IHkxS7EX125YVX+8nBnYsgpyRQXd5HuJWgu
         kEwkVuGr5cDwsR6kE4wmt+Oku2hx/9CwaO/Oji4/nG+CDHXO9arhHjrANVllhGbNt4KG
         MPvqs0YF4OZrSbN0wUwSKApq41wu78EML9prHxCD9QGFtVYysATpDYmpPyY5sfhgaM+Z
         HTakGK8mFEK3FpU5Fl+Q4zJIK5jXL9ZDvL7QKAiNT/rO5iGVmZSEs5c7d+kqK7ncO52c
         0c/A==
X-Gm-Message-State: APjAAAUYs2cP03+5erJ2Tw9Kq+QLA+ofJSjLp9gsDZ6pOEnnjWrVJOmn
        hKN1agU6HwUqzKlzaKJeJrY=
X-Google-Smtp-Source: APXvYqwGccc6+qJ6fu7lfAAauwtZvtPeLkhiMe9OxJMG2Jg+hfl9NJGSzizq4OGkb7Sp0XJb4FrbIQ==
X-Received: by 2002:aa7:8d10:: with SMTP id j16mr5842105pfe.109.1568332545774;
        Thu, 12 Sep 2019 16:55:45 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 1sm24596429pff.39.2019.09.12.16.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 16:55:45 -0700 (PDT)
Date:   Thu, 12 Sep 2019 16:55:24 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_sai: Implement set_bclk_ratio
Message-ID: <20190912235523.GG24937@Asurada-Nvidia.nvidia.com>
References: <20190830215910.31590-1-daniel.baluta@nxp.com>
 <20190906012938.GB17926@Asurada-Nvidia.nvidia.com>
 <20190911110017.GA2036@sirena.org.uk>
 <CAEnQRZAid2xXu+6PxWDCBNDwS6c8DfNXEcNqseDPAsVJ7kEHeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZAid2xXu+6PxWDCBNDwS6c8DfNXEcNqseDPAsVJ7kEHeg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 04:06:41PM +0300, Daniel Baluta wrote:
> On Wed, Sep 11, 2019 at 2:01 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Thu, Sep 05, 2019 at 06:29:39PM -0700, Nicolin Chen wrote:
> > > On Sat, Aug 31, 2019 at 12:59:10AM +0300, Daniel Baluta wrote:
> >
> > > > This is to allow machine drivers to set a certain bitclk rate
> > > > which might not be exactly rate * frame size.
> >
> > > Just a quick thought of mine: slot_width and slots could be
> > > set via set_dai_tdm_slot() actually, while set_bclk_ratio()
> > > would override that one with your change. I'm not sure which
> > > one could be more important...so would you mind elaborating
> > > your use case?
> >
> > The reason we have both operations is partly that some hardware
> > can configure the ratio but not do TDM and partly that setting
> > TDM slots forces us to configure the slot size depending on the
> > current stream configuration while just setting the ratio means
> > we can just fix the configuration once.  I'd say it's just a user
> > error to try to do both simultaneously.
> 
> Yes, exactly. We wanted to have a better control of bclk freq.
> Sorry for the late answer, I'm traveling.

I see. Thanks for the explain. Just acked.
