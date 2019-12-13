Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB589C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 04:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913152077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 04:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="Xd8DQt15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfLMEkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 23:40:02 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33880 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbfLMEkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:40:01 -0500
Received: by mail-vs1-f67.google.com with SMTP id g15so714501vsf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 20:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CxeVqN7WWZohGfBayl/KWuS+nYYVkIE8W26755ehKCA=;
        b=Xd8DQt15TEBmxWpqEeFCaZoe21s55+mSfnHvGFbeg9bLiJ4j2h7SwH/XTEnp71SZ73
         ZycLWokcoyu6sa1FpY+Cp/3bpEv6zhBoxym148EovHuBbxuNKgMQ3HWQ4/pGAW/uLys1
         EjlFXNvx268C+i6hj8eUxzu6EhiaZpm2FXPGeQisLNs1x9n9fA+S4tIy/K9NHr8HqDul
         i+xP23j6KawDG6n3PHOzmU5XCvlvLmK+bI73YmqPxIqiqX2mHYKcgr5vWMpd4/8+P5kD
         QBDviVVz2Bm3DBv/4SWXC7IX0nsU58spJx/zGps/ni5b++qgOVZ8QyJDKph5jCvl/hXk
         VqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CxeVqN7WWZohGfBayl/KWuS+nYYVkIE8W26755ehKCA=;
        b=OSvZm5dHeSgBcdmmlp8Dl/C0L6FmQjfWao2Jm3o3nVcVhdjn+NSHiJGN54P0GCUtAC
         Qx+xGrjTrDNZRdYuVa+kYlgk1OB0m/oUFsR94PU+0cQYfK7fyTS/ZLsniBjC9hSX6PiK
         qnV5G+rE4BRkl5UO7A75dUZLWnhyn61Be/Zh619wMjdOdIzOQeV6UhcC7nXy+7TGRfbl
         O8XzrwCDCqMTxnu1rYf4lBO9/4ptDwZ5+V9H7pIdnr63f/t7G7PDr8BAsprbx4KgbTyo
         sUd64asV9ZqWqDcyNc0++t/t8kxKZgdBHsLJP2ZruDUN/YitILCvObFc6iE5wL18UTEA
         tztw==
X-Gm-Message-State: APjAAAWbUUUTuM+T9MuAfhY9+KYodUmg6s2aNqG/G9fh3AYr++3rTXJ4
        TtHv8f8NKcefcVx/v3Qt7SxfU+uKehrXw6Ogzbwgbg==
X-Google-Smtp-Source: APXvYqxUYboYxgAx3u/cwl+SWhpsV25Tto1uX65RitUNLoAbztqqRzfRir+y4ljY/5uoG9B0ULKQhDBoKIKecfbYkX0=
X-Received: by 2002:a67:fb41:: with SMTP id e1mr9415848vsr.159.1576212000836;
 Thu, 12 Dec 2019 20:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20191212061702.BFE2D6E85603@corona.crabdance.com>
 <CAHLCerOHjAEEA1BpUqPdZvFwHMy11SqC+ZtjdFyManu7iOpBXA@mail.gmail.com>
 <20191212232859.E09FC6E85603@corona.crabdance.com> <CAHLCerN9jc94ydKKoaDZPoTy=LmVZti6UUpND5aK3FMzTkCmoA@mail.gmail.com>
In-Reply-To: <CAHLCerN9jc94ydKKoaDZPoTy=LmVZti6UUpND5aK3FMzTkCmoA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 13 Dec 2019 10:09:49 +0530
Message-ID: <CAHLCerMf1nbuxjZz81QnE6jXeQ5UvB=R18SDu69cE9Q6rQp8+w@mail.gmail.com>
Subject: Re: [RESEND PATCH] thermal: rockchip: enable hwmon
To:     schaecsn@gmx.net, jdelvare@suse.com, linux@roeck-us.net
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        lakml <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Guenter's email.

On Fri, Dec 13, 2019 at 10:08 AM Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
>
> Hi Stefan,
>
> On Fri, Dec 13, 2019 at 4:59 AM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
> >
> > Hello Amit,
> >
> > > On Thu, Dec 12, 2019 at 11:47 AM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
> > > >
> > > > By default, of-based thermal drivers do not enable hwmon.
> > > > Explicitly enable hwmon for both, the soc and gpu temperature
> > > > sensor.
> > >
> > > Is there any reason you need to expose this in hwmon?
> >
> > Why hwmon:
> >
> > The soc embedds temperature sensors and hwmon is the standard way to expose
> > sensors.
>
> Let me rephrase - is there something in the hwmon subsystem that is
> needed that isn't provided by the thermal subsystem inside
> /sys/class/thermal?
>
> > Sensors exposed by hwmon are automagically found by userland clients. Users
> > want to run sensors(1) and expect them to show up.
> >
>
> That is a good point. In which case, I wonder if we should just fix
> this in of-thermal.c instead of requiring individual drivers to do
> write boilerplate code. I'm thinking of a flag that the driver could
> set to enable the thermal_hwmon interface for of-thermal drivers.
>
> > Why in rockchip_thermal.c:
> >
> > drivers/thermal/ provides a high-level hwmon api in thermal_hwmon.[hc] which is
> > used by at least these thermal drivers: rcar_gen3_thermal.c, rcar_thermal.c,
> > st/stm_thermal.c, and broadcom/bcm2835_thermal.c. I want to hook up
> > rockchip_thermal.c exactly the same way.
> >
> > Apparently, other architectures hook up the cpu temperature sensors to hwmon
> > elsewhere. Most seem to do this in hwmon/, e.g. hwmon/coretemp.c. These drivers
> > are written from scratch. Utilizing thermal_hwmon.[ch] for chips which have
> > already drivers in drivers/thermal/ seems to be more elegant.
> >
> >  Stefan
