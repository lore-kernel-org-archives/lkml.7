Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DEFC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA4921871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562192737;
	bh=ejLltnTIWoGKvZ4IzBJ8B6AMvgJiAUb7I9Ko85CNvAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oBkPDi7aVqVrOZywkeYtstwPGAg0K0rMan1WpqzB7FalmX+LSJhsimAJYtXzNDVNy
	 TpbZXGVygtEK8UGUyHUZpeZnodWuDTHUpE3MfGn0EDw0m+4RNGFPrlwcM+gb7/Jvi0
	 NjuclbPdFh70LTA1y5ZK+sBpICcW53EzN/fdmYWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfGCWZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:25:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41549 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfGCWZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:25:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so1933012pff.8;
        Wed, 03 Jul 2019 15:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AMF1uoTlMkX+Pls3mTFK6YLj3hEtQWezkWxmNqd6HjU=;
        b=qvLRqHdYQFZAWeJFtDXlWL+8Ry7MEIttfsb3mooLfI0hn2Mrh5C4dZ2qen44WCV2IG
         fOnv9iVFDFr5lsi7QiT0c8VshQc42zSan60++OVO3q9L3+dAYl/pQoq1gQ0OqL+GxRzZ
         A0kflYMUImSA0QaWVYx4cPvfjKJcury6qYQjlo6uTUPLRzgzbTIe/bRLBnkrAyt3mu+u
         bxekoe2NdULb62sl5Yx19kZdsDtOQJFHAzfvKTrmieFFjc9g04q9kc01pSctCRGataxs
         F0LwyGLTyzPwfaV1LuRw475iPOc0rF+KEfMqVh4+RsNChe9fUhc6DthNFVSTvR05qxit
         288A==
X-Gm-Message-State: APjAAAWus9Xq198Bc3etM5IL+ADDA7xTNzo90SUF9+dmkh296l/Rsax3
        kmQxkeqTaD0ktnu8zqMBIvg=
X-Google-Smtp-Source: APXvYqyncPS62YpDaL5Dk/gyvbNqcz22/RBBSSvrv7XmF52P82x6QXe/8Zq1nba6mrUegPrnTbc4Sg==
X-Received: by 2002:a63:4518:: with SMTP id s24mr40294724pga.123.1562192734914;
        Wed, 03 Jul 2019 15:25:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f186sm3376178pfb.5.2019.07.03.15.25.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 15:25:32 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B489E402AC; Wed,  3 Jul 2019 22:25:31 +0000 (UTC)
Date:   Wed, 3 Jul 2019 22:25:31 +0000
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
Message-ID: <20190703222531.GX19023@42.do-not-panic.com>
References: <20160825201919.GE3296@wotan.suse.de>
 <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de>
 <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
 <20190629084257.GA1227@kroah.com>
 <20190702205106.GR19023@42.do-not-panic.com>
 <20190703074048.GH3033@kroah.com>
 <20190703165020.GV19023@42.do-not-panic.com>
 <20190703185758.GB14336@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703185758.GB14336@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 08:57:58PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 03, 2019 at 04:50:20PM +0000, Luis Chamberlain wrote:
> > On Wed, Jul 03, 2019 at 09:40:48AM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Jul 02, 2019 at 08:51:06PM +0000, Luis Chamberlain wrote:
> > > > On Sat, Jun 29, 2019 at 10:42:57AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Jun 28, 2019 at 11:40:22AM -0700, Luis Chamberlain wrote:
> > > > > > On Wed, Jun 26, 2019 at 9:51 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > > > >
> > > > > > > On Wed, Jun 26, 2019 at 03:21:08PM -0700, Luis Chamberlain wrote:
> > > > > > > > On Tue, Feb 5, 2019 at 2:07 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > > > > > > In lieu of no Luke Skywalker, if you will, for a large kconfig revamp
> > > > > > > > > on this, I'm inclined to believe *at least* having some kconfig_symb
> > > > > > > > > exposed for some modules is better than nothing. Christoph are you
> > > > > > > > > totally opposed to this effort until we get a non-reverse engineered
> > > > > > > > > effort in place? It just seems like an extraordinary amount of work
> > > > > > > > > and I'm not quite sure who's volunteering to do it.
> > > > > > > > >
> > > > > > > > > Other stakeholders may benefit from at least having some config -->
> > > > > > > > > module mapping for now. Not just backports or building slimmer
> > > > > > > > > kernels.
> > > > > > > >
> > > > > > > > Christoph, *poke*
> > > > > > >
> > > > > > > Yes, I'm still totally opposed to a half-backed hack like this.
> > > > > > 
> > > > > > The solution puts forward a mechanism to add a kconfig_symb where we
> > > > > > are 100% certain we have a direct module --> config mapping.
> > > > > > 
> > > > > > This is *currently* determined when the streamline_config.pl finds
> > > > > > that an object has only *one* associated config symbol associated. As
> > > > > > Cristina noted, of 62 modules on a running system 58 of them ended up
> > > > > > getting the kconfig_symb assigned, that is 93.5% of all modules on the
> > > > > > system being tested. For the other modules, if they did want this
> > > > > > association, we could allow a way for modules to define their own
> > > > > > KBUILD_KCONF variable so that this could be considered as well, or
> > > > > > they can look at their own kconfig stuff to try to fit the model that
> > > > > > does work. To be clear, the heuristics *can* be updated if there is
> > > > > > confidence in alternative methods for resolution. But since it is
> > > > > > reflective of our current situation, I cannot consider it a hack.
> > > > > > 
> > > > > > This implementation is a reflection of our reality in the kernel, and
> > > > > > as has been discussed in this thread, if we want to correct the gaps
> > > > > > we need to do a lot of work. And *no one* is working towards these
> > > > > > goals.
> > > > > > 
> > > > > > That said, even if you go forward with an intrusive solution like the
> > > > > > one you proposed we could still use the same kconfig_symb...
> > > > > > 
> > > > > > So no, I don't see this as a hack. It's a reflection as to our current
> > > > > > reality. And I cannot see how the kconfig_symb can lie or be
> > > > > > incorrect. So in fact I think that pushing this forward also makes the
> > > > > > problem statement clearer for the future of what semantics needs to be
> > > > > > addressed, and helps us even annotate the problematic areas of the
> > > > > > kernel.
> > > > > > 
> > > > > > What negative aspects do you see with this being merged in practice?
> > > > > 
> > > > > I'm trying to see what the actual problem that you are wanting to solve
> > > > > here with this.  What exactly is it?
> > > > 
> > > > The problem is that there is no current maping of a module to respective
> > > > kconfig symbol.
> > > 
> > > That's because it is not just "one" symbol per module.
> > 
> > This is true. But it is not the case for all modules.  In fact it seems
> > its true that most modules do have *one* main symbol.
> 
> You mean "one unique symbol from all other modules", right?

I mean that in the typical case you have *one* main *parent* symbol defining
one device driver for one piece of hardware.

> That is much different than just "one" symbol, given that almost
> every driver depends on something else being enabled as well (bus type,
> platform type, arch, etc.)

Yes but that is different than what is trying to be addressed.

> And I would argue, that finding that "one" symbol is easy, just parse
> the Makefiles.  But I would also state that this "one" symbol doesn't
> really help you much as those are the "simple" things.  It's how to
> turn on all of the required symbols to get to that "one" symbol that is
> the hard part.

Absolutely, but *that* is a different problem! But I am glad you brought
that up and acknowledge it. Addressing that problem will take time and
folks are working towards it. Addressing that problem will still however
not address the problem being addressed here.

> And conversely, if you disable that "one" symbol, does that also mean
> you can disable the symbols it depended on?  If so, how far back?

Right.. 

> And what about functionality?  If my usb-storage device is "enabled" in
> the build, yet all filesystems are not, or the needed dm module is not,
> it is useless.

Yes. The localmodconfig approach is to keep enabled as modules *all* currently
enabled modules, that covers that.

But again, this is a separate problem. The one I am addressing, on
behalf of Cristina, is a subspace, dedicated towards *hardware*
functionality.

> Hardware requires usually more than one real "symbol" in
> order to work properly, as you know.

Right. This does not mean that this information of parent main symbol is
not useful. And having it available on the modules can help with
multiple goals, without requiring kernel sources.

> And of course, what does this really matter to anyone?  If you build
> "all modules" and you only load the modules you actually use for your
> hardware (based on auto-loading), then your system uses the same amount
> of memory as if you disabled all of the modules you did not need.

For backports it means you can enable only what you need, or at least
show users what modules in a backports release could be upgraded and let
you enable / disable them.  For other users, people can care about build
time. And not everyone has fancy systems to build all modules; and
sometimes you may just want to enable a small qemu system and build
locally on it, enabling all modules on such systems would just be
extremely silly.

> Yes, it's faster to build, but is that what you are trying to optimize
> for here?

Particularly for me, yes. Others have other needs and I have already
stated clearly what the gains are.

> Anyway, if this is just an acidemic thing, have fun, but I would not be
> adding anything else to the module image that is not really going to be
> useful to anyone.

The academic consensus is kconfig semantics are poo and we need to do
slowly start addressing this. I believe that striving towards having
one kconfig symbol per hw component can help long term, and in the
meantime, this also will help with the 'make localmodconfig' and
backport users.

> good luck!

This is not about luck. If you don't want to address these problems,
that's fine, but please provide objective considerations rather than
right out rejection without a reasonable basis. Or even better, provide
alternative recommendations.

The alternative Christoph recommended is hugely instrusive, no one is
working on it, and the simple solution proposed in this thread at least
gets us a small step forward in helping to enable a few more users,
while also postulating if we should strive towards having one main kconfig
for each hw component. Since it seems this is already the case, and
there are only a few outliers, this effort should help spot outliers
and address them to help with our semantics.

  Luis
