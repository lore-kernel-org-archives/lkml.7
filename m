Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717DEC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED3E2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbfIPQ3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:29:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38852 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfIPQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:29:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so556083ljn.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 09:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7narMV9OTYNzOroVWgFd4nRfpeAHkS1DELxNwsQgU8=;
        b=Jpu6K3gyTTR08ClLo50pc+QB7ojG2xHfUKt/66SvkrjYKNv/WrdrqPep0DNH+rR1Z+
         69RUjZPS2BsoQOAsbiVRG3Yl9w3GCd3s8inPytWxwEHAFbG2QgHHR2F1GIZHDySnCyIn
         RNaT/0AQnEyrcJeRa6SgigrRYoSWiZcP0n7TnZeOKl48wEcLmOXhV5vCGDlxSOdJdZ2A
         7aA+nCaZUUMEfuXwIvvY4Gw+WF4q9RuuBqgQjSPyOYYB4pqzpa3jtFA5mQ6mQ1cK166f
         SNI2N+mSWY08xPiJQo0xnLx4AOVe1siPoe2jvhow3R3T7W9esGEsHwX5//T9P6Jb5Zwx
         POJg==
X-Gm-Message-State: APjAAAU7YUA55TRd4b1hEnRYqkDWn6fdgY50aWfa5m0XCiZYh4caLRLF
        0gBvpsaboamAlVzSNmcXVBgbZUe+lTFfwoM/RxA=
X-Google-Smtp-Source: APXvYqwMsOkcphhHTKrF/EiIRSmSKA/fSeeY5GxccGZwHcDrzfqwChNKVRKp/+O1sWchWQ8cn4aBT54W+P4bLyjfZG0=
X-Received: by 2002:a2e:a316:: with SMTP id l22mr101468lje.211.1568651386857;
 Mon, 16 Sep 2019 09:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20170130110512.6943-1-thierry.reding@gmail.com>
 <20190914152544.GA17499@roeck-us.net> <CAK8P3a3G_9EeK-Xp7ZeA0EN7WNzrL7AxoQcNZ8z-oe5NsTYW6g@mail.gmail.com>
 <056ccf5c-6c6c-090b-6ca1-ab666021db48@roeck-us.net> <20190916134920.GA18267@ulmo>
 <20190916154336.GA6628@roeck-us.net> <20190916155031.GE7488@ulmo>
In-Reply-To: <20190916155031.GE7488@ulmo>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Sep 2019 18:29:30 +0200
Message-ID: <CAK8P3a1EZi5apOm90B6YW2GzFXsirz5wk-D66daR20oj_TLXNg@mail.gmail.com>
Subject: Re: [PATCH 0/6] ARM, arm64: Remove arm_pm_restart()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 5:50 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Mon, Sep 16, 2019 at 08:43:36AM -0700, Guenter Roeck wrote:
> > On Mon, Sep 16, 2019 at 03:49:20PM +0200, Thierry Reding wrote:
> > > On Mon, Sep 16, 2019 at 06:17:01AM -0700, Guenter Roeck wrote:
> > > > On 9/16/19 12:49 AM, Arnd Bergmann wrote:
> > > > > On Sat, Sep 14, 2019 at 5:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > On Mon, Jan 30, 2017 at 12:05:06PM +0100, Thierry Reding wrote:
> > > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > > >
> > > > > > > Hi everyone,
> > > > > > >
> > > > > > > This small series is preparatory work for a series that I'm working on
> > > > > > > which attempts to establish a formal framework for system restart and
> > > > > > > power off.
> > > > > > >
> > > > > > > Guenter has done a lot of good work in this area, but it never got
> > > > > > > merged. I think this set is a valuable addition to the kernel because
> > > > > > > it converts all odd providers to the established mechanism for restart.
> > > > > > >
> > > > > > > Since this is stretched across both 32-bit and 64-bit ARM, as well as
> > > > > > > PSCI, and given the SoC/board level of functionality, I think it might
> > > > > > > make sense to take this through the ARM SoC tree in order to simplify
> > > > > > > the interdependencies. But it should also be possible to take patches
> > > > > > > 1-4 via their respective trees this cycle and patches 5-6 through the
> > > > > > > ARM and arm64 trees for the next cycle, if that's preferred.
> > > > > > >
> > > > > >
> > > > > > We tried this twice now, and it seems to go nowhere. What does it take
> > > > > > to get it applied ?
> > > > >
> > > > > Can you send a pull request to soc@kernel.org after the merge window,
> > > > > with everyone else on Cc? If nobody objects, I'll merge it through
> > > > > the soc tree.
> > > > >
> > > >
> > > > Sure, I'll rebase and do that.
> > >
> > > I've uploaded a rebased tree here:
> > >
> > >     https://github.com/thierryreding/linux/tree/for-5.5/system-power-reset
> > >
> > > The first 6 patches in that tree correspond to this series. There were a
> > > couple of conflicts I had to resolve and I haven't fully tested the
> > > series yet, but if you haven't done any of the rebasing, the above may
> > > be useful to you.
> > >
> >
> > Maybe Arnd can just use your branch (or rather part of it if you would
> > split it off) since you already did the work ?

The branch needs to be rebased once more as it is currently
based on linux-next.

> Yeah, I can just send the pull request for the 6 patches after -rc1.

Ok, sounds good. I'm also happy to take the remaining patches
in that branch, for the other architectures.

      Arnd
