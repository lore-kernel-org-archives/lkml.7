Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC787C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FD12081C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHDWKwAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfDYMdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:33:11 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38711 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDYMdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:33:10 -0400
Received: by mail-wm1-f46.google.com with SMTP id w15so3924wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tmlh66TVXb+pSFlqjzdKxmks/bQ0y8g4h02Q2AlwVMA=;
        b=hHDWKwAV5nYFX6rVYSYfwUolebmMX3j62o6yjHU45+9SpEt8301nswM+kEfWQdAoLm
         fW4mMyasKnxApgWqR7SQJ4ejX6ZFoesknAxGgmjPO5MssprQfn/9aD42VJ+ZDM+m5q8e
         0K1A/ZdVNIvgCLFq7YFc0aWlqh3LANecYz2byijnLrEwmakPuyoBq8/GXhIB8H8EMqcv
         dq2mvKiiNgLx4bR67kPRjhQHFxIjyDCxuPz5jO4k8/CS6aO101lrJSW10xMVjoloIHAT
         o14WlOVR2qezBex6eRSLvfcC5RXN7WJVnN0jiHxikp4MueONLuGWNcyLAKNe1KMIfRoB
         e5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tmlh66TVXb+pSFlqjzdKxmks/bQ0y8g4h02Q2AlwVMA=;
        b=PCpPzHtpQZnjaNamh3xRxDnfSee3HQGNQOCpF4myIRNbD5gH+VPhxqgWnUPjDvzN2E
         nHGTNlDgHXkezAsn8bFaJ5fA5F5zfGMNWteOJ4nEqozRoLXbAF0mUWjw2FGa7KCUZv29
         +Xs62bA9EzVmbfp/v3qsRZMTJWjgFk07fL2geurGYz5Xi82MSSUDghJ1FVxWB04NAYWS
         QfEtaxDP+VAM9PZDiAoTpgC5hM2g3g5hOgBgHK0ZtITOY5Ki3Ytip8Ih4OXmh15B6InO
         Ku/8YjWNOmfZp2KWjrc9Wt2tCqy340K+VT+lSCz9XpXuHsvx6N7rQ3bLo8NQxN6dDbmi
         DGkw==
X-Gm-Message-State: APjAAAU/Y6CMA92oyW3wWUwRvf5ZV7eK9sH/LAHMEVyApSp0V+dC7THz
        crWIsOsZzzp5UVaDmrFi7kK5387x5Tg=
X-Google-Smtp-Source: APXvYqyO73VogtYJaAG2wco5dVXxq7D6ym3CqkjHRmSdg3sRZSfQ9pQAWVmnWn5TqLxqTjxNqcSEZw==
X-Received: by 2002:a1c:730c:: with SMTP id d12mr3212612wmb.47.1556195588720;
        Thu, 25 Apr 2019 05:33:08 -0700 (PDT)
Received: from apalos (athedsl-4485328.home.otenet.gr. [94.71.60.216])
        by smtp.gmail.com with ESMTPSA id t9sm26127402wra.71.2019.04.25.05.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 05:33:07 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:33:03 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Christian Neubert <christian.neubert.86@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Message-ID: <20190425123303.GA12659@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com>
 <20190314121541.GB19385@apalos>
 <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
 <20190314134428.GA24768@apalos>
 <874l85v8p6.fsf@FE-laptop>
 <20190318112844.GA1708@apalos>
 <87h8c0s955.fsf@FE-laptop>
 <20190318122113.GA4834@apalos>
 <20190424093015.rcr5auamfccxf6ei@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424093015.rcr5auamfccxf6ei@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

> > > Also, during this week-end, Christian suggested that the issue might
> > > come from the AVS support.
> > > 
> > > Could you disable it and check you still have the issue?
> > > 
> > > For this, you just have to remove the avs node in
> > > arch/arm64/boot/dts/marvell/armada-37xx.dtsi and rebuild the dtb.
> > Sure. You'll have to wait for a week though. Currently on a trip. I'll run that
> >  once i return
> 
> @Ilias: Can you please try this now and confirm to Gregory ?
I am more overloaded than usual and totally forgot about this. Apologies.
I'll try finding some time and do this.

Thanks
/Ilias
