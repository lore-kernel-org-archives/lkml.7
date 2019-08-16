Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F3FC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1505206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m+0+I/Tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfHPWEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 18:04:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44523 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfHPWEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:04:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so3772886pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2jts3hBzwwnHxg1iUXq8B1Z0rmV8e++y+KmKdSCHThk=;
        b=m+0+I/TpTOyQzaEQUomEUx5W96kpIKZVzID/SkVn4hAsDzIkGAvTdSA6QTt4SW2i7Y
         8Q2cpCm0spTv80IFdkK2fZewW3cKCkrBDpP0oj0xZSWmnwJorJdZfeQ1E+7RJy/wI5+C
         chhLlDXPpjvzQ1qTzVNCWZucGOIHWnxg7994o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2jts3hBzwwnHxg1iUXq8B1Z0rmV8e++y+KmKdSCHThk=;
        b=lvOAAHgjU7LrJH9CckZpASnG3G5XlhnokKQWRG1nKRZblm8/16Vl47DA0W08Qj2CqQ
         iGxdovan1xdffoFdbVDOX1z/JTLTOOvluSPpz9AZNUIqy9YDxAxmiwjZFkTx3Uv78ziZ
         rWAZfUNga6/ij/Q4gb14imNx9w0eNd3sDcPC0TtDdWZV7Zgkf/VIyr2deooGtUC0BnSu
         oqC2p3Z5gh198nqk69/q4gURXFKvjqgqGpHsTcMyC7jSvg6U+JHoJB8JHuIasU8s7WG5
         T6VgtcosYO5pKHUudZdMtGyPiUgasBt77aguZy1+7ZEeZs6aDXgYubBqH1DauwaSrwxK
         jD2A==
X-Gm-Message-State: APjAAAUlVEBWh8qIFhBT9F8yj8NUkTdb/8YGbfwR1wrMRUrqgdapUk10
        VaHmg68ZwCM0IV6Xo4fTtvTVhQ==
X-Google-Smtp-Source: APXvYqzSjjQ6lUaojHffuDZVtmBKjVdYmKgcPupyNOrT/RtfpSy+MnLEpH7GklayvOJ9u1JaEveP6g==
X-Received: by 2002:a63:5550:: with SMTP id f16mr9955980pgm.426.1565993054375;
        Fri, 16 Aug 2019 15:04:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t6sm5064133pjy.18.2019.08.16.15.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 15:04:13 -0700 (PDT)
Date:   Fri, 16 Aug 2019 15:04:11 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 1/4] dt-bindings: net: phy: Add subnode for LED
 configuration
Message-ID: <20190816220411.GX250418@google.com>
References: <20190813191147.19936-1-mka@chromium.org>
 <20190813191147.19936-2-mka@chromium.org>
 <20190816201338.GA1646@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816201338.GA1646@bug>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:13:38PM +0200, Pavel Machek wrote:
> Hi!
> 
> Please Cc led mailing lists on led issues.

sorry for missing this

> On Tue 2019-08-13 12:11:44, Matthias Kaehlcke wrote:
> > The LED behavior of some Ethernet PHYs is configurable. Add an
> > optional 'leds' subnode with a child node for each LED to be
> > configured. The binding aims to be compatible with the common
> > LED binding (see devicetree/bindings/leds/common.txt).
> > 
> > A LED can be configured to be:
> > 
> > - 'on' when a link is active, some PHYs allow configuration for
> >   certain link speeds
> >   speeds
> > - 'off'
> > - blink on RX/TX activity, some PHYs allow configuration for
> >   certain link speeds
> > 
> > For the configuration to be effective it needs to be supported by
> > the hardware and the corresponding PHY driver.
> > 
> > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> > @@ -173,5 +217,20 @@ examples:
> >              reset-gpios = <&gpio1 4 1>;
> >              reset-assert-us = <1000>;
> >              reset-deassert-us = <2000>;
> > +
> > +            leds {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                led@0 {
> > +                    reg = <0>;
> > +                    linux,default-trigger = "phy-link-1g";
> > +                };
> 
> Because this affects us.
> 
> Is the LED software controllable?

it might be for certain PHYs, integration with the LED framework is
not part of this series.

> Or can it do limited subset of triggers you listed?

it depends on the PHY. The one in this series (RTL8211E) only supports
a limited subset of the listed triggers.
