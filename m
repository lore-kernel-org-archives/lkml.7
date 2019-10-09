Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC95ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC0B206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfJIDvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 23:51:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729352AbfJIDvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:51:51 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34C283CBE2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 03:51:51 +0000 (UTC)
Received: by mail-pg1-f198.google.com with SMTP id m20so729722pgv.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 20:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v6zthWMaXxy16Sz5/Jfq7PYKQr7G+zzByXErJdXa1H4=;
        b=DJM5GDa8pGErWKmEhCcmroaP06VzvUMwUXtaMlfWqgDZVqfrn7bUyLZ8K6FzKccVhM
         u4Iv/CC2jJCvR9qk/Ph8eaPWYmdBriitqyRRjuxvROA6ArLj9aClWLFs0kq9PCz15d/h
         98wfLtbE1plSVJiSsVtPqqnRY6wcaUBkZl6r5WwXDBdJRmghSc8A5bP2G5dripre7T2F
         Hj93OWBTISZirvttxa+hZ/QcJ6kUagMd6Qxt40sZm/q3qwZflwttBn/9/rPpI7IyOoAk
         VFGo2r3PKNTOGSN30UJE0knG6Q21lXnLx5nzdcuSrCmmFvrTEe9eEXi5sR/HpwO3/POd
         JVyA==
X-Gm-Message-State: APjAAAVFFV7ytPXSLt+45405lrIvLhDV8dxpZbYyN3gqp3g0CyXbXgEC
        otwImsSFdYU+HNUXiFQuIW4aUF3bUzLDGSuXQmLtxTlWfYzu8SzW5g8421kktwYx/sjZiQQo8lT
        5zgMcTstkeDsC3dXqYYgjh+qR
X-Received: by 2002:a17:90a:aa0a:: with SMTP id k10mr1554982pjq.13.1570593110337;
        Tue, 08 Oct 2019 20:51:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxoesHOy2Ihhkj1080nk6QezDay6UcvY1O5/cwED5wOEVCNZkMAHBTRY0QCZpVQq1c1wqcLBA==
X-Received: by 2002:a17:90a:aa0a:: with SMTP id k10mr1554908pjq.13.1570593109202;
        Tue, 08 Oct 2019 20:51:49 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 207sm616720pfu.129.2019.10.08.20.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 20:51:48 -0700 (PDT)
Date:   Wed, 9 Oct 2019 11:51:37 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/userfaultfd.c: simplify the calculation of new_flags
Message-ID: <20191009035137.GE10750@xz-x1>
References: <20190806053859.2374-1-richardw.yang@linux.intel.com>
 <20191003004505.GE13922@redhat.com>
 <20191004224640.GC32588@richard>
 <20191004232834.GP13922@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191004232834.GP13922@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 07:28:34PM -0400, Andrea Arcangeli wrote:
> On Sat, Oct 05, 2019 at 06:46:40AM +0800, Wei Yang wrote:
> > On Wed, Oct 02, 2019 at 08:45:05PM -0400, Andrea Arcangeli wrote:
> > >Hello,
> > >
> > >On Tue, Aug 06, 2019 at 01:38:59PM +0800, Wei Yang wrote:
> > >> Finally new_flags equals old vm_flags *OR* vm_flags.
> > >> 
> > >> It is not necessary to mask them first.
> > >> 
> > >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > >> ---
> > >>  fs/userfaultfd.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >> 
> > >> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > >> index ccbdbd62f0d8..653d8f7c453c 100644
> > >> --- a/fs/userfaultfd.c
> > >> +++ b/fs/userfaultfd.c
> > >> @@ -1457,7 +1457,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >>  			start = vma->vm_start;
> > >>  		vma_end = min(end, vma->vm_end);
> > >>  
> > >> -		new_flags = (vma->vm_flags & ~vm_flags) | vm_flags;
> > >> +		new_flags = vma->vm_flags | vm_flags;
> > >>  		prev = vma_merge(mm, prev, start, vma_end, new_flags,
> > >>  				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > >>  				 vma_policy(vma),
> > >
> > >And then how do you clear the flags after the above?
> > >
> > >It must be possible to clear the flags (from
> > >UFFDIO_REGISTER_MODE_MISSING|UFFDIO_REGISTER_MODE_WP to only one set
> > >or invert).
> > >
> > >We have no WP support upstream yet, so maybe that's why it looks
> > >superfluous in practice, but in theory it isn't because it would then
> > >need to be reversed by Peter's (CC'ed) -wp patchset.
> > >
> > >The register code has already the right placeholder to support -wp and
> > >so it's better not to break them.
> > >
> > >I would recommend reviewing the uffd-wp support and working on testing
> > >the uffd-wp code instead of changing the above.
> > >
> > 
> > Sorry, I don't get your point. This change is valid to me even from arithmetic
> > point of view.
> > 
> >     vm_flags == VM_UFFD_MISSING | VM_UFFD_WP
> > 
> > The effect of current code is clear these two bits then add them. This equals
> > to just add these two bits.
> > 
> > I am not sure which part I lost.
> 
> The cleaned removed the "& ~" and that was enough to quickly tell the
> cleaned up version was wrong.
> 
> What I should have noticed right away as well is that the code was
> already wrong, sorry. That code doesn't require a noop code cleanup,
> it requires a fix and the "& ~" needs to stay.
> 
> This isn't going to make any difference upstream until the uffd-wp
> support is merged so it is enough to queue it in Peter's queue, or you
> can merge it independently.

IMHO it's good to have it as independent patch so at least it won't
confuse another reader of the master branch.  But just in case, I've
also queued it in my local tree of uffd-wp.

Thanks,

-- 
Peter Xu
