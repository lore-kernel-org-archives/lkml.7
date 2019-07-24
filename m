Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFF6C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF4022387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563982462;
	bh=+prRFyB7DanVEGMBCrwCgd8rnmDkSa6XV1YHv8OZiRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uhcNTWKK2ysi2RExmlYqQRw9/96+JkJmfIa/jrkDJxb2TAN+QBQSQNiUZQMM2TF4R
	 2ll5ocYl+FyJ6y/7XhGqf7Vyg2sX2KdhTZ31yEgFW+2OGaiTakegJzkcUNr0DEA+XZ
	 OwE8c6PrhLkFoxECn2RhYa/6cF9iQTsdofoeqjUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfGXPeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfGXPeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:34:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E219C21951;
        Wed, 24 Jul 2019 15:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563982459;
        bh=+prRFyB7DanVEGMBCrwCgd8rnmDkSa6XV1YHv8OZiRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vXNaaiG5CXsptEQZPajhTUgNoyElBn0kPBWPQ5JrW/P6bVSurkuhzzngvJvUMqtpS
         4HTZi0HgkUaR2UUDCPqaozqtIoPUomnP7bgnT3M6ixNxNBS8fmUNLCIl+v9qGm4nVT
         /ACRBml0OpCwK3bwh6h8B60lspcnOs9Vhex8dAGI=
Date:   Wed, 24 Jul 2019 17:34:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Message-ID: <20190724153416.GA27117@kroah.com>
References: <alpine.DEB.2.21.1907141215350.1669@nanos.tec.linutronix.de>
 <CAHbf0-EPfgyKinFuOP7AtgTJWVSVqPmWwMSxzaH=Xg-xUUVWCA@mail.gmail.com>
 <alpine.DEB.2.21.1907151011590.1669@nanos.tec.linutronix.de>
 <CAHbf0-F9yUDJ=DKug+MZqsjW+zPgwWaLUC40BLOsr5+t4kYOLQ@mail.gmail.com>
 <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907151140080.1669@nanos.tec.linutronix.de>
 <CAMe9rOqMqkQ0LNpm25yE_Yt0FKp05WmHOrwc0aRDb53miFKM+w@mail.gmail.com>
 <20190723130513.GA25290@kroah.com>
 <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de>
 <20190723134454.GA7260@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723134454.GA7260@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:44:54PM +0200, Greg KH wrote:
> On Tue, Jul 23, 2019 at 03:31:32PM +0200, Thomas Gleixner wrote:
> > On Tue, 23 Jul 2019, Greg KH wrote:
> > > On Mon, Jul 15, 2019 at 01:16:48PM -0700, H.J. Lu wrote:
> > > > >
> > > > 
> > > > Since building a workable kernel for different kernel configurations isn't a
> > > > requirement for gold, I don't recommend gold for kernel.
> > > 
> > > Um, it worked before this commit, and now it doesn't.  "Some" companies
> > > are using gold for linking the kernel today...
> > 
> > gold is known to fail the kernel build. x32 vdso linking is not working
> > since years and just because it 'works' for some configurations and breaks
> > for no valid reasons even with those configurations is just not good
> > enough.
> > 
> > As there is obviously no priority for fixing gold to work proper with the
> > kernel, I'm not at all interested in these 'regression' reports and in odd
> > 'fixes' which just end up reverting or modifying perfectly valid changes
> > without understanding the root cause, i.e. the most horrible engineering
> > principle: duct-taping.
> > 
> > TBH, I'm tired of it. We fail the build for clang if it does not support
> > asm gotos and the clang people are actively working on fixing it and we're
> > helping them as much as we can. The companies who used clang nevertheless
> > have been on their own for years and if someone wants to use gold then
> > nobody is preventing them from doing so. They can keep their duct-tape in
> > their own trees.
> > 
> > See this thread for further discussion:
> > 
> >  https://lkml.kernel.org/r/alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de
> 
> Sorry, I saw that after writing that.  You are right, if the others
> don't object, that's fine with me.  I'll go poke the various build
> systems that are failing right now on 5.3-rc1 and try to get them fixed
> for this reason.

Ok, I dug around and the gold linker is not being used here, only clang
to build the source and GNU ld to link, and I am still seeing this
error.

Hm, clang 8 does not cause this error, but clang 9 does.  Let me go poke
the people who are providing this version of clang to see if there's
something they can figure out.

greg k-h
