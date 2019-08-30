Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EB4C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9DF23407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567175711;
	bh=nNLPmaKMMB2N7l9R/H4ByTAR5mepW2jNCvoDSdRyy5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2sHm8kPHqNdG7d9pVW/LfKbvGrD5X8G7wcP+q6tN3m6DTE/ym99SNmLHfsDqryG2M
	 3R7Hxk2J5j0fkIwspB6276jxDPyvZQSbC3nRIiZFYB1wxJF1JUxkx2s+ZrqScz6mLr
	 84J5xcty8ZrLpMALyAQdra5ItHxabC+zasvlW1d0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfH3OfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfH3OfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:35:10 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 359862342A;
        Fri, 30 Aug 2019 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567175708;
        bh=nNLPmaKMMB2N7l9R/H4ByTAR5mepW2jNCvoDSdRyy5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UmocibFq5CDI1wGQee6sVYNdf25UrDCs4hSY9FU+tOxZb3AEQWL8YDG16KppVIg0W
         rbOvOyRItwDjdCAG0iKF5cki73HBWoCZD9bQseeqvjAL06ie1jnuk8K6WfVKbj4Qac
         4knN2qI+IGN110HniEEGcuH54ltiWAY4AaWhY7aQ=
Received: by mail-qt1-f178.google.com with SMTP id n7so7807013qtb.6;
        Fri, 30 Aug 2019 07:35:08 -0700 (PDT)
X-Gm-Message-State: APjAAAW91RJUT1gh64tdeoF6OPwrhJbWSn3mXph1cof2AOkxyQzB8RBm
        HME4wVcST7XxyqtwE8RdtZycFF7FvxrzNTdQxw==
X-Google-Smtp-Source: APXvYqx3ZJ5AnmTRZdYkwwEXr/wJvUUBAPmNsLa9aoYFepRiRFnQsDXtGtLCJtPuS+Jz0hERPPgAjmckiyaKFlnifY8=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr15705734qtc.143.1567175707306;
 Fri, 30 Aug 2019 07:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx_pSnC_2D7ufLRyfE3b8uRc814XEf8zu+SpNtT7_Z8NLg@mail.gmail.com>
 <CAL_JsqKWcGSzCF_ZyEo6bbuayoYks51A-JAMp_oLR1RyTUzNUA@mail.gmail.com> <CAGETcx_RL4hHHA2MFTVyV1ivgghaBZePROXpnC-UUJ7tcH4kSQ@mail.gmail.com>
In-Reply-To: <CAGETcx_RL4hHHA2MFTVyV1ivgghaBZePROXpnC-UUJ7tcH4kSQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 30 Aug 2019 09:34:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJB+41Sjxi-udYzw8sAq0myrcnxjSyzrxeEsoctZX6pbw@mail.gmail.com>
Message-ID: <CAL_JsqJB+41Sjxi-udYzw8sAq0myrcnxjSyzrxeEsoctZX6pbw@mail.gmail.com>
Subject: Re: Adding depends-on DT binding to break cyclic dependencies
To:     Saravana Kannan <saravanak@google.com>
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

On Thu, Aug 29, 2019 at 11:58 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Aug 29, 2019 at 9:28 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Aug 22, 2019 at 1:55 AM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > Frank, Greg and I got together during ELC and had an extensive and
> > > very productive discussion about my "postboot supplier state cleanup"
> > > patch series [1]. The three of us are on the same page now -- the
> > > series as it stands is the direction we want to go in, with some minor
> > > refactoring, documentation and naming changes.
> > >
> > > However, one of the things Frank is concerned about (and Greg and I
> > > agree) in the current patch series is that the "cyclic dependency
> > > breaking" logic has been pushed off to individual drivers using the
> > > edit_links() callback.
> >
> > I would think the core can detect this condition. There's nothing
> > device specific once you have the dependency tree. You still need to
> > know what device needs to probe first and the drivers are going to
> > have that knowledge anyways. So wouldn't it be enough to allow probe
> > to proceed for devices in the loop.
>
> The problem is that device links don't allow creating a cyclic
> dependency graph -- for good reasons. The last link in the cycle would
> be rejected. I don't think trying to change device link to allow
> cyclic links is the right direction to go in nor is it a can of worms
> I want to open.
>
> So, we'll need some other way of tracking the loop and then allowing
> only those devices in a loop to attempt probing even if their
> suppliers haven't probed. And then if a device ends up being in more
> than one loop, things could get even more complicated. And after one
> of the devices in the loop probes, we still need to somehow figure out
> the "bad" link and delete it so the last "good" link can be made
> before all the suppliers have their sync_state() called (because the
> "good" link hasn't been created yet). That all gets pretty messy. If
> we are never going to accept any DT changes, then I'd rather go with
> edit_links() and keep the complexity within the one off weird hardware
> where there are cycles instead of over complicating the driver core.

If it is so complex, then it should not be in DT. Things like
describing clocks at the gate/mux/divider level turned out to be too
complex to get right or complete, so we avoid that.

> > Once 1 driver succeeds, then you
> > can enforce the dependencies on the rest.
> >
> > > The concern being, there are going to be multiple device specific ad
> > > hoc implementations to break a cyclic dependency. Also, if a device
> > > can be part of a cyclic dependency, the driver for that device has to
> > > check for specific system/products in which the device is part of a
> > > cyclic dependency (because it might not always be part of a cycle),
> > > and then potentially have cycle/product specific code to break the
> > > cycle (since the cycle can be different on each system/product).
> > >
> > > One way to avoid all of the device/driver specific code and simplify
> > > my patch series by a non-trivial amount would be by adding a
> > > "depends-on" DT binding that can ONLY be used to break cycles. We can
> > > document it as such and reject any attempts to use it for other
> > > purposes. When a depends-on property is present in a device node, that
> > > specific device's supplier list will be parsed ONLY from the
> > > depends-on property and the other properties won't be parsed for
> > > deriving dependency information for that device.
> >
> > Seems like only ignoring the dependencies with a cycle would be
> > sufficient.
>
> No, we need to only ignore the "bad" dependency. We can't ignore all
> the dependencies in the cycle because that would cause the suppliers
> to clean up the hardware state before the consumers are ready.

I misunderstood. I now see this is back to duplicating all the data
that's already there which I've already said no to.

> > For example, consider a clock controller which has 2 clock
> > inputs from other clock controllers where one has a cycle and one
> > doesn't. Also consider it has a regulator dependency. We only need to
> > ignore the dependency for 1 of the clock inputs. The rest of the
> > dependencies should be honored.
>
> Agreed. In this case, if the device used the depends-on property,
> it'll have to list the 1 clock controller and the regulator.
>
> > > Frank, Greg and I like this usage model for a new depends-on DT
> > > binding. Is this something you'd be willing to accept?
> >
> > To do the above, it needs to be inverted.
>
> I understand you are basically asking for a "does-not-depend-on"
> property (like a black list). But I think a whitelist on the rare
> occasions that we need to override would give more flexibility than a
> blacklist. It'll also mean we don't have to check every supplier with
> the entire black list each time.

So if we have 10 dependencies and 1 to ignore, we're going to list the
9 dependencies? And if I want to know where the cycle is, I have to
figure out which 1 of the 10 dependencies you omitted. Pick black or
white list with what's going to be shortest in the common case.

Also, when new dependencies are added to a node, we'd have to check
that the dependency is added to 'depends-on' (or was it not on
purpose).

> > Convince me that cycles are really a problem anywhere besides clocks.
>
> I wouldn't be surprised at all if interconnects end up with cyclic
> dependencies as support for more of them are added.

Perhaps, though I'm doubtful the drivers for them could be both
required at probe and built as modules.

> > I'd be more comfortable with a clock specific property if we only need
> > it for clocks and I'm having a hard time imagining cycles for other
> > dependencies.
>
> I definitely don't want per-supplier type override. That's just making
> things too complicated and adding too many DT properties if we need to
> override more than clocks.

I'm all for generic properties, but not if we only have hypothetical
cases for anything beyond clocks. I know clocks are a somewhat common
problem because it has come up before. I'm just asking for specific
example that's not clocks.

Part of the problem is we can't really police how a generic property
is used. Maybe Linux is only using it for cycles, but then u-boot
folks may think it works well for other reasons. Maybe a dtc check
could mitigate that. Warn on any dependencies that are not a cycle.
Actually, you could add a check for any cycles first and then we can
see where all they exist.

Rob
