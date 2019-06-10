Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F304C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005A620859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M54n+YZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfFJVyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:54:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44562 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfFJVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:54:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so1555808plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ilDXamFYOlEO8GWysgGDqHVYIEw5cY+v0lRtT4Q7uCA=;
        b=M54n+YZdWMqnrmPvi6vT8IJ8mylWm76h2+jOYmOVHfsu4lCiaKMQ1fk0oTQP4ru2nY
         ZCdqPnTKIyooUPaEM0H4AQ2XextdAG3axmuTwTqqvloFS2xJT1E3apq/5VUWy/AMUXkp
         eSGBRMMGb678qHmrEEdTy32gFDUA4i8/fzObI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ilDXamFYOlEO8GWysgGDqHVYIEw5cY+v0lRtT4Q7uCA=;
        b=Ze+QmsXqFeb2kyKnBV7z5qg7p/6CT3JqiM6rmGFQhsArNkyO4OBOTIAv+DKSxoXQXO
         h9MG/EJarq4qDNIHXnTIj6+iQJTz5irfM38UWZ5wkskfIPpr7nsGmYOlEZ8k2LSJI7m/
         sn2knp/fwF+VYvfNiKfDBHD7xEfkDxGdCX7rsnU6PTdZ1UwTp7QTTqu5ZE8tBZr49LLA
         pLIzPb0KlmVClA+Do4s+uatqAjgcFAdnIcEg3Vt1D9kDK5Zmt4elkaxmREbg8mXhZMI/
         Mk+4tQBOa7u0dpyGXq67OCwURhQsG2qyW5GqiqWSoIvyWWYnmZ5AbRQhzwcA7n+UP1N1
         VaHg==
X-Gm-Message-State: APjAAAVhQl4hcqYkPpKEJO7srwHz0zGRP4BX4lDPYrWfiBYzJjL1s2Uu
        xl106n+PBjUt9tHUEUfIdocrEA==
X-Google-Smtp-Source: APXvYqzMm6aINKOxX2KeUbtZPTnv+Z+yfCyTSVJfFV7qUiltd8qouqT/1lMB0iF/K2lBlTNTuW1Feg==
X-Received: by 2002:a17:902:e409:: with SMTP id ci9mr72703491plb.103.1560203646104;
        Mon, 10 Jun 2019 14:54:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u7sm11324196pgl.64.2019.06.10.14.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 14:54:05 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:54:03 -0700
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
Message-ID: <20190610215403.GC137143@google.com>
References: <20180208113032.27810-1-enric.balletbo@collabora.com>
 <20180208113032.27810-4-enric.balletbo@collabora.com>
 <20190607220947.GR40515@google.com>
 <20190608210226.GB2359@xo-6d-61-c0.localdomain>
 <819ecbcd-18e3-0f6b-6121-67cb363df440@collabora.com>
 <20190610203928.GA137143@google.com>
 <c8992414-8067-f82a-55f0-74fe9c2e1b3e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8992414-8067-f82a-55f0-74fe9c2e1b3e@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 11:02:27PM +0200, Enric Balletbo i Serra wrote:
> Hi Matthias,
> 
> On 10/6/19 22:39, Matthias Kaehlcke wrote:
> > Hi Enric
> > 
> > On Mon, Jun 10, 2019 at 12:00:02PM +0200, Enric Balletbo i Serra wrote:
> >> Hi Matthias,
> >>
> >> On 8/6/19 23:02, Pavel Machek wrote:
> >>> Hi!
> >>>
> >>>>> +	 * Note that this method is based on empirical testing on different
> >>>>> +	 * devices with PWM of 8 and 16 bits of resolution.
> >>>>> +	 */
> >>>>> +	n = period;
> >>>>> +	while (n) {
> >>>>> +		counter += n % 2;
> >>>>> +		n >>= 1;
> >>>>> +	}
> >>>>
> >>>> I don't quite follow the heuristics above. Are you sure the number of
> >>>> PWM bits can be infered from the period? What if the period value (in
> >>>> ns) doesn't directly correspond to a register value? And even if it
> >>>> did, counting the number of set bits (the above loops is a
> >>>> re-implementation of ffs()) doesn't really result in the dividers
> >>>> mentioned in the comment. E.g. a period of 32768 ns (0x8000) results
> >>>> in a divider of 1, i.e. 32768 brighness levels.
> >>>>
> >>
> >> Right, I think that only works on the cases that we only have one pwm cell, and
> >> looks like during my tests I did only tests on devices with one pwm cell :-(
> >>
> >> And as you point the code is broken for other cases (pwm-cells > 1)
> >>
> >>>> On veyron minnie the period is 1000000 ns, which results in 142858
> >>>> levels (1000000 / 7)!
> >>>>
> >>>> Not sure if there is a clean solution using heuristics, a DT property
> >>>> specifying the number of levels could be an alternative. This could
> >>>> also be useful to limit the number of (mostly) redundant levels, even
> >>>> the intended max of 4096 seems pretty high.
> >>>>
> >>
> >> Looking again looks like we _can not_ deduce the number of bits of a pwm, it is
> >> not exposed at all, so I think we will need to end adding a property to specify
> >> this. Something similar to what leds-pwm binding does, it has:
> >>
> >> max-brightness : Maximum brightness possible for the LED
> > 
> > Thanks for the confirmation that I didn't just miss some clever trick.
> > 
> > I also think that some kind of DT property is needed, I'll try to come
> > up with a reasonable name, keeping in mind that some devices might not
> > want to use the entire range of levels.
> > 
> 
> Note that, If I remember correctly, the original idea behind all these patches
> was provide a default curve with enough points following the  CIE 1931 formula
> (which describes how we perceive light). When default doesn't work for your
> hardware, you could play and define your own curve using the
> num-interpolated-steps property I.e:
> 
>  brightness-levels = <0 2048 4096 8192 16384 65535>;
>  num-interpolated-steps = <2048>;
>  default-brightness-level = <4096>;
> 
> Or even expose all the possible levels, like you do with your chromeos kernel.
> 
>  brightness-levels = <0 65535>;
>  num-interpolated-steps = <65535>;
>  default-brightness-level = <4096>;
> 
> The above should work independently of the bug found (that of course needs to be
> fixed)

Thanks for the info, indeed (keep) using a custom curve could be an
option.

I'm learning about the corresponding user space component of Chrome OS
as we speak. It looks like it's possible to specify the minimum
brightness level to use, which should do the trick, also making the OS
aware of the exponential nature of the backlight levels might help.
