Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C11C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B274A2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T0GLzLcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406210AbfHBTki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:40:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43867 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406158AbfHBTkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:40:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so27011630pld.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 12:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hZZ6FWmMn+OS2bgjBLcjFysPFZH4K2Ou5+WcqYSmM1U=;
        b=T0GLzLczX9JeZaCYF3d+arvpokN7gqmeqIcSa5X8K5HpiZ9pMedgFLFCOhH5MhZbEU
         R/Ks68/S4SYlVgXjjn0veWCf1fq8AHaCM/QzTgGCyzq1AHqrFHYcq0jgnSd0EG3Gsk4l
         GmSJ/W7A5UNYdIJ29Hyjcwj8QFZM5JRFofH6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZZ6FWmMn+OS2bgjBLcjFysPFZH4K2Ou5+WcqYSmM1U=;
        b=frpDGFQ9F+z/4KeRxifGqh3VaXraWMzCr8mgSadDD4RL61zuQvQxUZeGDjxGgrFckK
         lY9Jy5RVfshSicA6893z8H2JbFcuIQVv21aLUAkcjtg6WGZtq0yUnIOW+nDsOfrkD85r
         00Oj93+0NCzZMxtNanUkcqpalJFHIatWeESvlzPoooIFBYLaTWNlF9L754+UexUXllhV
         ME9vmuSYl0GALUVtoI7cptGJ/W1Z0YbmAH9eeQ7LokRPhyqnQz139UqkKODG2R2TjTM0
         AOsgfPHfz8BoNaTdgPRmR1vu24WYjZNZZ6pE2X38vCZBUBbteL9NIX2sUCnWPz7oxmrZ
         5Kmg==
X-Gm-Message-State: APjAAAV1dKKJhd4MqvOG9giYMX4/llRzXOhP2bbrETNbufESfiYD8oe3
        iTE3YB4xARNMqUU505uwM5mVOg==
X-Google-Smtp-Source: APXvYqzFkdKYNEfPiPn7V9aHNxl6ViCr+8qHSEL6P4IEQbxCcnI4kxCbl60R+Sf1NyoJ2l1UeYB2pg==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr49481675plp.126.1564774836706;
        Fri, 02 Aug 2019 12:40:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y12sm86453517pfn.187.2019.08.02.12.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 12:40:36 -0700 (PDT)
Date:   Fri, 2 Aug 2019 12:40:32 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 4/4] net: phy: realtek: configure RTL8211E LEDs
Message-ID: <20190802194032.GM250418@google.com>
References: <20190801190759.28201-1-mka@chromium.org>
 <20190801190759.28201-5-mka@chromium.org>
 <20190802181840.GP2099@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190802181840.GP2099@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Aug 02, 2019 at 08:18:40PM +0200, Andrew Lunn wrote:
> On Thu, Aug 01, 2019 at 12:07:59PM -0700, Matthias Kaehlcke wrote:
> > Configure the RTL8211E LEDs behavior when the device tree property
> > 'realtek,led-modes' is specified.

note to self: update commit message

> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Hi Matthias
> 
> I was more thinking of adding a new driver call to the PHY driver API,
> to configure an LED. Something like
> 
> rtl8211e_config_leds(phydev, int led, struct phy_led_config cfg);

I guess it sould be singular ('_config_led') if it configures a single
LED.

> It would be called by the phylib core after config_init(). But also,
> thinking ahead to generic linux LED support, it could be called later
> to reconfigure the LEDs to use a different trigger. The standard LED
> sysfs interface would be used.

I'll look into the phylib part.

Thanks

Matthias
