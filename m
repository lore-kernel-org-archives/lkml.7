Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F195C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B466215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBFtMYwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfFLT34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:29:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33064 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfFLT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:29:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id p4so13357203oti.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uYed1+eLaZFWbZYsbtbINdhtROF7xeccXOmlYzNhXA=;
        b=uBFtMYwndCQsvtaj0rOROzVr4oIjcvn7YJd4vJpWJCSb1/XOxKHR3jl2yVpuZn751+
         rYoF+O36sTVwnwuD2OxAPM7Mi32uGUWSxHG1zgRqgV4PirKCBgyevhCQLcopCPRhnwab
         lCOkTe5YFwm94+htq8ZihScSuF8DhfjH23Rw09goLoQw69uJvaVzP9vjfT1a9z/N2LFK
         qYTIexdheUO1UQLj8mc63gNP/NHD7Phqvv7vajQNFo3Yvy4IRxP/urwIAKQ0eXJWroGz
         FsTpGHsdWbUFB5AOFFkkS2HZCwz33tiicd5TVxXn7faeyM8+oOxu+3KVr8oZ3+9ZsuyD
         odww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uYed1+eLaZFWbZYsbtbINdhtROF7xeccXOmlYzNhXA=;
        b=VgZGCjGaC6TuJlQ1Py02ozrRoYR4GKaQ+Ek9tIefnLmdw31qQC8YNeYtRTkMyr52gW
         Lo4i6ecJpfh/eNwfvz3wrqZ42kcOYczMeuL/9W9mNOd8FpXvtoWHF1cGkRrgHf69KLaU
         4j3qjNwkXDmxvR4WnR4HxwSBzNCAzsd7hHe+5aekOALdZFwz7VD6ic4KMnw0IPvvOCAm
         8JWaSV4qNpDDqWPC6JEqcH2EE967INwYL/gq0dwAdeerQHX8JeZPi6I45GErG5T3M2D8
         7VxeO0offtjAjcoScmM7+pCPkp4fCZtfWr6sGPVDYzfLpbnOw8Wcx0NuPg1gMJg95MwI
         7eGg==
X-Gm-Message-State: APjAAAUU4nH9+HXccTrH9QAvYaC5FHilzuCqv57msHCeeepUAaHI4qLY
        VAmJH+yVZRweXuIKfLyLv7ezbxzqcFIaR+mN+boGDA==
X-Google-Smtp-Source: APXvYqweq1nvYWuk7fp9owEQ8qF3HuE6Lt4+5Juq2iBMV3fURqpvBdn/C3yFnWaZYs+AcnWdvc2uUN7niQ0DmF+AJ9U=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr27476157otr.231.1560367794940;
 Wed, 12 Jun 2019 12:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190604003218.241354-1-saravanak@google.com> <20190604003218.241354-2-saravanak@google.com>
 <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com>
 <570474f4-8749-50fd-5f72-36648ed44653@gmail.com> <CAGETcx8M3YkUBZ-e2LLfrbWgnMKMMNG5cv=p8MMmBe7ZyPJ7xw@mail.gmail.com>
 <20190611215242.GE212690@google.com> <CAL_Jsq+V9QUBpzmPyYjWe93-06-mpU=5JmUqvf-QsnuLxPnmUA@mail.gmail.com>
 <20190612142159.GA11563@kroah.com> <CAL_Jsq+x=_6jfC7hkHy+zAaPRB_3K7i9axRiBMHGE9mHQQtPtg@mail.gmail.com>
 <20190612170821.GA6396@kroah.com> <CAL_JsqJRPesdBQH7b7kDLs69pj7Ehw7DFx-pMA-eB2f+PY+Ngg@mail.gmail.com>
In-Reply-To: <CAL_JsqJRPesdBQH7b7kDLs69pj7Ehw7DFx-pMA-eB2f+PY+Ngg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 12 Jun 2019 12:29:18 -0700
Message-ID: <CAGETcx8tJREbq0DP_unPOYk-9S8T97EkRj+9+iC=uHc1QfrSpw@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/5] of/platform: Speed up of_find_device_by_node()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sandeep Patil <sspatil@android.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:19 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Jun 12, 2019 at 11:08 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 12, 2019 at 10:53:09AM -0600, Rob Herring wrote:
> > > On Wed, Jun 12, 2019 at 8:22 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jun 12, 2019 at 07:53:39AM -0600, Rob Herring wrote:
> > > > > On Tue, Jun 11, 2019 at 3:52 PM Sandeep Patil <sspatil@android.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 11, 2019 at 01:56:25PM -0700, 'Saravana Kannan' via kernel-team wrote:
> > > > > > > On Tue, Jun 11, 2019 at 8:18 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Saravana,
> > > > > > > >
> > > > > > > > On 6/10/19 10:36 AM, Rob Herring wrote:
> > > > > > > > > Why are you resending this rather than replying to Frank's last
> > > > > > > > > comments on the original?
> > > > > > > >
> > > > > > > > Adding on a different aspect...  The independent replies from three different
> > > > > > > > maintainers (Rob, Mark, myself) pointed out architectural issues with the
> > > > > > > > patch series.  There were also some implementation issues brought out.
> > > > > > > > (Although I refrained from bringing up most of my implementation issues
> > > > > > > > as they are not relevant until architecture issues are resolved.)
> > > > > > >
> > > > > > > Right, I'm not too worried about the implementation issues before we
> > > > > > > settle on the architectural issues. Those are easy to fix.
> > > > > > >
> > > > > > > Honestly, the main points that the maintainers raised are:
> > > > > > > 1) This is a configuration property and not describing the device.
> > > > > > > Just use the implicit dependencies coming from existing bindings.
> > > > > > >
> > > > > > > I gave a bunch of reasons for why I think it isn't an OS configuration
> > > > > > > property. But even if that's not something the maintainers can agree
> > > > > > > to, I gave a concrete example (cyclic dependencies between clock
> > > > > > > provider hardware) where the implicit dependencies would prevent one
> > > > > > > of the devices from probing till the end of time. So even if the
> > > > > > > maintainers don't agree we should always look at "depends-on" to
> > > > > > > decide the dependencies, we still need some means to override the
> > > > > > > implicit dependencies where they don't match the real dependency. Can
> > > > > > > we use depends-on as an override when the implicit dependencies aren't
> > > > > > > correct?
> > > > > > >
> > > > > > > 2) This doesn't need to be solved because this is just optimizing
> > > > > > > probing or saving power ("we should get rid of this auto disabling"):
> > > > > > >
> > > > > > > I explained why this patch series is not just about optimizing probe
> > > > > > > ordering or saving power. And why we can't ignore auto disabling
> > > > > > > (because it's more than just auto disabling). The kernel is currently
> > > > > > > broken when trying to use modules in ARM SoCs (probably in other
> > > > > > > systems/archs too, but I can't speak for those).
> > > > > > >
> > > > > > > 3) Concerns about backwards compatibility
> > > > > > >
> > > > > > > I pointed out why the current scheme (depends-on being the only source
> > > > > > > of dependency) doesn't break compatibility. And if we go with
> > > > > > > "depends-on" as an override what we could do to keep backwards
> > > > > > > compatibility. Happy to hear more thoughts or discuss options.
> > > > > > >
> > > > > > > 4) How the "sync_state" would work for a device that supplies multiple
> > > > > > > functionalities but a limited driver.
> > > > > >
> > > > > > <snip>
> > > > > > To be clear, all of above are _real_ problems that stops us from efficiently
> > > > > > load device drivers as modules for Android.
> > > > > >
> > > > > > So, if 'depends-on' doesn't seem like the right approach and "going back to
> > > > > > the drawing board" is the ask, could you please point us in the right
> > > > > > direction?
> > > > >
> > > > > Use the dependencies which are already there in DT. That's clocks,
> > > > > pinctrl, regulators, interrupts, gpio at a minimum. I'm simply not
> > > > > going to accept duplicating all those dependencies in DT. The downside
> > > > > for the kernel is you have to address these one by one and can't have
> > > > > a generic property the driver core code can parse. After that's in
> > > > > place, then maybe we can consider handling any additional dependencies
> > > > > not already captured in DT. Once all that is in place, we can probably
> > > > > sort device and/or driver lists to optimize the probe order (maybe the
> > > > > driver core already does that now?).
> > > > >
> > > > > Get rid of the auto disabling of clocks and regulators in
> > > > > late_initcall. It's simply not a valid marker that boot is done when
> > > > > modules are involved. We probably can't get rid of it as lot's of
> > > > > platforms rely on that, so it will have to be opt out. Make it the
> > > > > platform's responsibility for ensuring a consistent state.
> > > > >
> > > > > Perhaps we need a 'boot done' or 'stop deferring probe' trigger from
> > > > > userspace in order to make progress if dependencies are missing.
> > > >
> > > > People have tried to do this multiple times, and you never really know
> > > > when "boot is done" due to busses that have discoverable devices and
> > > > async probing of other busses.
> > >
> > > Yes, I know which is why I proposed the second name with more limited
> > > meaning/function.
> >
> > I still don't want to have the kernel have to rely on this.
> >
> > > > You do know "something" when you pivot to a new boot disk, and when you
> > > > try to load init, but given initramfs and the fact that modules are
> > > > usually included on them, that's not really a good indication that
> > > > anything is "finished".
> > > >
> > > > I don't want userspace to be responsible for telling the kernel, "hey
> > > > you should be finished now!", as that's an async notification that is
> > > > going to be ripe for problems.
> > >
> > > The usecase I care about here is when the DT has the dependency
> > > information, but the kernel doesn't have the driver and the dependency
> > > is never resolved.
> >
> > Then we have the same situation as today and nothing different happens,
> > right?
>
> Huh?
>
> This works today, but not for modules.

Replying to this a bit further down.

>
> >
> > > The same problem has to be solved with a
> > > 'depends-on' property. This easily happens with a new DT with added
> > > dependencies like pinctrl and an old kernel that doesn't have the
> > > "new" driver.

Isn't this the perfect example of an "implicit dependency" in a DT
node not being a mandatory dependency? The old kernel worked fine with
older DT without the added pinctrl dependency, so treating it as a
mandatory dependency seems wrong for that particular device?
depends-on avoids all this because the older kernel won't parse
depends-on. And for newer kernels, it'll parse only what depends-on
says are dependencies and not make wrong assumptions.

> > > Another example is IOMMUs. We need some way to say stop
> > > waiting for dependencies. It is really just a debug option (of course,
> > > how to prevent a debug option from being used in production?). This
> > > works now for built-in cases with the same late_initcall abuse.
> >
> > What is a debug option?  We need something "for real".
> >
> > > Using late_initcall_sync as an indicator has all the same problems
> > > with userspace indicating boot finished. We should get rid of the
> > > late_initcall_sync abuses and stop trying to work around them.
> >
> > I agree, but that's not the issue here.
>
> It is because the cover letter mentions it and downstream work around it.

This patch series is trying to remove the use of late_initcall_sync
and instead relying on dependency information coming from DT. So, you
are agreeing with the patchset.

> > > > I really like the "depends-on" information, as it shows a topology that
> > > > DT doesn't seem to be able to show today, yet we rely on it in the
> > > > kernel with the whole deferred probing mess.  To me, there doesn't seem
> > > > to be any other way to properly "know" this.
> > >
> > > As I said, DT *does* have this dependency information already. The
> > > problem is the kernel probing doesn't use it. Fix that and then we can
> > > discuss dependencies the DT doesn't provide that the kernel needs.
> >
> > Where can the kernel probing be fixed to use it?  What am I missing that
> > can be done instead of what this patchset does?
>
> Somewhere, either in each subsystem or in the DT or core code creating
> struct devices, you need to iterate thru the dependencies. Take clocks
> as an example:
>
> for each node:
>   for each 'clocks' phandle
>     Lookup struct device from clock phandle
>     Add the clock provider struct device to node's struct device links
>
> Now, repeat this for regulators, interrupts, etc.

I'm more than happy to do this if the maintainers can accept this as a
solution, but then we need to agree that we need an override property
if the implicit dependency isn't a mandatory dependency. We also need
to agree on how we do this without breaking backwards compatibility.
Either as a config option for this feature or have a property in the
"chosen" node to say it's okay to assume existing bindings imply
mandatory dependencies (it's just describing the DT more explicitly
and the kernel will use it to enable this feature).

Although regulator binding are a "problem" because the kernel will
have to parse every property in a node to check if it ends with
-supply and then treat it as if it's a regulator binding (even though
it might not be). So regulators will need some kind of "opt out" in
the kernel (not DT).

> This series is pretty much doing the same thing, you just have to
> parse each provider rather than only 'depends-on'.
>
> One issue is the struct device for the dependency may not be created
> yet. I think this series would have the same issue, but haven't dug
> into how it avoids that or whether it just ignores it and falls back
> to deferring probe.

The patch series handles this properly and doesn't fall back to
deferred probing.

> I'm also not clear on how you create struct devices and add
> dependencies before probing gets attempted. If a driver is already
> registered, probe is going to be attempted before any dependencies are
> added. I guess the issue is avoided with drivers being modules, but
> any solution should work for built-in too.

This is also handled properly in the series.

I've actually boot tested both these scenarios you call out and the
patch series handles them properly.

But you are missing the main point here. The goal isn't to just
eliminate deferred probing (it's a great side effect even it it just
stops 99% of them), but also remove the bad assumption that
late_initcall_sync() means all the devices are probed. The suppliers
need a better signal (which the patch series provides) to tell when
they can "unfreeze" the resources left on at boot.

It's true that device tree overlays can be added after userspace comes
up, but in those cases whoever is adding the device tree nodes can make
sure that the resources needed by the "to be added overlay devices" are
kept at the right level. It's also unlikely that the bootloader is
leaving resources
on for these overlay devices because they might never be added.

And even if it doesn't work perfectly for instances with overlays
(neither does the
current kernel), it's still better to fix it for the next
million/billion devices that'll use
ARM without post boot overlays.

Thanks,
Saravana
