Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C31C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 08:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D572075B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 08:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561797784;
	bh=tWHRy4FMp7DnQydopt93j2ub9TZE/tkPNsRLnlo7cAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=beI83W5lasnGqUVk46VtBn+sp3LOwHunjM+vbSdvK2gheuhf7BgTFdY1dvkYM32p4
	 FBuyDVa4BYBn+0KUpdG0sd7zUKKB5NYobZAsNY4llpkqAo4NutzWQm78PVZAxo2yqt
	 fTxm7KLKpKOzetX6vAJMDwdvvGl9TtcX/+7nrKOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfF2InC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 04:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfF2InB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 04:43:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 627942083B;
        Sat, 29 Jun 2019 08:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561797780;
        bh=tWHRy4FMp7DnQydopt93j2ub9TZE/tkPNsRLnlo7cAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKBomON3r/S7SyY7Eqki+fWCLEWIPU4w/rIRzZaeWmyOfxx1B3FLZx6TQBDblJc1l
         XrQjGbY5ux+sVe8zI2M3034WpDTMf8StbhUq0ZBdXk6WcojV4q6vWoZUe5jXcqM5Aq
         9qQU6idbLCiayBzIs1G0nHGaFhtrRFa/OtApGnOU=
Date:   Sat, 29 Jun 2019 10:42:57 +0200
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
Message-ID: <20190629084257.GA1227@kroah.com>
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de>
 <20160825074313.GC18622@lst.de>
 <20160825201919.GE3296@wotan.suse.de>
 <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de>
 <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:40:22AM -0700, Luis Chamberlain wrote:
> On Wed, Jun 26, 2019 at 9:51 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jun 26, 2019 at 03:21:08PM -0700, Luis Chamberlain wrote:
> > > On Tue, Feb 5, 2019 at 2:07 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > In lieu of no Luke Skywalker, if you will, for a large kconfig revamp
> > > > on this, I'm inclined to believe *at least* having some kconfig_symb
> > > > exposed for some modules is better than nothing. Christoph are you
> > > > totally opposed to this effort until we get a non-reverse engineered
> > > > effort in place? It just seems like an extraordinary amount of work
> > > > and I'm not quite sure who's volunteering to do it.
> > > >
> > > > Other stakeholders may benefit from at least having some config -->
> > > > module mapping for now. Not just backports or building slimmer
> > > > kernels.
> > >
> > > Christoph, *poke*
> >
> > Yes, I'm still totally opposed to a half-backed hack like this.
> 
> The solution puts forward a mechanism to add a kconfig_symb where we
> are 100% certain we have a direct module --> config mapping.
> 
> This is *currently* determined when the streamline_config.pl finds
> that an object has only *one* associated config symbol associated. As
> Cristina noted, of 62 modules on a running system 58 of them ended up
> getting the kconfig_symb assigned, that is 93.5% of all modules on the
> system being tested. For the other modules, if they did want this
> association, we could allow a way for modules to define their own
> KBUILD_KCONF variable so that this could be considered as well, or
> they can look at their own kconfig stuff to try to fit the model that
> does work. To be clear, the heuristics *can* be updated if there is
> confidence in alternative methods for resolution. But since it is
> reflective of our current situation, I cannot consider it a hack.
> 
> This implementation is a reflection of our reality in the kernel, and
> as has been discussed in this thread, if we want to correct the gaps
> we need to do a lot of work. And *no one* is working towards these
> goals.
> 
> That said, even if you go forward with an intrusive solution like the
> one you proposed we could still use the same kconfig_symb...
> 
> So no, I don't see this as a hack. It's a reflection as to our current
> reality. And I cannot see how the kconfig_symb can lie or be
> incorrect. So in fact I think that pushing this forward also makes the
> problem statement clearer for the future of what semantics needs to be
> addressed, and helps us even annotate the problematic areas of the
> kernel.
> 
> What negative aspects do you see with this being merged in practice?

I'm trying to see what the actual problem that you are wanting to solve
here with this.  What exactly is it?  Who needs to determine the
"singular" configuration option that caused a kernel module to be built
at the expense of all other options?  What can that be used for and who
will use it?

confused,

greg k-h
