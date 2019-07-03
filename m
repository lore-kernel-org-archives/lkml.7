Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CF9C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB842189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562172626;
	bh=pZgbZDta30FXAJEj8Gmbq46C9Lx8HPHbzn0oIFnUH2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zq3q9SUXM3RvWCxV+y5KPHHNdxQmjWJUS2EtonLcPUaDq3bi8u5hC1nsr2c/eN4G2
	 6YlZ1SUqCX7UuudgY0+WLwHp3antUM610cnptIdLel99+YWyCC/5He5KipOMbBJVyk
	 Pi49olxjYyLCNM5uXZkJsTQ5sQRXfBkvyBNu5v4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfGCQuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:50:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36552 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGCQuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:50:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so1566798pfl.3;
        Wed, 03 Jul 2019 09:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sNrKHgbuNiAJqEKHtSZuZ2LxkmuMJR3AaNrNrxjF63M=;
        b=p/NhCUvzQRLPhrRbKFRQ7Il/vbuKedO9IXXuDebWkYn0WwD/VvSI+BGYR5LMYMCikz
         z/Al/ZzOdsDvqGowAm+F+2odUhD6SltTzjsP8K1yRl2GLlPNux+3qLrNSaQyj+hNeTVK
         8GaX8FWaRNyZHDpgRjb96VR7DUwJp6FOfsTUhDIMGh328QugWujSzcVuoPtE9LRWPCfP
         rGc/L6wyus6c8dE3ouFUNvkPFl1rh4VIuvoEUCWav7ke4C7jC3dSavZb4vugW+wQHzqN
         NcyYFH/X6xoGUjnu4ycDKS+gvV8hZncZS+g4NajeNLlwCcASCGu5ndiYeOeMCe/ltyqo
         hGCw==
X-Gm-Message-State: APjAAAWZB96mEEALpqbiz1Htct8BZSCSepysQF73C0kaNu83aWukr3CX
        qf7H75WhHtgVH46nxhb4yYs=
X-Google-Smtp-Source: APXvYqwZboW6PDUT27v1bv6bh9maZq3up5/R4jthoHmcl2Ng0duoraw5JUELhb9eKaJzIVKGVayrYQ==
X-Received: by 2002:a65:404a:: with SMTP id h10mr39043395pgp.262.1562172623538;
        Wed, 03 Jul 2019 09:50:23 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h18sm4828442pfr.75.2019.07.03.09.50.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 09:50:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F283C402AC; Wed,  3 Jul 2019 16:50:20 +0000 (UTC)
Date:   Wed, 3 Jul 2019 16:50:20 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Brendan Higgins <brendanhiggins@google.com>,
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
        Theodore Ts'o <tytso@mit.edu>,
        Daniel Jonsson <danijons@student.chalmers.se>,
        Andrzej Wasowski <wasowski@itu.dk>
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
Message-ID: <20190703165020.GV19023@42.do-not-panic.com>
References: <20160818175505.GM3296@wotan.suse.de>
 <20160825074313.GC18622@lst.de>
 <20160825201919.GE3296@wotan.suse.de>
 <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de>
 <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
 <20190629084257.GA1227@kroah.com>
 <20190702205106.GR19023@42.do-not-panic.com>
 <20190703074048.GH3033@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703074048.GH3033@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 09:40:48AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 02, 2019 at 08:51:06PM +0000, Luis Chamberlain wrote:
> > On Sat, Jun 29, 2019 at 10:42:57AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jun 28, 2019 at 11:40:22AM -0700, Luis Chamberlain wrote:
> > > > On Wed, Jun 26, 2019 at 9:51 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > >
> > > > > On Wed, Jun 26, 2019 at 03:21:08PM -0700, Luis Chamberlain wrote:
> > > > > > On Tue, Feb 5, 2019 at 2:07 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > > > > In lieu of no Luke Skywalker, if you will, for a large kconfig revamp
> > > > > > > on this, I'm inclined to believe *at least* having some kconfig_symb
> > > > > > > exposed for some modules is better than nothing. Christoph are you
> > > > > > > totally opposed to this effort until we get a non-reverse engineered
> > > > > > > effort in place? It just seems like an extraordinary amount of work
> > > > > > > and I'm not quite sure who's volunteering to do it.
> > > > > > >
> > > > > > > Other stakeholders may benefit from at least having some config -->
> > > > > > > module mapping for now. Not just backports or building slimmer
> > > > > > > kernels.
> > > > > >
> > > > > > Christoph, *poke*
> > > > >
> > > > > Yes, I'm still totally opposed to a half-backed hack like this.
> > > > 
> > > > The solution puts forward a mechanism to add a kconfig_symb where we
> > > > are 100% certain we have a direct module --> config mapping.
> > > > 
> > > > This is *currently* determined when the streamline_config.pl finds
> > > > that an object has only *one* associated config symbol associated. As
> > > > Cristina noted, of 62 modules on a running system 58 of them ended up
> > > > getting the kconfig_symb assigned, that is 93.5% of all modules on the
> > > > system being tested. For the other modules, if they did want this
> > > > association, we could allow a way for modules to define their own
> > > > KBUILD_KCONF variable so that this could be considered as well, or
> > > > they can look at their own kconfig stuff to try to fit the model that
> > > > does work. To be clear, the heuristics *can* be updated if there is
> > > > confidence in alternative methods for resolution. But since it is
> > > > reflective of our current situation, I cannot consider it a hack.
> > > > 
> > > > This implementation is a reflection of our reality in the kernel, and
> > > > as has been discussed in this thread, if we want to correct the gaps
> > > > we need to do a lot of work. And *no one* is working towards these
> > > > goals.
> > > > 
> > > > That said, even if you go forward with an intrusive solution like the
> > > > one you proposed we could still use the same kconfig_symb...
> > > > 
> > > > So no, I don't see this as a hack. It's a reflection as to our current
> > > > reality. And I cannot see how the kconfig_symb can lie or be
> > > > incorrect. So in fact I think that pushing this forward also makes the
> > > > problem statement clearer for the future of what semantics needs to be
> > > > addressed, and helps us even annotate the problematic areas of the
> > > > kernel.
> > > > 
> > > > What negative aspects do you see with this being merged in practice?
> > > 
> > > I'm trying to see what the actual problem that you are wanting to solve
> > > here with this.  What exactly is it?
> > 
> > The problem is that there is no current maping of a module to respective
> > kconfig symbol.
> 
> That's because it is not just "one" symbol per module.

This is true. But it is not the case for all modules.  In fact it seems
its true that most modules do have *one* main symbol.

On at least Cristina's system of of 62 modules 58 *did* have one symbol.
For the modules evaluated where this was not the case, it did seem wise
to actually revise the symbol definition for the other modules.

> If it were, you can just parse the Makefiles and get that single config
> option for most modules, right?

The heuristic essentially does this and only provides the module
attribute where this was true.

> But even then, multiple options can
> influence a single module as to what actually gets built into that
> module.

Yes. For example one hardware device driver may support different
families of chipsets, and so it could have sub-options for each
family.

> So, I would say, "who really cares"?

For most visible modules it would seem we do have a one config symbol
mapping which could enable it. And I noted who would care. The defaults
of a module, for instance sub-options to enable / disable different
support for different chipsets, *should* suffice for most users.

> > > Who needs to determine the
> > > "singular" configuration option that caused a kernel module to be built
> > > at the expense of all other options?
> > 
> > Folks wanting to slim down their kernel build, and users of backports.
> 
> People who want to "slim" down things are rare, 

It is basic math though:

Users of 'make localmodconfig' +  backport users > Users of 'make localmodconfig'

And yet we already support 'make localmodconfig'. So what is being
proposed can help enhance 'make localmodconfig' and yet provides more
users outside of those users, without requiring kernel sources.

> and it's usually worth
> it to work backwards anyway (see what functionality is needed and then
> go from there, not look at the modules themselves).  Or use a tool like
> 'make localmodconfig' and trim.

And I am noting we can further enhance a feature which we already
do support, and enable *more* users requiring similar information.

> > > What can that be used for and who will use it?
> > 
> > Without a mapping there is no clean way to let you slim down your kernel
> > using a distro kernel as a base, enabling only those things you really
> > need.
> 
> It's hard to determine "what you really need" :)

Right, but at least for device functionality, the above would help
significantly. It also poses the question whether or not device drivers
*should* strive towards having one kconfig symbol to help with this.

There is a lot of research over the lack of proper semantics on use of
kconfig, and issues this causes. It is so bad that some researchers have
tried define our semantics through *reverse engineering*. The question
of whether or not we *should* strive to have *one* symbol per a driver
for an actual hardware component is worth evaluating long term, for the
sake of helping with semantics of kconfig use. I see there being gains
with this, and I find it hard to find counters to where quite the
opposite is true. Can you?

> Use localmodconfig and you have a great start, then prune from there.

This thread poses the question if we can do better, and suggests one
small area where we can start.

> Trying to put _all_ configuration dependencies in a single module isn't
> going to work, our configuration language does not distill down to that.

The question we should be evaluating if we *should* strive to buckle up
on this and have at least one config symbol per module associated with
hardware. I'm suggesting there are gains for this, and am providing two
groups of users that would benefit from this clearly. And I'm also
suggesting that it could help with kconfig semantics, long term.

  Luis
