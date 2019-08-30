Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C5C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0E52186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVPTvMGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfH3E6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 00:58:42 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34327 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfH3E6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:58:42 -0400
Received: by mail-ot1-f43.google.com with SMTP id c7so5791224otp.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 21:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otaruv9LefKS//TBIlDQnjNiuW6KTPwtImDRK6ssut0=;
        b=YVPTvMGlcH01uTnYYmqDUhLpoNUvdfkrjOWSONoE//HewEvD6G+gfszJ2m7bXZDXzi
         LkC6wbKiVtzJgQMwCBbvQB67g+SFUCRXy3qkIsUJn0jv/8ce8eNu9LhdnalvYMmRgeX4
         PXkmY10YLl7WjZAm6IXJot6DohZhiRdnk4EL5hJ4+WEJHBtIipnf+mEP9DtUcnGpSVR+
         EMq+i+LB3ot7jf4ZtsX4Czgn2uPT5Rmp3b2Sf/m9EzRtRjebDkn2NbtjRHeqzCDIJHiO
         Tjjy8J2dpl6fhX2eaComfNcj9gfomIOh4l9Mg5MMuYMUm2bvuiF+sacYKgZb16CDPMNR
         oOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otaruv9LefKS//TBIlDQnjNiuW6KTPwtImDRK6ssut0=;
        b=ENppAC0fo1RMNOSrepkS4v4cB++TkHqDJQ3Erml0lGPcGgXqu8MxDninwOi118wPSw
         cLnXxXFCKF6OmdqZd36GC6X48iCgAsu0uupBMzzf/FpF8lNBtHJTIAW5KJRzdMzcdyvZ
         YHGINQSnb2a7E/Ofj2LRRhJPf9XMcIXjMdgoih2955ivfzwxVEOCXfDwkUapxdkVye9e
         NWuu38qmHWujRQi2c6gJ8HrBiq2+8OJLx2S5XIt/McYLC6bNljvBHrZ4k2RYpdOPE4uj
         Tb11W9etf5nVhpVi5t46z18WGy+S6HPVoNolVVVbk0Ff3XR0QgkopCWgoyY875ocbPw1
         9TIg==
X-Gm-Message-State: APjAAAUA28L6hRfSUM887+74Q+1Z9jgMsGWnv7dVh6n0+Xp+gg0Hrcjo
        cXgwmI4BpnIgHy3BzRf1+e9MnmLx3bjZyCLBWtu4wQ==
X-Google-Smtp-Source: APXvYqzSt6NNhsdCchPdX3qSuDp2k6hX88p0qYy4ZK+ape7vUHCkMYvJtodpyBpAWOKj0LwxR7h3DMOJbseD2+pcNO4=
X-Received: by 2002:a05:6830:54:: with SMTP id d20mr3109090otp.225.1567141120629;
 Thu, 29 Aug 2019 21:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx_pSnC_2D7ufLRyfE3b8uRc814XEf8zu+SpNtT7_Z8NLg@mail.gmail.com>
 <CAL_JsqKWcGSzCF_ZyEo6bbuayoYks51A-JAMp_oLR1RyTUzNUA@mail.gmail.com>
In-Reply-To: <CAL_JsqKWcGSzCF_ZyEo6bbuayoYks51A-JAMp_oLR1RyTUzNUA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 29 Aug 2019 21:58:04 -0700
Message-ID: <CAGETcx_RL4hHHA2MFTVyV1ivgghaBZePROXpnC-UUJ7tcH4kSQ@mail.gmail.com>
Subject: Re: Adding depends-on DT binding to break cyclic dependencies
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 9:28 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Aug 22, 2019 at 1:55 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Hi Rob,
> >
> > Frank, Greg and I got together during ELC and had an extensive and
> > very productive discussion about my "postboot supplier state cleanup"
> > patch series [1]. The three of us are on the same page now -- the
> > series as it stands is the direction we want to go in, with some minor
> > refactoring, documentation and naming changes.
> >
> > However, one of the things Frank is concerned about (and Greg and I
> > agree) in the current patch series is that the "cyclic dependency
> > breaking" logic has been pushed off to individual drivers using the
> > edit_links() callback.
>
> I would think the core can detect this condition. There's nothing
> device specific once you have the dependency tree. You still need to
> know what device needs to probe first and the drivers are going to
> have that knowledge anyways. So wouldn't it be enough to allow probe
> to proceed for devices in the loop.

The problem is that device links don't allow creating a cyclic
dependency graph -- for good reasons. The last link in the cycle would
be rejected. I don't think trying to change device link to allow
cyclic links is the right direction to go in nor is it a can of worms
I want to open.

So, we'll need some other way of tracking the loop and then allowing
only those devices in a loop to attempt probing even if their
suppliers haven't probed. And then if a device ends up being in more
than one loop, things could get even more complicated. And after one
of the devices in the loop probes, we still need to somehow figure out
the "bad" link and delete it so the last "good" link can be made
before all the suppliers have their sync_state() called (because the
"good" link hasn't been created yet). That all gets pretty messy. If
we are never going to accept any DT changes, then I'd rather go with
edit_links() and keep the complexity within the one off weird hardware
where there are cycles instead of over complicating the driver core.

> Once 1 driver succeeds, then you
> can enforce the dependencies on the rest.
>
> > The concern being, there are going to be multiple device specific ad
> > hoc implementations to break a cyclic dependency. Also, if a device
> > can be part of a cyclic dependency, the driver for that device has to
> > check for specific system/products in which the device is part of a
> > cyclic dependency (because it might not always be part of a cycle),
> > and then potentially have cycle/product specific code to break the
> > cycle (since the cycle can be different on each system/product).
> >
> > One way to avoid all of the device/driver specific code and simplify
> > my patch series by a non-trivial amount would be by adding a
> > "depends-on" DT binding that can ONLY be used to break cycles. We can
> > document it as such and reject any attempts to use it for other
> > purposes. When a depends-on property is present in a device node, that
> > specific device's supplier list will be parsed ONLY from the
> > depends-on property and the other properties won't be parsed for
> > deriving dependency information for that device.
>
> Seems like only ignoring the dependencies with a cycle would be
> sufficient.

No, we need to only ignore the "bad" dependency. We can't ignore all
the dependencies in the cycle because that would cause the suppliers
to clean up the hardware state before the consumers are ready.

> For example, consider a clock controller which has 2 clock
> inputs from other clock controllers where one has a cycle and one
> doesn't. Also consider it has a regulator dependency. We only need to
> ignore the dependency for 1 of the clock inputs. The rest of the
> dependencies should be honored.

Agreed. In this case, if the device used the depends-on property,
it'll have to list the 1 clock controller and the regulator.

> > Frank, Greg and I like this usage model for a new depends-on DT
> > binding. Is this something you'd be willing to accept?
>
> To do the above, it needs to be inverted.

I understand you are basically asking for a "does-not-depend-on"
property (like a black list). But I think a whitelist on the rare
occasions that we need to override would give more flexibility than a
blacklist. It'll also mean we don't have to check every supplier with
the entire black list each time.

> Convince me that cycles are really a problem anywhere besides clocks.

I wouldn't be surprised at all if interconnects end up with cyclic
dependencies as support for more of them are added.

> I'd be more comfortable with a clock specific property if we only need
> it for clocks and I'm having a hard time imagining cycles for other
> dependencies.

I definitely don't want per-supplier type override. That's just making
things too complicated and adding too many DT properties if we need to
override more than clocks.

-Saravana
