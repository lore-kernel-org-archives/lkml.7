Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37520C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051DB2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553790526;
	bh=1fc30OU2sl22P6ONDhWxny5PnOgUBeM7u8DVVvIS5Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f6GHmygBxdyfuavoVX0qm/73m3MQSX8Kl4y6y5rU1xDay7GJpn/HWr+b54Xjr9x5/
	 IAbRYhUaCZbNVz2UeRYDct3TrASQbX8VkyQGkO95mtW+ojbYcRLI4nhWdIrYh7he0G
	 Aa3LOhOSmH2ZpyhGz0ddtTTvDt/NxGD4AJ/hqDNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfC1Q2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:28:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41893 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfC1Q2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:28:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id 64so18889973otb.8;
        Thu, 28 Mar 2019 09:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=awOg/48iAqQFPw8p4NI3hF5iP5KBfF1+0EfD1TD635M=;
        b=fhsK1nnHcvnthj009r4m4q7ozkrRiHU6wNLu56ptfbFbe/zI/+RWpQ8eu6tPxTx+wI
         +04oIm4JfAUVFAoUDhhavoELmK0ETyCidHxFrDTGUvkAUGKWdfi7w8XAj0eM+FO6KWuY
         c8p98Rj9IhdDm2AKPnHpoflzmOyzb8I8B9LV4LurDzc4uKodT8694BT5LtxsmYGD7HAh
         GsiOAPaH4Mqt5uERsvs1L/i6zjRx2PAiXUVmIJQfsAEQy7m1m4vSNLq/m6NfaS5sPiYU
         iAQekRmc65nAIermAl2nPBkhxEVKUCw/16zzFqvp8WSv/Hg9or7RaxSCUD52LYynATx9
         2XMg==
X-Gm-Message-State: APjAAAWC0KjDDDZPG3OxoWYSkL3+6we9kFqRGjL+GHJedzu1ou9UqEDS
        jA/mDGwhihVKEzwzifAQGQ==
X-Google-Smtp-Source: APXvYqzEs7tQTE6sHB5zuAe5d1xeQgXJKbpHaGqtiOrVS6+BRrfqxYuXaxVEgS2VyYBeC+ijArsv0w==
X-Received: by 2002:a05:6830:11c2:: with SMTP id v2mr15513257otq.161.1553790523591;
        Thu, 28 Mar 2019 09:28:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q18sm9804511otl.51.2019.03.28.09.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:28:42 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:28:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/6] leds: netdev trigger: allow setting initial
 values in device tree
Message-ID: <20190328162842.GA11865@bogus>
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-7-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314140619.3309-7-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 03:06:19PM +0100, Rasmus Villemoes wrote:
> It can be quite convenient to initialize a netdev-triggered LED with a
> device name and setting the rx,tx,link properties from device tree,
> instead of having to do that in an init script (or udev rule) in
> userspace.
> 
> My main motivation for this is to be able to switch away from the
> deprecated CONFIG_CAN_LEDS. The example added to common.txt
> corresponds to switching linux,default-trigger = "can0-rxtx" to
> "netdev" and adding the indicated netdev subnode.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  .../devicetree/bindings/leds/common.txt       | 11 +++++++
>  drivers/leds/trigger/ledtrig-netdev.c         | 30 +++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index 7cb88460a47c..f8078c4cf6f8 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -43,6 +43,17 @@ Optional properties for child nodes:
>                  Documentation/ABI/testing/sysfs-class-led-trigger-netdev)
>                  to reflect the state and activity of a net device.
>  
> +                The optional child node netdev can be used to
> +                configure initial values for the link, rx, tx and
> +                device_name properties. For example,
> +
> +                netdev {

I was going to let the use of netdev slide, but now you have it 
twice and that's a Linuxism.

> +                    rx;
> +                    tx;
> +                    link;

What do these mean?

> +                    device-name = "can0";

can0 is a linux thing and doesn't belong in DT.

> +                };

I really don't like this. What's this going to look like if every 
trigger wants to add something like this? What's special about netdev 
leds?

We really need to decouple the Linux LED trigger design from the DT 
bindings. I have no problem associating LEDs with devices in DT, but it 
shouldn't just bring the LED trigger design into the bindings.
