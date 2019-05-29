Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA59C072B1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012ED206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="LG/0YABP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfE2BhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:37:15 -0400
Received: from onstation.org ([52.200.56.107]:41496 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfE2BhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:37:14 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 99F293E93F;
        Wed, 29 May 2019 01:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1559093834;
        bh=tyVLy2ENuden01IXz/hRN+5ZbuMQKZkszz/9C9/ss6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LG/0YABPiyqLpHWPuJMPvOkQV/U7VNgOKLIFW04Hosc+5wdS0fcws/Am9pUUgJZs7
         h78vCOJhG4lEEGCFMiDcxY7jINAPhgKM6OnmqWmUIx3D0EDbh5q10fNu5P06I9oS3A
         C3X8vsq4QxvUZ1aIxVZE1fuAOSwTiCyLGHa0ObeA=
Date:   Tue, 28 May 2019 21:37:13 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dave Airlie <airlied@linux.ie>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        freedreno@lists.freedesktop.org
Subject: Re: [Freedreno] [PATCH RFC v2 0/6] ARM: qcom: initial Nexus 5
 display support
Message-ID: <20190529013713.GA13245@basecamp>
References: <20190509020352.14282-1-masneyb@onstation.org>
 <CACRpkda-7+ggoeMD9=erPX09OWteX0bt+qP60_Yv6=4XLqNDZQ@mail.gmail.com>
 <20190529011705.GA12977@basecamp>
 <CAOCk7NrRo2=0fPN_Sy1Bhhy+UV7U6uO5aV9uXZc8kc3VpSt71g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCk7NrRo2=0fPN_Sy1Bhhy+UV7U6uO5aV9uXZc8kc3VpSt71g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 07:32:14PM -0600, Jeffrey Hugo wrote:
> On Tue, May 28, 2019 at 7:17 PM Brian Masney <masneyb@onstation.org> wrote:
> >
> > On Tue, May 28, 2019 at 03:46:14PM +0200, Linus Walleij wrote:
> > > On Thu, May 9, 2019 at 4:04 AM Brian Masney <masneyb@onstation.org> wrote:
> > >
> > > > Here is a patch series that adds initial display support for the LG
> > > > Nexus 5 (hammerhead) phone. It's not fully working so that's why some
> > > > of these patches are RFC until we can get it fully working.
> > > >
> > > > The phones boots into terminal mode, however there is a several second
> > > > (or more) delay when writing to tty1 compared to when the changes are
> > > > actually shown on the screen. The following errors are in dmesg:
> > >
> > > I tested to apply patches 2-6 and got the console up on the phone as well.
> > > I see the same timouts, and I also notice the update is slow in the
> > > display, as if the DSI panel was running in low power (LP) mode.
> > >
> > > Was booting this to do some other work, but happy to see the progress!
> >
> > Thanks!
> >
> > I've had three people email me off list regarding the display working on
> > 4.17 before the msm kms/drm driver was converted to the DRM atomic API so
> > this email is to get some more information out publicly.
> >
> > I pushed up a branch to my github with 15 patches applied against 4.17
> > that has a working display:
> >
> > https://github.com/masneyb/linux/commits/display-works-4.17
> >
> > It's in low speed mode but its usable. The first 10 patches are in
> > mainline now and the last 5 are in essence this patch series with the
> > exception of 'drm/atomic+msm: add helper to implement legacy dirtyfb'.
> > There's a slightly different version of that patch in mainline now.
> >
> > I'm planning to work on the msm8974 interconnect support once some of
> > the outstanding interconnect patches for the msm kms/drm driver arrive
> > in mainline. I'd really like to understand why the display works on
> > 4.17 with those patches though. I assume that it's related to the
> > vblank events not working properly? Let me preface this with I'm a
> > total DRM newbie, but it looked like the pre-DRM-atomic driver wasn't
> > looking for these events in the atomic commits before the migration?
> > See commit 70db18dca4e0 ("drm/msm: Remove msm_commit/worker, use atomic
> > helper commit"), specifically the drm_atomic_helper_wait_for_vblanks()
> > call that was added.
> 
> Do you know if the nexus 5 has a video or command mode panel?  There
> is some glitchyness with vblanks and command mode panels.

Its in command mode. I know this because I see two 'pp done time out'
messages, even on 4.17. Based on my understanding, the ping pong code is
only applicable for command mode panels.

Brian
