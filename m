Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369E4C742A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF98D2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bs26fGes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfGKX1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:27:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44324 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfGKX1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 19:27:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so3637447pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 16:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQ/UPpkf43M39Y65vxIKz0SurwBx2n5nYoAUMAZvqZo=;
        b=bs26fGesVGhtAlKpxGQKx/4yxesmmf4BVK6RslfTMoW4o2RTYdTga3DXd0tl70DHAJ
         Hk4iRwq3kK9H92U7C2A8J8QL9mCYhRZTJYinFmXYWqDJuZuYJjkb9f36EpocDd8Yh85I
         lc/sbwwCH2VbBIFd8Gr1P7HJHiMRbnNnalYL9DzfglTi9z4ixW/rfMl3vfd8jQxI0Lun
         869Ei6CVv/H/7kJNBm4f6oZBo9nGXGLDvvOqw0QaAL3JwyeV5vTCfhsyDjija2iGx1lS
         XqvYEDLKbpciwVkfTK0r2CW4Age20yQWOmoM+KPbPyBA6iubaJwLD4/pH7YJlrPIl5CL
         3GxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQ/UPpkf43M39Y65vxIKz0SurwBx2n5nYoAUMAZvqZo=;
        b=SOenEJX7Hl4dYCxZs2YxFvUAWi52hWNyudNMVViQ9bzzx+XW5WWjeEGMkxRc1LXMG+
         f1qrQ/yxEpwtxosZ6bN02L1Uv4tvbuQUO7gZGx4SLUMI9fM1HMAYtSUi91n5wQXMQPF0
         a0otB/yjgGmQY7PZOm5zodc1h9wCxaLGLW/MgX8VbSeyaHIcxowye7snV24pwbf0ynmk
         9XZRr/tjJBgQfkD7AJBbkjQA989CZieHuculcfXAg3+Bm/kEwEZXDqoCHfsN3T2VBhKO
         /3x6i0rwkaBwp0r0zXxsFnPOb+Q6jbf4OnQUzZU24w54LlyAYu0QDjuk3GVzHrys7jhG
         XldA==
X-Gm-Message-State: APjAAAX8nG77eD4pYFp9eEH3DICRce7QTYEXyOjB1lHnZyJmy/6VSFz3
        KlTAs91z7sVBSmh3nAaKlT2RnXC3qahb1G/CQlMpDA==
X-Google-Smtp-Source: APXvYqx9Lvvdz2ECX8kvqwrUFdD7paFWZ0RppTN9lCPPNeAKdZpjp6ZOBV9wpD1zdS1TNxRwDh8b9WAJMGDLgfZekwA=
X-Received: by 2002:a63:eb51:: with SMTP id b17mr6896421pgk.384.1562887643142;
 Thu, 11 Jul 2019 16:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20160818175505.GM3296@wotan.suse.de> <20160825074313.GC18622@lst.de>
 <20160825201919.GE3296@wotan.suse.de> <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de> <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
 <40f70582-c16a-7de0-cfd6-c7d5ff9ead71@metux.net> <20190703173555.GW19023@42.do-not-panic.com>
 <9a2ae341-9ea7-d4c6-7c3e-b12bb6515905@metux.net> <20190703224234.GY19023@42.do-not-panic.com>
In-Reply-To: <20190703224234.GY19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 11 Jul 2019 16:27:11 -0700
Message-ID: <CAFd5g454UVYqm+HgA1nXsy-cAg_3gvjvZ4KQmW4P5gqpDp1WMg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Wed, Jul 3, 2019 at 3:42 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Jul 03, 2019 at 09:31:33PM +0200, Enrico Weigelt, metux IT consult wrote:
> > On 03.07.19 19:35, Luis Chamberlain wrote:
> >
> > Hi,
> >
> > >> Okay, but IIRC this will add more boilerplate those modules.
> > >
> > > Just one module attribute.
> >
> > Yes, but still one per module. This raises the question whether
> > maintainers are willing to cope w/ tons of tiny patches for just
> > one line - for something that will take quite some time to become
> > actually useful (doesn't help much if only few drivers support it),
> > and is only helpful in a few use cases.
>
> This can be wrapped in kconfig and disabled by default.
>
> > And to make it really useful, we also need some way to automatically
> > derive which other symbols to enable (subsystems, etc), w/o auto-
> > enabling stuff one doesn't need here. (are the defaults sane for
> > this usecase ?)
>
> No, that's a separate problem.

I am interested in this use case, but I agree that this is a separate issue.

Luis, I saw you cc'ed me on an email with the SAT solver people and
that they are still working on this. Enrico, want me to CC you on that
and we can continue this discussion there?

> > The main problem here, IMHO, is that the kconfig system doesn't really
> > know what makes up a module (it only knows that something w =y cant
> > depend on something thats =m).
> >
> > So it smalls like we'd need some config language that really understands
> > things like modules, subsystems, arches, etc with their properties and
> > is used by both kconfig and kbuild. Then we could put all metadata there
> > instead of the current macro calls. At that point we could also put
> > things like match tables in here, which would solve the problem of
> > finding the right driver by hardware descriptions.
> >
> > But that's really a *big* topic, it's not easy.
>
> Christoph's sugggestion goes along the lines with addressing some of
> this, yet 2 years havegone by and no one is working on it and its hugely
> intrusive. I'd welcome the patches.

I would like to see those. I would also very much like to see code
dependencies, not just kconfig dependencies, tracked in Kbuild
somehow.

> > >> And I wonder whether target binaries are the right place for those
> > >> things at all - IMHO that's something one wants to derive from the
> > >> source code  / .config's.
> > >
> > > For the use cases mentioned for why the module attribute is being
> > > suggested it would help to not have to download kernel sources.
> >
> > Are we still talking about compiling custom kernels ?
> > (how to do that w/o source code ?)
>
> There is a difference between getting kernel sources for your current
> running kernel Vs getting kernel sources from say Linus' tree or the
> stable tree, or whatever subsystem you work on. I'm saying that with
> a module attribute being present you would *not* have to get the kernel
> sources for the current kernel you are running.
>
> > > The only question we want to answer is: for the hardware components
> > > present on this system, which configs options do I need to enable
> > > to support these components?
> >
> > What else would one need that data, if not compiling a custom kernel
> > (which in turn needs the source) ?
>
> One is compiling a custom kernel.
>
> > > At least for virtualization we decided to support at least these two to
> > > help:
> > >
> > >   * make kvmconfig
> > >   * make xenconfig
> >
> > These two are rather simple. Most times there isn't much variance in
> > virtual hardware (unless one starts directly mapping in pci or usb
> > devices ...)
>
> Actually no, there is huge variance on the qemu level and that problem
> is not solved by the above.
>
> > > Similar problem would be found if one wanted to find a desirable kernel
> > > config for a remote system. One should be able to somehow scrape some
> > > hardware information, dump that to a file, and then somehow generate
> > > a working config for that system.
> >
> > Yes. That's actually pretty much the same usecase (in my case I'd also
> > have dts, lspci/lsusb output, etc)
> >
> > > The module attribute being suggested would enable at least one way
> > > to gather some of the required config symbols: symbols for *hardware*
> > > and where one can run a modern kernel, with many features / hardware
> > > enabled already.
> >
> > But only for a pretty specific usecase.
>
> Two: build time, and backports.

I think testing is another potential use case. Admittedly, I might
want something more general, but the general idea of being able to map
a config to code is super useful for automated testing.

For example, I want to run all tests. I enable all configs,cool. But
how do I know that the desired code under test actually ran?

Another example, okay I ran my tests and some of them failed. All my
test debug information is all mixed together and there is a lot of
noise present, also I am afraid that something else not part of the
test influenced the test or code under test behavior. So I want to
rerun the failed tests and the code that they test and nothing else.

> > I'm not opposed to this, but
> > I wonder whether maintainers are willing to accept that stuff for just
> > that specific usecase.
>
> This is why we are discussing this on this thread.
>
> Since we have 'make localmodconfig' already upstream, and since this
> would help both users of that and backports I'd argue it makes sense
> upstream. Otherwise I find it that having upstream 'make localmodconfig'
> but not wanting to improve that problem space rather odd.
>
> > > However, folks producing embedded systems *do* / *should* have a lot of
> > > knowledge of their systems, and so the type of scheme you have devised
> > > seems sensible for it.
> >
> > Usually we have (unless we need to do reverse engineering :o). But it's
> > a pretty time-consuming task. Especially if the requirements change
> > several times in the development or lifetime of a specific product.
> >
> > For example "oh, we now need eth", "naah, we don't wanna use usb
> > anymore", "let's take a different SoM", ... not that have pretty
> > orthogonal sets of configs we need to maintain: hardware- and non-
> > hardware-related ones. And hardware-related ones can fall into different
> > categories like fixed-attached/onboard vs. hotpluggable ones.
> >
> > Recently I had a case where the customer requested xattr support, so
> > I had to enable general xattr support as well as per-filesystem.
> > Pretty simple, but having lots of those cases quickly sums up. One of
> > the reasons why I've written my own little config generator.
>
> I agree that the problem space you are dealing with should be made
> easier.
>
> > >> In embedded world, we often have scenarios where we want a really
> > >> minimal kernel, but need to enable/disable certain hi-level peripherals
> > >> in the middle of the project (eg. "oh, we also need ethernet, but we
> > >> wanna drop usb"). There we'll have to find out what actual chip is,
> > >> its corresponding driver, required subsystems, etc, and also kick off
> > >> everything we don't need anymore.
> > >
> > > Right. One *should* be able to tell some tool, hey, here is the list of
> > > my desirable .config options. Go and figure out what I need to make that
> > > work and give me a resulting .config. Its not easy.
> >
> > I think I've already got into a pretty usable state - at least for my
> > projects. For now only supports a few boards and limited set of
> > features, but patches are always welcomed :)
>
> A solution upstream would be better ;)
>
> > >> I've thought about implementing some actual dependency tracking
> > >> (at least recording the auto-enabled symbols), but didn't expect that
> > >> to become practically usable anytime soon,
> > >
> > > The ability to easily ask the kernel to enable the components needed
> > > for a respective config option *is* very useful but indeed not easy.
> >
> > Yes, it would need to understand things like conditional definitions
> > to deduce that certain things need to be enabled first, before certain
> > drivers become choosable.
> >
> > > This is not the only space where this problem exists. Similar problem
> > > exists for distribution packages, and dependencies. Challenges have
> > > been made for proper research towards these problems, and such research
> > > has lead distributions to opt to enable some of these algorithms.
> >
> > The problem w/ dependencies is that there can be different types of
> > dependencies, as well as different types of software objects. Just
> > solving the expressions is only a part of the problem.
> >
> > > This begs the question if we could learn from similar efforts on Linux
> > > for these sorts of questions. One possibility here is to evaluate the
> > > prospect of using a SAT solver with Minimally Unsatisfiable Subformulas
> > > (MUSes) support, which should be be able to address thir problem. This
> > > prospect is ongoing and currrent R&D is active, for details refer to:
> > >
> > > https://kernelnewbies.org/KernelProjects/kconfig-sat
> >
> > Good tip, I'll have a look at it.
> >
> > > It certainly can be useful for components, ie, not hardware. But for
> > > hardware a one-to-one mapping of one driver to one config would be of
> > > much more use.
> >
> > Unfortunately, we don't have this 1:1 mapping. Often drivers support
> > different sets of devices, depending on other factors, sometimes sub-
> > options (eg. different hw versions), sometimes depending on other
> > subsystems, sometimes arch-specific, etc, etc.
> >
> > I think we should work towards that, but I doubt we'd reach that goal
> > anytime soon, and begs the question whether it's really worth all the
> > effort required for that.
>
> Code speaks, and fortunately its being worked on.
>
> > > It would be wonderful if for instance kconfig
> > > supported a way to group a major set of components under *one* config
> > > symbol and then say: "I want this major component enabled" and then it'd
> > > go and enable all the defaults which would be required for it.
> >
> > Yes, thought about that, too. For example have syms for selecting whole
> > boards and features of them - a bit like this:
> >
> >   --> Preconfigure for specific boards
> >       --> board A
> >       --> board B
> >       ...
> >   --> Enable board features
> >       --> Ethernet port
> >       --> Display
> >           --> Touch panel
> >       --> Audio
> >       ....
> >
> > BUT: this would turn into maintenance hell, so I dropped that idea.

I wonder if that would work for the testing scenario? I don't think it
is unreasonable for a test owner to provide a defconfig that makes it
possible to run their test. We could then merge these together to
create a kconfig to run all desired tests. Doesn't address all the
issues I mentioned here, but it's a start.

> > > An example is if you
> > > wanted to enable PCI on a system which didn't support it. Because of
> > > this, it seems you'd want *all* desirable configs and let a piece of
> > > software figure out what you need / can enable. And.. this is precisely
> > > where the SAT solver with MUSes could help...
> >
> > Yes, but this piece of software first needs to know whether eg. PCI
> > is available on that HW. Oh, and things like PCI could be a dependency
> > as well as an feature on its own, depending on how you gonna use it.
> > (eg. if directly access from userland or VMs).
>
> Yes, but that is a separate problem. The way 'make localmodconfig'
> addresses this is by keeping as modules things which are already
> modules. And keeping things it found as =y as buit-in in your kernel as
> well.

Cheers!
