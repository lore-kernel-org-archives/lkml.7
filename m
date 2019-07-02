Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599B5C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2963F218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562114011;
	bh=wATDrZHVWhpPLtBeufdGgAHA08DHSyOqLPshf0r3wFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iU98XO+1OGx3hrNIvs4RbthE1Ss3RhJbHuzAr5eUqFjj222xQV5cqMiYzICe+4zDz
	 W1MqLu8WnIK7p891D4S0pfO05JXbchFNs9B+yICHeXB8o4BeiGlJrTqW7qKyt/dqZP
	 FxFPs479XxinTsNWcF8clJ/EgHufMsCxKsEut8y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfGCAda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:33:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38689 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfGCAd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:33:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id v186so564474oie.5;
        Tue, 02 Jul 2019 17:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Yr9yB1AZWsS/mXrXMLz4bQ3WuzbAZMzXcbw5fV8dFU=;
        b=fCMtcAqwIA42N7v5UaHJgxBXWbBpJEJ9TRcCUuj9G1HbeNJWuo0ngmGsmlpLMoXi/p
         tOoQoYbCVXHn90lUO47Yg+s8bjoT3EYU6l7kiGY2vYaErwBS/+yUP/w6vbuDI5ywUb76
         nnEbTuhOYAQ6wRDJgY6v7BePVGNSEjO0JojT23qUCNST5UmLHvRm7bIJXIf2Y+drOQS3
         559Ctjj28DFOGbQjIkS/SfQek00VkNZDMb0/bYue3Ht850UADjD5nKjrfGi5WXgIFMpU
         XWca17OJXpKJENHyYNqHufDAT0WWKyUIy6sBgstPhM1X8Ze9quBQDQIjJjv+sqM+xkER
         fSAw==
X-Gm-Message-State: APjAAAUT+pp8CpEx1cRYa8EubtU6Jp3pNpyNzr8INX9UonTa2fp8aELJ
        C3HhOi8lycv3PMGpmzS/C12BKvdI2PE=
X-Google-Smtp-Source: APXvYqy5KGKngrSYbRV/7vvhT1vc4EmSL/bLYZA8Z4fnRwFodgiMd2Azhb2Gluj5lLc2OYYuLDfJ4Q==
X-Received: by 2002:a63:506:: with SMTP id 6mr20283387pgf.434.1562100668863;
        Tue, 02 Jul 2019 13:51:08 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g1sm36264pgg.27.2019.07.02.13.51.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 13:51:07 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 744EC40251; Tue,  2 Jul 2019 20:51:06 +0000 (UTC)
Date:   Tue, 2 Jul 2019 20:51:06 +0000
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
Message-ID: <20190702205106.GR19023@42.do-not-panic.com>
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de>
 <20160825074313.GC18622@lst.de>
 <20160825201919.GE3296@wotan.suse.de>
 <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de>
 <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
 <20190629084257.GA1227@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629084257.GA1227@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 10:42:57AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 28, 2019 at 11:40:22AM -0700, Luis Chamberlain wrote:
> > On Wed, Jun 26, 2019 at 9:51 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Wed, Jun 26, 2019 at 03:21:08PM -0700, Luis Chamberlain wrote:
> > > > On Tue, Feb 5, 2019 at 2:07 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > > In lieu of no Luke Skywalker, if you will, for a large kconfig revamp
> > > > > on this, I'm inclined to believe *at least* having some kconfig_symb
> > > > > exposed for some modules is better than nothing. Christoph are you
> > > > > totally opposed to this effort until we get a non-reverse engineered
> > > > > effort in place? It just seems like an extraordinary amount of work
> > > > > and I'm not quite sure who's volunteering to do it.
> > > > >
> > > > > Other stakeholders may benefit from at least having some config -->
> > > > > module mapping for now. Not just backports or building slimmer
> > > > > kernels.
> > > >
> > > > Christoph, *poke*
> > >
> > > Yes, I'm still totally opposed to a half-backed hack like this.
> > 
> > The solution puts forward a mechanism to add a kconfig_symb where we
> > are 100% certain we have a direct module --> config mapping.
> > 
> > This is *currently* determined when the streamline_config.pl finds
> > that an object has only *one* associated config symbol associated. As
> > Cristina noted, of 62 modules on a running system 58 of them ended up
> > getting the kconfig_symb assigned, that is 93.5% of all modules on the
> > system being tested. For the other modules, if they did want this
> > association, we could allow a way for modules to define their own
> > KBUILD_KCONF variable so that this could be considered as well, or
> > they can look at their own kconfig stuff to try to fit the model that
> > does work. To be clear, the heuristics *can* be updated if there is
> > confidence in alternative methods for resolution. But since it is
> > reflective of our current situation, I cannot consider it a hack.
> > 
> > This implementation is a reflection of our reality in the kernel, and
> > as has been discussed in this thread, if we want to correct the gaps
> > we need to do a lot of work. And *no one* is working towards these
> > goals.
> > 
> > That said, even if you go forward with an intrusive solution like the
> > one you proposed we could still use the same kconfig_symb...
> > 
> > So no, I don't see this as a hack. It's a reflection as to our current
> > reality. And I cannot see how the kconfig_symb can lie or be
> > incorrect. So in fact I think that pushing this forward also makes the
> > problem statement clearer for the future of what semantics needs to be
> > addressed, and helps us even annotate the problematic areas of the
> > kernel.
> > 
> > What negative aspects do you see with this being merged in practice?
> 
> I'm trying to see what the actual problem that you are wanting to solve
> here with this.  What exactly is it?

The problem is that there is no current maping of a module to respective
kconfig symbol.

> Who needs to determine the
> "singular" configuration option that caused a kernel module to be built
> at the expense of all other options?

Folks wanting to slim down their kernel build, and users of backports.

> What can that be used for and who will use it?

Without a mapping there is no clean way to let you slim down your kernel
using a distro kernel as a base, enabling only those things you really
need.

Historically those interested would just have streamline_config.pl at
their disposal, but it isn't perfect. Although Cristina extended
streamline_config.pl, the proper approach here would be to see if the
heuristics in streamline_config.pl which she made use of to map a config
symbol for a module could be written in C. The safe heuristic used is
that for modules where there was only one kconfig symbol associated,
we'd be certain that kconfig symbol was the one needed for that module.

A side benefit is also that by having a modinfo section for the kconfib
symbol we'd have access to it via sysfs, an example is
/sys/module/e1000/section/kconfig_symb, and then streamline_config.pl
could be simplified further by not having to parse Makefiles in perl.
The reason for using a modinfo section also is you could get the
information about configs needed for modules without requiring your
kernel sources, and this information then also becomes available to
augment udevadm for its own hardware db info.

Another set of users of this would be users of backports. For instance
users on distro kernels but their current kernel lacks updated drivers
for one of your devices, and you want to use a backports release, but
just want to build / only the drivers you really need for the release.
Backports then could easily scrape for the sysfs attribute / udevadm db
to let you build and install only the modules you need.

Long term users are developers working on trying to clear up kconfig
semantics. Having a clear indicator in our tree about modules where a
direct mapping was not possible (say with a KBUILD_KCONF definition in
their Makefiles to clarify which config symbol enables it) gives us an
idea of kconfig entries which may be contrived and could use some
clarifications.

  Luis
