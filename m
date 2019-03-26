Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E6FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F9520823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbfCZNRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:17:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38202 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZNRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:17:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so9755804qth.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 06:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4J2pUja7yQCOBPtzRhzCuOwHzcJHjeyBts/dk/OYpQg=;
        b=EjFi2pXugjo7oiTO8SqyFtLzUDIT3Rlzww/VL9dwPFq7EF4Ha4M11c6HMKqQyY7HUm
         2AtfIh+6i+sIIPWla4XQz7lWWsKt/BUWO/9L5G1GI8PVECJ7yLR0c1gTUwRskxNPYpWE
         ooxkTWPmr0tlJAwzGDf67JaU7aLGpJVBJfn2EP4AbiQVOjKL9Ntk6RygrVTVShTsNJhM
         +59/fuJbQX4v4Kogc3tJGEyDb0BpkuAy/jMTviuk9EnpajrpV8geKS0spG8e6IF5pcoJ
         giHGMrR4T80vMI2A+3jJw/IhNCs6+9J6g+MR8o0ogqxYCSupJPdamznkYReZcXsVzTbL
         /dTg==
X-Gm-Message-State: APjAAAWyS+Vp74HHg1dNS8sm0zcGfDSbTAy6OxNFV/sFDSL2hAQbpWFS
        9CHNWoUnxA4cBTKAZ3zVJ3SviOW8VZkUxI7JZR4=
X-Google-Smtp-Source: APXvYqygt2kNepjI8Xn1snsSp4yLtPPf7jtVLDhVovgckWRoOlEiwSrnCx+OEloXSDyg23A61o92H7/2sllCIzb4EOI=
X-Received: by 2002:a0c:9487:: with SMTP id j7mr24698045qvj.180.1553606225300;
 Tue, 26 Mar 2019 06:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1903231125480.2157@nanos.tec.linutronix.de>
 <20190326092607.GE14186@localhost> <alpine.DEB.2.21.1903261329040.1789@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903261329040.1789@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Mar 2019 14:16:47 +0100
Message-ID: <CAK8P3a0PSSvYGS7fwg7iT0tu6njBnuFKq7MFqJcA2hJ1-RmmHw@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Force upper bound for setting CLOCK_REALTIME
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 1:31 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 26 Mar 2019, Miroslav Lichvar wrote:
> > On Sat, Mar 23, 2019 at 11:36:19AM +0100, Thomas Gleixner wrote:
> > > It is reasonable to force an upper bound for the various methods of setting
> > > CLOCK_REALTIME. Year 2262 is the absolute upper bound. Assume a maximum
> > > uptime of 30 years which is plenty enough even for esoteric embedded
> > > systems. That results in an upper bound of year 2232 for setting the time.
> >
> > The patch looks good to me.
> >
> > I like this approach better than using a larger value closer to the
> > overflow (e.g. one week) and stepping the clock back automatically
> > when the clock reaches that time, but I suspect it might possibly
> > break more tests (or any unusual applications messing with time) as a
> > much larger interval is now EINVAL.
>
> I'm fine with breaking a few tests on the way rather than having undefined
> behaviour and the constant flow of patches tackling the wrong end of the
> stick.

I think the one downside of your approach is that it introduces a second
arbitrary cut-off point after which the system almost functions perfectly,
but is no longer able to do ntp updates or set the right time after a reboot.

That said, all other ideas I've managed to come up with are worse,
 so I agree on going ahead with this version.

We could still bikeshed over the exact cutoff time, as the one you
picked isn't particularly intuitive. It's almost exactly 30 years before
the final end point, but your calculation is off by a few days because
of leap years. And no, I don't have a particular preference for any
other color of this bikeshed either, it's probably as good as any other
time within 20 years of what you suggested.

          Arnd
