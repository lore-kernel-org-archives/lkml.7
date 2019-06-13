Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5DBC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0119B21743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eh7V3O2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfFMRLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:11:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42425 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbfFMRLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:11:11 -0400
Received: by mail-io1-f65.google.com with SMTP id u19so18586237ior.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N3qDAZwZqxC4UyoOIhHYUwzcDbIARMSiLNJ2yGeLMdo=;
        b=eh7V3O2aS38SAwQ5ws7fCcM7k/UGKK1pP/guCl6amGOoSv8xMO9mPsRkemReTxX0f8
         xx2EFqshWI2oxUvWtdGYfHdPvA4wmPke6q3t7/A+3I3LDk7zsS9F7tRilD1IE3CCGdv+
         Lcq6hOJvrpMk5XoUy+dh7WdmHsy5baVaSzp90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N3qDAZwZqxC4UyoOIhHYUwzcDbIARMSiLNJ2yGeLMdo=;
        b=PG2Lju5M9tcjyVX4763jOXl2GZ/rzthdnh1y+fpFzcK9ff+L2aNSspCzWh55FmkDf7
         LA63wba0B4LrcYFv1oz08QuzQicCEPJzOPiVBUfAuUKE7MMMsxNlqh/ZfKCKQqE/dnor
         EYynYPgTnMkGcXw6xebuw+DnGAYN62JtGBwzj1oG9i4CWmjEjUTdZ+wD7pNSXueCrdK1
         dSAd0d1b06lXIIDNW4HPc3SCEeulG3EBGAl6w9HCJrqLVpXZt3xEVzgDmVI/5EQV7Agm
         xYxwqUaX0mNmV9UMPhJVu8Zd41RsrQW7M/GhdK5ehbIYhcWD73hPz6I92u+QBwXDR5nm
         ujfA==
X-Gm-Message-State: APjAAAXFiEZ/v+rYEkIeHZcSaqRhR4caBP9U515oko5urJF/vb61mE6O
        +Mp2OXGJj+5TmGd45hUF2zkJQK5Aw9Q=
X-Google-Smtp-Source: APXvYqwKI9JJlHH/Fd6aAVGToPH39afTm2kWuknhrq+yXwOVJD9dCOE3CeAlsc1z99HFNxEg8poLyA==
X-Received: by 2002:a6b:6012:: with SMTP id r18mr9095233iog.241.1560445870261;
        Thu, 13 Jun 2019 10:11:10 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id q1sm528722ios.86.2019.06.13.10.11.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 10:11:09 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id m24so18611966ioo.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:11:09 -0700 (PDT)
X-Received: by 2002:a5e:8f08:: with SMTP id c8mr1658529iok.52.1560445869195;
 Thu, 13 Jun 2019 10:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <c2e6af51-5676-3715-6666-c3f18df7b992@free.fr> <CAK8P3a1_WvHYW243MR5-NdFm3cSt+cVGM5EJmOM8uiQMQ3vQjQ@mail.gmail.com>
 <a732f522-5e65-3ac4-de04-802ef5455747@free.fr> <CAD=FV=U+Ky1bAuAuuY+eBdTP9U3kbuH0tfwyN0Zs-iw0GNUFyQ@mail.gmail.com>
 <13cb7357-0d10-fe43-bee1-b2142d01684c@free.fr>
In-Reply-To: <13cb7357-0d10-fe43-bee1-b2142d01684c@free.fr>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Jun 2019 10:10:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xb1kum3z72Gzt1ROMJWNkkscAMgMkcXEFqnovOVbv=5Q@mail.gmail.com>
Message-ID: <CAD=FV=Xb1kum3z72Gzt1ROMJWNkkscAMgMkcXEFqnovOVbv=5Q@mail.gmail.com>
Subject: Re: [PATCH v1] iopoll: Tweak readx_poll_timeout sleep range
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Thu, Jun 13, 2019 at 9:37 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wro=
te:
>
> On 13/06/2019 18:11, Doug Anderson wrote:
>
> > On Thu, Jun 13, 2019 at 9:04 AM Marc Gonzalez wrote:
> >
> >> Hmmm, I expect the typical use-case to be:
> >> "HW manual states operation X completes in 100 =C2=B5s.
> >> Let's call usleep_range(100, foo); before hitting the reg."
> >>
> >> And foo needs to be a "reasonable" value: big enough to be able
> >> to merge several requests, low enough not to wait too long after
> >> the HW is ready.
> >>
> >> In this case, I'd say usleep_range(100, 200); makes sense.
> >>
> >> Come to think of it, I'm not sure min=3D26 (or min=3D50) makes sense..=
.
> >> Why wait *less* than what the user specified?
> >
> > IIRC usleep_range() nearly always tries to sleep for the max.  My
> > recollection of the design is that you only end up with something less
> > than the max if the system was going to wake up anyway.  In such a
> > case it seems like it wouldn't be insane to go and check if the
> > condition is already true if 25% of the time has passed.  Maybe you'll
> > get lucky and you can return early.
> >
> > Are you actually seeing problems with the / 4, or is this patch just a
> > result of code inspection?
>
> No actual issue. I just ran into a driver calling:
>
>         readl_poll_timeout(status, val, val & mask, 1, 1000);
>
> and it seemed... unwise(?) to call usleep_range(1, 1);
>
> But if, as you say, usleep_range() aims for the max

It was certainly what we found in:

https://lkml.kernel.org/r/1444265321-16768-6-git-send-email-dianders@chromi=
um.org

...in fact, at one point in time I had a patch cooked up that would
change the behavior during boot where (presumably) we'd rather boot
faster.  ...but after fixing dwc2 it didn't actually have much of an
impact elsewhere.


> then I guess it's
> not a big deal to issue an early read or 3... Meh

IMO it seems like the driver should be fixed.  It should either specify:

a) the (well defined) 0 for the delay, which means no delay.

b) a more sane delay


-Doug
