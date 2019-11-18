Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF106C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 04:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CCC2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 04:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574052367;
	bh=5Fi8ISTGYC0I8pS4sCvDYqG1hSWfZevAihoTOHEYSWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fSk8QhpyWYdZrkOdBwmICTMkbo/0+bpI+cViFiHjcVLQ5ePqTfR683osd2/zHUV2L
	 7tjGpoapTCRVIHmrpszplr8wpTgMdKviXrihBMzGMG5bd/9lrvN8IzV0VXtnN5iy4B
	 +LcsiDb2QdJaMRclbemiCOpibiJjJrE2PEkglcsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKREqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 23:46:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40833 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKREqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 23:46:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id p59so12404617edp.7;
        Sun, 17 Nov 2019 20:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUOQUGby+FTDEOd45d8wOcDXQ1N8J/aKk3wSgOD09hw=;
        b=o0Jhwv8lA8GADwEVNXPAELicuQDbGgvA6LwgTgMI8RfEbCe6MqDpRADdWqX3/35Y+c
         wZwjp8sk2H9xlq2oXmT5IoIbUkTYd9YSu1jCPkf5qEXPiPM1l5yw46Gd4wmExzWsT/Cq
         CpQYlEZRJTSHBrv69I0u9TjzfwuuoeP2q8PU1x+q/bRDdE30W/r9EHGqboYtayYU2gtL
         Kz/+dRFmxdui8DL93zfF3UTDx8rk9Nkfu6zPmtuap437Z5nrj2DLAhawgqgeo5RMOh9o
         TDWqdhcxX0CgadFhGd8HB26dQG7DrtQd/IJn/z88Mbmoz3v6Xx3h4cpQ1hmJCncQb4hy
         Gffw==
X-Gm-Message-State: APjAAAUbliMSDP2fiqE8e+dkYvSYxB1uFFDtk6aATkx2D7s7eQc68WHV
        SRpzturjuH/BoTQJ6BWcngA1rMC+fFIbkdkHxn0=
X-Google-Smtp-Source: APXvYqw9NlN7CITunK84MNI2Vn7QAoDPrBVkCP57F7UOm7PUdWeBg1nXqiNvcs9Pp3iAV1wQVOpRBdZQFcJoIQdxFKU=
X-Received: by 2002:a17:906:5251:: with SMTP id y17mr24339371ejm.108.1574052364573;
 Sun, 17 Nov 2019 20:46:04 -0800 (PST)
MIME-Version: 1.0
References: <2717750.dCEzHT3DVQ@kreacher>
In-Reply-To: <2717750.dCEzHT3DVQ@kreacher>
From:   Len Brown <lenb@kernel.org>
Date:   Sun, 17 Nov 2019 23:45:53 -0500
Message-ID: <CAJvTdKn9wuoXkKecZxCJHPZAG7XK_BqAZT5=7k9Mi4zo4SBL0g@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Consolidate disabled state checks
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 6:16 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> There are two reasons why CPU idle states may be disabled: either
> because the driver has disabled them or because they have been
> disabled by user space via sysfs.
>
> In the former case, the state's "disabled" flag is set once during
> the initialization of the driver and it is never cleared later (it
> is read-only effectively).

for x86 (intel_idle and acpi_idle), no states with disabled=1 are  registered
with cpuidle.  Instead, intel_idle (currently) skips them in the loop
that registers states.
(and acpi_idle never touches the disabled field)

And so for x86, governors checking for drv->states[i].disabled is a NOP,
and the condition described by CPUIDLE_STATE_DISABLED_BY_DRIVER
does not (yet) exist.

Looking at the ARM code, it seems that cpuidle-imx6q.c and cpuidle-tegra20.c
reach into the cpuidle states at run time and toggle the
drv->states[i].disabled.

It seems that this patch takes the initial value of
drv->states->disabled, and sets the (per cpu)
usage.disable=..BY_DRIVER,
but that subsequent run-time toggles in drv->states[i]disabled by
these drivers would be missed,
because you're removed the run-time checking of drv->states->disabled?

Finally, I'd like to change intel_idle so that it *can* register a
state that is disabled, by default.
If I change the driver to NOT skip registering disabled states, and
the cpuidle copy has cpuidle_state.disabled=1,
then the state is indeed, unused at run-time.  But as you said,
it is effectively read-only, and is not indicated in sysfs, and can
not be changed via sysfs.

One way to do this is to do what you do here and initialize
usage.disabled to drv->state.disabled. (not distinguishing between
DRIVER and USER)
That way the user could later over-ride what a driver set, by clearing
the disabled attribute.

However, the ARM drivers, at least, seem to want to reserve the right
to set and clear the drv->state.disabled,
and to have them continue to have that right, we have to continue
checking that field at run-time.
And giving drivers the opportunity to do that disabling driver-wide,
instead of per-cpu (usage) wide,
seems to be something we may want to keep.

-Len


-- 
Len Brown, Intel Open Source Technology Center
