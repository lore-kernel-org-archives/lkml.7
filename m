Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E144FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54B92087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR3hULzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfCNLNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:13:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38575 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfCNLNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:13:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id e10so343517edy.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RMOoVDoRQlI7L1h8FJKw79xGY87vh7SJpA5gZVDztl8=;
        b=nR3hULzWAMRF76UE7NTs3N7TFDK8OnWvssFtF05/Jad3PZRuWqF00J0bkm7XVSiFLd
         ll6y6O3onU9p3Uk/QpwFbtA5jPbU5dMdj9n0tsvHcW+Cd+vo2Dt7mqqfXiFk368jreWU
         wnr+k+LHNCtOTwGviMNvoCJO4qDq2iZaL6HVjkVnHuT32G+gBjA/hTGkDVVE/xPbakMn
         RRXKLxZS28DRELhJaC36uSi4Fb/vDqpCTT2/CRpm/b2jSkD9CQV3OMFo+cpSeB/tVL8c
         OaH+vSNWTiczYon1JkOIusJ1cinhRWoEcjx6/BoRO9B7atO2PsrFII4wrQduZSK37liY
         0G4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RMOoVDoRQlI7L1h8FJKw79xGY87vh7SJpA5gZVDztl8=;
        b=loCvY2R4fxfKLP86Ka4vvpIPB2kSZG0U+yoBwPmNSHBxcY2tJv1uWJwfOiU3fX2F6W
         ilD3IsugYcKz6AH7Iuk2kxQLL/K+eVxEnPgXnJjmxTkBCfh3V1yNdeISRA0Tw0x6PhNj
         ZwPZXyCm1JFLjrVQZPW/1IzX1gxaINmsEy3/2D0XhjH0oDMCZuFWQDFXXraejdKezyMZ
         KVDCpuU1fD/1r7bJHmHtTDjCQ1Iik0MQqihhSj4hns8eCCMCQz/ZT8TZdVK3+GoI5ZPC
         zYtSSkeTDQiNu4ZnRnmTrzyv9n9h73ip+OgJytBgZ/qOGShHwkRh8rDroOBMFgLqjHkn
         Nb6A==
X-Gm-Message-State: APjAAAUuB+coUJtkw6s03n6Ou84O6ERywxov1hT1WpRqxb+kcJ6s7oXN
        V/GahdhUx2VeW4YRvFRaWlU=
X-Google-Smtp-Source: APXvYqznLSfFyJ9VP2fOr/yfSewmiVBe7yYX393hW8fVStwW4PuG7wCcuoq0xWL2cv9Tt1PHYrnDUg==
X-Received: by 2002:a17:906:54d:: with SMTP id k13mr2511351eja.207.1552561997422;
        Thu, 14 Mar 2019 04:13:17 -0700 (PDT)
Received: from google.com ([2620:0:104b:12:374e:3aa9:8052:60b8])
        by smtp.gmail.com with ESMTPSA id f41sm1113622eda.77.2019.03.14.04.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 04:13:16 -0700 (PDT)
Date:   Thu, 14 Mar 2019 12:13:15 +0100
From:   Armando Miraglia <arma2ff0@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     neil@brown.name, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, sankalpnegi2310@gmail.com,
        matthias.bgg@gmail.com, sr@denx.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in
 spi-mt7621.c
Message-ID: <20190314111313.GB8034@google.com>
References: <20190313122403.248873-1-armax@google.com>
 <20190313123454.GB2202@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313123454.GB2202@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My answers are in-line below. BTW bare with me as this is my attempt to get my
feet wet in how to contribute to the linux kernel for my own pleasure and
interest :)

On Wed, Mar 13, 2019 at 03:34:54PM +0300, Dan Carpenter wrote:
> On Wed, Mar 13, 2019 at 01:24:04PM +0100, Armando Miraglia wrote:
> > Running Lindent on the mt7621-spi.c file in drivers/staging I noticed that the
> > file contained style issues. This change attempts to address such style
> > problems.
> > 
> 
> Don't run lindent.  I think checkpatch.pl has a --fix option that might
> be better, but once the code is merged then our standard become much
> higher for follow up patches.
> 
> > Signed-off-by: Armando Miraglia <armax@google.com>
> > ---
> > NOTE: resend this patch to include all mainteners listed by get_mantainers.pl.
> >  drivers/staging/mt7621-spi/spi-mt7621.c | 27 +++++++++++++------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
> > index b509f9fe3346..03d53845f8c5 100644
> > --- a/drivers/staging/mt7621-spi/spi-mt7621.c
> > +++ b/drivers/staging/mt7621-spi/spi-mt7621.c
> > @@ -52,14 +52,14 @@
> >  #define MT7621_LSB_FIRST	BIT(3)
> >  
> >  struct mt7621_spi {
> > -	struct spi_master	*master;
> > -	void __iomem		*base;
> > -	unsigned int		sys_freq;
> > -	unsigned int		speed;
> > -	struct clk		*clk;
> > -	int			pending_write;
> > -
> > -	struct mt7621_spi_ops	*ops;
> > +	struct spi_master *master;
> > +	void __iomem *base;
> > +	unsigned int sys_freq;
> > +	unsigned int speed;
> > +	struct clk *clk;
> > +	int pending_write;
> > +
> > +	struct mt7621_spi_ops *ops;
> 
> The original is fine.  I don't encourage people to do fancy indenting
> with their local variable declarations inside functions but for a struct
> the declarations aren't going to change a lot so people can get fancy
> if they want.
> 
Is there an explicit intent to deprecate Lindent in favor of checkpatch.pl
--fix? If one would like to contribute to fixing the tooling for linting which
of the two would be the right target for such an effort?

> The problem with a local is if you need to add a new variable then you
> have to re-indent a bunch of unrelated lines or have one out of
> alignment line.  Most people know this intuitively so they don't get
> fancy.
> 
> >  };
> >  
> >  static inline struct mt7621_spi *spidev_to_mt7621_spi(struct spi_device *spi)
> > @@ -303,7 +303,7 @@ static int mt7621_spi_setup(struct spi_device *spi)
> >  	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
> >  
> >  	if ((spi->max_speed_hz == 0) ||
> > -		(spi->max_speed_hz > (rs->sys_freq / 2)))
> > +	    (spi->max_speed_hz > (rs->sys_freq / 2)))
> 
> Yeah.  Lindent is correct here.

Funny enough, this is something I adjusted manually :)

> >  		spi->max_speed_hz = (rs->sys_freq / 2);
> >  
> >  	if (spi->max_speed_hz < (rs->sys_freq / 4097)) {
> > @@ -316,9 +316,10 @@ static int mt7621_spi_setup(struct spi_device *spi)
> >  }
> >  
> >  static const struct of_device_id mt7621_spi_match[] = {
> > -	{ .compatible = "ralink,mt7621-spi" },
> > +	{.compatible = "ralink,mt7621-spi"},
> 
> The original was better.
> 
> >  	{},
> >  };
> > +
> >  MODULE_DEVICE_TABLE(of, mt7621_spi_match);
> 
> No need for a blank.  These are closely related.

Ack.

> >  
> >  static int mt7621_spi_probe(struct platform_device *pdev)
> > @@ -408,9 +409,9 @@ MODULE_ALIAS("platform:" DRIVER_NAME);
> >  
> >  static struct platform_driver mt7621_spi_driver = {
> >  	.driver = {
> > -		.name = DRIVER_NAME,
> > -		.of_match_table = mt7621_spi_match,
> > -	},
> > +		   .name = DRIVER_NAME,
> > +		   .of_match_table = mt7621_spi_match,
> > +		   },
> 
> The new indenting is very wrong.

Ack. In fact, I was thinking this could be one target to fix the logic in
Lindent to do this appropriately.

I have a process question here: to post a change for the only accepted change I
have in this patch should I send out a new patch?

Thanks for the help and the review!
Cheers,
A.
