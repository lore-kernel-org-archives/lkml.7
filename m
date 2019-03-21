Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A36C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482C521902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553193058;
	bh=W221PceSx+0/3/ymjrkG06LMoCJ1oDK2rItmtBScC5U=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=Jt3sh0ZZYRkV6KAy1gtJI9+J+E0GthLUbTFoo2kr4TQcChQeExCA8eLCTqIGPWJX0
	 akXMVAuJ8glUVP9IEZeOXlPJC6ErL5p/H3LcaqwFmBo5y3ZRQo54ZmueVM6JG1toR8
	 hwo2OvsgGPCX3aYbF1jn/mZWp29Ow2pKge/MGdfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfCUSa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbfCUSa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:30:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B0E021902;
        Thu, 21 Mar 2019 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553193055;
        bh=W221PceSx+0/3/ymjrkG06LMoCJ1oDK2rItmtBScC5U=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=QQ0TEE70HLAhOPmhp2Z8iPrKvh85jZpL3aWHU4+0ujG/GEc5dvCcs+8H+JZK+4Bll
         GywvHThW0HFw6pcgkeOnl4pzVYNerU1JdLQe9wHHFbHEFimQEXPLocJJn6+Z4OADli
         umTUSFmfEXQlei6NBqJnfbb1U+nJeskI12CLdMm0=
Date:   Thu, 21 Mar 2019 19:30:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     dsterba@suse.cz, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Stable patches that don't apply to older kernels and how to get
 them
Message-ID: <20190321183052.GB10586@kroah.com>
References: <20190321151413.GB8120@suse.cz>
 <20190321163941.GA11121@kroah.com>
 <20190321181946.GA28481@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321181946.GA28481@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 07:19:46PM +0100, David Sterba wrote:
> On Thu, Mar 21, 2019 at 05:39:41PM +0100, Greg KH wrote:
> > On Thu, Mar 21, 2019 at 04:14:14PM +0100, David Sterba wrote:
> > > Hi,
> > > 
> > > would it be possible to have a git repository with all patches that are
> > > submitted to stable@ but don't apply directly?
> > > 
> > > I get notified by mail, that's fine though it's not that convenient to
> > > see all the pending patches for backport to a given version.
> > > 
> > > My proposal:
> > > 
> > > - create a separate stable-unapplied git repository
> > > 
> > > - if a patch does not apply to a given version, it's stored as-is to a
> > >   directory of the base version (like 4.4)
> > > 
> > > - once a fixed version is applied to stable-queue.git/released-4.4, the
> > >   patch in the other repo is deleted
> > > 
> > > I believe this can be highly automated and once implemented would not
> > > too much additional work to the stable workflow. I could possibly write
> > > a scraper of the mail archives to pick the patches and manage the
> > > repository but I think that a central repository could help other
> > > maintainers too or to spread the load to all interested developers.
> > > 
> > > If something like that already exists, please let me know.
> > 
> > Nothing like this exists, sorry.
> > 
> > And if you want to automate this, wonderful, but I do not have any time
> > to do so, and it does not fit into my workflow at all.  Patches that do
> > not apply are the exception by far, not the rule, so I doubt this would
> > really help out much.
> 
> I'm concerned about patches that are sent to sable but don't get applied
> in the end. IOW dropped on the floor, unless somebody cares, which is
> probably the maintainers that are known to be overloaded.
> 
> So, I'm looking for some kind of help, to extend the stable workflow and
> address the problem where it happens and where the whole mail and git
> machinery already is.
> 
> The number of unapplied patches has raised recently for me because I
> started to closely examine which stable versions could be affected. And
> go as far as 4.4.
> 
> Why there are otherwise only a few patches that don't apply, I can only
> speculate and I think that differs by subsystem. That stable kernels are
> potentially missing stability fixes should be a concern in general. But
> well, it seems I have to help myself here.

You can easily just filter on the FAILED emails and see what happens
there if you want to track these.  I figure that if I send out the email
and no one responds with a backported patch, then no one really cares
about that issue on that old kernel, so we are fine.  If they did care,
they would do the backport :)

Again, look at Sasha's emails, that might be what you are looking for.

Or better yet, create something automated on your own that does the "did
this apply or not" test for you, that way you get to see what happens
here much more easily and only for the subsystems you care about.

thanks,

greg k-h
