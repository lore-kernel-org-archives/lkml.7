Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4006EC04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 01:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA9E21479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 01:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558402018;
	bh=GH/arutFese2EuO3zHb/kOEPV3fBcPf6OEiV3o0mpIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aem4qcPIi14E2aJAnm3Z8Y3Po5lPTgs8ofH6r02MujAeznROpFIfvCAZd8J9etp3w
	 Q3QhTPH9tilSRkrVh05MK3QLuOIG6IiPhYDRRLXcmFYIpps2yimqQch433bD7rM222
	 6PCYimplCFY+qOmLV/pBy7WoOXat3bm0Bv9S+rpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfEUB05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 21:26:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39247 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfEUB04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 21:26:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so7556645plm.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 18:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q5tudNQ9cSMh3fCrTxG8NdksCakwJg8DbWSQrWyIrTI=;
        b=DLIH2eCPL/TbrcrBJeS072RZfACT/OHayR/cqOaUp7jstN6cQtTJ2IEb2WSwA905Yu
         CbztJl76ysh8fRQywqbHQMTK4Rtqu2TV+LgMStlkUkwDn4fgj109EcDjDtosETfHillX
         pAjdbYgfJtj0PofpNUmu9de9BVwPaZ6FWCF4NrS6UB4R2FgmYMg6DFxcPpyMVltTUWf6
         1QvvaVsF5RCkX2nLqQFkXPI/4Ia/PTK4vdvU6FjwFgyo5LvCfhUcqE6RfsJ//mYo5vgp
         zn0yh4FxQMYMqrVG7Uz48HqxvkW8oi1wqdHSvAJdr88NARk0dpExcyT1I9jxgVTaC5O/
         m0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q5tudNQ9cSMh3fCrTxG8NdksCakwJg8DbWSQrWyIrTI=;
        b=G/r0knRdE8ew60KYEZOwW/+qq5+CzExaSNCQx6hGLiJLCSYkcuxun9uG89Ag/bwAuY
         RoARuwLnl1HBoADmkoa/MxB1PlUFGWA8ybxMrOl7U2Wi99YVaY3hwuv/qVvJlbCB09Fq
         aiAb9GBbA+RRrrgwl37AzuHSXcFT8IUPT1Yh0QoQDXIx4gAs2A76qo8yzcQGo3rl3LWd
         KM5CQ1esc8HEObXo2oyqzEw6wn5LZRWeO5LjMtxw7F2JiG8a/PuHYv+BGlKQOf7WGqVn
         nBfJQk32lcgiWyup8WfQHX4LAA60uwE/K7/pgfy/hohffk/2ikozRT/LvUR8dyGJSyTP
         lRzQ==
X-Gm-Message-State: APjAAAXLWdNfgalubcVGpv/o7KoBICW5JW3d0UFaCu1HKLPqmyASek8i
        Ewge51hfWa/46wMUH6d7/s8=
X-Google-Smtp-Source: APXvYqwrSyAyALFyw9JHfY/nrm7OEjpxF4Wqstkj8FkkR4Th/leZJbMdZSinz1oSvJWv54bKmZF/tA==
X-Received: by 2002:a17:902:ba8d:: with SMTP id k13mr65556652pls.52.1558402016072;
        Mon, 20 May 2019 18:26:56 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id a8sm9209871pfk.14.2019.05.20.18.26.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 18:26:54 -0700 (PDT)
Date:   Tue, 21 May 2019 10:26:49 +0900
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
Message-ID: <20190521012649.GE10039@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-5-minchan@kernel.org>
 <20190520142633.x5d27gk454qruc4o@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520142633.x5d27gk454qruc4o@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

On Mon, May 20, 2019 at 04:26:33PM +0200, Oleksandr Natalenko wrote:
> Hi.
> 
> On Mon, May 20, 2019 at 12:52:51PM +0900, Minchan Kim wrote:
> > This patch factor out madvise's core functionality so that upcoming
> > patch can reuse it without duplication.
> > 
> > It shouldn't change any behavior.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/madvise.c | 168 +++++++++++++++++++++++++++------------------------
> >  1 file changed, 89 insertions(+), 79 deletions(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 9a6698b56845..119e82e1f065 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -742,7 +742,8 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
> >  	return 0;
> >  }
> >  
> > -static long madvise_dontneed_free(struct vm_area_struct *vma,
> > +static long madvise_dontneed_free(struct task_struct *tsk,
> > +				  struct vm_area_struct *vma,
> >  				  struct vm_area_struct **prev,
> >  				  unsigned long start, unsigned long end,
> >  				  int behavior)
> > @@ -754,8 +755,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> >  	if (!userfaultfd_remove(vma, start, end)) {
> >  		*prev = NULL; /* mmap_sem has been dropped, prev is stale */
> >  
> > -		down_read(&current->mm->mmap_sem);
> > -		vma = find_vma(current->mm, start);
> > +		down_read(&tsk->mm->mmap_sem);
> > +		vma = find_vma(tsk->mm, start);
> >  		if (!vma)
> >  			return -ENOMEM;
> >  		if (start < vma->vm_start) {
> > @@ -802,7 +803,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> >   * Application wants to free up the pages and associated backing store.
> >   * This is effectively punching a hole into the middle of a file.
> >   */
> > -static long madvise_remove(struct vm_area_struct *vma,
> > +static long madvise_remove(struct task_struct *tsk,
> > +				struct vm_area_struct *vma,
> >  				struct vm_area_struct **prev,
> >  				unsigned long start, unsigned long end)
> >  {
> > @@ -836,13 +838,13 @@ static long madvise_remove(struct vm_area_struct *vma,
> >  	get_file(f);
> >  	if (userfaultfd_remove(vma, start, end)) {
> >  		/* mmap_sem was not released by userfaultfd_remove() */
> > -		up_read(&current->mm->mmap_sem);
> > +		up_read(&tsk->mm->mmap_sem);
> >  	}
> >  	error = vfs_fallocate(f,
> >  				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> >  				offset, end - start);
> >  	fput(f);
> > -	down_read(&current->mm->mmap_sem);
> > +	down_read(&tsk->mm->mmap_sem);
> >  	return error;
> >  }
> >  
> > @@ -916,12 +918,13 @@ static int madvise_inject_error(int behavior,
> >  #endif
> 
> What about madvise_inject_error() and get_user_pages_fast() in it
> please?

Good point. Maybe, there more places where assume context is "current" so
I'm thinking to limit hints we could allow from external process.
It would be better for maintainance point of view in that we could know
the workload/usecases when someone ask new advises from external process
without making every hints works both contexts.

Thanks.
