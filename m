Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DE7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C70206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PRCUg5e3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfDCVTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:19:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43664 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCVTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:19:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so197156pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AWnvT+zVoOgf5czsOtHLdOl/gEnaW/0oyXSc96bZjOI=;
        b=PRCUg5e3QjggFcZZQMqeQmU+O1V53EHQK5rg3QMl+c2IfqwAlnAnLqSx4zBIaZdT2w
         NZpMVy1tfhvYd2HIX4sBHzuohhIxApbo18qaZMtIr92AFgYzy/SY7k8sl4dRcSqVXYOh
         HtzcQq13U3GKoUDrzQhh0/toLIifZCYs+RyyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AWnvT+zVoOgf5czsOtHLdOl/gEnaW/0oyXSc96bZjOI=;
        b=XjbSLJ+anSRJxwRLVtumPgE0S+28js7Bfj1EFN1+ThDOi+fnfbQRI6fwSUtH5h1bU5
         wG7+3uFRs/cCu1ZziJ+dcEyMx3n3PUIeWEKl0UwaoJ615F70GUN4q/HVluaj9IE0fFxv
         DKThUzSd22SHktpyzDOoYKg4mhVbvGKBDBwMj+eGUwr4YF88BTFVVFr1GaG8UmoRHrMJ
         KzEgPomCxHfBC33ga8X+gSzmB/Y8pvLJaxLxzfpf+5vBjUs3RUO2xXVVamW85kxkcaR/
         aiVfl0ONqVhmIbYDINTGTUe4KXDRlINJr4SvzXoDMcnGXSMIoATdc1XLgCWEFAuftQsw
         HeUQ==
X-Gm-Message-State: APjAAAV/2EBjgMej8PWcaf6nNG4UCQswuRQzOVU7EfM+8Nn5+XaOx0rv
        Hng7YZAL6B058Of8IDCXCb8JvQ==
X-Google-Smtp-Source: APXvYqxl1Qj8CXFltxE+FsHMZKdwFmdwk8jHmxO3QYSbfgLqBKiILw+q2vfJUqsgQi6+ADyWkRCO0A==
X-Received: by 2002:a63:fb16:: with SMTP id o22mr1770842pgh.209.1554326384090;
        Wed, 03 Apr 2019 14:19:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v20sm25359838pfn.116.2019.04.03.14.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 14:19:43 -0700 (PDT)
Date:   Wed, 3 Apr 2019 14:19:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
Message-ID: <20190403211943.GT112750@google.com>
References: <20190403203137.203582-1-dianders@chromium.org>
 <20190403210436.GS112750@google.com>
 <CAD=FV=Whd4upxDDOrmVt=HgjEiGNuL2FccOfezpAFsy5yB55JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=Whd4upxDDOrmVt=HgjEiGNuL2FccOfezpAFsy5yB55JA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 02:08:40PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Apr 3, 2019 at 2:04 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > +static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
> >
> > nit: the fact that a high priority workqueue is used is an
> > implementation detail, since the driver has no function to perform a
> > transfer with 'normal'/low priority there is no need to distinguish
> > between the two cases. In this sense I'd be inclined to remove the
> > 'high_pri' from the function names.
> >
> > Sorry for not mentioning this earlier, I focussed on other
> > details, anyway it's just a nit.
> 
> I still kinda like having the "high_pri" in there since the point of
> this function is to transfer the work onto the high priority
> workqueue.  It's not an exported function so having the implementation
> detail leak into the name isn't a bad thing, is it?

IMO the long name with details mostly irrelevant to the caller (they
want to do a 'normal' transfer, the function should do the right thing
to get that done) is more distracting than helpful. But yeah, this is
definitely 'nit/bikeshed' territory ;-)

> ...so unless someone else thinks the name should change or you feel
> strongly about it I won't plan to change the name.

no strong feelings on my side, just wanted to mention it.
