Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECD7C47E49
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE35217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572979747;
	bh=sBXW7Y3XWS5oCMwqXlYFhhF/4022KiBmqq6Jnn0h16s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YwcxrdY86itUdSEaOi5h0pexYTjLO87pRJmxLDPMBixVtIXSS/c54PfVvPhcMzMso
	 3FodKI16mnLipAS0MQbWEq89nKDrCSDLskLOdV6+UQ8v9EQiTbJY1PRBU/VPyYo5gv
	 ZGtLa8NqUDbsG4F61k4XP62ttc5wRw8foyvWckGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390732AbfKEStH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:49:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34198 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389861AbfKEStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:49:06 -0500
Received: by mail-oi1-f194.google.com with SMTP id l202so18522730oig.1;
        Tue, 05 Nov 2019 10:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qj5LiYO9Gp8VVa5aloZ7icPxyBMoZMvJD6YekkOcDko=;
        b=DZh4DBB6PGYD9EHe8SNxx49+3hErp897GlDbAOarx4jIEVk3pbY4yFS47UNf4UkZOU
         8pwl4bDqk72chY5FoevbkCSSZmZFIyWsiO8okHJ9z5mpQibVynwYzLFzhWF5bq5uzbtb
         pRFsUb1IMVeArStTGYqSFoCzVgMoH/lPwhjE+vAsv5MjHtaKba2no6mkSGn4THxHPHgj
         gaxC6LGbgJUAL2afyeB6gUB/yH99DIji7oFW5yry2ZKP7d0Y7E60BNW2SiidNvccSxSs
         05vS1e+h3aKyUMUJ7fjyK+oRu+AjgzW+OqMCPiypwwip7D+r+hY+GQPRyeUUXsi+sTYq
         16bg==
X-Gm-Message-State: APjAAAWZMzHiLH+kqZc2XN9E5D/zea4QUiIp+hLhMRHECF32OR5JXnNb
        MI7sIIfx/Kz/oEq+CFboj42HXvY=
X-Google-Smtp-Source: APXvYqyrkBUlvV4cInkJ0w/GC7dlp4bZRcgeBsiVsjLD/Uy3nlwd90V6BQaJ97S30Z3HKKwFfh/7vw==
X-Received: by 2002:aca:a842:: with SMTP id r63mr394336oie.118.1572979745545;
        Tue, 05 Nov 2019 10:49:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u18sm2530972otq.31.2019.11.05.10.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 10:49:04 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:49:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 08/11] dt-bindings: pinctrl: qcom-wcd934x: Add
 bindings for gpio
Message-ID: <20191105184903.GA4709@bogus>
References: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
 <20191029112700.14548-9-srinivas.kandagatla@linaro.org>
 <CACRpkdYc-3Nk7VGj8mAjaM4C0dc_X7ZOK0cptW2Sr+kKwvyFVg@mail.gmail.com>
 <4f0e22ab-6aa1-2ed1-a85b-fb66531e0b2a@linaro.org>
 <CACRpkda2CdbPe7jsomZSxdJ1wE65OmNYDsZNj1OmfzdvG4kWng@mail.gmail.com>
 <502c64dd-a249-bb2c-7bc5-8c66fa66be35@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <502c64dd-a249-bb2c-7bc5-8c66fa66be35@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 01:27:45PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 05/11/2019 13:25, Linus Walleij wrote:
> > On Mon, Nov 4, 2019 at 10:35 AM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org>  wrote:
> > 
> > > This controller just has Output enable bits, No pin control properties.
> > > 
> > > As you suggested I can move this to drivers/gpio in next version.
> > OK perfect, thanks!
> > 
> > NB: this probably also affects the compatible-string which contains
> > "pinctrl*" right?
> Yes, I will suffix it with "-gpio" instead.

Not a discussion we should be having because you should name this after 
what's in the chip documentation not the OS subsystem it happens to land 
in.

Rob
