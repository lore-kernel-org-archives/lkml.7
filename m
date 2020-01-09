Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D86C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A832077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578576552;
	bh=iHdDym7OR79CQ1t/GpbEMYCujRuSnN4psVqgGjqi+CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TUXcYZvRAXQmBtdjCRbMzbViHLv2Pkn6tzoNXKn0cZg39QsIqqOeIMF58XXIEMah0
	 SHY+2kRvHJXWJFgmsFH3j2erCEKrIfoGQAHk0VZXtkJA8na7AgFPIhYAQYSxTJ7JVs
	 pmSBq/dGbr8L56l9Nthtgb1XhT2JH/Q2EVgjmp8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgAIN3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:29:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45595 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgAIN3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:29:10 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so7192039ljc.12;
        Thu, 09 Jan 2020 05:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ErcL1N2fmNI636PPVQLs5GTMAwUgd2f5seuvakUioCs=;
        b=QcitNdlnK1P8XDsxpOgCJEwk8BBeULze+HvJMfvdQLstUAogkO0HRDXMxt23Xq8ZEq
         omkD9d+73f49SLK0dpWF2+fyJogSQb2sKjnkQBllazj9K6sfP8TeYqHSq99dZoJRfxeP
         Tz6FdqVBlVBOSt/NlFQ4up89rRSZDcpstAKFUNs6Y1MbzVpWcxo35CoafZdsFoA1rrYg
         THdYG47CGQWjWNMDbwQwTjtmQJqV2rYRVIvXvSqMTpkpGebkIaKBhL9jXhOI8VY+6pBg
         k4sa6qDKRscAFBfZAaYInptVWWKwfQwbgFVEeUd6tjLB5dji3vmnIOLzZJeyXGnUQ8Gn
         h4dA==
X-Gm-Message-State: APjAAAX78+2GfWTcxOvQaXm0qmiM0y/RFuy8LSFbHhNHA+chhijaJxmg
        IH7YTBYrvbYPecAnFjVQoLU=
X-Google-Smtp-Source: APXvYqw1hcidTUPsXmbfZ5E6ekSaUosd6Z+QbgYKjFwaIPR65Yk0gkHBGblfoIvMFxRv4YpPXS00DQ==
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr6321120ljh.138.1578576547878;
        Thu, 09 Jan 2020 05:29:07 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id y25sm3094435lfy.59.2020.01.09.05.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 05:29:07 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ipXsD-0004Te-LT; Thu, 09 Jan 2020 14:29:17 +0100
Date:   Thu, 9 Jan 2020 14:29:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     guillaume La Roque <glaroque@baylibre.com>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        khilman@baylibre.com
Subject: Re: [PATCH v6 1/2] dt-bindings: net: bluetooth: add interrupts
 properties
Message-ID: <20200109132917.GM30908@localhost>
References: <20200109104257.6942-1-glaroque@baylibre.com>
 <20200109104257.6942-2-glaroque@baylibre.com>
 <20200109105305.GL30908@localhost>
 <a33f9c30-03a8-ea12-e9d3-5e050e41318e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a33f9c30-03a8-ea12-e9d3-5e050e41318e@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:13:23PM +0100, guillaume La Roque wrote:
> 
> On 1/9/20 11:53 AM, Johan Hovold wrote:
> > On Thu, Jan 09, 2020 at 11:42:56AM +0100, Guillaume La Roque wrote:
> >> add interrupts and interrupt-names as optional properties
> >> to support host-wakeup by interrupt properties instead of
> >> host-wakeup-gpios.
> >>
> >> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> >> ---
> >>  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> >> index c44a30dbe43d..d33bbc998687 100644
> >> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> >> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> >> @@ -37,7 +37,9 @@ Optional properties:
> >>      - pcm-frame-type: short, long
> >>      - pcm-sync-mode: slave, master
> >>      - pcm-clock-mode: slave, master
> >> -
> >> + - interrupts: must be one, used to wakeup the host processor if
> >> +   gpiod_to_irq function not supported
> >> + - interrupt-names: must be "host-wakeup"
> > Looks like you forgot to address Rob's comment. If I understood him
> > correctly you either need to stick with "host-wakeup-gpios" (and fix
> > your platform) or deprecate it in favour of "interrupts":
> >
> > 	https://lkml.kernel.org/r/20191218203818.GA8009@bogus
> 
> not forgot marcel ask me a v6

Not much point in sending v6 before addressing feedback on v5.
Especially as Marcel asked for a v6 with acks. ;)

> for rob comment ok but it's not possible to support gpiod_to_irq on my
> platform.
> 
> if i deprecated it i need to update all DT with good interrupt number
> right?

Not sure. Perhaps just updating the binding is enough. Rob?

Johan
