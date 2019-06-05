Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F52C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB596206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3Mo45sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFESpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 14:45:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45236 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFESpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 14:45:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so5804934wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K8N46fWUOEG4OnxcmFaSCvtXW9QMjpx422Fubch/fAg=;
        b=x3Mo45shcQTOwBujY640GJsEgNV/UCdhU4pANEsUY8cAQGdrstT0p+LC/kc4nx3Gqa
         h6dTNWZYqmjnRHTNAFxS7s2wy0101bZt5331rkqrzK4M/v4NrFHNr9tdUycYDrwI15Tn
         mkxan1b0Z/ycBpMSzmoOVG7exjqE0Pcy7K+OHrWNP8/x4GbFg+bFK/22y54KDm+QQZih
         X1ZmBPiRTU0T7emkhJ1r2tu23BJUOdtuLTWQYF53ogsD0WQxmPMQhX+hCdg5zShT4g0s
         gaAOvQ0ZXUw9Y0lrz87SJylNnzf/uoSweBBnFnbYRpSrH9oRsnc1MEs7X7X4J/FYYgA+
         vTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K8N46fWUOEG4OnxcmFaSCvtXW9QMjpx422Fubch/fAg=;
        b=azCx6JRnN5vsdP2/5+e9bcx6J7T5xzIOy/j/uyP91G73TewHDb2a6alPmRLZ1/18q2
         +mQhsXjUBqD8Y9qg3a3fzZph7X/GkCEUy3D/MbRpojS9KyWgSKC8miuAblxPYV1EK5XG
         zHHFyB6Br1YwEr9Foq/2JPHfjEZeHh7JMMELgebQlzqEaF5TlXBdXVTkTlhMDuR9kM+f
         rT1hoyzo3dzQIymGRhZFZcwHli20YY7fXe9K3JNJu/XqL4omiGPZ9E+z3fJZlY6WQVJB
         6y2btpZuIEujzVTGik2TjOgaC/9Ok+oqEyVPMeMWJvvNUTAKwmMHQgu52Wns1ShsVeIk
         tkww==
X-Gm-Message-State: APjAAAUOrEXFtH1uaAMCusMOif9Ha9o5p/0CHjg7LVIGkPNWaBNuVb+3
        GNZ9GKk1eVu7slDU9gSVcZblqg==
X-Google-Smtp-Source: APXvYqxcTA0YT6+OKwa2qZovVlIfuQzONXqXp82SphP4xaCsrSm6az072QmNvTDfPW2x7VRN1zTFtw==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr12840892wrv.164.1559760308262;
        Wed, 05 Jun 2019 11:45:08 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id h1sm3722812wrt.20.2019.06.05.11.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 11:45:07 -0700 (PDT)
Date:   Wed, 5 Jun 2019 19:45:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Hancock <hancock@sedsystems.ca>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: core: Support multiple OF child devices of the
 same type
Message-ID: <20190605184505.GT4797@dell>
References: <1559687743-31879-1-git-send-email-hancock@sedsystems.ca>
 <1559687743-31879-2-git-send-email-hancock@sedsystems.ca>
 <20190605063108.GF4797@dell>
 <7561b2af-52b4-af78-f854-00ba0b86c822@sedsystems.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7561b2af-52b4-af78-f854-00ba0b86c822@sedsystems.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2019, Robert Hancock wrote:

> On 2019-06-05 12:31 a.m., Lee Jones wrote:
> > On Tue, 04 Jun 2019, Robert Hancock wrote:
> > 
> >> Previously the MFD core supported assigning OF nodes to created MFD
> >> devices, but relied solely on matching the of_compatible string. This
> >> would result in devices being potentially assigned the wrong node if
> >> there are multiple devices with the same compatible string within a
> >> multifunction device.
> >>
> >> Add support for matching the full name of the node in the MFD cell
> >> definition, so that we can match against a specific instance of a
> >> device. If this is not specified, we match just based on the
> >> compatible string, as before.
> >>
> >> Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
> >> ---
> >>  drivers/mfd/mfd-core.c   | 5 ++++-
> >>  include/linux/mfd/core.h | 3 +++
> >>  2 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> >> index 1ade4c8..74bc895 100644
> >> --- a/drivers/mfd/mfd-core.c
> >> +++ b/drivers/mfd/mfd-core.c
> >> @@ -177,7 +177,10 @@ static int mfd_add_device(struct device *parent, int id,
> >>  
> >>  	if (parent->of_node && cell->of_compatible) {
> >>  		for_each_child_of_node(parent->of_node, np) {
> >> -			if (of_device_is_compatible(np, cell->of_compatible)) {
> >> +			if (of_device_is_compatible(np, cell->of_compatible) &&
> >> +			    (!cell->of_full_name ||
> >> +			     !strcmp(cell->of_full_name,
> >> +				     of_node_full_name(np)))) {
> >>  				pdev->dev.of_node = np;
> >>  				break;
> > 
> > That is some ugly, squashed up code.
> > 
> > If we end up accepting this, I suggest flattening this out a bit.
> > 
> > ... but we'll cross that bridge when we come to it.
> 
> Yes, that if statement could be broken up to make it more readable. Will
> fix in a next version assuming the concept is acceptable.
> 
> > 
> >> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> >> index 99c0395..470f6cb 100644
> >> --- a/include/linux/mfd/core.h
> >> +++ b/include/linux/mfd/core.h
> >> @@ -55,6 +55,9 @@ struct mfd_cell {
> >>  	 */
> >>  	const char		*of_compatible;
> >>  
> >> +	/* Optionally match against a specific device of a given type */
> >> +	const char		*of_full_name;
> >> +
> > 
> > Can you give me an example for when this might be useful?
> 
> This is an example of some device tree entries for our MFD device:
> 
>             axi_iic_0: i2c@c0000 {
>                 compatible = "xlnx,xps-iic-2.00.a";
>                 clocks = <&axi_clk>;
>                 clock-frequency = <100000>;
>                 interrupts = <7>;
>                 #size-cells = <0>;
>                 #address-cells = <1>;
>             };
> 
>             axi_iic_1: i2c@d0000 {
>                 compatible = "xlnx,xps-iic-2.00.a";
>                 clocks = <&axi_clk>;
>                 clock-frequency = <100000>;
>                 interrupts = <8>;
>                 #size-cells = <0>;
>                 #address-cells = <1>;
>             };
> 
> and the corresponding MFD cells:
> 
> {
> 	.name		= "axi_iic_0",
> 	.of_compatible	= "xlnx,xps-iic-2.00.a",
> 	.of_full_name	= "i2c@c0000",
> 	.num_resources	= ARRAY_SIZE(dbe_i2c1_resources),
> 	.resources	= dbe_i2c1_resources
> },
> {
> 	.name		= "axi_iic_1",
> 	.of_compatible	= "xlnx,xps-iic-2.00.a",
> 	.of_full_name	= "i2c@d0000",
> 	.num_resources	= ARRAY_SIZE(dbe_i2c2_resources),
> 	.resources	= dbe_i2c2_resources
> },
> 
> Without having the .of_full_name support, both MFD cells ended up
> wrongly matching against the i2c@c0000 device tree node since we just
> picked the first one where of_compatible matched.

What is contained in each of their resources?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
