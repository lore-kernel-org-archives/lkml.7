Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138E5C742A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3AF20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pC1rUeUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfGKXHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:07:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44507 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfGKXHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 19:07:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so3774371plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 16:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qGhOFVVuh1+hXZl4hRpVsq3pyMl58gDzWUfgabd5Wk=;
        b=pC1rUeUsUJNlod97gWaG8RwEIRMJ93XD8nEOvbudDiOflrPz5bNgkYB222olkOK9e+
         JMU0yF7nevaJlsRDSsArz0mFViMjF9lPxyrS3GKMMN9gtFjxjdCPcy0SkmnVR7HbqZ6v
         PSPmg2HKo6W0Lo4P/ljzZOUCkURcTYTt2JwJtxuJpEbpW1OzsydcW3y9mMIzVcWFnCDk
         dvhdDm49LwMroorcny0EwN6pUR5cskCwzJVah8Kj93nG+hrYRDt70gDZa2M4u8jnYUJ6
         9oiBkwY5uQ7JSaZ8Kx8wwzk4+zQb8p4/GcR5a4Y0Wz21K85cQBCRr74t1p9Lk8/CXMIN
         RgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qGhOFVVuh1+hXZl4hRpVsq3pyMl58gDzWUfgabd5Wk=;
        b=ceXt6FUhF7SEPlbj6C0hD4vfJOZstK9Q8Q0APHrDhRQKKhenQ8QZiXpiKlfA3ONXXh
         Fwoe3zTD2yyDRPHtPyy3YSoyOc7QHxgBUpyzXxXPEg4d8uoP5sMMtcdlT/te5pRo18kB
         ndIp7dHkSjyBiaKOeuFqy5MoMfRp0fx8YomjTBvOnxB8rEzcNXuPnki0NGKJVg9lWEti
         XxrSCfPr1+8lVVTy/Q/nELmI+3BaNxIIZMnxy/dj1g5ttOK054YynjX4z57hEvM4APed
         5DjWUbde6TmKz4k5J6pXmqjZf7u+SM9gmjE6DtSGwsxOy41IqUwPhtqxfNwsGALgzPHG
         REPA==
X-Gm-Message-State: APjAAAUV/ciWGY/qJdA/Q1T3C7txaoRBUFbdSrMNKu18rhR8AtfcOUWN
        kP3JALsFlaiwQqw/TTDOz65DGtXQd3Au0VOx7agR4A==
X-Google-Smtp-Source: APXvYqwRbzXfz8+tRkRk82bppmgo6RvJOCW4UL3hfJaEFcemn8pvU0j0qx9PoyKqBSvgnFguiW0Yk1JoGcCum2yuM/w=
X-Received: by 2002:a17:902:1004:: with SMTP id b4mr7521409pla.325.1562886458358;
 Thu, 11 Jul 2019 16:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20160825201919.GE3296@wotan.suse.de> <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de> <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
 <20190629084257.GA1227@kroah.com> <20190702205106.GR19023@42.do-not-panic.com>
 <20190703074048.GH3033@kroah.com> <20190703165020.GV19023@42.do-not-panic.com>
 <20190703185758.GB14336@kroah.com> <20190703222531.GX19023@42.do-not-panic.com>
In-Reply-To: <20190703222531.GX19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 11 Jul 2019 16:07:27 -0700
Message-ID: <CAFd5g45nGf-abwtNzSOo8suGyhzTEEQbiq7yNCS8XoO4ezA=UQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Cristina Moraru <cristina.moraru09@gmail.com>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        backports@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Bolle <pebolle@tiscali.nl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Tejun Heo <tj@kernel.org>,
        Jej B <James.Bottomley@hansenpartnership.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Daniel Jonsson <danijons@student.chalmers.se>,
        Andrzej Wasowski <wasowski@itu.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 3:25 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Jul 03, 2019 at 08:57:58PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 03, 2019 at 04:50:20PM +0000, Luis Chamberlain wrote:
> > > On Wed, Jul 03, 2019 at 09:40:48AM +0200, Greg Kroah-Hartman wrote:
> > > > On Tue, Jul 02, 2019 at 08:51:06PM +0000, Luis Chamberlain wrote:
> > > > > On Sat, Jun 29, 2019 at 10:42:57AM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Fri, Jun 28, 2019 at 11:40:22AM -0700, Luis Chamberlain wrote:
> > > > > > > On Wed, Jun 26, 2019 at 9:51 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jun 26, 2019 at 03:21:08PM -0700, Luis Chamberlain wrote:
> > > > > > > > > On Tue, Feb 5, 2019 at 2:07 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > > > > > > > In lieu of no Luke Skywalker, if you will, for a large kconfig revamp
> > > > > > > > > > on this, I'm inclined to believe *at least* having some kconfig_symb
> > > > > > > > > > exposed for some modules is better than nothing. Christoph are you
> > > > > > > > > > totally opposed to this effort until we get a non-reverse engineered
> > > > > > > > > > effort in place? It just seems like an extraordinary amount of work
> > > > > > > > > > and I'm not quite sure who's volunteering to do it.
> > > > > > > > > >
> > > > > > > > > > Other stakeholders may benefit from at least having some config -->
> > > > > > > > > > module mapping for now. Not just backports or building slimmer
> > > > > > > > > > kernels.
> > > > > > > > >
> > > > > > > > > Christoph, *poke*
> > > > > > > >
> > > > > > > > Yes, I'm still totally opposed to a half-backed hack like this.
> > > > > > >
> > > > > > > The solution puts forward a mechanism to add a kconfig_symb where we
> > > > > > > are 100% certain we have a direct module --> config mapping.
> > > > > > >
> > > > > > > This is *currently* determined when the streamline_config.pl finds
> > > > > > > that an object has only *one* associated config symbol associated. As
> > > > > > > Cristina noted, of 62 modules on a running system 58 of them ended up
> > > > > > > getting the kconfig_symb assigned, that is 93.5% of all modules on the
> > > > > > > system being tested. For the other modules, if they did want this
> > > > > > > association, we could allow a way for modules to define their own
> > > > > > > KBUILD_KCONF variable so that this could be considered as well, or
> > > > > > > they can look at their own kconfig stuff to try to fit the model that
> > > > > > > does work. To be clear, the heuristics *can* be updated if there is
> > > > > > > confidence in alternative methods for resolution. But since it is
> > > > > > > reflective of our current situation, I cannot consider it a hack.
> > > > > > >
> > > > > > > This implementation is a reflection of our reality in the kernel, and
> > > > > > > as has been discussed in this thread, if we want to correct the gaps
> > > > > > > we need to do a lot of work. And *no one* is working towards these
> > > > > > > goals.
> > > > > > >
> > > > > > > That said, even if you go forward with an intrusive solution like the
> > > > > > > one you proposed we could still use the same kconfig_symb...
> > > > > > >
> > > > > > > So no, I don't see this as a hack. It's a reflection as to our current
> > > > > > > reality. And I cannot see how the kconfig_symb can lie or be
> > > > > > > incorrect. So in fact I think that pushing this forward also makes the
> > > > > > > problem statement clearer for the future of what semantics needs to be
> > > > > > > addressed, and helps us even annotate the problematic areas of the
> > > > > > > kernel.
> > > > > > >
> > > > > > > What negative aspects do you see with this being merged in practice?
> > > > > >
> > > > > > I'm trying to see what the actual problem that you are wanting to solve
> > > > > > here with this.  What exactly is it?
> > > > >
> > > > > The problem is that there is no current maping of a module to respective
> > > > > kconfig symbol.
> > > >
> > > > That's because it is not just "one" symbol per module.
> > >
> > > This is true. But it is not the case for all modules.  In fact it seems
> > > its true that most modules do have *one* main symbol.
> >
> > You mean "one unique symbol from all other modules", right?
>
> I mean that in the typical case you have *one* main *parent* symbol defining
> one device driver for one piece of hardware.
>
> > That is much different than just "one" symbol, given that almost
> > every driver depends on something else being enabled as well (bus type,
> > platform type, arch, etc.)
>
> Yes but that is different than what is trying to be addressed.
>
> > And I would argue, that finding that "one" symbol is easy, just parse
> > the Makefiles.  But I would also state that this "one" symbol doesn't
> > really help you much as those are the "simple" things.  It's how to
> > turn on all of the required symbols to get to that "one" symbol that is
> > the hard part.
>
> Absolutely, but *that* is a different problem! But I am glad you brought
> that up and acknowledge it. Addressing that problem will take time and
> folks are working towards it. Addressing that problem will still however
> not address the problem being addressed here.
>
> > And conversely, if you disable that "one" symbol, does that also mean
> > you can disable the symbols it depended on?  If so, how far back?
>
> Right..
>
> > And what about functionality?  If my usb-storage device is "enabled" in
> > the build, yet all filesystems are not, or the needed dm module is not,
> > it is useless.
>
> Yes. The localmodconfig approach is to keep enabled as modules *all* currently
> enabled modules, that covers that.
>
> But again, this is a separate problem. The one I am addressing, on
> behalf of Cristina, is a subspace, dedicated towards *hardware*
> functionality.

Hmm...maybe this isn't what I am looking for then. I am interested in
the problem of figuring out what dependencies I need to select to turn
on a desired config symbol (which is obviously a separate issue), and
I am interested in associating symbols with a config symbol and then
ensuring that symbol is exercised. Basically, I want a way to make
sure my tests actually get run without a human looking at them; I feel
like what you are working on might help with this latter issue, but I
am not 100% sure. It sounds like it is not your primary goal in any
case.

> > Hardware requires usually more than one real "symbol" in
> > order to work properly, as you know.
>
> Right. This does not mean that this information of parent main symbol is
> not useful. And having it available on the modules can help with
> multiple goals, without requiring kernel sources.
>
> > And of course, what does this really matter to anyone?  If you build
> > "all modules" and you only load the modules you actually use for your
> > hardware (based on auto-loading), then your system uses the same amount
> > of memory as if you disabled all of the modules you did not need.
>
> For backports it means you can enable only what you need, or at least
> show users what modules in a backports release could be upgraded and let
> you enable / disable them.  For other users, people can care about build
> time. And not everyone has fancy systems to build all modules; and
> sometimes you may just want to enable a small qemu system and build
> locally on it, enabling all modules on such systems would just be
> extremely silly.
>
> > Yes, it's faster to build, but is that what you are trying to optimize
> > for here?
>
> Particularly for me, yes. Others have other needs and I have already
> stated clearly what the gains are.
>
> > Anyway, if this is just an acidemic thing, have fun, but I would not be
> > adding anything else to the module image that is not really going to be
> > useful to anyone.
>
> The academic consensus is kconfig semantics are poo and we need to do
> slowly start addressing this. I believe that striving towards having
> one kconfig symbol per hw component can help long term, and in the
> meantime, this also will help with the 'make localmodconfig' and
> backport users.
>
> > good luck!
>
> This is not about luck. If you don't want to address these problems,
> that's fine, but please provide objective considerations rather than
> right out rejection without a reasonable basis. Or even better, provide
> alternative recommendations.
>
> The alternative Christoph recommended is hugely instrusive, no one is
> working on it, and the simple solution proposed in this thread at least
> gets us a small step forward in helping to enable a few more users,
> while also postulating if we should strive towards having one main kconfig
> for each hw component. Since it seems this is already the case, and
> there are only a few outliers, this effort should help spot outliers
> and address them to help with our semantics.

Ooo, looks like I should take a look at that.

Cheers!
