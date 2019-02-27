Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1459C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608CB21850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551310349;
	bh=FlqdCibZ3MxTrV8hATewVMzNLWo3qnc3HnOzvPNx2ag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ravRjJOkI38qhcdLJAewD+I+nNpYaqppqk/z5jy+Ms9+/jtEuZnjeI2OZmme7VpZT
	 b7m8vapR6IjSOnkbzUq+FxsOi+o6e9yNiVdl8wJneJRaVNiwaZFYkpcL32h7OLXsXS
	 9m7Vuu+87j0BNWPcMHoV4SDkyL1ZmzLRrXKqO/CE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfB0Xc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbfB0Xc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:32:27 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B60218AC;
        Wed, 27 Feb 2019 23:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551310346;
        bh=FlqdCibZ3MxTrV8hATewVMzNLWo3qnc3HnOzvPNx2ag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0KN6tvaKbBa+zveOHxRRNv3I5DQNOWuclO4YyCOf1sPj7dlqCS4EjOsfTDYQ/Y+Hv
         f9kos83Unrn80M1EOWDfp0W/GQk6WQd3vLiSuMdM40YBzeRwQMWm1URRmBuxKvPJ5T
         DYnZ2/wxJ3aXpvCsfxg5+VT97c7Z9XSVADstxwJI=
Received: by mail-qk1-f175.google.com with SMTP id x9so11039541qkf.0;
        Wed, 27 Feb 2019 15:32:26 -0800 (PST)
X-Gm-Message-State: APjAAAXqc8e84eoRV20KWkjJFnP2Bd8/kukM3bneQvcRbhxJL6EoJ8hb
        tek2apBglup+c+ZWlKDqHMu1e5jpdzcB6vTLKw==
X-Google-Smtp-Source: AHgI3IZavbTX6NNaTeOkTOG34v4rDdpnlcozcdq5kQypCTR1QWli7X6dDKO+fEw3153QMJdUxDBSbxPb1ChT7D+TPdw=
X-Received: by 2002:a37:a381:: with SMTP id m123mr4290840qke.147.1551310345677;
 Wed, 27 Feb 2019 15:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20190227021841.GA26337@centauri.lan>
In-Reply-To: <20190227021841.GA26337@centauri.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Feb 2019 17:32:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKY3UHOf7w0o+8t7qwhOb3h8_MKVQQw-_xXL12gzb=iOQ@mail.gmail.com>
Message-ID: <CAL_JsqKY3UHOf7w0o+8t7qwhOb3h8_MKVQQw-_xXL12gzb=iOQ@mail.gmail.com>
Subject: Re: broken probe deferred for power-domains
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Alexander Graf <agraf@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 8:18 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> Hello Rob,
>
> Your patch e01afc325025 ("PM / Domains: Stop deferring probe
> at the end of initcall") breaks deferred probe for power domains.

With all the dependencies built-in, right?

What board in case I have one?

> The patch looks like this:
>
> +++ b/drivers/base/power/domain.c
> @@ -2253,7 +2253,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
>                 mutex_unlock(&gpd_list_lock);
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
> -               return -EPROBE_DEFER;
> +               return driver_deferred_probe_check_state(dev);
>         }
>
>
> Having two drivers (both using module_platform_driver),
> one being a PD provider and one being a PD consumer.
>
> Before your patch:
> The PD consumer driver calls dev_pm_domain_attach(),
> and gets EPROBE_DEFER until the PD provider driver
> has been probed successfully.
>
> (The PD provider driver needs some regulators, so it
> is only successfully probed after the regulator driver
> has been probed successfully.)
>
> Anyway, dev_pm_domain_attach() returned success after
> the some deferred probes.
>
>
> After your patch:
> dev_pm_domain_attach() return ENODEV,
> which comes from driver_deferred_probe_check_state().
> Since it returns ENODEV rather than EPROBE_DEFER,
> the PD consumer driver fails to probe.
>
>
> The problem is related to your other patch 25b4e70dcce9
> ("driver core: allow stopping deferred probe after init").
>
> driver_deferred_probe_check_state() returns ENODEV if
> initcalls_done == true.
>
> initcalls_done is set from late_initcall(deferred_probe_initcall),
> in drivers/base/dd.c:
>        driver_deferred_probe_trigger();
>        flush_work(&deferred_probe_work);
>        initcalls_done = true;
>
> This does not seem very robust, since
>
> #1 It does not handle the case where two drivers have been
> deferred (put in the deferred probe pending list),
> where additionally one of the drivers has to be probed
> before the other.
>
> (We would need to call driver_deferred_probe_trigger() + flush_work()
> at least twice to handle this.)
>
> #2 Since this code is run from late_initcall(),
> initcalls_done might get set before other drivers using late_initcall()
> have even had a chance to run.

IMO, we should not have drivers using late_initcall. We need some
level just to do things at the end of boot. The same fragility exists
with the clock and regulator disabling.

> I can imagine that a driver using late_initcall() + EPROBE_DEFER
> will absolutely not work with this code.
>
>
> This patch fixes #1, but not #2.
> However, I assume that even this change would not work if we have 3
> drivers, where each driver a > b > c has to be probed, in that order.
> (and all of them were placed in the deferred probe pending list).

I thought a successful probe would trigger a retry too. I need to look
at it again.

Maybe it would be more robust to re-trigger probe until the pending
list doesn't change. Then we could handle any length of dependencies.

>
> Suggestions and patches are welcome.
>
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index a823f469e53f..3443cb78be9b 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -288,7 +288,6 @@ static int deferred_probe_initcall(void)
>         driver_deferred_probe_trigger();
>         /* Sort as many dependencies as possible before exiting initcalls */
>         flush_work(&deferred_probe_work);
> -       initcalls_done = true;
>
>         /*
>          * Trigger deferred probe again, this time we won't defer anything
> @@ -297,6 +296,8 @@ static int deferred_probe_initcall(void)
>         driver_deferred_probe_trigger();
>         flush_work(&deferred_probe_work);
>
> +       initcalls_done = true;
> +
>         if (deferred_probe_timeout > 0) {
>                 schedule_delayed_work(&deferred_probe_timeout_work,
>                         deferred_probe_timeout * HZ);
>
>
>
> Kind regards,
> Niklas
