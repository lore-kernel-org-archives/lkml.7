Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0A3C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A143B2146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lRaikns7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfGAQz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:55:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40239 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfGAQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:55:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so6319004pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xDSI42+k7oV3eNOdMjBIpymPAXqrgf6nD9EQGoEDOSQ=;
        b=lRaikns7k0uCZd5C9Ln4pFCafvvy3X3J1z3IOKuS6jl6hcBL6bV2bF/9yEndlBwiut
         VSDmQY3n9WohNZyarR2lVtR/uCDI3dEyNmWB6NXRX16l+AlIqu+kYx5bpkmFUNpj4PmD
         4WJtWiEUnvCoQuD2X2/ZiwMj36GFejsjvm2gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xDSI42+k7oV3eNOdMjBIpymPAXqrgf6nD9EQGoEDOSQ=;
        b=aljc1tclpEZ2HvUiusLq5jTfgJi+o8C81DcIcJnS2YegYGsHA9gXd5GJm7thVVOD/f
         AmP2ScBGoFiwKAsHx7JMMPQyZC1lEsg2cRhuEr7UMO75xbcgiW+oomLb6xo+8G0+OQxu
         iPtaXxPp91Hzlam/Ulq/d+I6+6VBLXbbDz2N2Q2In0a6aDvYgz6jNrLI8+vjxINllQAA
         RpDUDZpYJ59udpW6EIGWmWGoeLm64JYSxCfzrwg8YtNOeXVyR1WjsiTSkfTfJ8ZVpVzo
         GBTRksL8QooGBP3qY2bN1tuFVy1Hdl1HyapwBMuWeA4RZ0n+JJYadCkCPK4gXlkCONoj
         7XUQ==
X-Gm-Message-State: APjAAAWtGutAqbKk8GnpP+lKORRVcqM6dCdq+LEaPjHYWJrNyRcKrFX1
        b/Tmoqfy1KVaDzjMvwiSfGQk/w==
X-Google-Smtp-Source: APXvYqxwphdbl0NMiWm88UC1X5R0XR+EGB+EX9ncZxUKCYgnZV3kX08POr1D29GjDrjDNRrLjmPDTQ==
X-Received: by 2002:a17:90a:a404:: with SMTP id y4mr311822pjp.58.1562000127976;
        Mon, 01 Jul 2019 09:55:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d2sm12367553pgo.0.2019.07.01.09.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 09:55:27 -0700 (PDT)
Date:   Mon, 1 Jul 2019 09:55:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v2 2/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190701165523.GD137143@google.com>
References: <20190624203114.93277-1-mka@chromium.org>
 <20190624203114.93277-3-mka@chromium.org>
 <20190626145611.GA22348@xo-6d-61-c0.localdomain>
 <20190628083452.tlgcylwo34lxi4s6@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190628083452.tlgcylwo34lxi4s6@holly.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 28, 2019 at 09:34:52AM +0100, Daniel Thompson wrote:
> On Wed, Jun 26, 2019 at 04:56:11PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > Export the type of the brightness curve via the new sysfs attribute
> > > 'scale'. The value of the attribute may be a simple string like
> > > 'linear' or 'non-linear', or a composite string similar to
> > > 'compatible' strings of the device tree. A composite string consists
> > > of different elements separated by commas, starting with the
> > > most-detailed description and ending with the least-detailed one. An
> > > example for a composite string is "cie-1931,perceptual,non-linear"
> > > This brightness curve was generated with the CIE 1931 algorithm, it
> > > is perceptually linear, but not actually linear in terms of the
> > > emitted light. If userspace doesn't know about 'cie-1931' or
> > > 'perceptual' it should at least be able to interpret the 'non-linear'
> > > part.
> > 
> > I'm not sure the comma-separated thing is a good idea. If it is, it should 
> > go to the Documentation, not to changelog.
> 
> So I viewed the comma-separated thing as allow us to describe facts about
> the scale used.
> 
> In particular I suspect that some controllers will be non-linear *and*
> non-perceptual and that some userspaces, particularly those that animate
> backlight changes, may care enough about the difference to ask us to add
> another fact to the set that describes that scale.
> 
> Having said that I do share your concern that the comma-separated list
> is overengineered and that all userspaces will end up implementing
> something like:
> 
> if (strstr("non-linear", scale) {
>   mode = PERCEPTUAL;
> } else if (strstr("unknown", scale) {
>   mode = use_existing_hueristic();
> } else {
>   mode = LINEAR;
> }

I agree that this is not unlikely ...

So let's just make it 'linear', 'non-linear' and 'unknown'?

> > > +What:		/sys/class/backlight/<backlight>/scale
> > > +Date:		June 2019
> > > +KernelVersion:	5.4
> > > +Contact:	Daniel Thompson <daniel.thompson@linaro.org>
> > > +Description:
> > > +		Description of the scale of the brightness curve. The
> > > +		description consists of one or more elements separated by
> > > +		commas, from the most detailed to the least detailed
> > > +		description.
> > > +
> > > +		Possible values are:
> > > +
> > > +		unknown
> > > +		  The scale of the brightness curve is unknown.
> > > +
> > > +		linear
> > > +		  The brightness changes linearly in terms of the emitted
> > > +		  light, changes are perceived as non-linear by the human eye.
> > > +
> > > +		non-linear
> > > +		  The brightness changes non-linearly in terms of the emitted
> > > +		  light, changes might be perceived as linear by the human eye.
> > 
> > non-linear is not too useful as described.
> 
> Agree.
> 
> The idea is that allows a userspace with simple backlight needs to
> simple map the brightness property directly to a slider using the
> approach above without worrying about perceptual or (possible future)
> logarithmic scales. Such an approach won't be perfect but it
> probably won't feel horrible for the user either.
> 
> Arguably the descriptions should move away from the raw factual
> approach and describe what advise the kernel of offering the
> userspace.

ok, I'll change it in the next revision

> > > +		perceptual,non-linear
> > > +		  The brightness changes non-linearly in terms of the emitted
> > > +		  light, changes should be perceived as linear by the human eye.
> > > +
> > > +		cie-1931,perceptual,non-linear
> > > +		  The brightness curve was calculated with the CIE 1931
> > > +		  algorithm. Brightness changes non-linearly in terms of the
> > > +		  emitted light, changes should be perceived as linear by the
> > > +		  human eye.
> > 
> > Is it useful to know difference between perceptual, and cie-1931?
> 
> Depends how assertive the userspaces are!
> 
> If they follow the "fix kernel bugs in the kernel" mantra rather than
> implement workarounds and heuristics then I suspect it would not be used
> much.
> 
> 
> > Would it be useful to export absolute values in some well-known units?
> > 
> > If I'm in dark room, I may want 100mW/m^2 of backlight... And it would
> > be nice if I could set same backlight intensity on all my devices
> > easily.
> 
> I'm a little sceptical that we could calibrate an absolute scale on
> enough devices for such a property to be useful. I think it would be
> "unknown" on almost every system.

I share your scepticism and would expect most devices to remain
"unknown"
