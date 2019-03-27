Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C487C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF1B206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553664829;
	bh=hA9dsY4to0sqzSBA2TeuG0sLGRkc7aTwCqIlM+otlVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N+aplqKVS9lG3l0ZKkSFhUNDw8J4IDbUcNn2h3EDDO7Hcm5XzOjnF9sNnGj9FoNG7
	 XMnvv9ta2mh6QFLGaPAKgFIWsUr/zNQw3MgNbRJJBbHCGx63QeYbPc0hWiTtIYi/ZZ
	 ZjhgbHGVU9W118mf+ehofcT+9FqLsfLiALaHZTYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbfC0Fds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfC0Fdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:33:47 -0400
Received: from localhost (unknown [218.148.84.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DEC206DF;
        Wed, 27 Mar 2019 05:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553664826;
        bh=hA9dsY4to0sqzSBA2TeuG0sLGRkc7aTwCqIlM+otlVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZYhc/cecXucqv1HhsBTNZpEzAlz/iDrz0l46W+8b1JXG2Oyq7Ag6hAxuiTRouNJo
         UrfY/CQPTsiptlAx3HHvZXWaYa5+zING6/TPhqCI+VFGW6JXiCuLMrqGx6M4tfXGKt
         QZCldccKm7DQjDkhUdlqg7/XjRqVH3ykHupyizp0=
Date:   Wed, 27 Mar 2019 14:33:42 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked
 down
Message-ID: <20190327053342.GA17484@kroah.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-26-matthewgarrett@google.com>
 <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
 <20190327003057.GA27311@kroah.com>
 <CALCETrVDDf4dj3Md1Nxc5P_NCToXGnAbEO3bGfwgKSfeVmU4Kw@mail.gmail.com>
 <20190327050615.GA548@kroah.com>
 <16124107-70D3-4CA0-9766-36FC6DC10128@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16124107-70D3-4CA0-9766-36FC6DC10128@amacapital.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:29:41PM -0700, Andy Lutomirski wrote:
> 
> 
> > On Mar 26, 2019, at 10:06 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> >> On Tue, Mar 26, 2019 at 09:29:14PM -0700, Andy Lutomirski wrote:
> >>> On Tue, Mar 26, 2019 at 5:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>> 
> >>>> On Tue, Mar 26, 2019 at 12:20:24PM -0700, Andy Lutomirski wrote:
> >>>> On Tue, Mar 26, 2019 at 11:28 AM Matthew Garrett
> >>>> <matthewgarrett@google.com> wrote:
> >>>>> 
> >>>>> From: Matthew Garrett <mjg59@google.com>
> >>>>> 
> >>>>> debugfs has not been meaningfully audited in terms of ensuring that
> >>>>> userland cannot trample over the kernel. At Greg's request, disable
> >>>>> access to it entirely when the kernel is locked down. This is done at
> >>>>> open() time rather than init time as the kernel lockdown status may be
> >>>>> made stricter at runtime.
> >>>> 
> >>>> Ugh.  Some of those files are very useful.  Could this perhaps still
> >>>> allow O_RDONLY if we're in INTEGRITY mode?
> >>> 
> >>> Useful for what?  Debugging, sure, but for "normal operation", no kernel
> >>> functionality should ever require debugfs.  If it does, that's a bug and
> >>> should be fixed.
> >>> 
> >> 
> >> I semi-regularly read files in debugfs to diagnose things, and I think
> >> it would be good for this to work on distro kernels.
> > 
> > Doing that for debugging is wonderful.  People who want this type of
> > "lock down" are trading potential security for diagnositic ability.
> > 
> 
> I think you may be missing the point of splitting lockdown to separate integrity and confidentiality.  Can you actually think of a case where *reading* a debugfs file can take over a kernel?

Reading a debugfs file can expose loads of things that can help take
over a kernel, or at least make it easier.  Pointer addresses, internal
system state, loads of other fun things.  And before 4.14 or so, it was
pretty trivial to use it to oops the kernel as well (not an issue here
anymore, but people are right to be nervous).

Personally, I think these are all just "confidentiality" type things,
but who really knows given the wild-west nature of debugfs (which is as
designed).  And given that I think this patch series just crazy anyway,
I really don't care :)

thanks,

greg k-h
