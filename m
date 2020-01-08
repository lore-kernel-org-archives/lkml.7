Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952DAC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE832070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578501728;
	bh=RnoomfQqdyWrpRTnoPHfF+D9AQEynoANXYRrSNq5Bkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w1AXXbUgZl3x9wBHGt06WIjY6s31KYHMvmBBKbqCWLtaDQq/slcgfjpqZt6kOVJSe
	 UeUZim9n4iMhymsr/a+zqVQMRdbqQSFzwgriZeqHXI9ZITlQuJw8jo/7MejnDmgCZa
	 KHjojk2afQ9aJkDFy0YE61LNrI0OoK87lgY3jvVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgAHQmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:42:07 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34455 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgAHQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:42:06 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so3199701oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Icg47JqvHN2zEf9dLVseBc9ilOfxDem/7KAl7G0secI=;
        b=TFIkOMf/ndBTEGgYMQ5XhOnRihfYGRET5G2SUpYPi1QuR7MawKWrr7WTiOA/Q0M1y5
         rj74keE+9i5T4bHiMPiUVymNLFvluYNLGrz1eXyJ4p9kD9XPvojxP+nl+V7VFnR2lpJk
         xLMAEejOtAbwEpLXVDj+noh9ul/KgJaj2xNeemlZQioxqfRGxHuFxiiVLV00jTveaoHP
         xVEc6vCsV7CbN5FN5s7+es96V9THBExcz8xZYTdSi0aFc1z/SSx86KxdMpGeR2pP8N47
         dhOR8i1ZK4Bah8c14kz4eYVffWvme2qZ0AxvtMHkjW6wotqtbOpzVnpMf9j/Gudv7UZx
         mk/g==
X-Gm-Message-State: APjAAAU5RsvTV4Hx2W2hQGakKSqGaa2VBRWehjnkpElHod1/eCIc93Ob
        GO+4oQE5mH+SeZS/KmKrM+shmWs=
X-Google-Smtp-Source: APXvYqzilD6ZPBdCyqt5DvPoc73NvD4qWcby7eIyg7bcO2ohUSW1pag3tdfWtAPQEJd7ZG3pUrUycg==
X-Received: by 2002:aca:c494:: with SMTP id u142mr3996438oif.86.1578501724821;
        Wed, 08 Jan 2020 08:42:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g61sm1276977otb.53.2020.01.08.08.42.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:42:04 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2208fa
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:42:02 -0600
Date:   Wed, 8 Jan 2020 10:42:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mohana Datta Yelugoti <ymdatta.work@gmail.com>
Cc:     jacek.anaszewski@gmail.com, trivial@kernel.org,
        Mohana Datta Yelugoti <ymdatta.work@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: spi-ir-led: fix spelling mistake
 "balue"->"value"
Message-ID: <20200108164202.GA15850@bogus>
References: <20191225205941.28429-1-ymdatta.work@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191225205941.28429-1-ymdatta.work@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2019 02:29:39 +0530, Mohana Datta Yelugoti wrote:
> There is a spelling mistake in:
>       Documentation/bindings/leds/irled/spi-ir-led.txt.
> Fix it.
> 
> Signed-off-by: Mohana Datta Yelugoti <ymdatta.work@gmail.com>
> ---
>  Documentation/devicetree/bindings/leds/irled/spi-ir-led.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
