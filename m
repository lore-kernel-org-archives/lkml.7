Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F53C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E158E2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFJ60z7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfB1A0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:26:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43152 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfB1A0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 19:26:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id j1so13853461lfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 16:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XW0NL3gRkpcUyaFlXMX4tmqu9Pfi3EOpFOLebCBiA2U=;
        b=JFJ60z7MnHuUBMKgUx7bDHJyE+gQCyhhpuQgBzQiVCGxXwy4oR9kcFsy0Junzm0OiD
         RE3QcdI+Lc2ZumKNCwNpbQE7BXBB2JJuQ3eAcBXoMHbQb0iiev6uN+6J1n3YJTE9bDWv
         +s0MUBXAQBGtWtDJd83ylhrnPA+YHWnT6ntQvs89YICV1eAhXC24iTLtLjeOwQxGiMUB
         3qnjjImAJfPPkhXGZHDRXD8c/zdcpr8cNyxA8seUyd9ANjzDgplvg2aMbrlJix3FN4zn
         hVpN08Beiy2bBZR7bzJUZDegbeP+eiiwwjp3qDvme8eEErFUKgzZ+tuWJZABhtcResly
         bvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XW0NL3gRkpcUyaFlXMX4tmqu9Pfi3EOpFOLebCBiA2U=;
        b=KOdhhV9AyyfETaJXvICEL9ZpOkOGWqZja1by+RwasKq0J2IhPOLOyek88RAHcm2VPZ
         RUakj1B56IMs4iHco0Ol9OJr5VOMWve83duZw0jHpVw+XSSihW4IbrSs+c7J8VjegY6H
         hJytfAW6KT7ddYSGayS6lcRpkqif3lxJpCY056JKTwFhSaBmT35DPGIbQ/lH2Mnrhozn
         dIrsFsLFSPo0Co45JKQZedzAfagl55Ccs0wp7h+5SzpgcqWXet2/ZhgUuLpJN7sYRHH3
         sZm7OKkVzUCtebP7GnPfMD15U4Aubx+ViwqGOcGkD6UvvE+/UJAK6b1k+TwcGH+eMS7t
         mGmA==
X-Gm-Message-State: AHQUAuZEmil3rsa6qIurQv2Ry6OqtvEiyctsudNJhKaUZ7eX+XKz5b1B
        dKIMYFHEzPw7pN13DJAq3zYx7w==
X-Google-Smtp-Source: AHgI3IZ/J2YYl7NaYg5Nmy1QbUCCZ721A1Ydu/RgczsdHCtQw8BIH5xY7Y5Ft4FD6bdj9m5ZocqAiA==
X-Received: by 2002:a19:c6cd:: with SMTP id w196mr2395511lff.127.1551313579265;
        Wed, 27 Feb 2019 16:26:19 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id u11sm4251389lfb.85.2019.02.27.16.26.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 27 Feb 2019 16:26:18 -0800 (PST)
Date:   Thu, 28 Feb 2019 01:26:16 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Alexander Graf <agraf@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: broken probe deferred for power-domains
Message-ID: <20190228002616.GB19221@centauri.lan>
References: <20190227021841.GA26337@centauri.lan>
 <CAL_JsqKY3UHOf7w0o+8t7qwhOb3h8_MKVQQw-_xXL12gzb=iOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKY3UHOf7w0o+8t7qwhOb3h8_MKVQQw-_xXL12gzb=iOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 05:32:14PM -0600, Rob Herring wrote:
> On Tue, Feb 26, 2019 at 8:18 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
> >
> > Hello Rob,
> >
> > Your patch e01afc325025 ("PM / Domains: Stop deferring probe
> > at the end of initcall") breaks deferred probe for power domains.
> 
> With all the dependencies built-in, right?

Yep

> 
> What board in case I have one?

You probably do :) Dragonboard 410c.

It is reproducible very easily with branch: initcalls-for-robh
from this git:
https://git.linaro.org/people/niklas.cassel/kernel.git

ARCH=arm64 make defconfig

I recommend you to use trace_printk() when debugging drivers/base/dd.c,
since I've seen that printk can affect the timing so much that the issue
goes away :) (So don't forget to enable CONFIG_FTRACE).

> 
> > The patch looks like this:
> >
> > +++ b/drivers/base/power/domain.c
> > @@ -2253,7 +2253,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
> >                 mutex_unlock(&gpd_list_lock);
> >                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
> >                         __func__, PTR_ERR(pd));
> > -               return -EPROBE_DEFER;
> > +               return driver_deferred_probe_check_state(dev);
> >         }
> >
> >
> > Having two drivers (both using module_platform_driver),
> > one being a PD provider and one being a PD consumer.
> >
> > Before your patch:
> > The PD consumer driver calls dev_pm_domain_attach(),
> > and gets EPROBE_DEFER until the PD provider driver
> > has been probed successfully.
> >
> > (The PD provider driver needs some regulators, so it
> > is only successfully probed after the regulator driver
> > has been probed successfully.)
> >
> > Anyway, dev_pm_domain_attach() returned success after
> > the some deferred probes.
> >
> >
> > After your patch:
> > dev_pm_domain_attach() return ENODEV,
> > which comes from driver_deferred_probe_check_state().
> > Since it returns ENODEV rather than EPROBE_DEFER,
> > the PD consumer driver fails to probe.
> >
> >
> > The problem is related to your other patch 25b4e70dcce9
> > ("driver core: allow stopping deferred probe after init").
> >
> > driver_deferred_probe_check_state() returns ENODEV if
> > initcalls_done == true.
> >
> > initcalls_done is set from late_initcall(deferred_probe_initcall),
> > in drivers/base/dd.c:
> >        driver_deferred_probe_trigger();
> >        flush_work(&deferred_probe_work);
> >        initcalls_done = true;
> >
> > This does not seem very robust, since
> >
> > #1 It does not handle the case where two drivers have been
> > deferred (put in the deferred probe pending list),
> > where additionally one of the drivers has to be probed
> > before the other.
> >
> > (We would need to call driver_deferred_probe_trigger() + flush_work()
> > at least twice to handle this.)
> >
> > #2 Since this code is run from late_initcall(),
> > initcalls_done might get set before other drivers using late_initcall()
> > have even had a chance to run.
> 
> IMO, we should not have drivers using late_initcall. We need some
> level just to do things at the end of boot. The same fragility exists
> with the clock and regulator disabling.
> 
> > I can imagine that a driver using late_initcall() + EPROBE_DEFER
> > will absolutely not work with this code.
> >
> >
> > This patch fixes #1, but not #2.
> > However, I assume that even this change would not work if we have 3
> > drivers, where each driver a > b > c has to be probed, in that order.
> > (and all of them were placed in the deferred probe pending list).
> 
> I thought a successful probe would trigger a retry too. I need to look
> at it again.

That is true, a successful probe does trigger a retry,
driver_bound() has a call to driver_deferred_probe_trigger(),
which calls schedule_work(&deferred_probe_work).

I guess what is missing is a call to flush_work(&deferred_probe_work)
after the work has been scheduled.

But since the flush_work() waits, I guess the additional flush_work()
has to be in deferred_probe_initcall(), and not in driver_bound().


Kind regards,
Niklas

> 
> Maybe it would be more robust to re-trigger probe until the pending
> list doesn't change. Then we could handle any length of dependencies.
> 
> >
> > Suggestions and patches are welcome.
> >
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index a823f469e53f..3443cb78be9b 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -288,7 +288,6 @@ static int deferred_probe_initcall(void)
> >         driver_deferred_probe_trigger();
> >         /* Sort as many dependencies as possible before exiting initcalls */
> >         flush_work(&deferred_probe_work);
> > -       initcalls_done = true;
> >
> >         /*
> >          * Trigger deferred probe again, this time we won't defer anything
> > @@ -297,6 +296,8 @@ static int deferred_probe_initcall(void)
> >         driver_deferred_probe_trigger();
> >         flush_work(&deferred_probe_work);
> >
> > +       initcalls_done = true;
> > +
> >         if (deferred_probe_timeout > 0) {
> >                 schedule_delayed_work(&deferred_probe_timeout_work,
> >                         deferred_probe_timeout * HZ);
> >
> >
> >
> > Kind regards,
> > Niklas
