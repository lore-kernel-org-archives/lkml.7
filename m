Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6246C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2C3206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nTiLWlQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbfFJUjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:39:32 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:33106 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbfFJUjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:39:32 -0400
Received: by mail-pf1-f180.google.com with SMTP id x15so5982578pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cFNnx6L3NQaEKxP/8K3frHUq1rFUCkpHgDob39ijY5g=;
        b=nTiLWlQRWOOai+AcxpoBEJbMuF+pVTFt3BBsdGsjBOfzmaVbCKcFK4s23SNo7e2GTJ
         jtJwXoqfHvpq4Np+08z9PvSLKiHZVRf80d/XzE7Wn/rC2nS4tJyoONnw7T6sQ/wwJBOZ
         iHfLawG6mwBu3z8LTK8RLQahT1Mt4eKFXWYu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cFNnx6L3NQaEKxP/8K3frHUq1rFUCkpHgDob39ijY5g=;
        b=mYQKF1yFWCpg1eyzq3uFUjBK1GIa62f0H6pIB4cVMhPSaU//ekPaqdcBSo1v63atot
         zfszMLwE+GS6cVEnts84TwYgDpxLQLO1zmmkdVddJ2GvvvGTWkk5TP+Si/i0Vyytp8Vu
         +aT4aRy3KfHtbaD+JsMFWewF22miyIgrEq+9HKOydPwktbDD+lDExaLIVZRH85tZmycZ
         LvNyxo0R+V+aMlsXYHCCw8T8rJxDsRivR3CLttkn6bdMVxdHuRXmbD0RH2K+7fJ61eOI
         UrQG14aNBF44ze1MXd2n7EXsi1KyWimgJqL4WvdTi7dFSmSVlNI9fOYgfuq7k8SbDmVF
         7dmw==
X-Gm-Message-State: APjAAAVtEhgOrwv4YeH7tpBU46Pe1Fh6P6vY/qBczggDz7WxBk+gWOPy
        /YCGCwssirCKPp7iPb5ZN3rGxQ==
X-Google-Smtp-Source: APXvYqz+xziOX6ZCyhZv+1/CLpFL+p/rrOFMQrx4endY5YsdqYjRZAqcyyyRMTBDBwb3F2w84xx6qQ==
X-Received: by 2002:a65:4786:: with SMTP id e6mr17183159pgs.85.1560199171334;
        Mon, 10 Jun 2019 13:39:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n127sm11632938pga.57.2019.06.10.13.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 13:39:30 -0700 (PDT)
Date:   Mon, 10 Jun 2019 13:39:28 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 3/4] backlight: pwm_bl: compute brightness of LED
 linearly to human eye.
Message-ID: <20190610203928.GA137143@google.com>
References: <20180208113032.27810-1-enric.balletbo@collabora.com>
 <20180208113032.27810-4-enric.balletbo@collabora.com>
 <20190607220947.GR40515@google.com>
 <20190608210226.GB2359@xo-6d-61-c0.localdomain>
 <819ecbcd-18e3-0f6b-6121-67cb363df440@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <819ecbcd-18e3-0f6b-6121-67cb363df440@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric

On Mon, Jun 10, 2019 at 12:00:02PM +0200, Enric Balletbo i Serra wrote:
> Hi Matthias,
> 
> On 8/6/19 23:02, Pavel Machek wrote:
> > Hi!
> > 
> >>> +	 * Note that this method is based on empirical testing on different
> >>> +	 * devices with PWM of 8 and 16 bits of resolution.
> >>> +	 */
> >>> +	n = period;
> >>> +	while (n) {
> >>> +		counter += n % 2;
> >>> +		n >>= 1;
> >>> +	}
> >>
> >> I don't quite follow the heuristics above. Are you sure the number of
> >> PWM bits can be infered from the period? What if the period value (in
> >> ns) doesn't directly correspond to a register value? And even if it
> >> did, counting the number of set bits (the above loops is a
> >> re-implementation of ffs()) doesn't really result in the dividers
> >> mentioned in the comment. E.g. a period of 32768 ns (0x8000) results
> >> in a divider of 1, i.e. 32768 brighness levels.
> >>
> 
> Right, I think that only works on the cases that we only have one pwm cell, and
> looks like during my tests I did only tests on devices with one pwm cell :-(
> 
> And as you point the code is broken for other cases (pwm-cells > 1)
> 
> >> On veyron minnie the period is 1000000 ns, which results in 142858
> >> levels (1000000 / 7)!
> >>
> >> Not sure if there is a clean solution using heuristics, a DT property
> >> specifying the number of levels could be an alternative. This could
> >> also be useful to limit the number of (mostly) redundant levels, even
> >> the intended max of 4096 seems pretty high.
> >>
> 
> Looking again looks like we _can not_ deduce the number of bits of a pwm, it is
> not exposed at all, so I think we will need to end adding a property to specify
> this. Something similar to what leds-pwm binding does, it has:
> 
> max-brightness : Maximum brightness possible for the LED

Thanks for the confirmation that I didn't just miss some clever trick.

I also think that some kind of DT property is needed, I'll try to come
up with a reasonable name, keeping in mind that some devices might not
want to use the entire range of levels.
