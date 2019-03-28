Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74554C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAC12173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553732625;
	bh=Gy7Yb8H07DybOdc6/zVQojyG8LZtlwzMcAO7aIOUg8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=myi19YsvEwjiLAzCS8z1xUnXzAF4CKIbwKjupZWNRhH4nmdFpW+OT1rAouN1q4jHL
	 qEqXTu3sr1MIgGwwU9YlXlwTiRdNdZ/r6cqmpNMIbG7qUESIjTjX3KQ6CpxzlC4ddq
	 HM+zdJSH/gSLNNcdqhwWHZiE8/p2sYB5/s5TBJrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfC1AXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:23:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36967 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1AXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:23:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id v84so14432435oif.4;
        Wed, 27 Mar 2019 17:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C16BZd0TRL4z9PZK2z3sm2L2mAWDUg8cu7Gho7kgosA=;
        b=kiAgbGkzMOVyiGSZSWboQOVCdOCetSKfbGaC2AabhWSMvRBPjSReGvJJCwqJsUN0rQ
         dKpIMhio9xK4EGniKDi/cb0dx4UmE4ZYBCcBbvbcw/PcZWd5X+tsxv4ziqe7rin4uxFe
         YFMMU9CjxN7dtarB8t6d8lpbaFZzfOVm8dHB3E9fXz312wDyQwxWcA/1WCl1AoEfzbOH
         ZtmSAeaGr6J+2moo1viVkFTCGFOd9sdI3kcNFfDPXUm/EfCVz78mH3HDGjvxTeegk1/R
         TMCTxILdszO/VUYwSMkSHZE4Ug4VHxqJy9ifcw+TRudynN3B4aFRlUgx0CfOiPvLW5K5
         mW1Q==
X-Gm-Message-State: APjAAAXeMJxTAfqMij/6vVMI66jYxheUyBPV9h46SoaCTjA29FAUjD3S
        NMmzadrV8rsBDWx+vqNpcw==
X-Google-Smtp-Source: APXvYqwc3s5zWtTIwvgKQiZaXGuwDjAq+A5hDbV7isxJcJSsiuAUtgJcu/wj7C2LZGVjPL8DNhV3uQ==
X-Received: by 2002:aca:4405:: with SMTP id r5mr7104298oia.165.1553732623085;
        Wed, 27 Mar 2019 17:23:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m21sm5810125otj.48.2019.03.27.17.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 17:23:42 -0700 (PDT)
Date:   Wed, 27 Mar 2019 19:23:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH 05/25] dt-bindings: leds: Add function and color
 properties
Message-ID: <20190328002341.GB22901@bogus>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-6-jacek.anaszewski@gmail.com>
 <98c1a41e-77bb-5ffd-b5b3-772a28c0f0a6@ti.com>
 <796a13a7-fb8c-9b5b-6bd5-dfb7458731fe@gmail.com>
 <232b6154-cccd-c1f9-80c3-438098f3ab08@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <232b6154-cccd-c1f9-80c3-438098f3ab08@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 05:43:11PM +0100, Jacek Anaszewski wrote:
> On 3/11/19 6:24 PM, Jacek Anaszewski wrote:
> > Dan,
> > 
> > On 3/11/19 1:26 PM, Dan Murphy wrote:
> > > On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
> > > > Introduce dedicated properties for conveying information about
> > > > LED function and color. Mark old "label" property as deprecated.
> > > > 
> > > > Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > > > Cc: Baolin Wang <baolin.wang@linaro.org>
> > > > Cc: Daniel Mack <daniel@zonque.org>
> > > > Cc: Dan Murphy <dmurphy@ti.com>
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> > > > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > Cc: Simon Shields <simon@lineageos.org>
> > > > ---
> > > >   Documentation/devicetree/bindings/leds/common.txt | 55
> > > > +++++++++++++++++++----
> > > >   1 file changed, 47 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/leds/common.txt
> > > > b/Documentation/devicetree/bindings/leds/common.txt
> > > > index aa1399814a2a..3402b0e1cec9 100644
> > > > --- a/Documentation/devicetree/bindings/leds/common.txt
> > > > +++ b/Documentation/devicetree/bindings/leds/common.txt
> > > > @@ -10,14 +10,23 @@ can influence the way of the LED device
> > > > initialization, the LED components
> > > >   have to be tightly coupled with the LED device binding. They
> > > > are represented
> > > >   by child nodes of the parent LED device binding.
> > > > +
> > > >   Optional properties for child nodes:
> > > >   - led-sources : List of device current outputs the LED is
> > > > connected to. The
> > > >           outputs are identified by the numbers that must be defined
> > > >           in the LED device binding documentation.
> > > > +- function: LED functon. Use one of the LED_FUNCTION_* prefixed
> > > > definitions
> > > > +        from the header include/dt-bindings/leds/common.h.
> > > > +        If there is no matching LED_FUNCTION available, add a new one.
> > > > +- color : Color of the LED. Use one of the LED_COLOR_NAME_*
> > > > prefixed definitions
> > > > +        from the header include/dt-bindings/leds/common.h.
> > > > +        If there is no matching LED_COLOR_NAME available, add a
> > > > new one.
> > > > +
> > > 
> > > I am assuming multi color can re-use this property as well?
> > 
> > I intended it to be a string, but indeed it would be better if we will
> > make it an integer to be consistent with the discussed LED multi color
> > design.
> 
> Going further, I wonder if it would make sense to make function also
> an integer. This way we could enforce use of LED functions known
> to kernel.

I think if we did that, then we'd just need to keep label. I think we 
need to allow for populating a string in DT matching a sticker next to 
an LED on a device.

Rob
