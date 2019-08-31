Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB8BC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 05:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E84523426
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 05:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxR6uq24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfHaFCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 01:02:03 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:32801 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHaFCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 01:02:03 -0400
Received: by mail-ot1-f41.google.com with SMTP id p23so8966739oto.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 22:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMvMh+RAbKGo7z5tnuSKgcfW+NLz3FUmuj/NbxrZZHY=;
        b=OxR6uq24qK0OWAtFjqU2oClGohrRbN+OLGMBOF46KVZL2Y7XTyZZMUr62OY3EvANYj
         hq2I9R/KvYqcQlIZMi9n2ZppAfZU3xpdk4u3kbDVbJllSuHDjtrQSUAbm7nKUNKdOjs+
         ykD3NEtCBCBJjFLKKidekHLrnrjcJXy55mZhi7SnU7AsrH0Ux3iODbXdRF49jZklYY+c
         cNaIhjgPQOk0ZZHqAjFcKatv0BVZlTEunUrI4E/dNP+ahCRjTXRZYabvjcgIAot+7WLp
         Gtj3ji+GHGodBA+NmnxHgP/Cz7Oi94aTg9niZJNxsc/RnRM0wSbfJfRXEwbJFq0udqMY
         NyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMvMh+RAbKGo7z5tnuSKgcfW+NLz3FUmuj/NbxrZZHY=;
        b=SOFB7frmDQTj46jRUyq+/RhWS+N1hLuDOaaY7Qfsrp9hNDmAxA4VQWGqy4yn0KOBfq
         4wpWX25J/Q0I20hzud5714OR1k1AiXRp2cIRm00ZjbySKW8YbxrmglgZ81lIEFcLLy0/
         OAkAY+scxi08+xH5XuRXgOg2C95R+llpGpyXVTzM8Zg/8DHf4cP32eYW3MiNDbQZ5SA8
         avpkKy7yxpGBgsObWZ0HBO5uVYNvvGLLG4tzJ17AKUywMLgTnynU7NI2T2BJCSMlEpy6
         lvmUWZ6J+wv4jLeT4Ybg1V+bim/7Jwsznb/jQPm0o1l5Gxcf/obV+QzTNgKoi/CqH+C+
         K50g==
X-Gm-Message-State: APjAAAVzxsOGuZSai3xrP/gywK2Bsk4nEe6yVb/DZ8RbwxKBNWh1GsA/
        tS3aiB7RwC11nut7sfw52hD2rh6qlDbjZDCYqAMMuw==
X-Google-Smtp-Source: APXvYqxkx2G1h5CN5mFxrf0lKFjiy0grQIP9tGpRfCoy+82Ofv7GBe0O+O+EUPeQsW7Q+/ydlxu4sb3mIdwTIXoM2CM=
X-Received: by 2002:a9d:6256:: with SMTP id i22mr15272404otk.139.1567227721572;
 Fri, 30 Aug 2019 22:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx_pSnC_2D7ufLRyfE3b8uRc814XEf8zu+SpNtT7_Z8NLg@mail.gmail.com>
 <CAL_JsqKWcGSzCF_ZyEo6bbuayoYks51A-JAMp_oLR1RyTUzNUA@mail.gmail.com>
 <CAGETcx_RL4hHHA2MFTVyV1ivgghaBZePROXpnC-UUJ7tcH4kSQ@mail.gmail.com>
 <CAL_JsqJB+41Sjxi-udYzw8sAq0myrcnxjSyzrxeEsoctZX6pbw@mail.gmail.com> <CAGETcx9T_3GKgAj=3jANb=JAa5b5hP+r4CLVm9a2LYf2CQiH9Q@mail.gmail.com>
In-Reply-To: <CAGETcx9T_3GKgAj=3jANb=JAa5b5hP+r4CLVm9a2LYf2CQiH9Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 30 Aug 2019 22:01:25 -0700
Message-ID: <CAGETcx-_Mewt-ZND1WkjtdvLZ9iXTZBEdSPU6kO3G_L28mCHdQ@mail.gmail.com>
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

On Fri, Aug 30, 2019 at 5:32 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, Aug 30, 2019 at 7:35 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Aug 29, 2019 at 11:58 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Thu, Aug 29, 2019 at 9:28 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Thu, Aug 22, 2019 at 1:55 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > Frank, Greg and I got together during ELC and had an extensive and
> > > > > very productive discussion about my "postboot supplier state cleanup"
> > > > > patch series [1]. The three of us are on the same page now -- the
> > > > > series as it stands is the direction we want to go in, with some minor
> > > > > refactoring, documentation and naming changes.
> > > > >
> > > > > However, one of the things Frank is concerned about (and Greg and I
> > > > > agree) in the current patch series is that the "cyclic dependency
> > > > > breaking" logic has been pushed off to individual drivers using the
> > > > > edit_links() callback.
> > > >
> > > > I would think the core can detect this condition. There's nothing
> > > > device specific once you have the dependency tree. You still need to
> > > > know what device needs to probe first and the drivers are going to
> > > > have that knowledge anyways. So wouldn't it be enough to allow probe
> > > > to proceed for devices in the loop.
> > >
> > > The problem is that device links don't allow creating a cyclic
> > > dependency graph -- for good reasons. The last link in the cycle would
> > > be rejected. I don't think trying to change device link to allow
> > > cyclic links is the right direction to go in nor is it a can of worms
> > > I want to open.
> > >
> > > So, we'll need some other way of tracking the loop and then allowing
> > > only those devices in a loop to attempt probing even if their
> > > suppliers haven't probed. And then if a device ends up being in more
> > > than one loop, things could get even more complicated. And after one
> > > of the devices in the loop probes, we still need to somehow figure out
> > > the "bad" link and delete it so the last "good" link can be made
> > > before all the suppliers have their sync_state() called (because the
> > > "good" link hasn't been created yet). That all gets pretty messy. If
> > > we are never going to accept any DT changes, then I'd rather go with
> > > edit_links() and keep the complexity within the one off weird hardware
> > > where there are cycles instead of over complicating the driver core.
> >
> > If it is so complex, then it should not be in DT.
>
> I'm talking about existing simple DT bindings that says what
> clocks/interconnects/regulators a device needs. Not sure what you mean
> by "it should not be in DT".
>
> > Things like
> > describing clocks at the gate/mux/divider level turned out to be too
> > complex to get right or complete, so we avoid that.
>
> Right, and this patch series has nothing to do with describing complex
> internals of a device.
>
> >
> > > > Once 1 driver succeeds, then you
> > > > can enforce the dependencies on the rest.
> > > >
> > > > > The concern being, there are going to be multiple device specific ad
> > > > > hoc implementations to break a cyclic dependency. Also, if a device
> > > > > can be part of a cyclic dependency, the driver for that device has to
> > > > > check for specific system/products in which the device is part of a
> > > > > cyclic dependency (because it might not always be part of a cycle),
> > > > > and then potentially have cycle/product specific code to break the
> > > > > cycle (since the cycle can be different on each system/product).
> > > > >
> > > > > One way to avoid all of the device/driver specific code and simplify
> > > > > my patch series by a non-trivial amount would be by adding a
> > > > > "depends-on" DT binding that can ONLY be used to break cycles. We can
> > > > > document it as such and reject any attempts to use it for other
> > > > > purposes. When a depends-on property is present in a device node, that
> > > > > specific device's supplier list will be parsed ONLY from the
> > > > > depends-on property and the other properties won't be parsed for
> > > > > deriving dependency information for that device.
> > > >
> > > > Seems like only ignoring the dependencies with a cycle would be
> > > > sufficient.
> > >
> > > No, we need to only ignore the "bad" dependency. We can't ignore all
> > > the dependencies in the cycle because that would cause the suppliers
> > > to clean up the hardware state before the consumers are ready.
> >
> > I misunderstood. I now see this is back to duplicating all the data
> > that's already there which I've already said no to.
>
> What I proposed earlier was using depends-on for all devices. And I'm
> glad you rejected it because I like my current set of patches better
> than the earlier one. The question here is whether we can allow this
> for the rare occasions where there is a cycle. Frank, Greg and I think
> it was a reasonable compromise when we talked about it in person.
>
> >
> > > > For example, consider a clock controller which has 2 clock
> > > > inputs from other clock controllers where one has a cycle and one
> > > > doesn't. Also consider it has a regulator dependency. We only need to
> > > > ignore the dependency for 1 of the clock inputs. The rest of the
> > > > dependencies should be honored.
> > >
> > > Agreed. In this case, if the device used the depends-on property,
> > > it'll have to list the 1 clock controller and the regulator.
> > >
> > > > > Frank, Greg and I like this usage model for a new depends-on DT
> > > > > binding. Is this something you'd be willing to accept?
> > > >
> > > > To do the above, it needs to be inverted.
> > >
> > > I understand you are basically asking for a "does-not-depend-on"
> > > property (like a black list). But I think a whitelist on the rare
> > > occasions that we need to override would give more flexibility than a
> > > blacklist. It'll also mean we don't have to check every supplier with
> > > the entire black list each time.
> >
> > So if we have 10 dependencies and 1 to ignore, we're going to list the
> > 9 dependencies? And if I want to know where the cycle is, I have to
> > figure out which 1 of the 10 dependencies you omitted. Pick black or
> > white list with what's going to be shortest in the common case.
>
> Sure, but how often are we even going to encounter these?
>
> > Also, when new dependencies are added to a node, we'd have to check
> > that the dependency is added to 'depends-on' (or was it not on
> > purpose).
>
> Even if it's a "doesnt-depend-on" you'll still have that confusion of
> whether the new dependency should be added to that blacklist.
>
> > > > Convince me that cycles are really a problem anywhere besides clocks.
> > >
> > > I wouldn't be surprised at all if interconnects end up with cyclic
> > > dependencies as support for more of them are added.
> >
> > Perhaps, though I'm doubtful the drivers for them could be both
> > required at probe and built as modules.
>
> This is 100% true/possible on SDM845. They are needed for some
> consumers to write to registers. And both the consumer and the
> interconnect provider can be loaded as modules. In fact, some paths in
> the provider is left on from boot so that the CPU and other devices
> can reach memory. You asked for examples of where else there could be
> cycles, I gave you one.
>
> > > > I'd be more comfortable with a clock specific property if we only need
> > > > it for clocks and I'm having a hard time imagining cycles for other
> > > > dependencies.
> > >
> > > I definitely don't want per-supplier type override. That's just making
> > > things too complicated and adding too many DT properties if we need to
> > > override more than clocks.
> >
> > I'm all for generic properties, but not if we only have hypothetical
> > cases for anything beyond clocks. I know clocks are a somewhat common
> > problem because it has come up before. I'm just asking for specific
> > example that's not clocks.
>
> I gave you another example above and you are just dismissing it saying
> it probably can't be a module, etc. Not sure what more I can tell.
>
> > Part of the problem is we can't really police how a generic property
> > is used. Maybe Linux is only using it for cycles, but then u-boot
> > folks may think it works well for other reasons.
>
> Any property could be misused. We can't control downstream stuff or
> other projects.
>
> > Maybe a dtc check
> > could mitigate that. Warn on any dependencies that are not a cycle.
> > Actually, you could add a check for any cycles first and then we can
> > see where all they exist.
>
> Sorry, I'm not going to sign up to make dtc changes to be able to add
> DT bindings.

Thinking more about this, I don't think it's worth holding back the
entire series trying to solve the cyclic dependencies.

At least as of today, the clock framework has a hack (hack because it
expects globally unique clock names that causes problems for some
corner cases) that allows the supplier (the one that gets a few clocks
from the consumers) to get away with not listing the consumer clocks
in the supplier's clock list. So, the SDM845 avoid cycles in DT
(despite having them in the hardware) that way.

So we can take our time trying to solve this in a generic fashion (new
DT property/binding, edit_links(), letting devices probe, etc). In the
meantime, maybe we'll run into more cycle issues that'll give us a
better idea of which solution would be better as a generic solution.

I'll send a new patch series addressing the concern about
platfom_device and dropping the attempt to solve cycles.

Thanks,
Saravana
