Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240C2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2ED820644
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6pFeVOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfF1Ie6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:34:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40359 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfF1Ie5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:34:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so5334056wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Er2fAVP5Ms4noh0Cce6d0mKo3XNlyHxFxsawOXmDLM=;
        b=O6pFeVOGYfmQlctyUG3G93L5C/LLenCucTCV/p3vUjtHjATslqdf3kbSY+viXGmtuG
         lYcVLiiJBRKWYIGaqOfbnWYKi68qv3tMnw237z3qlADjBgcGF8M7GHW7ST/eW0ALnl+E
         fr+J6qHMiyI7j+w5xpB4EJA/Fzh4BmtrzQqTA9s0c0Q6dQ07/lekkTfHmLqcHTRJvak2
         0e6HI29paJBQKFqYH4BTHk4kwYOKcSvcnuA0MNqj0trC6DfvDJqptsd3SccBG/+jz/bN
         WEMlRj5r6vjpVVxMKBNUnbTb1u+0e4M5exV3Hp/kWdssoXF45kE4trrsBUrKWOtZ1ANF
         DcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Er2fAVP5Ms4noh0Cce6d0mKo3XNlyHxFxsawOXmDLM=;
        b=hJWCeO1x4qrlFc+6v4Wo1CsNz1RdUfJco4usvKoZXTO1lvOWSAkPbUmdME7iSfsApC
         6nnJdGAuYV2xgQUK+EkSggkMFQ6KwD206Hpp+KsDRV7b2PYFm6OB8c0mJIeQLGNyknLG
         jdiMJrt4zpjTDw1jYvfFE9dxRtbwfWmwl+a3hW/tMY7FNg7HnQBDvw55OnD1UaRX2GBr
         kGqi8SrBVPeYYguMxbkZ5fw+e/3joC5U4q2LuS+se8l6VhBVtEMiHe6SFX1PfIJQUfSS
         YAL/FaaEbE94DDBDpdmG7lxsHj1EjHB3XZ/SvFA+QQNMpZmNbC6beaJT0mP/9psNjvoP
         Ln+w==
X-Gm-Message-State: APjAAAWY4Rc/lP7yBSDeq19fvqP4Vg1IJfKfDTU7je1S/xH9ReFwuCLb
        yF7pLJa8fNV3UQECTmukmgyc9w==
X-Google-Smtp-Source: APXvYqyu+ko5DkYvoncVokw5+gWHCgFUMRUfKwXwJWAaISU2l35wG8cpi1WKhWHPOHatxgefFn5qJw==
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr7053691wrw.131.1561710894826;
        Fri, 28 Jun 2019 01:34:54 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z17sm1542600wru.21.2019.06.28.01.34.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 01:34:54 -0700 (PDT)
Date:   Fri, 28 Jun 2019 09:34:52 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
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
Message-ID: <20190628083452.tlgcylwo34lxi4s6@holly.lan>
References: <20190624203114.93277-1-mka@chromium.org>
 <20190624203114.93277-3-mka@chromium.org>
 <20190626145611.GA22348@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626145611.GA22348@xo-6d-61-c0.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 04:56:11PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Export the type of the brightness curve via the new sysfs attribute
> > 'scale'. The value of the attribute may be a simple string like
> > 'linear' or 'non-linear', or a composite string similar to
> > 'compatible' strings of the device tree. A composite string consists
> > of different elements separated by commas, starting with the
> > most-detailed description and ending with the least-detailed one. An
> > example for a composite string is "cie-1931,perceptual,non-linear"
> > This brightness curve was generated with the CIE 1931 algorithm, it
> > is perceptually linear, but not actually linear in terms of the
> > emitted light. If userspace doesn't know about 'cie-1931' or
> > 'perceptual' it should at least be able to interpret the 'non-linear'
> > part.
> 
> I'm not sure the comma-separated thing is a good idea. If it is, it should 
> go to the Documentation, not to changelog.

So I viewed the comma-separated thing as allow us to describe facts about
the scale used.

In particular I suspect that some controllers will be non-linear *and*
non-perceptual and that some userspaces, particularly those that animate
backlight changes, may care enough about the difference to ask us to add
another fact to the set that describes that scale.

Having said that I do share your concern that the comma-separated list
is overengineered and that all userspaces will end up implementing
something like:

if (strstr("non-linear", scale) {
  mode = PERCEPTUAL;
} else if (strstr("unknown", scale) {
  mode = use_existing_hueristic();
} else {
  mode = LINEAR;
}


> > +What:		/sys/class/backlight/<backlight>/scale
> > +Date:		June 2019
> > +KernelVersion:	5.4
> > +Contact:	Daniel Thompson <daniel.thompson@linaro.org>
> > +Description:
> > +		Description of the scale of the brightness curve. The
> > +		description consists of one or more elements separated by
> > +		commas, from the most detailed to the least detailed
> > +		description.
> > +
> > +		Possible values are:
> > +
> > +		unknown
> > +		  The scale of the brightness curve is unknown.
> > +
> > +		linear
> > +		  The brightness changes linearly in terms of the emitted
> > +		  light, changes are perceived as non-linear by the human eye.
> > +
> > +		non-linear
> > +		  The brightness changes non-linearly in terms of the emitted
> > +		  light, changes might be perceived as linear by the human eye.
> 
> non-linear is not too useful as described.

Agree.

The idea is that allows a userspace with simple backlight needs to
simple map the brightness property directly to a slider using the
approach above without worrying about perceptual or (possible future)
logarithmic scales. Such an approach won't be perfect but it
probably won't feel horrible for the user either.

Arguably the descriptions should move away from the raw factual
approach and describe what advise the kernel of offering the
userspace.


> > +		perceptual,non-linear
> > +		  The brightness changes non-linearly in terms of the emitted
> > +		  light, changes should be perceived as linear by the human eye.
> > +
> > +		cie-1931,perceptual,non-linear
> > +		  The brightness curve was calculated with the CIE 1931
> > +		  algorithm. Brightness changes non-linearly in terms of the
> > +		  emitted light, changes should be perceived as linear by the
> > +		  human eye.
> 
> Is it useful to know difference between perceptual, and cie-1931?

Depends how assertive the userspaces are!

If they follow the "fix kernel bugs in the kernel" mantra rather than
implement workarounds and heuristics then I suspect it would not be used
much.


> Would it be useful to export absolute values in some well-known units?
> 
> If I'm in dark room, I may want 100mW/m^2 of backlight... And it would
> be nice if I could set same backlight intensity on all my devices
> easily.

I'm a little sceptical that we could calibrate an absolute scale on
enough devices for such a property to be useful. I think it would be
"unknown" on almost every system.


Daniel.
