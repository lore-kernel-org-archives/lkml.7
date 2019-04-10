Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78260C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400D1206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFBdFeP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfDJI0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:26:20 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:32989 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbfDJI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:26:19 -0400
Received: by mail-vk1-f195.google.com with SMTP id x194so377278vke.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C60e8J/901M0yAJl8d+mDMJW2gbbK7ZM+gdIk/nTZk8=;
        b=rFBdFeP7iFyWVDev+Fph9wEpmdEXlxySfCesz/Lj8qBriP8UZJIqvklEPjVyRsSr1k
         UX7hFiedRRtNNl5mr72ZcKbwqdJjarttOElJtO/JclvYTDlvHx1T1TjmAyHGeFdDcLkM
         BfcwX7lDtaD9WG4j4Qfi33hDDoIMJGOx1ow22q6ZB4hU4V30n/QJ/D6tbAxmsL4KPupI
         V1cLkQEVtOLjIFdUQeiaDvdTQwSzPP6VeQwdsUPsEp2u0+7lBB+dHwGK1/AMw9uM4+Sr
         pdtKSWWpymLO+m9kFsOgV0foioOREKpOtt6DUhiiz4Kx+g5Acl+trPgew6T5BhWtpjyi
         BTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C60e8J/901M0yAJl8d+mDMJW2gbbK7ZM+gdIk/nTZk8=;
        b=quUz/rX85NCW64g0JlgAvuJOGZ3iMg45xPzZIf9NKhDPCzr0AUCY4/pUWzo0grDKgx
         2n1N2NyKfg9r5i/tdiI7psN5u5mwIUMEFRsbdYJ55zageHZvjygqgi0d2Up9UPUFs5AP
         vnWmoLveiZkVK5Nf4H+WNxpzCVPyv/sRBahD9x2D5gnkMcJWPd8X/dfZCv7rvwycLBv2
         o1XspLsrrDmQS+9KA68zhTA+SkhC7gd9n++RQFytLCXwZAm8sZl7g/WZ8MewmANq0Zub
         3GPZRhaJwCIgmznivcaZIMxHMgHPc3yKu3h2Lsc62km6i9C/xcTMCjHjO676d626zLOK
         kAsg==
X-Gm-Message-State: APjAAAUh/0jkdWD1W6VPIBpwiPFotibhRZIeoSzRHWHmhSlLYlVs9pr5
        C+dK12VhVdScbErdRdpY+vmHIvr35s6CjZVnaHHH4g==
X-Google-Smtp-Source: APXvYqw3GyPpLGur74ddJXaEQwH5ZGzmVJzLKOqImGKXSFKdkKbRx7sVo5nxvisvHRi2BT/e7f7HfTCatBvLckAPcfs=
X-Received: by 2002:a1f:2c8:: with SMTP id 191mr22851733vkc.29.1554884778538;
 Wed, 10 Apr 2019 01:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190327143548.25305-1-ulf.hansson@linaro.org>
 <CAPDyKFqc9OeaCGrSu7toMcgZesN2xBqqWNQfqUt+4+FvQ4kmDw@mail.gmail.com> <CAJZ5v0g57V=tHdTJ2THLfTH_CbHQyS8xpNaeZUojPiHp=+gS4Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0g57V=tHdTJ2THLfTH_CbHQyS8xpNaeZUojPiHp=+gS4Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 10 Apr 2019 10:25:42 +0200
Message-ID: <CAPDyKFpjpLaYSqj23YV_HdNG9Tp485Omn4pVQQH_Cj8_k_E8WQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/4] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 at 17:01, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Apr 9, 2019 at 1:57 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 27 Mar 2019 at 15:35, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Changes in v13:
> > >  - Use WRITE|READ_ONCE when reading/writing the "next_hrtimer" variable in the
> > > struct cpuidle_device. Also reset the same variable after resumed from idle to
> > > avoid it from containing a stale value.
> > >  - Added acks from Daniel Lezcano.
> > >  - The entire v13 series, including the PSCI/ARM changes are available in a
> > > git branch [3].
> >
> > Rafael, I have address the received comments on this version $subject
> > series, is there anything that is holding you back from queuing it?
> >
> > If you like I can send a pull-request, to simplify for you.
>
> I will get to this one shortly.  I've been waiting for possible
> comments on patch [3/4], but since no one has commented so far, it
> seems to be non-controversial. :-)
>
> I'm going to add this material to the cpuidle branch rather than genpd.

Sound good to me, thanks!

>
> > Moreover, there is another series which I have pinged you about
> > earlier, which I would appreciate to queue via your tree. It's acked
> > by PSCI maintainers and is ready to go. "[PATCH v2 0/5] drivers:
> > firmware: psci: Some cleanup and refactoring".
>
> If you want me to merge the PSCI series, please resent it with a
> request to that end in the cover letter.  Also please let me know
> whether or not it depends on the $subject series.

No dependency, but I am using it as a base for a future series that I
will post as soon as you have queued it.

So, I have just resent the series, as per your request. If there is
anything else, just let me know.

Kind regards
Uffe
