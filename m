Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AAFC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E5021D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570025955;
	bh=YO5/ci08pbNc+U68W/o9vXyIVvCkSLO3nliD2CjKVFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CMYLUIZkcpLCafcsYNmRjm5UUZYX5UFUXFY1+hXvVUDbKD5IAhR0aHhRrmTdrMqgM
	 GoB3TeUwgW3Lwc1gxsEhxPcZ5AwGQ7z2BnQkp+4Sf7pkeBOBCzoEP9we/jY/xFeugC
	 2WzPvhGqJe424aJVHX8IqwmxTNbATJB91++G6Akk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfJBOTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:19:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32927 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJBOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:19:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id r5so26586502qtd.0;
        Wed, 02 Oct 2019 07:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=kP7vzKS5Q2upGPJNgGMib8DMfY3IAcXtVKuvJsiJTIs=;
        b=DFM+9xRdnR+HNmOVM+UrHsZOHOXMzBKY88h0SXBAe9f3pEArG8o4WfiJIMz3W0v5cP
         AaDl29MyWEc1mIPPEnQS47MpilVyNtNIjLLWvAdJvSbW67mDlxkvoXkJYEmKnNhCBV17
         d9iK6M+G56NvRs6Ix22Qo9S4TobcAObUQb8wYOONb1y93TeN/z42+ItExzoKi0MvCrgR
         bpHH769+ecaPHxKVXOiKYuJzhGo+VisCWBwaWmumVb8kv5rpM7TXb7ZENhFlSua6H7VB
         akReegfTC2Af6EJCWt/9aJwFfTHPIxNnt8AVdNXmiM6IwcL47aNmGFLtzH4JAcJ/tGOt
         hhWw==
X-Gm-Message-State: APjAAAVayxUGsL3TnNTLIAqYEcCuGeYRMaY2fuLbHk7/CeU3IVZSCaWZ
        T0j2GYgdI+fdomdxa9uaBw==
X-Google-Smtp-Source: APXvYqzPfzSmp7xskhCIvKOVtYhxyh8HfoSES/y1fgUMOyF0qc0thkfrFz5NQmijtp/ZM7tIotE0PQ==
X-Received: by 2002:ac8:7b97:: with SMTP id p23mr4209487qtu.292.1570025953392;
        Wed, 02 Oct 2019 07:19:13 -0700 (PDT)
Received: from localhost ([132.205.230.8])
        by smtp.gmail.com with ESMTPSA id h9sm10006638qke.12.2019.10.02.07.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:19:12 -0700 (PDT)
Message-ID: <5d94b1e0.1c69fb81.4e2f9.3e79@mx.google.com>
Date:   Wed, 02 Oct 2019 09:19:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 1/5] dt-bindings: clock: meson8b: add the clock inputs
References: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
 <20190921151223.768842-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190921151223.768842-2-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2019 17:12:19 +0200, Martin Blumenstingl wrote:
> The clock controller on Meson8/Meson8b/Meson8m2 has three (known)
> inputs:
> - "xtal": the main 24MHz crystal
> - "ddr_pll": some of the audio clocks use the output of the DDR PLL as
>   input
> - "clk_32k": an optional clock signal which can be connected to GPIOAO_6
>   (which then has to be switched to the CLK_32K_IN function)
> 
> Add the inputs to the documentation so we can wire up these inputs in a
> follow-up patch.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/clock/amlogic,meson8b-clkc.txt       | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

