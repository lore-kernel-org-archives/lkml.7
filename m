Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEC1C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF1F21897
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562139654;
	bh=+dS722UyAM8LRJCnQHjINVT/+tf8dVBhrK0IZ3tm/CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZckmTKxKXDFhBKYvyPMYBDAX/Xbj6vopeypkY0A1X3wPSPTd6d33mKIKsIbDCKl4w
	 lCyg4ehbBSjrlRXIha32Cczgpjy0E+hTtfNlSMhMjAD8K7FZgiQw7foCIqdIvBwkuo
	 T8yxMfyz+BeMzk1ErG0H+RS1gG5aX1B0xuV3mb2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfGCHkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfGCHkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:40:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 779BE21880;
        Wed,  3 Jul 2019 07:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562139650;
        bh=+dS722UyAM8LRJCnQHjINVT/+tf8dVBhrK0IZ3tm/CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBJkFDmxci6Z8zsCWUNvmR0m0RsWAxBygRAjGjX9b32Wg9Dp172aSxOjxbbTX+O8y
         yXkqIGjViFpsfsRUFuwHgUMhOgdhdh+F4uYafbJehQYBQ4n8xtXcLNfOp1HLA4hs2h
         AN1+onOF5W8kptSvU+uiCWxt8bc8A3wDT0acUX9E=
Date:   Wed, 3 Jul 2019 09:40:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <20190703074048.GH3033@kroah.com>
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de>
 <20160825074313.GC18622@lst.de>
 <20160825201919.GE3296@wotan.suse.de>
 <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de>
 <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
 <20190629084257.GA1227@kroah.com>
 <20190702205106.GR19023@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702205106.GR19023@42.do-not-panic.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 08:51:06PM +0000, Luis Chamberlain wrote:
> On Sat, Jun 29, 2019 at 10:42:57AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jun 28, 2019 at 11:40:22AM -0700, Luis Chamberlain wrote:
> > > On Wed, Jun 26, 2019 at 9:51 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Wed, Jun 26, 2019 at 03:21:08PM -0700, Luis Chamberlain wrote:
> > > > > On Tue, Feb 5, 2019 at 2:07 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > > > In lieu of no Luke Skywalker, if you will, for a large kconfig revamp
> > > > > > on this, I'm inclined to believe *at least* having some kconfig_symb
> > > > > > exposed for some modules is better than nothing. Christoph are you
> > > > > > totally opposed to this effort until we get a non-reverse engineered
> > > > > > effort in place? It just seems like an extraordinary amount of work
> > > > > > and I'm not quite sure who's volunteering to do it.
> > > > > >
> > > > > > Other stakeholders may benefit from at least having some config -->
> > > > > > module mapping for now. Not just backports or building slimmer
> > > > > > kernels.
> > > > >
> > > > > Christoph, *poke*
> > > >
> > > > Yes, I'm still totally opposed to a half-backed hack like this.
> > > 
> > > The solution puts forward a mechanism to add a kconfig_symb where we
> > > are 100% certain we have a direct module --> config mapping.
> > > 
> > > This is *currently* determined when the streamline_config.pl finds
> > > that an object has only *one* associated config symbol associated. As
> > > Cristina noted, of 62 modules on a running system 58 of them ended up
> > > getting the kconfig_symb assigned, that is 93.5% of all modules on the
> > > system being tested. For the other modules, if they did want this
> > > association, we could allow a way for modules to define their own
> > > KBUILD_KCONF variable so that this could be considered as well, or
> > > they can look at their own kconfig stuff to try to fit the model that
> > > does work. To be clear, the heuristics *can* be updated if there is
> > > confidence in alternative methods for resolution. But since it is
> > > reflective of our current situation, I cannot consider it a hack.
> > > 
> > > This implementation is a reflection of our reality in the kernel, and
> > > as has been discussed in this thread, if we want to correct the gaps
> > > we need to do a lot of work. And *no one* is working towards these
> > > goals.
> > > 
> > > That said, even if you go forward with an intrusive solution like the
> > > one you proposed we could still use the same kconfig_symb...
> > > 
> > > So no, I don't see this as a hack. It's a reflection as to our current
> > > reality. And I cannot see how the kconfig_symb can lie or be
> > > incorrect. So in fact I think that pushing this forward also makes the
> > > problem statement clearer for the future of what semantics needs to be
> > > addressed, and helps us even annotate the problematic areas of the
> > > kernel.
> > > 
> > > What negative aspects do you see with this being merged in practice?
> > 
> > I'm trying to see what the actual problem that you are wanting to solve
> > here with this.  What exactly is it?
> 
> The problem is that there is no current maping of a module to respective
> kconfig symbol.

That's because it is not just "one" symbol per module.

If it were, you can just parse the Makefiles and get that single config
option for most modules, right?  But even then, multiple options can
influence a single module as to what actually gets built into that
module.

So, I would say, "who really cares"?

> > Who needs to determine the
> > "singular" configuration option that caused a kernel module to be built
> > at the expense of all other options?
> 
> Folks wanting to slim down their kernel build, and users of backports.

People who want to "slim" down things are rare, and it's usually worth
it to work backwards anyway (see what functionality is needed and then
go from there, not look at the modules themselves).  Or use a tool like
'make localmodconfig' and trim.

> > What can that be used for and who will use it?
> 
> Without a mapping there is no clean way to let you slim down your kernel
> using a distro kernel as a base, enabling only those things you really
> need.

It's hard to determine "what you really need" :)

Use localmodconfig and you have a great start, then prune from there.
Trying to put _all_ configuration dependencies in a single module isn't
going to work, our configuration language does not distill down to that.

thanks,

greg k-h
