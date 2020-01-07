Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC2BC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245A72081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoX/Wy5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgAGK14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:27:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36101 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGK1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:27:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so18759550wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vBJGzXj5QdU43lWqUTAK5EXXNmW/nqsNzSmp/l5OPpE=;
        b=aoX/Wy5i7qneVbenio7YTr67jD+P8zBkFjTqdw7o2qfMsEYiXtFRLf6pgVqm/wP9RX
         AO4rcKUpwHJj4ho+cFej84k2SV53pv9uxT5cleSAmAlnGk+fmm+eP0nRzRiX4f/Pr9/K
         1ZvUJGwLxolkD2bdOzL/Xoy3NCdKQo5Fn4HH2EqpcMMF8MGFX20n/8ZNW978QeM6Wclb
         vT7rIJ3NnZ2jFWq9RO1tbJmDmRRcZLF8pSl2Uh253eVq59Un4GYkflUALwCTZAcmRVbl
         XDNkA+vEz1f94slKwgkTZ/CP+l3tgRPcPhG9e7T1gnPGiggs8eo5+TFOQIZszjiWaNRa
         ceaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vBJGzXj5QdU43lWqUTAK5EXXNmW/nqsNzSmp/l5OPpE=;
        b=TBJkAmY1A3Vntnmnat0ddimZ6HumtZEZFdCQoKSGHqnZq6lgLmLkT7byV956FBZmGY
         Eh8sef1y1pusKNYVvnq9b71Fm0D74nbw74yPJ/G/UzIw/7MCfFKOcjU2QzCb+PC6F7ta
         jYIvgj9r+6I3CCgmZdQfPpNaxFQawNvCyeNAM4QufpYIVRp/3jP7iY6B251yyalzStK/
         p1jdxCcaBYuEjhxyEFJt1bhGNtV7HWy6bPGzuox9geXwHofkrCFCgQMD8Z01b6t3w/3m
         HYl0qHvzTV8MoluSsK62GN3d7gLQkD5jYyJ0Xb2R/m7APbYQTW/orQ8y1LebR3pyWQyD
         WCjA==
X-Gm-Message-State: APjAAAVHgPUGHa6AOLSrFeEQoKTNw8amqg9OPkeOxPXFUlbNh71B5NOl
        qdkxuW/txu5fQcANQTz4kKz30w==
X-Google-Smtp-Source: APXvYqx+AqXuXl4H0wjfxYwUwjlLbufwCeWtYLbBBNVm8LWKRulRE5vHHqKjtGB4u0aE4Lh97eKyYw==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr40609247wma.159.1578392873273;
        Tue, 07 Jan 2020 02:27:53 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id t8sm73646767wrp.69.2020.01.07.02.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:27:52 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:28:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jean-Jacques Hiblot <jjhiblot@ti.com>, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, sre@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, daniel.thompson@linaro.org, dmurphy@ti.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com
Subject: Re: [PATCH v10 6/6] backlight: add led-backlight driver
Message-ID: <20200107102800.GG14821@dell>
References: <20191009085127.22843-1-jjhiblot@ti.com>
 <20191009085127.22843-7-jjhiblot@ti.com>
 <20191121181350.GN43123@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191121181350.GN43123@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, Tony Lindgren wrote:

> Hi,
> 
> * Jean-Jacques Hiblot <jjhiblot@ti.com> [700101 00:00]:
> > From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> > This patch adds a led-backlight driver (led_bl), which is similar to
> > pwm_bl except the driver uses a LED class driver to adjust the
> > brightness in the HW. Multiple LEDs can be used for a single backlight.
> ...
> 
> > +	ret = of_property_read_u32(node, "default-brightness", &value);
> > +	if (!ret && value <= priv->max_brightness)
> > +		priv->default_brightness = value;
> > +	else if (!ret  && value > priv->max_brightness)
> > +		dev_warn(dev, "Invalid default brightness. Ignoring it\n");
> 
> Hmm so just wondering.. Are we using "default-brightness" instead of the
> usual "default-brightness-level" here?

Did this get answered?

> Please Cc me on the next patchset too :)

I've been waiting for v11.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
