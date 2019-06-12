Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1280C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB41208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560363590;
	bh=v3wZxA8OQdNJVda6w+TOVq4a9A+OQYGCm4v5xFiQ9jA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mDOFHfOG9rBFn9BekK0DLxO+NDTut8+MHs3aCtbQbiFxykrmBW4V6joologFLyff7
	 E5rCpSOpn7bixGGXCaGTSnUaOIvxoxJY7i40N8nGTLSp8kNeXiMVbqguGwRFRTfP4V
	 /1HIu1lPOGMmi0Fy0YJGyu6hEBdwk2jUMC/T+0AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfFLSTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfFLSTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:19:49 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F3920B7C;
        Wed, 12 Jun 2019 18:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560363587;
        bh=v3wZxA8OQdNJVda6w+TOVq4a9A+OQYGCm4v5xFiQ9jA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xwZbkqxtKFfoSbumeowNTOQsQF0O4stwibdgW+b43bvBZmf0O/wOrKDXme0+HBclD
         uOd//dXZ1g7FtZn3dZUHeWqfrTClVzZHT/qukLOkkJixGPB86UQsMvW7EQr+Eo6NyP
         1e66RamZto+hD38sOmiYPrVHcLIRgNp4Gd1u9oZs=
Received: by mail-qt1-f176.google.com with SMTP id i34so19516915qta.6;
        Wed, 12 Jun 2019 11:19:47 -0700 (PDT)
X-Gm-Message-State: APjAAAUcQdRcnnawcUMqsnwxhgy3kVllwxEjyFt6ecOVjVpRm7+WIIkR
        olx1Y5CaZAs4YkeVosWkrQ8qy8ALqwKHBM5TlA==
X-Google-Smtp-Source: APXvYqz5UgsMA7CJkRQQM/ckzULoS7CRWevsveRYuSWFWxyVcZ8OyWxjPQkr8zOTSgEc9TD3ugwdN5CaS99CEAR5PXs=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr71321172qtb.224.1560363586519;
 Wed, 12 Jun 2019 11:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190604003218.241354-1-saravanak@google.com> <20190604003218.241354-2-saravanak@google.com>
 <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com>
 <570474f4-8749-50fd-5f72-36648ed44653@gmail.com> <CAGETcx8M3YkUBZ-e2LLfrbWgnMKMMNG5cv=p8MMmBe7ZyPJ7xw@mail.gmail.com>
 <20190611215242.GE212690@google.com> <CAL_Jsq+V9QUBpzmPyYjWe93-06-mpU=5JmUqvf-QsnuLxPnmUA@mail.gmail.com>
 <20190612142159.GA11563@kroah.com> <CAL_Jsq+x=_6jfC7hkHy+zAaPRB_3K7i9axRiBMHGE9mHQQtPtg@mail.gmail.com>
 <20190612170821.GA6396@kroah.com>
In-Reply-To: <20190612170821.GA6396@kroah.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 12 Jun 2019 12:19:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJRPesdBQH7b7kDLs69pj7Ehw7DFx-pMA-eB2f+PY+Ngg@mail.gmail.com>
Message-ID: <CAL_JsqJRPesdBQH7b7kDLs69pj7Ehw7DFx-pMA-eB2f+PY+Ngg@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/5] of/platform: Speed up of_find_device_by_node()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sandeep Patil <sspatil@android.com>,
        Saravana Kannan <saravanak@google.com>,
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

On Wed, Jun 12, 2019 at 11:08 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 12, 2019 at 10:53:09AM -0600, Rob Herring wrote:
> > On Wed, Jun 12, 2019 at 8:22 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jun 12, 2019 at 07:53:39AM -0600, Rob Herring wrote:
> > > > On Tue, Jun 11, 2019 at 3:52 PM Sandeep Patil <sspatil@android.com> wrote:
> > > > >
> > > > > On Tue, Jun 11, 2019 at 01:56:25PM -0700, 'Saravana Kannan' via kernel-team wrote:
> > > > > > On Tue, Jun 11, 2019 at 8:18 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Saravana,
> > > > > > >
> > > > > > > On 6/10/19 10:36 AM, Rob Herring wrote:
> > > > > > > > Why are you resending this rather than replying to Frank's last
> > > > > > > > comments on the original?
> > > > > > >
> > > > > > > Adding on a different aspect...  The independent replies from three different
> > > > > > > maintainers (Rob, Mark, myself) pointed out architectural issues with the
> > > > > > > patch series.  There were also some implementation issues brought out.
> > > > > > > (Although I refrained from bringing up most of my implementation issues
> > > > > > > as they are not relevant until architecture issues are resolved.)
> > > > > >
> > > > > > Right, I'm not too worried about the implementation issues before we
> > > > > > settle on the architectural issues. Those are easy to fix.
> > > > > >
> > > > > > Honestly, the main points that the maintainers raised are:
> > > > > > 1) This is a configuration property and not describing the device.
> > > > > > Just use the implicit dependencies coming from existing bindings.
> > > > > >
> > > > > > I gave a bunch of reasons for why I think it isn't an OS configuration
> > > > > > property. But even if that's not something the maintainers can agree
> > > > > > to, I gave a concrete example (cyclic dependencies between clock
> > > > > > provider hardware) where the implicit dependencies would prevent one
> > > > > > of the devices from probing till the end of time. So even if the
> > > > > > maintainers don't agree we should always look at "depends-on" to
> > > > > > decide the dependencies, we still need some means to override the
> > > > > > implicit dependencies where they don't match the real dependency. Can
> > > > > > we use depends-on as an override when the implicit dependencies aren't
> > > > > > correct?
> > > > > >
> > > > > > 2) This doesn't need to be solved because this is just optimizing
> > > > > > probing or saving power ("we should get rid of this auto disabling"):
> > > > > >
> > > > > > I explained why this patch series is not just about optimizing probe
> > > > > > ordering or saving power. And why we can't ignore auto disabling
> > > > > > (because it's more than just auto disabling). The kernel is currently
> > > > > > broken when trying to use modules in ARM SoCs (probably in other
> > > > > > systems/archs too, but I can't speak for those).
> > > > > >
> > > > > > 3) Concerns about backwards compatibility
> > > > > >
> > > > > > I pointed out why the current scheme (depends-on being the only source
> > > > > > of dependency) doesn't break compatibility. And if we go with
> > > > > > "depends-on" as an override what we could do to keep backwards
> > > > > > compatibility. Happy to hear more thoughts or discuss options.
> > > > > >
> > > > > > 4) How the "sync_state" would work for a device that supplies multiple
> > > > > > functionalities but a limited driver.
> > > > >
> > > > > <snip>
> > > > > To be clear, all of above are _real_ problems that stops us from efficiently
> > > > > load device drivers as modules for Android.
> > > > >
> > > > > So, if 'depends-on' doesn't seem like the right approach and "going back to
> > > > > the drawing board" is the ask, could you please point us in the right
> > > > > direction?
> > > >
> > > > Use the dependencies which are already there in DT. That's clocks,
> > > > pinctrl, regulators, interrupts, gpio at a minimum. I'm simply not
> > > > going to accept duplicating all those dependencies in DT. The downside
> > > > for the kernel is you have to address these one by one and can't have
> > > > a generic property the driver core code can parse. After that's in
> > > > place, then maybe we can consider handling any additional dependencies
> > > > not already captured in DT. Once all that is in place, we can probably
> > > > sort device and/or driver lists to optimize the probe order (maybe the
> > > > driver core already does that now?).
> > > >
> > > > Get rid of the auto disabling of clocks and regulators in
> > > > late_initcall. It's simply not a valid marker that boot is done when
> > > > modules are involved. We probably can't get rid of it as lot's of
> > > > platforms rely on that, so it will have to be opt out. Make it the
> > > > platform's responsibility for ensuring a consistent state.
> > > >
> > > > Perhaps we need a 'boot done' or 'stop deferring probe' trigger from
> > > > userspace in order to make progress if dependencies are missing.
> > >
> > > People have tried to do this multiple times, and you never really know
> > > when "boot is done" due to busses that have discoverable devices and
> > > async probing of other busses.
> >
> > Yes, I know which is why I proposed the second name with more limited
> > meaning/function.
>
> I still don't want to have the kernel have to rely on this.
>
> > > You do know "something" when you pivot to a new boot disk, and when you
> > > try to load init, but given initramfs and the fact that modules are
> > > usually included on them, that's not really a good indication that
> > > anything is "finished".
> > >
> > > I don't want userspace to be responsible for telling the kernel, "hey
> > > you should be finished now!", as that's an async notification that is
> > > going to be ripe for problems.
> >
> > The usecase I care about here is when the DT has the dependency
> > information, but the kernel doesn't have the driver and the dependency
> > is never resolved.
>
> Then we have the same situation as today and nothing different happens,
> right?

Huh?

This works today, but not for modules.

>
> > The same problem has to be solved with a
> > 'depends-on' property. This easily happens with a new DT with added
> > dependencies like pinctrl and an old kernel that doesn't have the
> > "new" driver. Another example is IOMMUs. We need some way to say stop
> > waiting for dependencies. It is really just a debug option (of course,
> > how to prevent a debug option from being used in production?). This
> > works now for built-in cases with the same late_initcall abuse.
>
> What is a debug option?  We need something "for real".
>
> > Using late_initcall_sync as an indicator has all the same problems
> > with userspace indicating boot finished. We should get rid of the
> > late_initcall_sync abuses and stop trying to work around them.
>
> I agree, but that's not the issue here.

It is because the cover letter mentions it and downstream work around it.

> > > I really like the "depends-on" information, as it shows a topology that
> > > DT doesn't seem to be able to show today, yet we rely on it in the
> > > kernel with the whole deferred probing mess.  To me, there doesn't seem
> > > to be any other way to properly "know" this.
> >
> > As I said, DT *does* have this dependency information already. The
> > problem is the kernel probing doesn't use it. Fix that and then we can
> > discuss dependencies the DT doesn't provide that the kernel needs.
>
> Where can the kernel probing be fixed to use it?  What am I missing that
> can be done instead of what this patchset does?

Somewhere, either in each subsystem or in the DT or core code creating
struct devices, you need to iterate thru the dependencies. Take clocks
as an example:

for each node:
  for each 'clocks' phandle
    Lookup struct device from clock phandle
    Add the clock provider struct device to node's struct device links

Now, repeat this for regulators, interrupts, etc.

This series is pretty much doing the same thing, you just have to
parse each provider rather than only 'depends-on'.

One issue is the struct device for the dependency may not be created
yet. I think this series would have the same issue, but haven't dug
into how it avoids that or whether it just ignores it and falls back
to deferring probe.

I'm also not clear on how you create struct devices and add
dependencies before probing gets attempted. If a driver is already
registered, probe is going to be attempted before any dependencies are
added. I guess the issue is avoided with drivers being modules, but
any solution should work for built-in too.

Rob
