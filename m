Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14143C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B7C20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551383260;
	bh=fvbKvB9dpvLtQwPPibVB73QLTFflU1juHCDsoYXUn3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gIDb6hRPd0QukiZ3wTmanhr7auArattiyxR4rxdLs25PVyb04w4dxRoA9IdcLe6RJ
	 K1LhoamUqwjPDTUcpAdOH7fvQiiA8Df16E4sV3O+qsBTwPtBrzGnWWZK2h5UfwISf6
	 EZpVcPy7STEgjv3e3fR7xsjqTFKdDVnoYadjdhQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbfB1Trj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:47:39 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37485 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfB1Trj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:47:39 -0500
Received: by mail-oi1-f193.google.com with SMTP id w66so17507204oia.4;
        Thu, 28 Feb 2019 11:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4zLpkg9lasy0oknFW0BAb173RlRaDWUARDEXV2KYlVQ=;
        b=o7zRIWV3FhGdxXJUerpGpGuNMuQQkk+cbUfZATCfk2upseiL5K4W7hV10mNdjx1nyG
         ZFQN6QwgmG/6CFHxWIj1vSDEWkznOxvbOtU1yGx7h3JCHQmFo9tlYFIevQMgwMNVddzn
         aUrJc5su1FMOFph4P28Rcsw2NcTSndQVwoz33t7I7hfk8tIzefT+buoPYBbmjp+EdxSB
         5NRz2NhNLRSnuERQsIppqI+P6SP3QGCSRQsDRla+T/NzkoojD1Tm9HLcVWIGFZO7MoEQ
         JGGPnezuDTnMzGq6Y8p4B2xw+3rxj3e9LBQiLGwF8g7huqzYOJ55fLiknt+rRG/3clBG
         K9jw==
X-Gm-Message-State: APjAAAVJXpLD/xNcdbG/nmu1qW4ZUnh3iPiuplgOmBfu/GhvbtIJ+l5e
        fdPx3eWn2xk6q1VQ76vKAg==
X-Google-Smtp-Source: AHgI3IZcVaVIt3JIXFrJEaqwgrZfby2Bq9Ok7clcX8jSWYhPXacngMqyeXKcxOKyylxGRBhN6jT2vw==
X-Received: by 2002:aca:fc09:: with SMTP id a9mr874570oii.106.1551383258425;
        Thu, 28 Feb 2019 11:47:38 -0800 (PST)
Received: from localhost ([2607:fb90:20de:307f:59ce:35b2:628:2365])
        by smtp.gmail.com with ESMTPSA id a15sm7951821otq.35.2019.02.28.11.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:47:37 -0800 (PST)
Date:   Thu, 28 Feb 2019 13:47:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH 7/8] dt-bindings: iio/counter: ftm-quaddec: add
 poll-interval parameter
Message-ID: <20190228194736.GA6079@bogus>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-7-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218140321.19166-7-patrick.havelange@essensium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 15:03:20 +0100, Patrick Havelange wrote:
> New optional parameter supported by updated driver.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> ---
>  .../devicetree/bindings/iio/counter/ftm-quaddec.txt       | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
