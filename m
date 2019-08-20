Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C1EC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819832332B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aYdoPW4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfHTPSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:18:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37985 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbfHTPSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:18:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so6735222edo.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WWDlGa28vuh6oyYZfImriVv5lKQQ+IIy5I7j/w5T4Gg=;
        b=aYdoPW4Mvo6YtazOhtnc4ypyhm+qnjOhOXk3ZP2Z58IiJkGhlIoOoy4vFST6kEbhnd
         V1wp+g3K8u0R1/NnJLA6jmPSQTsJFvmcgGqg9sx+I4Ybv+Atic0BqKdJYciuXoPn4GTu
         MVJmP+fAaX12IxRXdt8Yz7aCXLWYef4u5coho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WWDlGa28vuh6oyYZfImriVv5lKQQ+IIy5I7j/w5T4Gg=;
        b=Irj58nLHp37R5tBangVXBP2qFolYm4WBxSFJq+tpQ5neAAXjMY9HiCXApvp0bHuTHp
         60B/CSmmpF3Lh72OKX2QA5LH02thAN31kjV4CoFBFQflSBD7XCUYcl1iICVKScXS+Uwt
         UkFOlJyxZDHyqrJszNXyQhC2Te+QdPTf34kx9qAwUIwWuAB7f+pXinn1Ew3oXX2NHnAW
         RjT8tOXI07P3TRGWNOhmLYxltpdYKyulpoLn1+sCPqYLdWMdqjn1EO/glqZ88p3TVMoZ
         41jFxdDpcOmLSfUpGbD4LqTJgt+med+pD7SvOPwCk/FHtz1bvoOHH9lR4DuNY0Q3mZj9
         g8zg==
X-Gm-Message-State: APjAAAUXpInyQ3qq9Sak/q1cwrBTLxE4KWP7TvEXFYhEnC/IPPHwgvU1
        jYHBHjDuQEmaNYEli+jU+v7n7A==
X-Google-Smtp-Source: APXvYqwfJ8KGQhdIP9dJFoc5GtYy4qaMCSLIJx0+QTRiFkwBVEZaoyD3Z4vkA0GYiSFo+zVsSSDxmA==
X-Received: by 2002:a17:906:cc81:: with SMTP id oq1mr26923934ejb.124.1566314293557;
        Tue, 20 Aug 2019 08:18:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id oa21sm2669585ejb.60.2019.08.20.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 08:18:12 -0700 (PDT)
Date:   Tue, 20 Aug 2019 17:18:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4/4] mm, notifier: Catch sleeping/blocking for !blockable
Message-ID: <20190820151810.GG11147@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-5-daniel.vetter@ffwll.ch>
 <20190820133418.GG29246@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190820133418.GG29246@ziepe.ca>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:34:18AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 20, 2019 at 10:19:02AM +0200, Daniel Vetter wrote:
> > We need to make sure implementations don't cheat and don't have a
> > possible schedule/blocking point deeply burried where review can't
> > catch it.
> > 
> > I'm not sure whether this is the best way to make sure all the
> > might_sleep() callsites trigger, and it's a bit ugly in the code flow.
> > But it gets the job done.
> > 
> > Inspired by an i915 patch series which did exactly that, because the
> > rules haven't been entirely clear to us.
> > 
> > v2: Use the shiny new non_block_start/end annotations instead of
> > abusing preempt_disable/enable.
> > 
> > v3: Rebase on top of Glisse's arg rework.
> > 
> > v4: Rebase on top of more Glisse rework.
> > 
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > Cc: linux-mm@kvack.org
> > Reviewed-by: Christian König <christian.koenig@amd.com>
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> >  mm/mmu_notifier.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > index 538d3bb87f9b..856636d06ee0 100644
> > +++ b/mm/mmu_notifier.c
> > @@ -181,7 +181,13 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
> >  	id = srcu_read_lock(&srcu);
> >  	hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist) {
> >  		if (mn->ops->invalidate_range_start) {
> > -			int _ret = mn->ops->invalidate_range_start(mn, range);
> > +			int _ret;
> > +
> > +			if (!mmu_notifier_range_blockable(range))
> > +				non_block_start();
> > +			_ret = mn->ops->invalidate_range_start(mn, range);
> > +			if (!mmu_notifier_range_blockable(range))
> > +				non_block_end();
> 
> If someone Acks all the sched changes then I can pick this for
> hmm.git, but I still think the existing pre-emption debugging is fine
> for this use case.

Ok, I'll ping Peter Z. for an ack, iirc he was involved.

> Also, same comment as for the lockdep map, this needs to apply to the
> non-blocking range_end also.

Hm, I thought the page table locks we're holding there already prevent any
sleeping, so would be redundant? But reading through code I think that's
not guaranteed, so yeah makes sense to add it for invalidate_range_end
too. I'll respin once I have the ack/nack from scheduler people.

> Anyhow, since this series has conflicts with hmm.git it would be best
> to flow through the whole thing through that tree. If there are no
> remarks on the first two patches I'll grab them in a few days.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
