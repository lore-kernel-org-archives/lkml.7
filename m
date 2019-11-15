Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8832C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CEB207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLqpNBBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfKORjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:39:35 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38079 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfKORjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:39:35 -0500
Received: by mail-vs1-f68.google.com with SMTP id u18so6067860vsg.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 09:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RpTiZrFmVPBZEcZ46f43o7iat50PORaCu40SzpCwYI=;
        b=PLqpNBBzekULk++LUZPtAlvG3lwko6LLYc4c1jvatw2k7pma1D5VNGLqzE6JSLxw7o
         318fTCmePl2JqBLNcYaDG4UlT/8QfXxbVValRfs68adk5LjWJbQy57N/FUaR24Al2gYv
         HIvCoJ9lFQ4UFzWMr4OWDqmEZLh+2M0k3wBvq0J5hS+CgvRuGp1xwUPPGPVT5FC6uml5
         NAB4jsOaiWsQDcHeXyYZDSXG+G5dlbJry3GEQjx+5awoi9KagJcqyHVyo2VkNI+yCOF1
         dROVl5WragAg66c74GsQ9yk0ZaDZT1mDVBEqRT+NqEPHCRS+0c5Uu+bpgoq/yd6FDtFk
         zcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RpTiZrFmVPBZEcZ46f43o7iat50PORaCu40SzpCwYI=;
        b=pmB8+DVrEZl1OQZNDxzWN3N97JJlG28ggJdy7Hv+foJ4sQOFleMAj4BQ4lgkU+VM4O
         GGl8Y+JYrUx4OS9vEIDTaGRo/GPH27VeKzXVVaRcBGtrwO/+apku/peftwnguyhaj5IA
         e4ascY1cFMofNUsSnUCP/JirLijoTQ7h2EjXcszg6yL4PTmc9lghU8/oVSeK4hUWHBoL
         QpZ2B7E83HODG82wsqLw2YwlijUyqH4L7uU5V6MqjxjOrAtgO38fcRn3FyAgw3nMbSZd
         5W6xfp7FPmGFl9fI/5l3m7e9C3CU8BGNhHvh36eMqVZpw4TX7ZUHNURcxhXNVtUUWssq
         yT9w==
X-Gm-Message-State: APjAAAUROf+Nw8iT6JldhnRY5rRQMEinsoiTgDDtceuarE9PgLOhsxQO
        dE1wRM3ISuN15opGB79yf20UTAcH3cWVYhuxQ8EcEw==
X-Google-Smtp-Source: APXvYqzVfJbR4XgUCrhL51J5+RQ1jSExXLEP0AQGxxO+Dih748VNGzEWgrs5J9HKzRruTtBcePNa/RiuvvMRjNquD3k=
X-Received: by 2002:a67:d49e:: with SMTP id g30mr11358730vsj.119.1573839572721;
 Fri, 15 Nov 2019 09:39:32 -0800 (PST)
MIME-Version: 1.0
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
 <CAPDyKFoZEc-m7NMnaAa5bjtCSp4wyJqic3cLHk95xracoWcCUA@mail.gmail.com> <5c78cc29-deb1-4cea-5b30-6f7538ca4703@codeaurora.org>
In-Reply-To: <5c78cc29-deb1-4cea-5b30-6f7538ca4703@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 15 Nov 2019 09:39:19 -0800
Message-ID: <CAD=FV=W+JbeF7yKk6Vup=5-MSbYC8qq5rm176hZk2WdiFwA3qg@mail.gmail.com>
Subject: Re: [RFC 0/6] mmc: Add clock scaling support for mmc driver
To:     Ram Prakash Gupta <rampraka@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        cang@codeaurora.org, ppvk@codeaurora.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 15, 2019 at 3:13 AM Ram Prakash Gupta
<rampraka@codeaurora.org> wrote:
>
> Each time the triggering point for scaling up/down is hit, then a
> series of commands needs to be sent to the card, including running the
> tuning procedure. The point is, for sure, this doesn't come for free,
> both from a latency point of view, but also from an energy cost point
> of view. So, whether this really improves the behaviour, seems like
> very use case sensitive, right!?
>
> With clock scaling support device mode would be switched between low speed
> (hs50 or ddr52) and high speed mode(hs400 enhanced strobe).

I haven't read the patches, but just from this description it feels
like the wrong way to go.  From my understanding if you're running at
HS400 then you can run the card at any speed between 0 and 200 MHz.  I
see no reason why you'd want to switch modes.  Just stay at HS400 and
slow down the clock, right?  Then you can keep the "Enhanced Strobe"
which makes everything more reliable.

If you're running on a system that doesn't have enhanced strobe you
_should_ still be able to switch clock speeds without switching modes
since the spec has just a _maximum_ clock frequency for each mode, so
HS200, DDR50, etc should all be able to run at slower speeds without
an official mode switch.  You also shouldn't have to re-tune.  Tuning
is nothing magical, it's just trying to find the delay between sending
a pulse on the clock line and when you read the data sent by the other
side.  Assuming your tuning delay is natively represented in "phase
offset", you can convert that back to an actual delay and then back to
"phase offset" for the new clock.

To further argue against switching modes, I would also note that for
SD cards switching to a slower speed mode may result in an increase in
IO voltage, which seems like it could be bad for power consumption?


> And from energy point of view, this feature is only helping in saving energy
> and not adding any energy penalty. And we have observed a considerable amount
> of power saving(data shared in mid) when playing 1080p video playback with
> clock scaling feature support.

I am slightly baffled about why this would save energy unless it
allows you to lower the voltage to the controller.  I know you _can_
sometimes lower the voltage to the controller on Qualcomm parts, but
you are arguing that it is useful even on systems that can't lower the
voltage.  That feels slightly questionable.  I would expect that
racing to idle (with the right tuning parameters) would be a better
way to go.

As a specific example, let's imagine we want to transfer 1000 MB of
data and we have 20 seconds with which to do it.  We can achieve this
by transferring 50 MB/s for the whole 20 seconds.  Alternatively, we
could transfer at 400 MB/s 2.5 seconds and then fully power gate the
eMMC for the next 17.5 seconds.

In that example, I'd wonder ask is more power efficient.  Presumably
the 2nd.  This is the whole "race to idle" concept as I understand it.

The "race to idle" is talked about a lot in the context of CPU
frequency decisions.  Presumably you'll point out that "race to idle"
is NOT the right thing to do for choosing a CPU frequency.  As I
understand it, this is primarily true because we need to raise the CPU
voltage to run at faster speeds.  This would lead me to believe that
the only case you'd want to do frequency scaling like this is if it
allows you to lower the voltage provided to the eMMC controller.  As
you said, for Qualcomm it _does_ allow you to do this, but most other
SoCs don't.  ...so unless there's a flaw in my logic (always
possible!) this patch series should be amended to say it's only useful
if it allows you to down-volt the controller.

Just to think a little bit more about my logic: of course, you might
argue that we can't just do a 1000 MB data transfer.  We can break
that down into two cases:

a) For writing, presumably the data is produced over time and you
don't want to buffer the whole 1000 MB and delay 17.5 seconds before
you start writing.  ...but presumably you could do _some_ buffering
and then break things into chunks where you ungate the clock to the
card, write a chunk out, and then re-gate the clock.  There will
obviously be some overhead with each clock gate/ungate, but
(hopefully) not too much.  ...and there will be time when data is in
RAM and not on the disk so you'd worry about power failure, but if you
want to get data on the disk ASAP why are you scaling the clock (and
thus delaying the data from getting to the disk) at all?  Maybe some
math?  How long does it take to ungate/gate the clocks.  1 ms?  It's
just flipping a bit, right?  ...and does assuming we can allocate a 40
MB write buffer seem sane?  So we eat 1 ms to ungate, 100 ms to
transfer 40 MB, 1 ms to gate.  Compared to transferring at 50 MB/sec
(w/ no gating), we'd transfer the same 40 MB in 800 ms.  So we either
keep the clock on at 50 MHz for 800 ms or we keep it on at 200 MHz for
102 ms and gate it for 698 ms.

b) If you're reading data then hopefully the system has some sort of
readahead going on.  In the "video playback" case the system should
have no problem predicting that if you've just read bytes
1,000,000,000 - 2,000,000,000 of a file over the last 10 seconds that
you're likely to keep reading the same file.  Presumably it wouldn't
be totally insane to read 40 MB ahead of time and then we can do the
same math as a).  If 40 MB is too much for readahead, then shrink it
and redo the math.  Even with much smaller numbers the "race to idle"
wins because gating / ungating clocks is fast.  ...or do you know some
reason why gating / ungating clocks needs to be slow?  If so, how
slow?


> Test case used are 1080p and 4k video playback use case. Please find below
> test case information and power impact data. In both the below video playback
> cases, a considerable amount of power savings can be observed with clock scaling
> feature.
>
> Use cases Delta at battery (mA) Power impact %
> 30 fps at HD 1080p decode 20 Mbps 10 mA 11%
> 30 fps at UHD 8b H.264 42 Mbps 20.93 mA 19%

Numbers like this are exactly what is needed to justify your patch
series.  ...but I'd be super curious to how it would compare to:

1) Tuning the runtime PM auto-suspend delay.  If you have your
auto-suspend delay set wrong (like 500 ms) then all the math above is
totally wrong.  We'll keep clocking at 400 MHz needlessly even though
there is no data to transfer.  If autosuspend is just gating clocks
then it feels like you could set it to 1 ms, or 10 ms.  NOTE: if
autosuspend for you is something more major (fully turning off power
rails to the eMMC) then maybe you need another level where you just
turn off the clocks.  Seems like we could find some way to make that
work.

2) Tuning any readached mechanism in your system.  If your system
somehow does zero readahead then obviously all my arguments don't work
for reads.  ...but why would you not have readahead?

3) Tuning any write buffering in your system.  Same argument as #2.

4) Making sure that when the MMC card clock is gated that you request
the lowest voltage level for the controller (and set the controller's
bus clock to the lowest level since it's not doing anything).


I would also be very interested to know how much of those savings are
achieved if you keep the voltage to the MMC controller the same.  In
other words do something that arbitrarily keeps the MMC controller
requesting the same voltage level from the rest of the system and then
do your power measurements.  How much do your savings change?


I will also note that aggressive clock gating is exactly what the
dw_mmc controller does automatically (except for SDIO, but that's a
different story).  Seeing that the controller itself can stop the
clock in dw_mmc gives further credence that gating / ungating the
clock is a very lightweight operation and 1 ms is probably an
over-estimation of how long it takes.


I guess one very last note is that I spent most of the time above
arguing that the clock scaling concept is probably not useful for any
SoCs where you can't adjust the voltage provided to the MMC
controller.  That doesn't necessarily mean that your patch series is
useful for SoCs where you can.  Specifically you'd need to do math to
see how much more power the MMC controller takes at the higher
voltage.  Then you can calculate a "perf per watt".  If the watts to
transfer data at 400 MB/s aren't 8 times more than the watts to
transfer at 50 MB/s then that's a ding against your idea.  You'd also
don't have a dedicated voltage rail, right?  So you'd have to see what
percentage of the time the MMC controller was the only thing in the
system that was requesting the higher voltage.  If it happened that
something else in the system was keeping the voltage higher anyway
then it would be better for you to run faster and race to idle.
Really I guess the case you're most worried about is if the MMC
controller is causing other components in the system to be at a higher
voltage point (and thus take up more power)...


Hope that all makes sense.  I can read the patches themselves if
needed--everything from above is just based on your cover letter and
discussion with Ulf.  ;-)


-Doug
