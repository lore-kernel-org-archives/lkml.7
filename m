Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EEDC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9EF2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfDZV2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:28:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43266 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfDZV2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:28:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hK8Oj-0000Cx-Ck; Fri, 26 Apr 2019 21:28:45 +0000
Date:   Fri, 26 Apr 2019 22:28:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Message-ID: <20190426212845.GC2217@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
 <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
 <20190425200941.GW2217@ZenIV.linux.org.uk>
 <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
 <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com>
 <20190426170108.GZ2217@ZenIV.linux.org.uk>
 <fd4327a68e79540e9faee40bd198dfee373e59fb.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd4327a68e79540e9faee40bd198dfee373e59fb.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 04:49:24PM -0400, Jeff Layton wrote:

> Got it, thanks. Why use an atomic_t for the refcount if it's always
> accessed under spinlock?

_Which_ spinlock?  The whole reason for refcounts is that many dentries
might end up with shared external name.  So ->d_lock on one of them
won't do anything to accesses via another...

> > What I don't understand is why would anyone want to mess with
> > name snapshots for dentry_path() lookalikes...
> 
> Mostly because the place where the ceph code needs to use and free these
> strings is rather far removed from where they are created. It simplifies
> that part if we can access and free them all in the same way.
> 
> I was planning to just use name_snapshots universally for that purpose,
> but they have a rather specific method of freeing things that is hard to
> duplicate if you don't have a dentry to clone.
> 
> Probably that means I'm approaching this problem in the wrong way and
> need to do it differently.

For short names snapshot will put the copy into your variable, normally
on the stack frame.  So it doesn't really help if you want to keep that
stuff around.  Again, dentries with short names have those stored inside
the dentry and for anything long-term you will need to copy that data;
otherwise rename() will happily change those under you.

If you want to deal with pathnames, do __getname() + a loop similar to
that in dentry_path() et.al.  All there is to it.  Snapshots are
for situations when you want a reasonably short-term access to
name of specific dentry you have a reference to and do not want
to do any allocations.
