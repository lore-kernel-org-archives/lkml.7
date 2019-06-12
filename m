Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0306DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C430920B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560349325;
	bh=8glz7AmBO0JhEGxDCeCC/4jlvlq7LvO/BtjTKEKPa+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lysN2rz+eVqEjTs6b02m1C04dOH8AqG8RPlq6jsw1J3mOYiGWC5dIF06KuIHDn0C+
	 YBYtKpSs5EDIJ/XyrNRAee1Fz8qaKBH0AT9RzfUH4w9kjh9+kBQQp2n37z0P1Py3yX
	 MMMch5oathk+MN+bReGJAp0z/Nm7vaKR6ayyMIZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409332AbfFLOWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409256AbfFLOWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:22:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D58F215EA;
        Wed, 12 Jun 2019 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560349322;
        bh=8glz7AmBO0JhEGxDCeCC/4jlvlq7LvO/BtjTKEKPa+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BI41ewj+sEPz8R+55rL+2UgXxTn7lZ9FqMdtjFaCUEFzV5VV2B4GWdNiebkFGSP/4
         2gg5u9na02DA6sdVJYixUmRNooL0CWdYQsI7jv429uiXpBQze9FvGsVFpwMtP/6BjW
         rUd2NMjqFwb+r5QLC8ayDuIdBZZDWHjYSxJsBATs=
Date:   Wed, 12 Jun 2019 16:21:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Patil <sspatil@android.com>,
        Saravana Kannan <saravanak@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [RESEND PATCH v1 1/5] of/platform: Speed up
 of_find_device_by_node()
Message-ID: <20190612142159.GA11563@kroah.com>
References: <20190604003218.241354-1-saravanak@google.com>
 <20190604003218.241354-2-saravanak@google.com>
 <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com>
 <570474f4-8749-50fd-5f72-36648ed44653@gmail.com>
 <CAGETcx8M3YkUBZ-e2LLfrbWgnMKMMNG5cv=p8MMmBe7ZyPJ7xw@mail.gmail.com>
 <20190611215242.GE212690@google.com>
 <CAL_Jsq+V9QUBpzmPyYjWe93-06-mpU=5JmUqvf-QsnuLxPnmUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+V9QUBpzmPyYjWe93-06-mpU=5JmUqvf-QsnuLxPnmUA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 07:53:39AM -0600, Rob Herring wrote:
> On Tue, Jun 11, 2019 at 3:52 PM Sandeep Patil <sspatil@android.com> wrote:
> >
> > On Tue, Jun 11, 2019 at 01:56:25PM -0700, 'Saravana Kannan' via kernel-team wrote:
> > > On Tue, Jun 11, 2019 at 8:18 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > > >
> > > > Hi Saravana,
> > > >
> > > > On 6/10/19 10:36 AM, Rob Herring wrote:
> > > > > Why are you resending this rather than replying to Frank's last
> > > > > comments on the original?
> > > >
> > > > Adding on a different aspect...  The independent replies from three different
> > > > maintainers (Rob, Mark, myself) pointed out architectural issues with the
> > > > patch series.  There were also some implementation issues brought out.
> > > > (Although I refrained from bringing up most of my implementation issues
> > > > as they are not relevant until architecture issues are resolved.)
> > >
> > > Right, I'm not too worried about the implementation issues before we
> > > settle on the architectural issues. Those are easy to fix.
> > >
> > > Honestly, the main points that the maintainers raised are:
> > > 1) This is a configuration property and not describing the device.
> > > Just use the implicit dependencies coming from existing bindings.
> > >
> > > I gave a bunch of reasons for why I think it isn't an OS configuration
> > > property. But even if that's not something the maintainers can agree
> > > to, I gave a concrete example (cyclic dependencies between clock
> > > provider hardware) where the implicit dependencies would prevent one
> > > of the devices from probing till the end of time. So even if the
> > > maintainers don't agree we should always look at "depends-on" to
> > > decide the dependencies, we still need some means to override the
> > > implicit dependencies where they don't match the real dependency. Can
> > > we use depends-on as an override when the implicit dependencies aren't
> > > correct?
> > >
> > > 2) This doesn't need to be solved because this is just optimizing
> > > probing or saving power ("we should get rid of this auto disabling"):
> > >
> > > I explained why this patch series is not just about optimizing probe
> > > ordering or saving power. And why we can't ignore auto disabling
> > > (because it's more than just auto disabling). The kernel is currently
> > > broken when trying to use modules in ARM SoCs (probably in other
> > > systems/archs too, but I can't speak for those).
> > >
> > > 3) Concerns about backwards compatibility
> > >
> > > I pointed out why the current scheme (depends-on being the only source
> > > of dependency) doesn't break compatibility. And if we go with
> > > "depends-on" as an override what we could do to keep backwards
> > > compatibility. Happy to hear more thoughts or discuss options.
> > >
> > > 4) How the "sync_state" would work for a device that supplies multiple
> > > functionalities but a limited driver.
> >
> > <snip>
> > To be clear, all of above are _real_ problems that stops us from efficiently
> > load device drivers as modules for Android.
> >
> > So, if 'depends-on' doesn't seem like the right approach and "going back to
> > the drawing board" is the ask, could you please point us in the right
> > direction?
> 
> Use the dependencies which are already there in DT. That's clocks,
> pinctrl, regulators, interrupts, gpio at a minimum. I'm simply not
> going to accept duplicating all those dependencies in DT. The downside
> for the kernel is you have to address these one by one and can't have
> a generic property the driver core code can parse. After that's in
> place, then maybe we can consider handling any additional dependencies
> not already captured in DT. Once all that is in place, we can probably
> sort device and/or driver lists to optimize the probe order (maybe the
> driver core already does that now?).
> 
> Get rid of the auto disabling of clocks and regulators in
> late_initcall. It's simply not a valid marker that boot is done when
> modules are involved. We probably can't get rid of it as lot's of
> platforms rely on that, so it will have to be opt out. Make it the
> platform's responsibility for ensuring a consistent state.
> 
> Perhaps we need a 'boot done' or 'stop deferring probe' trigger from
> userspace in order to make progress if dependencies are missing.

People have tried to do this multiple times, and you never really know
when "boot is done" due to busses that have discoverable devices and
async probing of other busses.

You do know "something" when you pivot to a new boot disk, and when you
try to load init, but given initramfs and the fact that modules are
usually included on them, that's not really a good indication that
anything is "finished".

I don't want userspace to be responsible for telling the kernel, "hey
you should be finished now!", as that's an async notification that is
going to be ripe for problems.

I really like the "depends-on" information, as it shows a topology that
DT doesn't seem to be able to show today, yet we rely on it in the
kernel with the whole deferred probing mess.  To me, there doesn't seem
to be any other way to properly "know" this.

> Or
> maybe just some timeout would be sufficient. I think this is probably
> more useful for development than in a shipping product. Even if you
> could fallback to polling mode instead of interrupts for example, I
> doubt you would want to in a product.

timeouts suck.  And do not work for shipping products.  I want a device
with 100 modules that relys on DT to be able to boot just as fast as a
laptop with 100 modules that has all of the needed dependancies
described today in their bus topologies, because they used sane hardware
(i.e. PCI and ACPI).  Why hurt embedded people just because their
hardware relies on a system where you have to loop for long periods of
time because DT can not show the topology correctly?

> You should also keep in mind that everything needed for a console has
> to be built in. Maybe Android can say the console isn't needed, but in
> general we can't.

What does a console have to do with any of this?

confused,

greg k-h
