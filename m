Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E462EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2596215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560358405;
	bh=Gd7nBWu/riqqrCDPNE/lLbFZw/bok7CFxpqiLS1z7Hg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zgsyFE+8BraE2BZGAadH1UgUxWEzBEOVDPMfr+x60BQhWh5QDudV/BbqCJQyA/BXG
	 JEHZU3Wwge9elfp7rze7iVr6BCth9YC/iSGDD3cOZkxU/lNlYzQLYrTDgdNOYRR0su
	 C8d6UI/7AUDFahLhJ+3UP3tE94gN1zpQSUhs5yOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440381AbfFLQxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438136AbfFLQxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:53:24 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 734B82175B;
        Wed, 12 Jun 2019 16:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560358402;
        bh=Gd7nBWu/riqqrCDPNE/lLbFZw/bok7CFxpqiLS1z7Hg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tHjJuSSqSc40TKCZhqCtBd9FwSB5NesiqDvR+dwJl9OnXwDL7esTkaoIRwKz6AoLN
         C1aBlMs6YvND+2k1AToSIje6ZNcXruYYmwqlLUUx2zhx02UAFsN6sWJPFRifEDf9ms
         9Ql1gCxVTc4YWWFiSS0skQd03vPuQC9jtz0wo+FE=
Received: by mail-qt1-f173.google.com with SMTP id p15so11821753qtl.3;
        Wed, 12 Jun 2019 09:53:22 -0700 (PDT)
X-Gm-Message-State: APjAAAW9pyZb2zAVikWJO8/urxXV94cyH9vHn+Vrn3E5T9OTn07FbtTW
        TcJr9hFSPZn/nhAnqlQsiNk+DD4QUsv1R6y0Og==
X-Google-Smtp-Source: APXvYqwJV+lNBALkfNRQQDHDd46j42QAXY/jSP4T6xAdoZjMLwgNlJNnq1TwPeKeUlfWYQuJPp6BY24VcaYogLfgK1A=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr18637897qth.136.1560358401600;
 Wed, 12 Jun 2019 09:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190604003218.241354-1-saravanak@google.com> <20190604003218.241354-2-saravanak@google.com>
 <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com>
 <570474f4-8749-50fd-5f72-36648ed44653@gmail.com> <CAGETcx8M3YkUBZ-e2LLfrbWgnMKMMNG5cv=p8MMmBe7ZyPJ7xw@mail.gmail.com>
 <20190611215242.GE212690@google.com> <CAL_Jsq+V9QUBpzmPyYjWe93-06-mpU=5JmUqvf-QsnuLxPnmUA@mail.gmail.com>
 <20190612142159.GA11563@kroah.com>
In-Reply-To: <20190612142159.GA11563@kroah.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 12 Jun 2019 10:53:09 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+x=_6jfC7hkHy+zAaPRB_3K7i9axRiBMHGE9mHQQtPtg@mail.gmail.com>
Message-ID: <CAL_Jsq+x=_6jfC7hkHy+zAaPRB_3K7i9axRiBMHGE9mHQQtPtg@mail.gmail.com>
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

On Wed, Jun 12, 2019 at 8:22 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 12, 2019 at 07:53:39AM -0600, Rob Herring wrote:
> > On Tue, Jun 11, 2019 at 3:52 PM Sandeep Patil <sspatil@android.com> wrote:
> > >
> > > On Tue, Jun 11, 2019 at 01:56:25PM -0700, 'Saravana Kannan' via kernel-team wrote:
> > > > On Tue, Jun 11, 2019 at 8:18 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > > > >
> > > > > Hi Saravana,
> > > > >
> > > > > On 6/10/19 10:36 AM, Rob Herring wrote:
> > > > > > Why are you resending this rather than replying to Frank's last
> > > > > > comments on the original?
> > > > >
> > > > > Adding on a different aspect...  The independent replies from three different
> > > > > maintainers (Rob, Mark, myself) pointed out architectural issues with the
> > > > > patch series.  There were also some implementation issues brought out.
> > > > > (Although I refrained from bringing up most of my implementation issues
> > > > > as they are not relevant until architecture issues are resolved.)
> > > >
> > > > Right, I'm not too worried about the implementation issues before we
> > > > settle on the architectural issues. Those are easy to fix.
> > > >
> > > > Honestly, the main points that the maintainers raised are:
> > > > 1) This is a configuration property and not describing the device.
> > > > Just use the implicit dependencies coming from existing bindings.
> > > >
> > > > I gave a bunch of reasons for why I think it isn't an OS configuration
> > > > property. But even if that's not something the maintainers can agree
> > > > to, I gave a concrete example (cyclic dependencies between clock
> > > > provider hardware) where the implicit dependencies would prevent one
> > > > of the devices from probing till the end of time. So even if the
> > > > maintainers don't agree we should always look at "depends-on" to
> > > > decide the dependencies, we still need some means to override the
> > > > implicit dependencies where they don't match the real dependency. Can
> > > > we use depends-on as an override when the implicit dependencies aren't
> > > > correct?
> > > >
> > > > 2) This doesn't need to be solved because this is just optimizing
> > > > probing or saving power ("we should get rid of this auto disabling"):
> > > >
> > > > I explained why this patch series is not just about optimizing probe
> > > > ordering or saving power. And why we can't ignore auto disabling
> > > > (because it's more than just auto disabling). The kernel is currently
> > > > broken when trying to use modules in ARM SoCs (probably in other
> > > > systems/archs too, but I can't speak for those).
> > > >
> > > > 3) Concerns about backwards compatibility
> > > >
> > > > I pointed out why the current scheme (depends-on being the only source
> > > > of dependency) doesn't break compatibility. And if we go with
> > > > "depends-on" as an override what we could do to keep backwards
> > > > compatibility. Happy to hear more thoughts or discuss options.
> > > >
> > > > 4) How the "sync_state" would work for a device that supplies multiple
> > > > functionalities but a limited driver.
> > >
> > > <snip>
> > > To be clear, all of above are _real_ problems that stops us from efficiently
> > > load device drivers as modules for Android.
> > >
> > > So, if 'depends-on' doesn't seem like the right approach and "going back to
> > > the drawing board" is the ask, could you please point us in the right
> > > direction?
> >
> > Use the dependencies which are already there in DT. That's clocks,
> > pinctrl, regulators, interrupts, gpio at a minimum. I'm simply not
> > going to accept duplicating all those dependencies in DT. The downside
> > for the kernel is you have to address these one by one and can't have
> > a generic property the driver core code can parse. After that's in
> > place, then maybe we can consider handling any additional dependencies
> > not already captured in DT. Once all that is in place, we can probably
> > sort device and/or driver lists to optimize the probe order (maybe the
> > driver core already does that now?).
> >
> > Get rid of the auto disabling of clocks and regulators in
> > late_initcall. It's simply not a valid marker that boot is done when
> > modules are involved. We probably can't get rid of it as lot's of
> > platforms rely on that, so it will have to be opt out. Make it the
> > platform's responsibility for ensuring a consistent state.
> >
> > Perhaps we need a 'boot done' or 'stop deferring probe' trigger from
> > userspace in order to make progress if dependencies are missing.
>
> People have tried to do this multiple times, and you never really know
> when "boot is done" due to busses that have discoverable devices and
> async probing of other busses.

Yes, I know which is why I proposed the second name with more limited
meaning/function.

> You do know "something" when you pivot to a new boot disk, and when you
> try to load init, but given initramfs and the fact that modules are
> usually included on them, that's not really a good indication that
> anything is "finished".
>
> I don't want userspace to be responsible for telling the kernel, "hey
> you should be finished now!", as that's an async notification that is
> going to be ripe for problems.

The usecase I care about here is when the DT has the dependency
information, but the kernel doesn't have the driver and the dependency
is never resolved. The same problem has to be solved with a
'depends-on' property. This easily happens with a new DT with added
dependencies like pinctrl and an old kernel that doesn't have the
"new" driver. Another example is IOMMUs. We need some way to say stop
waiting for dependencies. It is really just a debug option (of course,
how to prevent a debug option from being used in production?). This
works now for built-in cases with the same late_initcall abuse.

Using late_initcall_sync as an indicator has all the same problems
with userspace indicating boot finished. We should get rid of the
late_initcall_sync abuses and stop trying to work around them.

> I really like the "depends-on" information, as it shows a topology that
> DT doesn't seem to be able to show today, yet we rely on it in the
> kernel with the whole deferred probing mess.  To me, there doesn't seem
> to be any other way to properly "know" this.

As I said, DT *does* have this dependency information already. The
problem is the kernel probing doesn't use it. Fix that and then we can
discuss dependencies the DT doesn't provide that the kernel needs.

> > Or
> > maybe just some timeout would be sufficient. I think this is probably
> > more useful for development than in a shipping product. Even if you
> > could fallback to polling mode instead of interrupts for example, I
> > doubt you would want to in a product.
>
> timeouts suck.  And do not work for shipping products.  I want a device
> with 100 modules that relys on DT to be able to boot just as fast as a
> laptop with 100 modules that has all of the needed dependancies
> described today in their bus topologies, because they used sane hardware
> (i.e. PCI and ACPI).  Why hurt embedded people just because their
> hardware relies on a system where you have to loop for long periods of
> time because DT can not show the topology correctly?

I failed to list buses, but those too are already described in DT. Bus
dependencies are handled already.

> > You should also keep in mind that everything needed for a console has
> > to be built in. Maybe Android can say the console isn't needed, but in
> > general we can't.
>
> What does a console have to do with any of this?

Do you want to move all the SoC support to modules and have a console?
That doesn't work. Dependencies for the console have to be resolved
before initcalls are done. I don't recall the exact details, but I did
hit that issue when working on handling the missing dependency issues
(25b4e70dcce9 driver core: allow stopping deferred probe after init).

The point is that moving things to modules does introduce issues
beyond just dependency tracking.

Rob
