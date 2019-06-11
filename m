Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AF2C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C82E2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hPfeNzhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436741AbfFKWLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:11:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40559 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407857AbfFKWLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:11:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so5703848pla.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8vFvJ8V6ajJREADlkWcQGOvk5dqkkgFT9ytOdn/LZ6s=;
        b=hPfeNzhq51hsmDu/JK7bh3qIFlI5DoZS5suqWw3uFdum9RZoZ2kLpg+CG3WfwtzWqG
         wUsWqTNqS4DVwjG3bZ5K061mHFseBicQAv9ZBnZKQCzCbAd+m0Wm71AVkht6a9BHwRBP
         mH/ugMZuWCy/YaFsK+qaD6od1aOotlirFt6fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8vFvJ8V6ajJREADlkWcQGOvk5dqkkgFT9ytOdn/LZ6s=;
        b=SvOpESheyd5WhpoNAdu7gK12nlp+aRLYXaEqrOL4JHXuKTZ31yd7yIZj2/yKkMBBeM
         ScRyKVSIYcC0Ga9Pk8+2R/z3JILGs5Z+Xu6nHXWbcyZ63vNxZUhp8gabyTsKt7gPDf6a
         4WPxySChjqpnnH9/6lYb20yTE9A6RDFHhvr/Xwpvjqr20mkpH2sTUHfph7Jo4eLd6qHR
         tXyW5V87yZwmBps7oaw5yKwbLpEj4aAx+DlQXQWrjQv4l/U4X3oEZvU6uFdu9hLTiIMw
         wcBOQN6yTK/Usmo5TNxuUCEoiYcIYlB8OxQfV1ghrDfKFDrTUuy/Y7Sdvq3yISTeLpGD
         EjmQ==
X-Gm-Message-State: APjAAAWMGWKYYzJN+havy4Dg11x7zfVKMkpoz6LcBPxtT9YEwxTr0fv6
        t5SB1zjDCyDTIrNRMlpwPBZW+w==
X-Google-Smtp-Source: APXvYqwEviZoSj03YwFf0xshEB8pQdCuQy4uEVw4wDJoV5zm7LJ8rVpZzWCRBK0Mj4y2Dqy1neX5Aw==
X-Received: by 2002:a17:902:e58b:: with SMTP id cl11mr57462355plb.24.1560291110514;
        Tue, 11 Jun 2019 15:11:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u4sm17102828pfu.26.2019.06.11.15.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 15:11:49 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:11:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness'
 property
Message-ID: <20190611221147.GG137143@google.com>
References: <20190610233739.29477-1-mka@chromium.org>
 <00220cd7-ed4b-5250-d448-cf83ed4c2012@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00220cd7-ed4b-5250-d448-cf83ed4c2012@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On Tue, Jun 11, 2019 at 10:02:23PM +0200, Jacek Anaszewski wrote:
> Hi Matthias,
> 
> On 6/11/19 1:37 AM, Matthias Kaehlcke wrote:
> > Add an optional 'max-brightness' property, which is used to specify
> > the number of brightness levels (max-brightness + 1) when the node
> > has no 'brightness-levels' table.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >   .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > index 64fa2fbd98c9..98f4ba626054 100644
> > --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > @@ -27,6 +27,9 @@ Optional properties:
> >                               resolution pwm duty cycle can be used without
> >                               having to list out every possible value in the
> >                               brightness-level array.
> > +  - max-brightness: Maximum brightness value. Used to specify the number of
> > +                    brightness levels (max-brightness + 1) when the node
> > +                    has no 'brightness-levels' table.
> 
> In the LED subsystem we have led-max-microamp property which seems to
> better describe hardware capabilities. It says just: this is the current
> level the LED can withstand. max-brightness does not implicitly convey
> this kind of information.
> 
> Why the need for the property at all? If for the reasons other than
> hardware capabilities than it should be more likely handled
> by userspace.

The driver needs to know how many brightness levels to expose to
userspace. It currently uses a heuristic for that which is broken:

https://elixir.bootlin.com/linux/v5.1.9/source/drivers/video/backlight/pwm_bl.c#L234
https://lore.kernel.org/patchwork/patch/1086777/#1282610

In any case it seems the discussion is going into the direction of
fixing the heuristic (apparently using the period as an indicator of
the PWM resolution has more merit than I was initially aware of), if
that moves forward the property wouldn't be needed.
