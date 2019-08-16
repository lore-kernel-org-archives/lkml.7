Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA3AC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4413D20665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NWmOxTml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfHPRwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:52:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40181 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbfHPRwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:52:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so3291862pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xjxlB0B/JZnHNwu9yzdxZFE3he1ESE8+7aIO3e2RkyQ=;
        b=NWmOxTmlwuqvYepW/pFP8VjWfNcBSeaFJiXDcL0o6v7Rvz8TLVtdKnwCd8I/2FMoMs
         78S4FIuhOe1aIEuZ/RxhcqKOfVuhGptQBHAw3i/dj3GvfGe2XVrRPMoi1FV9rxsP40Gi
         aOcF7Niwzy0kmnSzlnHcurkXlpMbOhRfTDSyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xjxlB0B/JZnHNwu9yzdxZFE3he1ESE8+7aIO3e2RkyQ=;
        b=DDJn/TjziiH95hHSxBxoN36uxESGYWx+x51H0xtDXRBw+uaXCLcN8Y3DL2wB5uQqmt
         mI/A+L7J2ktmvRXkuCoeYEZDTklL5WAA4PyLj6xFVW4kKoReXMXWlbRjXl8Um5/KNMBz
         O5rRrzfVgTb1Hht/8BgwgMjkdvONgDLfoLoTQKDy+sM6XXK2sUMKHfyvpxRk+X/Gxi9B
         ODuXQjZK+KWkTzdIbSQAqZU75bmknyH8Rb9fZgW2COpBZOldv3hrdlFbB0auKRHdzyoL
         pkYXNh7mtHJFKXPYSK3NyzQMT9j6s7sY9WTST4rCybaIJS0ZDLeBtAEJLVN0GSYdmKt1
         ooSg==
X-Gm-Message-State: APjAAAV7XQPkGgSNBPcIjyASUKotVjxwsIrnReZJT37454eQjAhwtNE5
        ZHpJ6kgrrcpqJxv5p3OdW/9jfQ==
X-Google-Smtp-Source: APXvYqwQomJ4VDkW8Ugkil0/0Fx0afChPTSA24OHMr8FpMJsdU6v6T3IhgWzwQyyDkhwbqMSnFaCYg==
X-Received: by 2002:aa7:8102:: with SMTP id b2mr12049391pfi.105.1565977925626;
        Fri, 16 Aug 2019 10:52:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 16sm10735880pfc.66.2019.08.16.10.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 10:52:05 -0700 (PDT)
Date:   Fri, 16 Aug 2019 10:51:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
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
Message-ID: <20190816175157.GT250418@google.com>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190816165148.7keg45fmlndr22fl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190816165148.7keg45fmlndr22fl@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Fri, Aug 16, 2019 at 06:51:48PM +0200, Uwe Kleine-König wrote:
> On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> > Backlight brightness curves can have different shapes. The two main
> > types are linear and non-linear curves. The human eye doesn't
> > perceive linearly increasing/decreasing brightness as linear (see
> > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > linearly to human eye"), hence many backlights use non-linear (often
> > logarithmic) brightness curves. The type of curve currently is opaque
> > to userspace, so userspace often uses more or less reliable heuristics
> > (like the number of brightness levels) to decide whether to treat a
> > backlight device as linear or non-linear.
> > 
> > Export the type of the brightness curve via the new sysfs attribute
> > 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> > 'unknown'. For devices that don't provide information about the scale
> > of their brightness curve the value of the 'scale' attribute is 'unknown'.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> I wonder what kind of problem you are solving here. Can you describe
> that in a few words?

The human eye perceives brightness in a logarithmic manner. For
backlights with a linear brightness curve brightness controls like
sliders need to use a mapping to achieve a behavior that is perceived
as linear-ish (more details: http://www.pathwaylighting.com/products/downloads/brochure/technical_materials_1466797044_Linear+vs+Logarithmic+Dimming+White+Paper.pdf)

As of now userspace doesn't have information about the type of the
brightness curve, and often uses heuristics to make a guess, which may
be right most of the time, but not always. The new attribute eliminates
the need to guess.
