Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA53C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EEE2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="quDyGfVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfHMHSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:18:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40554 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfHMHSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:18:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so494646wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E5kLOsNd1JoC/tKYPvjF5AM6FnpgT5H8QJRpzp0JJDo=;
        b=quDyGfVg17WZgsvg84lAvoSBSSAaK7/qCT9HoIg0NOW/nqt+fq7VXq5V+Ll8BTn49W
         +W5HfbUwZnv4kN/XOFhFYLlvvG/+iio5q31Dsq7fbTXUXwCGQFKMpbuERXq/krJT3PAs
         IKq/pfChBU0Bah64rtHB4i1kQ0cINrKriwIaWiCbO+JpFFlGC/KnXfisx9biSstSHQR1
         lrlQbioJbsGwPwXX2yrL4MD0flN4zMkmgLLKm9Y1+Tf5ALrAwaCbgm8+Gf3E01I6OdEr
         XSnGxirb4N7rdIN2CVsLkFH79FpFcgM9pJkPPwnb7pNLSCs8l8cuk83YSIrH5bdasYue
         SDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E5kLOsNd1JoC/tKYPvjF5AM6FnpgT5H8QJRpzp0JJDo=;
        b=rDyCzenbU8b70YxWHRfGSYg4PiX4Irxjhxl01vfDgBZt1FYL5YjKDZs/5YvbhnBkjc
         0O8Y08T+qnaiVpbe2XopL0Vrvyed6eXiHfkquwW8RHPpc+yxL0qJbztCrLNp9gn9751m
         pRtXBn0Lh+8AS6xjOT8KP+T7nN0DbPgE50e/uJsL2Riklv/2ueh3pvW514xflz70+mIz
         wiKVqTxhUV7m/WDPGA2nYWUXkQrfdhPc8NsqQiszwihBysT8gjdgbM0jeWBMbl+4JUGY
         CIbjWcjqJ62dakPcaE9EABXNOptPo7CYRWnfkHnnvojvUUv3XcVaPomUchPEHO58lj3A
         gRbQ==
X-Gm-Message-State: APjAAAXckq5D9nw8Y0G+EiGkl2mbDSnUo4xKNcMV+1EzFqrJTutE091i
        KZH26+bum8GeGrTFBqxXaSCFAQ==
X-Google-Smtp-Source: APXvYqxGG3JbfgborY+YIpwmjK4Y2TbKpsdVmQdDEsDRXsBTsyOxNr+gLpuglnv0VYJ/MYFIWlB5/g==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr1344165wmf.115.1565680696953;
        Tue, 13 Aug 2019 00:18:16 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id r11sm170287114wre.14.2019.08.13.00.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 00:18:15 -0700 (PDT)
Date:   Tue, 13 Aug 2019 08:18:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] mfd: madera: Add support for requesting the supply
 clocks
Message-ID: <20190813071814.GY26727@dell>
References: <20190806151321.31137-1-ckeepax@opensource.cirrus.com>
 <20190806151321.31137-2-ckeepax@opensource.cirrus.com>
 <20190812103853.GM26727@dell>
 <20190812160937.GM54126@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190812160937.GM54126@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Charles Keepax wrote:

> On Mon, Aug 12, 2019 at 11:38:53AM +0100, Lee Jones wrote:
> > On Tue, 06 Aug 2019, Charles Keepax wrote:
> > 
> > > Add the ability to get the clock for each clock input pin of the chip
> > > and enable MCLK2 since that is expected to be a permanently enabled
> > > 32kHz clock.
> > > 
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >  int madera_dev_init(struct madera *madera)
> > >  {
> > > +	static const char * const mclk_name[] = { "mclk1", "mclk2", "mclk3" };
> > >  	struct device *dev = madera->dev;
> > >  	unsigned int hwid;
> > >  	int (*patch_fn)(struct madera *) = NULL;
> > > @@ -450,6 +451,17 @@ int madera_dev_init(struct madera *madera)
> > >  		       sizeof(madera->pdata));
> > >  	}
> > >  
> > > +	BUILD_BUG_ON(ARRAY_SIZE(madera->mclk) != ARRAY_SIZE(mclk_name));
> > 
> > Not sure how this could happen.  Surely we don't need it.
> > 
> 
> mclk_name is defined locally in this function and the mclk array in
> include/linux/mfd/madera/core.h. This is to guard against one of
> them being updated but not the other. It is by no means essential
> but it feels like a good trade off given there is really limited
> downside.

It's fine in general I guess.  How likely would it be for anyone to
update either of the definitions?  Can there be more/less clocks on a
supported platform?

> > > +	for (i = 0; i < ARRAY_SIZE(madera->mclk); i++) {
> > > +		madera->mclk[i] = devm_clk_get_optional(madera->dev,
> > > +							mclk_name[i]);
> > > +		if (IS_ERR(madera->mclk[i])) {
> > > +			dev_warn(madera->dev, "Failed to get %s: %ld\n",
> > > +				 mclk_name[i], PTR_ERR(madera->mclk[i]));
> > 
> > Do we even want to warn on the non-acquisition of an optional clock?
> > 
> > Especially with a message that looks like something actually failed.
> > 
> 
> devm_clk_get_optional will return NULL if the clock was not
> specified, so this is silent in that case. A warning in the case
> something actually went wrong seems reasonable even if the clock
> is optional as the user tried to do something and it didn't
> behave as they intended.

If something actually went wrong, then doesn't then become and error
and should be reported (returned)?

> > > +			madera->mclk[i] = NULL;
> > > +		}
> > > +	}
> > > +
> > >  	ret = madera_get_reset_gpio(madera);
> > >  	if (ret)
> > >  		return ret;
> > > @@ -660,13 +672,19 @@ int madera_dev_init(struct madera *madera)
> > >  	}
> > >  
> > >  	/* Init 32k clock sourced from MCLK2 */
> > > +	ret = clk_prepare_enable(madera->mclk[MADERA_MCLK2]);
> > > +	if (ret != 0) {
> > > +		dev_err(madera->dev, "Failed to enable 32k clock: %d\n", ret);
> > > +		goto err_reset;
> > > +	}
> > 
> > What happened to this being optional?
> > 
> 
> The device needs the clock but specifying it through DT is
> optional (the clock framework functions are no-ops and return
> success if the clock pointer is NULL). Normally the 32kHz
> clock is always on, and more importantly no existing users of
> the driver will be specifying one.
> 
> We could remove the optional status for MCLK2, but it could break
> existing users who don't yet specify the clock until they update
> their DT and it will complicate the code as the other clocks are
> definitely optional, so MCLK2 will need special handling.

I'd prefer the code to reflect the actual situation.  If the clock is
not optional it doesn't sound correct to specify it as such.  Maybe as
an intermediary step we attempt to obtain it, but ignore missing
clocks (with a message and comment) if it is not yet specified.  We
can look to change the behaviour once users have had the chance to
update their DTs.

> > >  	ret = regmap_update_bits(madera->regmap,
> > >  			MADERA_CLOCK_32K_1,
> > >  			MADERA_CLK_32K_ENA_MASK | MADERA_CLK_32K_SRC_MASK,
> > >  			MADERA_CLK_32K_ENA | MADERA_32KZ_MCLK2);
> > >  	if (ret) {
> > >  		dev_err(madera->dev, "Failed to init 32k clock: %d\n", ret);
> > > -		goto err_reset;
> > > +		goto err_clock;
> > >  	}
> > >  
> > >  	pm_runtime_set_active(madera->dev);
> > > @@ -687,6 +705,8 @@ int madera_dev_init(struct madera *madera)
> > >  
> > >  err_pm_runtime:
> > >  	pm_runtime_disable(madera->dev);
> > > +err_clock:
> > > +	clk_disable_unprepare(madera->mclk[MADERA_MCLK2]);
> > 
> > Where are the other clocks consumed?
> 
> Other clocks will be consumed by the ASoC part of the driver for
> clocking the audio functionality and running the FLLs. I haven't
> sent those patches yet, but was planning on doing so once this
> was merged.

Okay.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
