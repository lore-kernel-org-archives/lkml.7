Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA29C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFD42087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pv1iKvVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfHSKCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:02:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39359 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSKCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:02:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id i63so1056653wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oGByaHL3WvRAzy9wH7sBu4JfOwqcR9WgHoejdLOV3QM=;
        b=Pv1iKvVjNFoT9NpBjh5AjigD0Gfi9AlI9zmHJZd0VcE2KJAzuvDqYkLHGAAXSTA0n5
         AJH9DSb/LcjmwVzKkS4Od5ciSpqSrL7YeD+XEUs9djKRPw7sH9BN07TcllUSaQopMX2B
         UIwuxiFUpgYYlLJHcJ57GFfZpcXEZmJJztHVhMMMc4gMqR2Zs2MCEgHW7sg9fNPtZm43
         kdUlo51U7YSEq1urcux3GlWC3hqbf7fxCmESHWxPanKWPpJ24Kq9YFFrq3EUT6sYgiir
         3SzF9hV23NSm0w1W/KzHY/6is/O7ID4nN+ZpPq2W2q2kttcuqGDakMjq7b3yiq+aiDgE
         xeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oGByaHL3WvRAzy9wH7sBu4JfOwqcR9WgHoejdLOV3QM=;
        b=bsSDVnyNZr1UgWEPxCCZIiu0b4X9tZFsxeOz9EJN1MKLIxTm8UEDesL43fWpNKJBqd
         Nbxrm08n0BGEx7eNRN2p1ZQ5kmBXopyLTb/x6BFKiRMt3hkom3JBvWDVR/CrvFtpWChS
         JfnwgtIzUzXe5qEXw+IMO8lglnCME3wDWcTf04QoTKqgg8VMPL1ijqPikXkr+RnY+XEd
         nY0Is4Gf25dJ9NjUfHV1GsxPSyNQUyepNgaac3Ajr+GqVvJxlBxRcAOC/J9jD3K5e0HS
         K0T20lVkQM+T/gTb758ZRDm0qpV+9YIGq84akBaQABAmfy8TzB8AYv11OrzzuCyn4E50
         RZvg==
X-Gm-Message-State: APjAAAUZzER3g2TH1jc32s2wqAlz9I7Cm91x3zd56LIIwFbeWYbKefVn
        yVepk4ZEMAu9Yo9QeznMIbCJ3w==
X-Google-Smtp-Source: APXvYqzAdCZexfjrffxQ2iQVUNZ3b9uiq8WokUSyaQSwncOs/o7Tq9IHD00J90l+fZLvg9wrybUMog==
X-Received: by 2002:a1c:d108:: with SMTP id i8mr20495497wmg.28.1566208963981;
        Mon, 19 Aug 2019 03:02:43 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o16sm17087477wrp.23.2019.08.19.03.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 03:02:43 -0700 (PDT)
Date:   Mon, 19 Aug 2019 11:02:41 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190819100241.5pctjxmsq6crlale@holly.lan>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190807201528.GO250418@google.com>
 <510f6d8a-71a0-fa6e-33ea-c4a4bfa96607@linaro.org>
 <20190816175317.GU250418@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816175317.GU250418@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:53:17AM -0700, Matthias Kaehlcke wrote:
> On Fri, Aug 16, 2019 at 04:54:18PM +0100, Daniel Thompson wrote:
> > On 07/08/2019 21:15, Matthias Kaehlcke wrote:
> > > On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> > > > Backlight brightness curves can have different shapes. The two main
> > > > types are linear and non-linear curves. The human eye doesn't
> > > > perceive linearly increasing/decreasing brightness as linear (see
> > > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > > linearly to human eye"), hence many backlights use non-linear (often
> > > > logarithmic) brightness curves. The type of curve currently is opaque
> > > > to userspace, so userspace often uses more or less reliable heuristics
> > > > (like the number of brightness levels) to decide whether to treat a
> > > > backlight device as linear or non-linear.
> > > > 
> > > > Export the type of the brightness curve via the new sysfs attribute
> > > > 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> > > > 'unknown'. For devices that don't provide information about the scale
> > > > of their brightness curve the value of the 'scale' attribute is 'unknown'.
> > > > 
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > 
> > > Daniel (et al): do you have any more comments on this patch/series or
> > > is it ready to land?
> > 
> > I decided to leave it for a long while for others to review since I'm still
> > a tiny bit uneasy about the linear/non-linear terminology.
> > 
> > However that's my only concern, its fairly minor and I've dragged by feet
> > for more then long enough, so:
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Thanks!
> 
> If you or someone else has another suggestion for the terminology that
> we can all agree on I'm happy to change it.

As you will see in my reply to Uwe. The term I tend to adopt when I want
to be precise about userspace behaviour is "perceptual" (e.g. that a
backlight can be mapped directly to a slider and it will feel right).

However that raises its own concerns: mostly about what is perceptual
enough.

Clear the automatic brightness curve support in the PWM driver is
perceptual.

To be honest I suspect that in most cases a true logarithmic curve (given a
sane exponent) would be perceptual enough. In other words it will feel
comfortable with a direct mapped slider and using it for animation
won't be too bad.

However when we get right down to it *that* is the information that is
actually most useful to userspace: explicit confirmation that the scale
can be mapped directly to a slider. I think it also aligned better with
Uwe's feedback (e.g. to start working towards having a preferred scale).


Daniel.







