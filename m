Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC66C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B32217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558436108;
	bh=9MEN2KbBeRSyHZZ/tEW93WclsJlCnlFw4hYl5f3HiOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qYsDu9euNz3L+4Kv6zT61W/IqWllI/HHmR4BFlsqf99kvw3ZNtt1NA2/gX6UQnprL
	 YRyPFhm7kTeoeRrdcDVE1G56Vy42bcuIDaWfrVpDalJPKDc/R+zj1WoUyblV9NLO7f
	 yfWMRwVgBNYE0WRQVAbA2Cp5aB+OLI+Y3PU5fzw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfEUKzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:55:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:42094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726750AbfEUKzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:55:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FCA9ACBC;
        Tue, 21 May 2019 10:55:04 +0000 (UTC)
Date:   Tue, 21 May 2019 12:55:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 4/7] mm: factor out madvise's core functionality
Message-ID: <20190521105503.GQ32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-5-minchan@kernel.org>
 <20190520142633.x5d27gk454qruc4o@butterfly.localdomain>
 <20190521012649.GE10039@google.com>
 <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
 <20190521104949.GE219653@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521104949.GE219653@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-05-19 19:49:49, Minchan Kim wrote:
> On Tue, May 21, 2019 at 08:36:28AM +0200, Oleksandr Natalenko wrote:
> > Hi.
> > 
> > On Tue, May 21, 2019 at 10:26:49AM +0900, Minchan Kim wrote:
> > > On Mon, May 20, 2019 at 04:26:33PM +0200, Oleksandr Natalenko wrote:
> > > > Hi.
> > > > 
> > > > On Mon, May 20, 2019 at 12:52:51PM +0900, Minchan Kim wrote:
> > > > > This patch factor out madvise's core functionality so that upcoming
> > > > > patch can reuse it without duplication.
> > > > > 
> > > > > It shouldn't change any behavior.
> > > > > 
> > > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > > ---
> > > > >  mm/madvise.c | 168 +++++++++++++++++++++++++++------------------------
> > > > >  1 file changed, 89 insertions(+), 79 deletions(-)
> > > > > 
> > > > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > > > index 9a6698b56845..119e82e1f065 100644
> > > > > --- a/mm/madvise.c
> > > > > +++ b/mm/madvise.c
> > > > > @@ -742,7 +742,8 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > -static long madvise_dontneed_free(struct vm_area_struct *vma,
> > > > > +static long madvise_dontneed_free(struct task_struct *tsk,
> > > > > +				  struct vm_area_struct *vma,
> > > > >  				  struct vm_area_struct **prev,
> > > > >  				  unsigned long start, unsigned long end,
> > > > >  				  int behavior)
> > > > > @@ -754,8 +755,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > > > >  	if (!userfaultfd_remove(vma, start, end)) {
> > > > >  		*prev = NULL; /* mmap_sem has been dropped, prev is stale */
> > > > >  
> > > > > -		down_read(&current->mm->mmap_sem);
> > > > > -		vma = find_vma(current->mm, start);
> > > > > +		down_read(&tsk->mm->mmap_sem);
> > > > > +		vma = find_vma(tsk->mm, start);
> > > > >  		if (!vma)
> > > > >  			return -ENOMEM;
> > > > >  		if (start < vma->vm_start) {
> > > > > @@ -802,7 +803,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > > > >   * Application wants to free up the pages and associated backing store.
> > > > >   * This is effectively punching a hole into the middle of a file.
> > > > >   */
> > > > > -static long madvise_remove(struct vm_area_struct *vma,
> > > > > +static long madvise_remove(struct task_struct *tsk,
> > > > > +				struct vm_area_struct *vma,
> > > > >  				struct vm_area_struct **prev,
> > > > >  				unsigned long start, unsigned long end)
> > > > >  {
> > > > > @@ -836,13 +838,13 @@ static long madvise_remove(struct vm_area_struct *vma,
> > > > >  	get_file(f);
> > > > >  	if (userfaultfd_remove(vma, start, end)) {
> > > > >  		/* mmap_sem was not released by userfaultfd_remove() */
> > > > > -		up_read(&current->mm->mmap_sem);
> > > > > +		up_read(&tsk->mm->mmap_sem);
> > > > >  	}
> > > > >  	error = vfs_fallocate(f,
> > > > >  				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> > > > >  				offset, end - start);
> > > > >  	fput(f);
> > > > > -	down_read(&current->mm->mmap_sem);
> > > > > +	down_read(&tsk->mm->mmap_sem);
> > > > >  	return error;
> > > > >  }
> > > > >  
> > > > > @@ -916,12 +918,13 @@ static int madvise_inject_error(int behavior,
> > > > >  #endif
> > > > 
> > > > What about madvise_inject_error() and get_user_pages_fast() in it
> > > > please?
> > > 
> > > Good point. Maybe, there more places where assume context is "current" so
> > > I'm thinking to limit hints we could allow from external process.
> > > It would be better for maintainance point of view in that we could know
> > > the workload/usecases when someone ask new advises from external process
> > > without making every hints works both contexts.
> > 
> > Well, for madvise_inject_error() we still have a remote variant of
> > get_user_pages(), and that should work, no?
> 
> Regardless of madvise_inject_error, it seems to be risky to expose all
> of hints for external process, I think. For example, MADV_DONTNEED with
> race, it's critical for stability. So, until we could get the way to
> prevent the race, I want to restrict hints.

Well, if you allow the full ptrace access then you can shoot the target
whatever you like.

> > Regarding restricting the hints, I'm definitely interested in having
> > remote MADV_MERGEABLE/MADV_UNMERGEABLE. But, OTOH, doing it via remote
> > madvise() introduces another issue with traversing remote VMAs reliably.
> 
> How is it signifiact when the race happens? It could waste CPU cycle
> and make unncessary break of that merged pages but expect it should be
> rare so such non-desruptive hint could be exposed via process_madvise, I think.
> 
> If the hint is critical for the race, yes, as Michal suggested, we need a way
> to close it and I guess non-cooperative userfaultfd with synchronous support
> would help private anonymous vma.

If we have a per vma fd approach then we can revalidate atomically and
make sure the operation is performed on the range that was really
requested. I do not think we want to provide a more specific guarantees.
Monitor process has to be careful same way ptrace doesn't want to harm
the target.

-- 
Michal Hocko
SUSE Labs
