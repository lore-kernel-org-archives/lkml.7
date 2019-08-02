Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751AAC41514
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8D4216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMoFTbKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406725AbfHBS1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 14:27:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43765 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405915AbfHBS1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 14:27:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so36445194pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 11:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iyciDfeLefufud92XPtBIUcF3M+xfQxtot7qPaY4KjU=;
        b=YMoFTbKPBoZXwxCuEwYjWgzntl3tH9LcT7GN3ZqIIS1GgX+sZ87yWZaE7/AqB+2Z8Z
         pCHK1MVBWhDpKa5X633FwA7Q4Rqowqa2XCBlN2JXFgYkPgrYNdjvuo4ex0zXKi5kFhuF
         JKJEAy4Fr9o7zIxYeE6ObA/pOTC00km6k1tHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iyciDfeLefufud92XPtBIUcF3M+xfQxtot7qPaY4KjU=;
        b=VjyT22bRABHgfDVlxE/B5YvIQhVmLUPLFpKX9D3Ju95dWHnsBPK1DcJOA6cmVWeW7W
         n9F4cLjIpU/RWatpxFuI1LYuQW3+tJqDVt6059u2FNCSVLnc3CisDiRMRjY1WNEg86+K
         +lKS4k5Y3yoJrGTQdRrsUHvYpYS3Jjc1fPuTb0k5hYORm/t/WaBo1JhV/apJx379ejcb
         GuEuadFjdnieAH78O2bM57gB4rJoofilvISXPQkJmVWoBeWLgKmk85tHIRtCb7PuVNf6
         jazSyMAJSpwX+j9/vKotF3xgPHVudYJ6EsWXSp7rhzEawlTi/LVUTdlPKuR92AaahgRz
         zZvg==
X-Gm-Message-State: APjAAAX5WYeYSjvFF6n5PdGpDzewmCO8/r3YUute6LepI1uv9TY9IOdz
        70jvBRGpyuARJPgaZfMW9C0iNg==
X-Google-Smtp-Source: APXvYqzgiY/OITDZnfouf3W8+91k7jkvNExx1DHHP9P0YLXPGjyTAYOaPiqzpNyX6alwgFIQHXRQig==
X-Received: by 2002:a63:ff65:: with SMTP id s37mr83163171pgk.102.1564770460233;
        Fri, 02 Aug 2019 11:27:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p23sm81442697pfn.10.2019.08.02.11.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 11:27:39 -0700 (PDT)
Date:   Fri, 2 Aug 2019 11:27:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: net: phy: Add subnode for LED
 configuration
Message-ID: <20190802182737.GL250418@google.com>
References: <20190801190759.28201-1-mka@chromium.org>
 <20190801190759.28201-2-mka@chromium.org>
 <20190802165755.GM2099@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190802165755.GM2099@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 06:57:55PM +0200, Andrew Lunn wrote:
> On Thu, Aug 01, 2019 at 12:07:56PM -0700, Matthias Kaehlcke wrote:
> > The LED behavior of some Ethernet PHYs is configurable. Add an
> > optional 'leds' subnode with a child node for each LED to be
> > configured. The binding aims to be compatible with the common
> > LED binding (see devicetree/bindings/leds/common.txt).
> > 
> > A LED can be configured to be 'on' when a link with a certain speed
> > is active, or to blink on RX/TX activity. For the configuration to
> > be effective it needs to be supported by the hardware and the
> > corresponding PHY driver.
> > 
> > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v4:
> > - patch added to the series
> > ---
> >  .../devicetree/bindings/net/ethernet-phy.yaml | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index f70f18ff821f..81c5aacc89a5 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -153,6 +153,38 @@ properties:
> >        Delay after the reset was deasserted in microseconds. If
> >        this property is missing the delay will be skipped.
> >  
> > +patternProperties:
> > +  "^leds$":
> > +    type: object
> > +    description:
> > +      Subnode with configuration of the PHY LEDs.
> > +
> > +    patternProperties:
> > +      "^led@[0-9]+$":
> > +        type: object
> > +        description:
> > +          Subnode with the configuration of a single PHY LED.
> > +
> > +    properties:
> > +      reg:
> > +        description:
> > +          The ID number of the LED, typically corresponds to a hardware ID.
> > +        $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> > +      linux,default-trigger:
> > +        description:
> > +          This parameter, if present, is a string specifying the trigger
> > +          assigned to the LED. Supported triggers are:
> > +            "phy_link_10m_active" - LED will be on when a 10Mb/s link is active
> > +            "phy_link_100m_active" - LED will be on when a 100Mb/s link is active
> > +            "phy_link_1g_active" - LED will be on when a 1Gb/s link is active
> > +            "phy_link_10g_active" - LED will be on when a 10Gb/s link is active
> > +            "phy_activity" - LED will blink when data is received or transmitted
> 
> Matthias
> 
> We should think a bit more about these names.
> 
> I can see in future needing 1G link, but it blinks off when there is
> active traffic? So phy_link_1g_active could be confusing, and very similar to
> phy_link_1g_activity?

agreed, the 'active' vs' 'activity' can be confusing, let's avoid that.

> So maybe 

> > +            "phy_link_10m" - LED will be solid on when a 10Mb/s link is active
> > +            "phy_link_100m" - LED will be solid on when a 100Mb/s link is active
> > +            "phy_link_1g" - LED will be solid on when a 1Gb/s link is active
> 
> etc.
>
> And then in the future we can have
> 
>                "phy_link_1g_activity' - LED will be on when 1Gbp/s
>                                         link is active and blink off
>                                         with activity.

sounds good to me

> What other use cases do we have? I don't want to support everything,
> but we should be able to represent the most common modes without the
> names getting too confusing.

Initially I planned to support to configure a LED to be solid for
multiple link speeds, however that could become a bit messy with the
string based triggers, unless we limit the possible combinations. My
expertise in network land is limited, so I'm not sure if that's an
important/realistic use case.
