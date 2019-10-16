Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC26FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066BA20663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yecjHGNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405457AbfJPNsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:48:23 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36349 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfJPNsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:48:23 -0400
Received: by mail-ua1-f65.google.com with SMTP id r25so7238744uam.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZczhRha9z1nsec5k7tudbJLt03HyH3VxjWdRdQFLkMs=;
        b=yecjHGNGAegoANYaWXbjqNsxcZY98ad90xKhK31I9DOTyeJZgCUmotpz3V/jznGqMn
         BYwrnpPhpWg1KxznTTq9FC6jFcYA0rKQX03A/vleQ9gsU/CJTA3St5eHCNU9xSuzJ5zK
         VgN60//LyDCJC7PzthpL510PVbOTU5Nl4UH2gAWH6mirijPOEdf/Va7Hc+ORzkX3Gnfs
         XsiPI00qHFIJEMK71BJcmZZefHq9zDpTo1TPIoXz4Az2/AcG/JZjZr7WdHlgDAswXIx6
         UMbregCoRGbVJZ8FCsiKkrAwNRyNk1y98nSx43akPsDVkiWEtjIFwUJinGbTKLOQsgmJ
         FP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZczhRha9z1nsec5k7tudbJLt03HyH3VxjWdRdQFLkMs=;
        b=tKlUNNwgSOSDo+ZR23btNLoQ2q6g6wXWxnKYwL8Qyh0O4Rje6BG6G7DzwjtLPpPyq7
         cvRM32wm42dI8Zk5qAvtFLWolYizERYaTYXmcQv2k/6HzJVEaVuaWwhT2JMVvaJsMbXq
         BsQbfJcw5seu3sN/VRBPER7uYJCvz+rcZVo6LT7H49InRjZk87MgCPYc9POpI6Ft/aXX
         Mon4HgZj1y1vcWp2YXvaa4/kk9DB/qTJ0vIOL8KwKxhzbnFiSDvJocUGR78WdmjyC1Pm
         fr5/nSSEKCOokpwTg/UDAYGuidyWBPRSbobJJ/FW7ZVJ8zLgmBd6ALEcxQs4wMu5d1GS
         BuOw==
X-Gm-Message-State: APjAAAXUSNLUzw7sRZmADtKGj2SKNoRoevufApscJrotKN7gI+eIls8q
        AVvi2WwC/wwapaFL0Cs8L5g9s7J5miS2wu48AKUYFw==
X-Google-Smtp-Source: APXvYqzDpJmGjL9BnoWGF8QRrB89KcB9r2ZCwEdZLc2zqHnhS1q/w4C+c6uMpxQU2nrpu5EyekFHa9wkYoswYcXPv3s=
X-Received: by 2002:ab0:5a97:: with SMTP id w23mr16874006uae.129.1571233701097;
 Wed, 16 Oct 2019 06:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
 <20190927044239.589e7c4c@oasis.local.home> <20191001163542.GB87296@google.com>
 <CAPDyKFrYqeoiSG5-KaBDt_G4kPtCxRO7+5fRa-HSWjuPPmAheQ@mail.gmail.com> <20191015171937.GO87296@google.com>
In-Reply-To: <20191015171937.GO87296@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Oct 2019 15:47:44 +0200
Message-ID: <CAPDyKFpE0LoxXAR=2JvPi8pvb-6_q4rgs-A4D6OU7XuP1XEtbg@mail.gmail.com>
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2019 at 19:19, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Ulf,
>
> On Tue, Oct 15, 2019 at 02:37:42PM +0200, Ulf Hansson wrote:
> > On Tue, 1 Oct 2019 at 18:35, Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > On Fri, Sep 27, 2019 at 04:42:39AM -0400, Steven Rostedt wrote:
> > > > On Thu, 26 Sep 2019 15:04:38 -0700
> > > > Matthias Kaehlcke <mka@chromium.org> wrote:
> > > >
> > > > > Define genpd_power_on/off and genpd_set_performance_state
> > > > > tracepoints and use them.
> > > >
> > > > I agree with Greg about adding a "why" you need this. But, in case
> > > > there's a good reason to have this, I have comments about the code
> > > > below.
> > >
> > > Thanks Greg and Steven for your comments.
> > >
> > > How about this instead:
> > >
> > >   Add tracepoints for genpd_power_on, genpd_power_off and
> > >   genpd_set_performance_state. The tracepoints can help with
> > >   understanding power domain behavior of a given device, which
> > >   may be particularly interesting for battery powered devices
> > >   and suspend/resume.
> >
> > Apologize for the delay, no excuse!
> >
> > I don't mind adding trace events, as long as it's for good reasons -
> > and to me, that seems a bit questionable here.
> >
> > According to the above, I believe the information you need is already
> > available via genpd's debugfs interface, no?
>
> Not in all cases, e.g. you can't peek at sysfs while the device is
> suspended.

Not sure I get this right. If a device that is attached to a genpd
that is runtime suspended, for sure you can have a look at the genpd
debugfs to see its current status.

> Also sysfs doesn't help much with seeing that a PD is
> toggling between on an off for some (possibly legitimate) reason.

Well, you could look at the "active_time" and the "total_idle_time"
nodes for the genpd in question. Those should change accordingly.

>
> At this point I don't need this information badly, just thought it
> could be useful. No problem if it is decided to hold back on it for
> now.

Okay, thanks!

Kind regards
Uffe
