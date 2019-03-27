Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F24DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26EA204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711524;
	bh=JkniCfTXMqYRp0YFhUkfp8QCK4JuIgZmgdfsNhO0zN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N1MQ6ioP5Bh82kX5XY+Gy/z+PwtfMf0oODrG+NVCWKqmfvGC0pDNTRL3hQqIirgH3
	 KVpmKvqrE1bpoewlnBiw+dH6pd/7LFkEoYVw45e3xuNbNF7UECz3pWqmE629z06IoR
	 76Q+Pww6Z4Bj5UvHz9WM9YNA11HhZ1Zi25s+JITs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391902AbfC0ScC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbfC0ScA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:32:00 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54944204FD;
        Wed, 27 Mar 2019 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711519;
        bh=JkniCfTXMqYRp0YFhUkfp8QCK4JuIgZmgdfsNhO0zN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2cki3BQ3qlGqon5UBAwAsFt/nI3qAv6CUDDtvg5CWd3adDjQB1GeEgYp1z+MKfnsM
         VHvEFprWizcDCh1O5f+4d4AEAga/BsBiI7/Bl2tJeCOQtkCdV44stIkoFBpCsq+NA9
         s1hLSeJScln20jv+1G9vkO6eIFeO2pDFDKymWTG4=
Date:   Thu, 28 Mar 2019 03:31:52 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked
 down
Message-ID: <20190327183152.GB9371@kroah.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-26-matthewgarrett@google.com>
 <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
 <20190327003057.GA27311@kroah.com>
 <CALCETrVDDf4dj3Md1Nxc5P_NCToXGnAbEO3bGfwgKSfeVmU4Kw@mail.gmail.com>
 <20190327050615.GA548@kroah.com>
 <16124107-70D3-4CA0-9766-36FC6DC10128@amacapital.net>
 <20190327053342.GA17484@kroah.com>
 <CALCETrUW=r=xyr4pGiGnn9zUEevf=z6PP3111Ds6qguV5SjYUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUW=r=xyr4pGiGnn9zUEevf=z6PP3111Ds6qguV5SjYUQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 10:39:53AM -0700, Andy Lutomirski wrote:
> On Tue, Mar 26, 2019 at 10:33 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 26, 2019 at 10:29:41PM -0700, Andy Lutomirski wrote:
> > >
> > >
> > > > On Mar 26, 2019, at 10:06 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > >> On Tue, Mar 26, 2019 at 09:29:14PM -0700, Andy Lutomirski wrote:
> > > >>> On Tue, Mar 26, 2019 at 5:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >>>
> > > >>>> On Tue, Mar 26, 2019 at 12:20:24PM -0700, Andy Lutomirski wrote:
> > > >>>> On Tue, Mar 26, 2019 at 11:28 AM Matthew Garrett
> > > >>>> <matthewgarrett@google.com> wrote:
> > > >>>>>
> > > >>>>> From: Matthew Garrett <mjg59@google.com>
> > > >>>>>
> > > >>>>> debugfs has not been meaningfully audited in terms of ensuring that
> > > >>>>> userland cannot trample over the kernel. At Greg's request, disable
> > > >>>>> access to it entirely when the kernel is locked down. This is done at
> > > >>>>> open() time rather than init time as the kernel lockdown status may be
> > > >>>>> made stricter at runtime.
> > > >>>>
> > > >>>> Ugh.  Some of those files are very useful.  Could this perhaps still
> > > >>>> allow O_RDONLY if we're in INTEGRITY mode?
> > > >>>
> > > >>> Useful for what?  Debugging, sure, but for "normal operation", no kernel
> > > >>> functionality should ever require debugfs.  If it does, that's a bug and
> > > >>> should be fixed.
> > > >>>
> > > >>
> > > >> I semi-regularly read files in debugfs to diagnose things, and I think
> > > >> it would be good for this to work on distro kernels.
> > > >
> > > > Doing that for debugging is wonderful.  People who want this type of
> > > > "lock down" are trading potential security for diagnositic ability.
> > > >
> > >
> > > I think you may be missing the point of splitting lockdown to separate integrity and confidentiality.  Can you actually think of a case where *reading* a debugfs file can take over a kernel?
> >
> > Reading a debugfs file can expose loads of things that can help take
> > over a kernel, or at least make it easier.  Pointer addresses, internal
> > system state, loads of other fun things.  And before 4.14 or so, it was
> > pretty trivial to use it to oops the kernel as well (not an issue here
> > anymore, but people are right to be nervous).
> >
> > Personally, I think these are all just "confidentiality" type things,
> > but who really knows given the wild-west nature of debugfs (which is as
> > designed).  And given that I think this patch series just crazy anyway,
> > I really don't care :)
> >
> 
> As far as I'm concerned, preventing root from crashing the system
> should not be a design goal of lockdown at all.  And I think that the
> "integrity" mode should be as non-annoying as possible, so I think we
> should allow reading from debugfs.

Sorry, the "crash the system" is not the issue here.  The issue is if
everyone can "ensure" that "everything" in debugfs is "safe" for this
mode of "lock down".  Given that no one has any idea of what really is
in debugfs, and to try to compare that with the design goals of what
"lock down" really is trying to achive, I think the goal of just giving
up and restricting access is fine if that makes people feel better about
this whole thing.

If this is locked down, it is going to cause distros more pain in
debugging user's issues, but that's their choice, not mine :)

thanks,

greg k-h
