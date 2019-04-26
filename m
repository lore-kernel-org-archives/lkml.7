Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85574C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CA7206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556287726;
	bh=JTCCCXpbVq2C2DkK0vg2hG4I0cUYt09lr0BjD7K1NMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q76+Sx7DTupDS9WxgqCjIsFafSAdUTnlQhR5xNtZKS8fP/b77GkUGsADFWZsR2k02
	 AvICe1PLAk5ifBHxq2qcEZWyM2Ag/EOEYT/tst62n4hipEBlI69wE044McuotDP5xv
	 kAwK28I7mIx0LIqpM1Y+XXNs289U622zeuzq0XEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDZOIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:08:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:51808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfDZOIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:08:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 725D0AFFB;
        Fri, 26 Apr 2019 14:08:42 +0000 (UTC)
Date:   Fri, 26 Apr 2019 16:08:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH V2] mm: Allow userland to request that the kernel clear
 memory on release
Message-ID: <20190426140841.GK22245@dhcp22.suse.cz>
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190424211038.204001-1-matthewgarrett@google.com>
 <20190425121410.GC1144@dhcp22.suse.cz>
 <CAG48ez0x6QiFpqXbimB9ZV-jS5UJJWhzg9XiAWncQL+phfKkPA@mail.gmail.com>
 <20190426053135.GC12337@dhcp22.suse.cz>
 <CAG48ez1MGyAd5tE=JLmjkFqou-VvsQHcJ5TU5f8_L43km9eoYA@mail.gmail.com>
 <20190426134722.GH22245@dhcp22.suse.cz>
 <CAG48ez1OS7DeeEtv5jhO6wtMA2M2A_Bp3-ndS+sP=UoFuMiREw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1OS7DeeEtv5jhO6wtMA2M2A_Bp3-ndS+sP=UoFuMiREw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-04-19 16:03:26, Jann Horn wrote:
> On Fri, Apr 26, 2019 at 3:47 PM Michal Hocko <mhocko@kernel.org> wrote:
> > On Fri 26-04-19 15:33:25, Jann Horn wrote:
> > > On Fri, Apr 26, 2019 at 7:31 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > On Thu 25-04-19 14:42:52, Jann Horn wrote:
> > > > > On Thu, Apr 25, 2019 at 2:14 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > > [...]
> > > > > > On Wed 24-04-19 14:10:39, Matthew Garrett wrote:
> > > > > > > From: Matthew Garrett <mjg59@google.com>
> > > > > > >
> > > > > > > Applications that hold secrets and wish to avoid them leaking can use
> > > > > > > mlock() to prevent the page from being pushed out to swap and
> > > > > > > MADV_DONTDUMP to prevent it from being included in core dumps. Applications
> > > > > > > can also use atexit() handlers to overwrite secrets on application exit.
> > > > > > > However, if an attacker can reboot the system into another OS, they can
> > > > > > > dump the contents of RAM and extract secrets. We can avoid this by setting
> > > > > > > CONFIG_RESET_ATTACK_MITIGATION on UEFI systems in order to request that the
> > > > > > > firmware wipe the contents of RAM before booting another OS, but this means
> > > > > > > rebooting takes a *long* time - the expected behaviour is for a clean
> > > > > > > shutdown to remove the request after scrubbing secrets from RAM in order to
> > > > > > > avoid this.
> > > > > > >
> > > > > > > Unfortunately, if an application exits uncleanly, its secrets may still be
> > > > > > > present in RAM. This can't be easily fixed in userland (eg, if the OOM
> > > > > > > killer decides to kill a process holding secrets, we're not going to be able
> > > > > > > to avoid that), so this patch adds a new flag to madvise() to allow userland
> > > > > > > to request that the kernel clear the covered pages whenever the page
> > > > > > > reference count hits zero. Since vm_flags is already full on 32-bit, it
> > > > > > > will only work on 64-bit systems.
> > > > > [...]
> > > > > > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > > > > > index 21a7881a2db4..989c2fde15cf 100644
> > > > > > > --- a/mm/madvise.c
> > > > > > > +++ b/mm/madvise.c
> > > > > > > @@ -92,6 +92,22 @@ static long madvise_behavior(struct vm_area_struct *vma,
> > > > > > >       case MADV_KEEPONFORK:
> > > > > > >               new_flags &= ~VM_WIPEONFORK;
> > > > > > >               break;
> > > > > > > +     case MADV_WIPEONRELEASE:
> > > > > > > +             /* MADV_WIPEONRELEASE is only supported on anonymous memory. */
> > > > > > > +             if (VM_WIPEONRELEASE == 0 || vma->vm_file ||
> > > > > > > +                 vma->vm_flags & VM_SHARED) {
> > > > > > > +                     error = -EINVAL;
> > > > > > > +                     goto out;
> > > > > > > +             }
> > > > > > > +             new_flags |= VM_WIPEONRELEASE;
> > > > > > > +             break;
> > > > >
> > > > > An interesting effect of this is that it will be possible to set this
> > > > > on a CoW anon VMA in a fork() child, and then the semantics in the
> > > > > parent will be subtly different - e.g. if the parent vmsplice()d a
> > > > > CoWed page into a pipe, then forked an unprivileged child, the child
> > > >
> > > > Maybe a stupid question. How do you fork an unprivileged child (without
> > > > exec)? Child would have to drop priviledges on its own, no?
> > >
> > > Sorry, yes, that's what I meant.
> >
> > But then the VMA is gone along with the flag so why does it matter?
> 
> But in theory, the page might still be used somewhere, e.g. as data in
> a pipe (into which the parent wrote it) or whatever. Parent
> vmsplice()s a page into a pipe, parent exits, child marks the VMA as
> WIPEONRELEASE and exits, page gets wiped, someone else reads the page
> from the pipe.
> 
> Yes, this is very theoretical, and you'd have to write some pretty
> weird software for this to matter. But it doesn't seem clean to me to
> allow a child to affect the data in e.g. a pipe that it isn't supposed
> to have access to like this.
> 
> Then again, this could probably already happen, since do_wp_page()
> reuses pages depending on only the mapcount, without looking at the
> refcount.

OK, now I see your point. I was confused about the unprivileged child.
You are right that this looks weird but we have traditionally trusted
child processes to not do a harm. I guess this falls down to the same
bucket. An early CoW on these mapping should solve the problem AFAICS.

-- 
Michal Hocko
SUSE Labs
