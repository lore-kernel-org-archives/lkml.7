Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B800C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 16:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E95206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 16:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tekFZI5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfLaQrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 11:47:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37101 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 11:47:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so35637110edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 08:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cGsByFr4h/gn5GTGed+TWKDlfh+tiGQaOBrL5+LciQ=;
        b=tekFZI5vkkt/vDaFdbyXiQ9T9oK543WnjVXoBu2WSNurH2ETaVpPDmsqM/K4vBR/SZ
         QJ9dLI0sWWF7sZt8UB0IgZ9v6sVztJashLl+a+gl5iZq+106TIB6ZxD1SvOu/zmktekT
         PK+wiOiqUfIlKDh8Kx+4Vkthdbov7erfXrdeg7QSQUADqffINId63yD2I8/yhnGoYU44
         Q/uI1s2ZzJ6YVG472BaPdUKx7qXSBEI5Pea9VlVAR95W9Qly/Z+jEFDp/D7AicBTDVir
         PCRXo3PikLY/zOOZKEFuW6wWRvo5r6hpX65ZhrES6wnNDVWK1AWuc/cwHvqDBVHnKmTQ
         ipNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cGsByFr4h/gn5GTGed+TWKDlfh+tiGQaOBrL5+LciQ=;
        b=kTM7CaqW9xFqAiM86CBzoEMiXoALlyt1y8CwPRnAK0GHhU2HT+F7erg5LlalHU6dsD
         cpwa5BFpUZ6xzyhv8WdHrxrkeBG35v1pmTazEC38frIuNW8qF7m8QZ8oFhAwLcSsfXl+
         HlwOnSF62ib/kXsP14cxs0+wOupoZRMMErGcS7R440ImDRPWJrK4fjupfF1GNUCoztiV
         XjgIxnwlpUkDny+2Mg+ondyE8u1dtn2CVYD1z9jHNohfRZyph5dzfUPwez0hoyQOUKQe
         o+6xIG6UIxnPGG5Q6rZqQTg9fyo0uIt00NMEjjfPT7WsjNuhoeERxQsjWmRpm/1j3hpE
         AF7g==
X-Gm-Message-State: APjAAAU2vMgBzLM7Ok9KZ3OjnRkPEh0wGpPoHr9nl6MjaakTnvUwVBpN
        vuqbVHdjMK3jEB3aXsvHfYzrWljFcJoVEdhEDw0=
X-Google-Smtp-Source: APXvYqyPr5J81gQPrQoYCkT+1zBN3nq2chGdkSn9ZwIahevBNVTzIArSqt56/oLThVzZHDREzBC0RWi6Rgxu34poChg=
X-Received: by 2002:a50:fb96:: with SMTP id e22mr77460467edq.18.1577810870473;
 Tue, 31 Dec 2019 08:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20191227173707.20413-1-martin.blumenstingl@googlemail.com>
 <20191227173707.20413-2-martin.blumenstingl@googlemail.com>
 <dd38ff5c-6a14-bb6a-4df5-d706f99234e9@arm.com> <CAFBinCDs3a8TJcQKgHUkDvssMR6Y2Kys38p50P0q=2KOiDTNHg@mail.gmail.com>
 <fe45f4f8-8c67-ded2-90bf-8d5fd6874876@arm.com> <CAFBinCByzLLdVTL0v=eC-TbZQnwnDY7cBLf4jyWq7N4PA1rr+A@mail.gmail.com>
 <ff2bdd26-3c34-63db-beb5-8f7c9fc7e790@arm.com>
In-Reply-To: <ff2bdd26-3c34-63db-beb5-8f7c9fc7e790@arm.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 31 Dec 2019 17:47:39 +0100
Message-ID: <CAFBinCAgzHJQpcf1WVQPkNXOq1ziXp7nx=ZAU9_2-VzA9hg-Yw@mail.gmail.com>
Subject: Re: [RFC v2 1/1] drm/lima: Add optional devfreq support
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     yuq825@gmail.com, dri-devel@lists.freedesktop.org, robh@kernel.org,
        tomeu.vizoso@collabora.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        linux-rockchip@lists.infradead.org, wens@csie.org,
        alyssa.rosenzweig@collabora.com, daniel@ffwll.ch,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, Dec 31, 2019 at 5:40 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2019-12-31 2:17 pm, Martin Blumenstingl wrote:
> > Hi Robin,
> >
> > On Mon, Dec 30, 2019 at 1:47 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2019-12-29 11:19 pm, Martin Blumenstingl wrote:
> >>> Hi Robin,
> >>>
> >>> On Sun, Dec 29, 2019 at 11:58 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >>>>
> >>>> Hi Martin,
> >>>>
> >>>> On 2019-12-27 5:37 pm, Martin Blumenstingl wrote:
> >>>>> Most platforms with a Mali-400 or Mali-450 GPU also have support for
> >>>>> changing the GPU clock frequency. Add devfreq support so the GPU clock
> >>>>> rate is updated based on the actual GPU usage when the
> >>>>> "operating-points-v2" property is present in the board.dts.
> >>>>>
> >>>>> The actual devfreq code is taken from panfrost_devfreq.c and modified so
> >>>>> it matches what the lima hardware needs:
> >>>>> - a call to dev_pm_opp_set_clkname() during initialization because there
> >>>>>      are two clocks on Mali-4x0 IPs. "core" is the one that actually clocks
> >>>>>      the GPU so we need to control it using devfreq.
> >>>>> - locking when reading or writing the devfreq statistics because (unlike
> >>>>>      than panfrost) we have multiple PP and GP IRQs which may finish jobs
> >>>>>      concurrently.
> >>>>
> >>>> I gave this a quick try on my RK3328, and the clock scaling indeed kicks
> >>>> in nicely on the glmark2 scenes that struggle, however something appears
> >>>> to be missing in terms of regulator association, as the appropriate OPP
> >>>> voltages aren't reflected in the GPU supply (fortunately the initial
> >>>> voltage seems close enough to that of the highest OPP not to cause major
> >>>> problems, on my box at least). With panfrost on RK3399 I do see the
> >>>> supply voltage scaling accordingly, but I don't know my way around
> >>>> devfreq well enough to know what matters in the difference :/
> >>> first of all: thank you for trying this out! :-)
> >>>
> >>> does your kernel include commit 221bc77914cbcc ("drm/panfrost: Use
> >>> generic code for devfreq") for your panfrost test?
> >>> if I understand the devfreq API correct then I suspect with that
> >>> commit panfrost also won't change the voltage anymore.
> >>
> >> Oh, you're quite right - I was already considering that change as
> >> ancient history, but indeed it's only in 5.5-rc, while that board is
> >> still on 5.4.y release kernels. No wonder I couldn't make sense of how
> >> the (current) code could possibly be working :)
> >>
> >> I'll try the latest -rc kernel tomorrow to confirm (now that PCIe is
> >> hopefully fixed), but I'm already fairly confident you've called it
> >> correctly.
> > I just tested it with the lima driver (by undervolting the GPU by
> > 0.05V) and it seems that dev_pm_opp_set_regulators is really needed.
> > I'll fix this in the next version of this patch and also submit a fix
> > for panfrost (I won't be able to test that though, so help is
> > appreciated in terms of testing :))
>
> Yeah, I started hacking something up for panfrost yesterday, but at the
> point of realising the core OPP code wants refactoring to actually
> handle optional regulators without spewing errors, decided that was
> crossing the line into "work" and thus could wait until next week :D
I'm not sure what you mean, dev_pm_opp_set_regulators uses
regulator_get_optional.
doesn't that mean that it is optional already?


Martin
