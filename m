Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDFDC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F3A20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1CbvyDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfJILfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:35:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42783 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfJILfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:35:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so2462160wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zoqf544e3TSKxjInWelA53LaLfaxVwpSA7VlNSs9qgo=;
        b=R1CbvyDtvpySmFaKbbIdxzu0cPyIBdPrvbomY5WDuXS8FxEqhBltUDb5ybu73Ceezl
         28RuTNVzaP+spaUFzIMjW3soNKDjW0byowHx/jD+8okoGxg5B5FL6c5z6u7GTtPL1Ezt
         GcWiYZBP6ABSky8QhzjgvvgLVbGPFJ5NVcwyRbP+kilR1V4Yp7tf2GeJFnvc0gNAWSjD
         D3fSlEK26BgDxrypoUnz0NPXwaWwkyAxyoq9oSTgxnNj3VxJ4puuQWWjgoNGE/8SEJaJ
         NFqs5lqeIpf45gPrbT0NHio6hU172nZsKlIDWHKTlxmodf9p4rFE9E5CcBdphSa9Ugs4
         KHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zoqf544e3TSKxjInWelA53LaLfaxVwpSA7VlNSs9qgo=;
        b=BajJN+dMeMmQzTQkComidiLZ+WoRjGokfLn0TE6bmdS7It8VgGwdIetNZsK/P1BV6V
         DyatEqfhePoZJRyPPhJ9S+C2TiqZEH4OprH10zPl7BSNNhjhTzt9nt/x/ba13WHgMav9
         yCoEAfcj1v+Dhu0q6TPvXWHWvZcg2npnPbCmwoFmFjbTAAc4onLQDAqvw4FalpgEd0pf
         xs8OQWFhSWyQSdLTP1HKZ5aGqMtkLgLCQ+8y18hrYc82GvAS3B6cPUNYSaPB6G67w4yz
         165RdjF/JrGKpdyCAu3+tBZCh/vbOq81eCQ7LJ+KBqjQVF5brjFjs/Y7v32EJersk6Gb
         w7wQ==
X-Gm-Message-State: APjAAAUwifDX2uTh1a1BUoVsQ6V1m8/oQAEekbZ+JHaPiXjx1Pg7l5N2
        +6aM4hVVrYbXyk7DULWanTuHfw==
X-Google-Smtp-Source: APXvYqzhIsgdZaIpGiHVKQhRfk7caa2l51lGxUjY2AM9i4e/fL3Ggyzq/0MaSvh70LwtsSxIjX5IVQ==
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr2387150wrw.195.1570620942880;
        Wed, 09 Oct 2019 04:35:42 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id n7sm1887494wrt.59.2019.10.09.04.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 04:35:42 -0700 (PDT)
Date:   Wed, 9 Oct 2019 12:35:40 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        heiko@sntech.de, dianders@chromium.org, mka@chromium.org,
        groeck@chromium.org, kernel@collabora.com, bleung@chromium.org,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: cros-ec: Let cros_ec_pwm_get_state() return the
 last applied state
Message-ID: <20191009113540.x6uxo3ryiuf7ql55@holly.lan>
References: <20191008105417.16132-1-enric.balletbo@collabora.com>
 <20191008143432.pbhcqamd6f4qwbqn@pengutronix.de>
 <4f009344-242e-19a7-6872-2c55df086044@collabora.com>
 <20191008203137.s22clq6v2om5ktio@pengutronix.de>
 <53b7d02b-1a2d-11da-fdd0-5378f360d876@collabora.com>
 <20191009095635.yysr33lnwldicyng@holly.lan>
 <20191009101637.gmvghwdvcmfw4yyk@pengutronix.de>
 <20191009104236.ux23ywnhvsym2qcb@holly.lan>
 <20191009112126.slpyxhnuqpiqgmes@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191009112126.slpyxhnuqpiqgmes@pengutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 01:21:26PM +0200, Uwe Kleine-König wrote:
> On Wed, Oct 09, 2019 at 11:42:36AM +0100, Daniel Thompson wrote:
> > On Wed, Oct 09, 2019 at 12:16:37PM +0200, Uwe Kleine-König wrote:
> > > On Wed, Oct 09, 2019 at 10:56:35AM +0100, Daniel Thompson wrote:
> > > > On Wed, Oct 09, 2019 at 11:27:13AM +0200, Enric Balletbo i Serra wrote:
> > > > > Hi Uwe,
> > > > > 
> > > > > Adding Daniel and Lee to the discussion ...
> > > > 
> > > > Thanks!
> > > > 
> > > > > On 8/10/19 22:31, Uwe Kleine-König wrote:
> > > > > > On Tue, Oct 08, 2019 at 06:33:15PM +0200, Enric Balletbo i Serra wrote:
> > > > > >>> A few thoughts to your approach here ...:
> > > > > >>>
> > > > > >>>  - Would it make sense to only store duty_cycle and enabled in the
> > > > > >>>    driver struct?
> > > > > >>>
> > > > > >>
> > > > > >> Yes, in fact, my first approach (that I didn't send) was only storing enabled
> > > > > >> and duty cycle. For some reason I ended storing the full pwm_state struct, but I
> > > > > >> guess is not really needed.
> > > > > >>
> > > > > >>
> > > > > >>>  - Which driver is the consumer of your pwm? If I understand correctly
> > > > > >>>    the following sequence is the bad one:
> > > > > >>>
> > > > > >>
> > > > > >> The consumer is the pwm_bl driver. Actually I'n trying to identify
> > > > > >> other consumers.
> > > > > > 
> > > > > 
> > > > > So far, the pwm_bl driver is the only consumer of cros-ec-pwm.
> > > > > 
> > > > > > Ah, I see why I missed to identify the problem back when I checked this
> > > > > > driver. The problem is not that .duty_cycle isn't set but there .enabled
> > > > > > isn't set. So maybe we just want:
> > > > > > 
> > > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > > > > index 2201b8c78641..0468c6ee4448 100644
> > > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > > @@ -123,6 +123,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
> > > > > >         if (brightness > 0) {
> > > > > >                 pwm_get_state(pb->pwm, &state);
> > > > > >                 state.duty_cycle = compute_duty_cycle(pb, brightness);
> > > > > > +               state.enabled = true;
> > > > > >                 pwm_apply_state(pb->pwm, &state);
> > > > > >                 pwm_backlight_power_on(pb);
> > > > > >         } else
> > > > > > 
> > > > > > ? On a side note: It's IMHO strange that pwm_backlight_power_on
> > > > > > reconfigures the PWM once more.
> > > > > > 
> > > > > 
> > > > > Looking again to the pwm_bl code, now, I am not sure this is correct (although
> > > > > it probably solves the problem for me).
> > > > 
> > > > Looking at the pwm_bl code I wouldn't accept the above as it is but I'd
> > > > almost certainly accept a patch to pwm_bl to move the PWM enable/disable
> > > > out of both the power on/off functions so the duty-cycle/enable or
> > > > disable can happen in one go within the update_status function. I don't
> > > > think such a change would interfere with the power and enable sequencing
> > > > needed by panels and it would therefore be a nice continuation of the
> > > > work to convert over to the pwm_apply_state() API.
> > > 
> > > OK for me. Enric, do you care enough to come up with a patch for pwm_bl?
> > > I'd expect that this alone should already fix your issue.
> > >  
> > > > None of the above has anything to do with what is right or wrong for
> > > > the PWM API evolution. Of course, if this thread does conclude that it
> > > > is OK the duty cycle of a disabled PWM to be retained for some drivers
> > > > and not others then I'd hope to see some WARN_ON()s added to the PWM
> > > > framework to help bring problems to the surface with all drivers.
> > > 
> > > I think it's not possible to add a reliable WARN_ON for that issue. It
> > > is quite expected that .get_state returns something that doesn't
> > > completely match the requested configuration. So if a consumer requests
> > > 
> > > 	.duty_cycle = 1
> > > 	.period = 100000000
> > > 	.enabled = false
> > > 
> > > pwm_get_state possibly returns .duty_cycle = 0 even for drivers/hardware
> > > that has a concept of duty_cycle for disabled hardware.
> > > 
> > > A bit this is addressed in https://patchwork.ozlabs.org/patch/1147517/.
> > 
> > Isn't that intended to help identify "odd" PWM drivers rather than "odd"
> > clients?
> > 
> > Initially I was thinking that a WARN_ON() could be emitted when:
> > 
> > 1. .duty_cycle is non-zero
> > 2. .enabled is false
> > 3. the PWM is not already enabled
> > 
> > (#3 included to avoid too many false positives when disabling a PWM)
> 
> I think I created a patch for that in the past, don't remember the
> details.
> 
> > A poisoning approach might be equally valid. If some drivers are
> > permitted to "round" .duty_cycle to 0 when .enabled is false then the
> > framework could get *all* drivers to behave in the same way by
> > zeroing it out before calling the drivers apply method. It is not that
> > big a deal but minimising the difference between driver behaviour should
> > automatically reduce the difference in API usage by clients.
> 
> I like it, but that breaks consumers that set .duty_cycle once during
> probe and then only do:
> 
> 	pwm_get_state(pwm, &state);
> 	state.enabled = ...
> 	pwm_apply_state(pwm, &state);
> 
> which is a common idiom.

Sorry I must have missed something. That appears to be identical to
what pwm_bl.c currently does, albeit for rather better reasons.

If setting the duty cycle and then separately enabling it is a
reasonable idiom then the cros-ec-pwm driver is a broken implementation
of the API and needs to be fixed regardless of any changes to pwm_bl.c .


Daniel.
