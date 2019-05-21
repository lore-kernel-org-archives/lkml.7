Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9AEC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D5A216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558435799;
	bh=bDfPzQL6A3wOwmb0E61DltYFgSPWMTpFFUtFma8Mw6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ynA5QX9fpwQ8jIwaLvoDNVl89tNIdn9Xfxi9D1W/1yEYxP6c/1nGRBiJBpaMBTy2W
	 J2vknV0mglFk/BOfQEPJFy+0c5prPl+t9NIH+uD1/ylWbyCNjHU67FjtO+xp/Wv7fH
	 Min32m/MjSsQAsb1tM8yF8FXeMg2Ft3hUSqf/umI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfEUKt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:49:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40081 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEUKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:49:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so8876995pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Stm0C6YcpMXYSmn/MRE96nYtm0sE3cLGz18Bicx3vkY=;
        b=iIN5PRr2hhNy5miQal2uGj/iuK5FmlUMC9h2UEPsfJeTZju++lqBt+VYJDK9rKDdjC
         d+/cjsV2pGDIU4DDOVYwu0ysyBmR0aU5skWSm8VCVT0YCVByWj7Ej0BUb1MoaVN4FwhD
         ve/wwArQeyg3pYsNH3YRSPnltb8ptahfbBNSqSx7ui/rgUPwX3w7xo38gGlRC8hohIHK
         Q20WLiy8bPg42TX01v2UIP8MbTprSMe6tI927OHDRqRk8KfeKgmjJF8wqYhmXp6TYdhT
         YM7sJeyPGmdz12RWrnG7b2EUBYFAGYy9JWq/npboH53iH0aQBko+NJf6ryHJlb0fgsfB
         ZXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Stm0C6YcpMXYSmn/MRE96nYtm0sE3cLGz18Bicx3vkY=;
        b=DlAzdsqJPBPp6FH8Wl/bjnORBO/IBbNyWD1/tiE9CJ1vFM2CkPUuF0Pb44T+0abQ9B
         6geID+JhTm2uMZLIcreOcAx3H0xbqYhCYeSx/N5JnQCNyrnZpn2FapS63wzPRHQZxK8G
         BF6MJaY5EoNBrxE2gBLhRydDfGD/7bTBDazrdBZ1i75pr9hyYSP3fi0ag7L3rfv9pdRe
         VdMB7z5IMy2ZDT2pB0P0pvAv6n9AfxUoyY+6G0J5Bio5+jW8HHQMHJP0YI76qV/JJ4eX
         Y6bXU+J4RRFMIzbp+AmGuT6I72UqgMroGyP8mO0rj7gHy+jlnALhehv+c7A76SXYv2b9
         wupw==
X-Gm-Message-State: APjAAAXRVE8u9WonPeII2J3AMLmqDLacKlx0X5T2D3Gn8J3/qISDIkrC
        bLdLtx5FCPVEJ6dgsqZCp2E=
X-Google-Smtp-Source: APXvYqxGi76NyYcWDtIEDaY2syL993S0wFdNZNV0ypOc260KhQBGfoSIl0aV4GKSCP+mvB5L7Z0TGw==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr85481313pfd.221.1558435796458;
        Tue, 21 May 2019 03:49:56 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id l21sm29029996pff.40.2019.05.21.03.49.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 03:49:55 -0700 (PDT)
Date:   Tue, 21 May 2019 19:49:49 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 4/7] mm: factor out madvise's core functionality
Message-ID: <20190521104949.GE219653@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-5-minchan@kernel.org>
 <20190520142633.x5d27gk454qruc4o@butterfly.localdomain>
 <20190521012649.GE10039@google.com>
 <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 08:36:28AM +0200, Oleksandr Natalenko wrote:
> Hi.
> 
> On Tue, May 21, 2019 at 10:26:49AM +0900, Minchan Kim wrote:
> > On Mon, May 20, 2019 at 04:26:33PM +0200, Oleksandr Natalenko wrote:
> > > Hi.
> > > 
> > > On Mon, May 20, 2019 at 12:52:51PM +0900, Minchan Kim wrote:
> > > > This patch factor out madvise's core functionality so that upcoming
> > > > patch can reuse it without duplication.
> > > > 
> > > > It shouldn't change any behavior.
> > > > 
> > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > ---
> > > >  mm/madvise.c | 168 +++++++++++++++++++++++++++------------------------
> > > >  1 file changed, 89 insertions(+), 79 deletions(-)
> > > > 
> > > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > > index 9a6698b56845..119e82e1f065 100644
> > > > --- a/mm/madvise.c
> > > > +++ b/mm/madvise.c
> > > > @@ -742,7 +742,8 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static long madvise_dontneed_free(struct vm_area_struct *vma,
> > > > +static long madvise_dontneed_free(struct task_struct *tsk,
> > > > +				  struct vm_area_struct *vma,
> > > >  				  struct vm_area_struct **prev,
> > > >  				  unsigned long start, unsigned long end,
> > > >  				  int behavior)
> > > > @@ -754,8 +755,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > > >  	if (!userfaultfd_remove(vma, start, end)) {
> > > >  		*prev = NULL; /* mmap_sem has been dropped, prev is stale */
> > > >  
> > > > -		down_read(&current->mm->mmap_sem);
> > > > -		vma = find_vma(current->mm, start);
> > > > +		down_read(&tsk->mm->mmap_sem);
> > > > +		vma = find_vma(tsk->mm, start);
> > > >  		if (!vma)
> > > >  			return -ENOMEM;
> > > >  		if (start < vma->vm_start) {
> > > > @@ -802,7 +803,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > > >   * Application wants to free up the pages and associated backing store.
> > > >   * This is effectively punching a hole into the middle of a file.
> > > >   */
> > > > -static long madvise_remove(struct vm_area_struct *vma,
> > > > +static long madvise_remove(struct task_struct *tsk,
> > > > +				struct vm_area_struct *vma,
> > > >  				struct vm_area_struct **prev,
> > > >  				unsigned long start, unsigned long end)
> > > >  {
> > > > @@ -836,13 +838,13 @@ static long madvise_remove(struct vm_area_struct *vma,
> > > >  	get_file(f);
> > > >  	if (userfaultfd_remove(vma, start, end)) {
> > > >  		/* mmap_sem was not released by userfaultfd_remove() */
> > > > -		up_read(&current->mm->mmap_sem);
> > > > +		up_read(&tsk->mm->mmap_sem);
> > > >  	}
> > > >  	error = vfs_fallocate(f,
> > > >  				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> > > >  				offset, end - start);
> > > >  	fput(f);
> > > > -	down_read(&current->mm->mmap_sem);
> > > > +	down_read(&tsk->mm->mmap_sem);
> > > >  	return error;
> > > >  }
> > > >  
> > > > @@ -916,12 +918,13 @@ static int madvise_inject_error(int behavior,
> > > >  #endif
> > > 
> > > What about madvise_inject_error() and get_user_pages_fast() in it
> > > please?
> > 
> > Good point. Maybe, there more places where assume context is "current" so
> > I'm thinking to limit hints we could allow from external process.
> > It would be better for maintainance point of view in that we could know
> > the workload/usecases when someone ask new advises from external process
> > without making every hints works both contexts.
> 
> Well, for madvise_inject_error() we still have a remote variant of
> get_user_pages(), and that should work, no?

Regardless of madvise_inject_error, it seems to be risky to expose all
of hints for external process, I think. For example, MADV_DONTNEED with
race, it's critical for stability. So, until we could get the way to
prevent the race, I want to restrict hints.

> 
> Regarding restricting the hints, I'm definitely interested in having
> remote MADV_MERGEABLE/MADV_UNMERGEABLE. But, OTOH, doing it via remote
> madvise() introduces another issue with traversing remote VMAs reliably.

How is it signifiact when the race happens? It could waste CPU cycle
and make unncessary break of that merged pages but expect it should be
rare so such non-desruptive hint could be exposed via process_madvise, I think.

If the hint is critical for the race, yes, as Michal suggested, we need a way
to close it and I guess non-cooperative userfaultfd with synchronous support
would help private anonymous vma.

> IIUC, one can do this via userspace by parsing [s]maps file only, which
> is not very consistent, and once some range is parsed, and then it is
> immediately gone, a wrong hint will be sent.
> 
> Isn't this a problem we should worry about?

I think it depends on the hint and usecase.

> 
> > 
> > Thanks.
> 
> -- 
>   Best regards,
>     Oleksandr Natalenko (post-factum)
>     Senior Software Maintenance Engineer
