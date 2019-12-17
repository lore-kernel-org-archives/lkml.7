Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90316C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CB021739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXp9LRcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLQIBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:01:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34179 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfLQIBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:01:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so10219600wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 00:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RYcPZBxNs0LR8aI9ut6hb3/+3nGM5FU0mpuZVJVKBqM=;
        b=FXp9LRcrDVkA8WcZNt2DGB5je9rP0L5nXs3II0LD3mnz5nxHRMKsTZDw7Rh7CVsHnd
         Trf/CAJzgiDWE9gsqQS8mcfLBVv/grKk5XvYMo1D0ZvTjsCRtgoJMWjYF/he3STC5esP
         vuuF0AhTDWnNwTsVc0tSPOmJcXGvngA4IOnO3g35RrvgMZr4z9J05nYyAngrwSYYUmg7
         Prk/Vzr8zNT27ztxarf9DrfMY7RCTX0H+lZsQ74pe1HPifj6EZlkhjt7lBFTj8cGuHcN
         diJwgVe1gqW8cgZgNi2TQgIyfUNGpCBYiGOHNnJ4EIpvKuN6PdZM5Aawlms+ugwxNBnJ
         2XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RYcPZBxNs0LR8aI9ut6hb3/+3nGM5FU0mpuZVJVKBqM=;
        b=AdVfmcdFbY14wCioDZF0w1MbaxTCcL0nXGaHkNWMAyWTvLnCV5yoDiHLessy5tWoGA
         CFz2eAXDdenfEdieVGeaKS9IWACsxh/cPAToaxgr3Kx5MMU40rxfbW4z1zmF8BkymC5y
         /dqqBI88uekWFqnvlpqsDgZ84DX+lfu551WQyvdzhKuncgznbphvpPprtEA4YZQwEB8E
         mR3uH/Ra/k0vqLTYoM1J4YNxTlNN6Ce9XaHxAL2VqGtL22fBX1CZdHUALOnFfggVV06e
         bMw+I+0uAlUoSIuRVWp1iseETWLE+FtwW5qxmeJWUnkrr/CW3Ligavevrhq93Tvqe/1Z
         skNw==
X-Gm-Message-State: APjAAAVmfIvHPQoRlFZqUstMMeLZySAkSLfSGo2Xo9+JkReGDC5xLcsh
        RuNoq0chd4pujXIIDBYQEf8auQ==
X-Google-Smtp-Source: APXvYqxRCna04c3LCNHy/aOTiZ+ysA7HIsZXfmIuviSjkwuNxXEkaWZmYBaJ5/NmY97Bk79fZC35CA==
X-Received: by 2002:a5d:4749:: with SMTP id o9mr34127834wrs.242.1576569706892;
        Tue, 17 Dec 2019 00:01:46 -0800 (PST)
Received: from dell (h185-20-99-142.host.redstation.co.uk. [185.20.99.142])
        by smtp.gmail.com with ESMTPSA id p26sm2020498wmc.24.2019.12.17.00.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 00:01:46 -0800 (PST)
Date:   Tue, 17 Dec 2019 08:01:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stefan@agner.ch, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v4 4/5] mfd: rn5t618: add more subdevices
Message-ID: <20191217080146.GE18955@dell>
References: <20191211215409.32764-1-andreas@kemnade.info>
 <20191211215409.32764-5-andreas@kemnade.info>
 <20191216153106.GK2369@dell>
 <20191216170000.022a4c31@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216170000.022a4c31@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019, Andreas Kemnade wrote:

> On Mon, 16 Dec 2019 15:31:06 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Wed, 11 Dec 2019, Andreas Kemnade wrote:
> > 
> > > The RC5T619 has a RTC which is missing in the
> > > RN5T618. Add it as subdevice to prepare for their implementation
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > Changes in v3:
> > > - alignment cleanup
> > >  drivers/mfd/rn5t618.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> > > index d78eb29b94a4..18d56a732b20 100644
> > > --- a/drivers/mfd/rn5t618.c
> > > +++ b/drivers/mfd/rn5t618.c
> > > @@ -22,6 +22,12 @@ static const struct mfd_cell rn5t618_cells[] = {
> > >  	{ .name = "rn5t618-wdt" },
> > >  };
> > >  
> > > +static const struct mfd_cell rc5t619_cells[] = {
> > > +	{ .name = "rn5t618-regulator" },
> > > +	{ .name = "rc5t619-rtc" },
> > > +	{ .name = "rn5t618-wdt" },
> > > +};
> > > +
> > >  static bool rn5t618_volatile_reg(struct device *dev, unsigned int reg)
> > >  {
> > >  	switch (reg) {
> > > @@ -173,8 +179,14 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
> > >  		return ret;
> > >  	}
> > >  
> > > -	ret = devm_mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
> > > -				   ARRAY_SIZE(rn5t618_cells), NULL, 0, NULL);
> > > +	if (priv->variant == RC5T619)
> > > +		ret = devm_mfd_add_devices(&i2c->dev, -1, rc5t619_cells,  
> > 
> > Ref: The "-1", please use this as an opportunity to use the defines.
> > 
> > > +					   ARRAY_SIZE(rc5t619_cells),
> > > +					   NULL, 0, NULL);
> > > +	else  
> > 
> > Are you sure it's not possible for 'variant' to be an unsupported
> > device?
> > 
> Well, does it change the behavior for devices other than the rc5t619?
> I do not think so. If the mfd driver is bound to unsupported devices,
> rn5t618_of_match is wrong.

Right, and can you catch that?

> Or do you want separate cell arrays for each of the three variant now to
> ease future extensions?

No need for that, thank you.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
