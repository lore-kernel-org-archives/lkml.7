Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06758C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B0921773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEUGgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:36:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38106 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfEUGgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:36:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so17132717wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pe1wEfWWxpVevLzH/SDlhBfecYpqVfg5aDepIYqh0eg=;
        b=p5mSE1nDKebulLT5q+KX/D+qWO48ffzZwBuXQMcktnIYHwiS5eFz6YWISi+B9XI1+h
         2ErSVit0m2rwVsSVfUKQ5byQQyX/OCro2l1+f3yOE+S3qYgVMO1gt3goO2XphsAeLSh2
         USQlDJM1RXcnPogZBg8gIqYX/TZ4DtwHc2dJCAa9kq/opgNOuC999uvJl+gEsTLMyj+s
         uBwYXt4ejxTBaoRutI6OHPNR7P9Er7s7PDhHh19HQUg9W3KZ9S0hov3G50eID5M/BxhC
         UpbixIa5IBguwG9BsG2dfevDc3TGpn3m9IYezgwNmaeA0Xf8MyQCuLfXr5nKZ18dUd8h
         pf9w==
X-Gm-Message-State: APjAAAVDvFUtd7t6tUpwb+p8Egyo1fAjt3yjEje6rGAC8N2PiUprWuv6
        1i6FWDsoYDWOXTOZs0HRqYxfdA==
X-Google-Smtp-Source: APXvYqwXxAV7y5XZ4ldwJaw3BtY2edne6dyljFDVIHToDTC0rOo9PIiZ79depKRqtC5aXkafrl560A==
X-Received: by 2002:a5d:688f:: with SMTP id h15mr10725497wru.44.1558420590217;
        Mon, 20 May 2019 23:36:30 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h17sm1561044wrq.79.2019.05.20.23.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 23:36:29 -0700 (PDT)
Date:   Tue, 21 May 2019 08:36:28 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
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
Message-ID: <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-5-minchan@kernel.org>
 <20190520142633.x5d27gk454qruc4o@butterfly.localdomain>
 <20190521012649.GE10039@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521012649.GE10039@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, May 21, 2019 at 10:26:49AM +0900, Minchan Kim wrote:
> On Mon, May 20, 2019 at 04:26:33PM +0200, Oleksandr Natalenko wrote:
> > Hi.
> > 
> > On Mon, May 20, 2019 at 12:52:51PM +0900, Minchan Kim wrote:
> > > This patch factor out madvise's core functionality so that upcoming
> > > patch can reuse it without duplication.
> > > 
> > > It shouldn't change any behavior.
> > > 
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > >  mm/madvise.c | 168 +++++++++++++++++++++++++++------------------------
> > >  1 file changed, 89 insertions(+), 79 deletions(-)
> > > 
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 9a6698b56845..119e82e1f065 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -742,7 +742,8 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
> > >  	return 0;
> > >  }
> > >  
> > > -static long madvise_dontneed_free(struct vm_area_struct *vma,
> > > +static long madvise_dontneed_free(struct task_struct *tsk,
> > > +				  struct vm_area_struct *vma,
> > >  				  struct vm_area_struct **prev,
> > >  				  unsigned long start, unsigned long end,
> > >  				  int behavior)
> > > @@ -754,8 +755,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > >  	if (!userfaultfd_remove(vma, start, end)) {
> > >  		*prev = NULL; /* mmap_sem has been dropped, prev is stale */
> > >  
> > > -		down_read(&current->mm->mmap_sem);
> > > -		vma = find_vma(current->mm, start);
> > > +		down_read(&tsk->mm->mmap_sem);
> > > +		vma = find_vma(tsk->mm, start);
> > >  		if (!vma)
> > >  			return -ENOMEM;
> > >  		if (start < vma->vm_start) {
> > > @@ -802,7 +803,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > >   * Application wants to free up the pages and associated backing store.
> > >   * This is effectively punching a hole into the middle of a file.
> > >   */
> > > -static long madvise_remove(struct vm_area_struct *vma,
> > > +static long madvise_remove(struct task_struct *tsk,
> > > +				struct vm_area_struct *vma,
> > >  				struct vm_area_struct **prev,
> > >  				unsigned long start, unsigned long end)
> > >  {
> > > @@ -836,13 +838,13 @@ static long madvise_remove(struct vm_area_struct *vma,
> > >  	get_file(f);
> > >  	if (userfaultfd_remove(vma, start, end)) {
> > >  		/* mmap_sem was not released by userfaultfd_remove() */
> > > -		up_read(&current->mm->mmap_sem);
> > > +		up_read(&tsk->mm->mmap_sem);
> > >  	}
> > >  	error = vfs_fallocate(f,
> > >  				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> > >  				offset, end - start);
> > >  	fput(f);
> > > -	down_read(&current->mm->mmap_sem);
> > > +	down_read(&tsk->mm->mmap_sem);
> > >  	return error;
> > >  }
> > >  
> > > @@ -916,12 +918,13 @@ static int madvise_inject_error(int behavior,
> > >  #endif
> > 
> > What about madvise_inject_error() and get_user_pages_fast() in it
> > please?
> 
> Good point. Maybe, there more places where assume context is "current" so
> I'm thinking to limit hints we could allow from external process.
> It would be better for maintainance point of view in that we could know
> the workload/usecases when someone ask new advises from external process
> without making every hints works both contexts.

Well, for madvise_inject_error() we still have a remote variant of
get_user_pages(), and that should work, no?

Regarding restricting the hints, I'm definitely interested in having
remote MADV_MERGEABLE/MADV_UNMERGEABLE. But, OTOH, doing it via remote
madvise() introduces another issue with traversing remote VMAs reliably.
IIUC, one can do this via userspace by parsing [s]maps file only, which
is not very consistent, and once some range is parsed, and then it is
immediately gone, a wrong hint will be sent.

Isn't this a problem we should worry about?

> 
> Thanks.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
