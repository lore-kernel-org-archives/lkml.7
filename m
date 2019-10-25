Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27EDCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF25206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jA+Rztwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406864AbfJYHTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:19:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43378 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406840AbfJYHTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:19:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id l24so934819pgh.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q/L5barERqVFMTFfN0b6H579EvN6zcwOea9h6lqu9TU=;
        b=jA+RztwlIRbtjSU68kRpA2ZIbp7Z82H7Ep+NCRgSH/XbwFrjiFSWj1sx9tsPmGMg1X
         d2heW0dH4SRFFmnbtO2Z305mH6zxY0MXPE+vCl5Evrv27b1xQpk0EpteXUb0PcQZ1nq9
         TJjCnkyoTVpcoJ/HCPPP/rj1w0DVo0z0i1tDp3oEZkcRKx+o/bWn8JxvU4qk6J5C3UGQ
         Rs4HDa/ok1nDwrD678/T10v5+lfpftkP7glX7J327ie3U67YzwyqDypLc8vapRc0ukQC
         8CqzOiCS5ZsEGGtmaoPKVrCrOgXWzlklX8xqMgA/zORW289Vu1HrGy2VUImfUCrlNG3E
         xqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q/L5barERqVFMTFfN0b6H579EvN6zcwOea9h6lqu9TU=;
        b=KEh8X4G9zU4bOY08Uh0bVIZbJ+URkaYkGqgqj5Squ2emY8qRWZjWcaLCqZ9JyKo0wF
         CxD79VJfrN+JPaDi0YWC1B1ZPOV3Szulo4TzOVcB+rLMIE7msXEChkpF7g+4ZdyD3zMj
         F4/r3rf8k3I8AqmaFkIKApMBC3ZSw+imu5d8YpiR51oowIlib8DKYQM9ttz9gp6uIm23
         dDEkQao8Z3aiTQ9id8KeQPT3v/KnD9d/s9KgAd8hYKlBzC8/qezRYxJbCrY8mQnl5RKE
         yndaaW27zmSIJdjaN78/L6iUjhUKmJkzAmapM4NhDfY4l5Th/+lASJ2pAT3nf7Ey5wfZ
         uFjA==
X-Gm-Message-State: APjAAAXSMqABPBsetZ9lgD71jzbb+Uk422Z9VrHELjKNmt6pNR+jORcm
        Z86r8w6QaRaCrPB8bS/c1HIs
X-Google-Smtp-Source: APXvYqwBRuQAriZLBverj4YOcg0fgwlqULitrorhrbCBVXEZUU2FIFFh8gs5pGu3UcQZ1+URygxT7w==
X-Received: by 2002:a63:e145:: with SMTP id h5mr2507155pgk.447.1571987976406;
        Fri, 25 Oct 2019 00:19:36 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id n72sm1438916pjc.4.2019.10.25.00.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Oct 2019 00:19:35 -0700 (PDT)
Date:   Fri, 25 Oct 2019 12:49:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        darshak.patel@einfochips.com, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, prajose.john@einfochips.com
Subject: Re: [PATCH 1/3] dt-bindings: arm: Add devicetree binding for Thor96
 Board
Message-ID: <20191025071927.GA19873@mani>
References: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
 <20191024144235.3182-2-manivannan.sadhasivam@linaro.org>
 <20191025062659.fyze6zt4jg6uzqxz@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025062659.fyze6zt4jg6uzqxz@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marco,

On Fri, Oct 25, 2019 at 08:26:59AM +0200, Marco Felsch wrote:
> Hi Manivannan,
> 
> On 19-10-24 20:12, Manivannan Sadhasivam wrote:
> > Add devicetree binding for Thor96 Board from Einfochips. This board is
> > one of the 96Boards Consumer Edition platform powered by NXP i.MX8MQ SoC.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 1b4b4e6573b5..8016174d5e49 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -239,6 +239,7 @@ properties:
> >          items:
> >            - enum:
> >                - boundary,imx8mq-nitrogen8m # i.MX8MQ NITROGEN Board
> > +              - einfochips,imx8mq-thor96  # i.MX8MQ Thor96 Board
> 
> Do we need to add a vendor patch too?
> 

Do you mean a patch for adding vendor prefix? If yes, then I have added it
already for AI_ML board and it is in mainline now!

https://elixir.bootlin.com/linux/v5.4-rc2/source/Documentation/devicetree/bindings/vendor-prefixes.yaml#L276

Thanks,
Mani

> Regards,
>   Marco
> 
> >                - fsl,imx8mq-evk            # i.MX8MQ EVK Board
> >                - purism,librem5-devkit     # Purism Librem5 devkit
> >                - solidrun,hummingboard-pulse # SolidRun Hummingboard Pulse
> > -- 
> > 2.17.1
> > 
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
