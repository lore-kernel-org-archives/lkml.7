Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9682DC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E062086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ChRXyIAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfHOHKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:10:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39611 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730143AbfHOHKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:10:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id g8so1336922edm.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 00:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MDJNuF+hut+3YRzITm+axnt/d3tCzk1EPMOdFx9+DEE=;
        b=ChRXyIAYC7Rv8Y/vZMRO+O0Vlh5DAbIO5arU41q9pJ83DPuxW7q/ClkJgPqFUTZdkI
         RFRAoqFle60uB8sY67kiMD84/VinSId3gTA/SLZHu2D0j6h0ZI94eO3b9q/2tAqdpX+c
         FhwIh8fhcacKOZx661IGz8Odmwog/6hD0LIYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MDJNuF+hut+3YRzITm+axnt/d3tCzk1EPMOdFx9+DEE=;
        b=rmUXIjyIpy8qEaUaxC1jBThM8bRpscrZ9ovaWPziJST2ONi2/yIEXvC2+NT1njc82M
         dG+o0NuepQLGwKLcd6aap+ehrVv8UYOD9j9gjWJcOhdh6RJZ08gc2xTybQSP2qhV/JEt
         O9DxMYqNGIQGjiqOJqufnJI+u9fYyeull/RWDsJjBMjAwFgjiyoBpIgCJcmuikQHJMmx
         nMweZgd/bjjA2MGgIBHqglP5QHAF09UGqVJpJhA448Xr6Cr3mzSakh76ir2zfuqZ5YqV
         vCfUv860FbBJcZoGjd4An3EHarD0ErUotkcAjirgP/2FZRx/DCykLMo8NplGZaK2OHLR
         dFUA==
X-Gm-Message-State: APjAAAXSAkR9lGP5bwDagufop781r+NNR5oX5Ldd2FWodWWpI9gDxLAS
        4mjJediZKUDSO8a/MsZpjWK8Kg==
X-Google-Smtp-Source: APXvYqzeqsYGya7a5gyG8JjAs2HpNqhI6YY0zlDjUM0vg0ax5p423oBpWZJFMYcam0b+ez79KuLR5w==
X-Received: by 2002:a50:c101:: with SMTP id l1mr854278edf.157.1565853017629;
        Thu, 15 Aug 2019 00:10:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q21sm257841ejo.76.2019.08.15.00.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 00:10:16 -0700 (PDT)
Date:   Thu, 15 Aug 2019 09:10:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4/5] mm, notifier: Add a lockdep map for
 invalidate_range_start
Message-ID: <20190815071014.GC7444@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-5-daniel.vetter@ffwll.ch>
 <20190815000959.GD11200@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190815000959.GD11200@ziepe.ca>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 09:09:59PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 14, 2019 at 10:20:26PM +0200, Daniel Vetter wrote:
> > This is a similar idea to the fs_reclaim fake lockdep lock. It's
> > fairly easy to provoke a specific notifier to be run on a specific
> > range: Just prep it, and then munmap() it.
> > 
> > A bit harder, but still doable, is to provoke the mmu notifiers for
> > all the various callchains that might lead to them. But both at the
> > same time is really hard to reliable hit, especially when you want to
> > exercise paths like direct reclaim or compaction, where it's not
> > easy to control what exactly will be unmapped.
> > 
> > By introducing a lockdep map to tie them all together we allow lockdep
> > to see a lot more dependencies, without having to actually hit them
> > in a single challchain while testing.
> > 
> > Aside: Since I typed this to test i915 mmu notifiers I've only rolled
> > this out for the invaliate_range_start callback. If there's
> > interest, we should probably roll this out to all of them. But my
> > undestanding of core mm is seriously lacking, and I'm not clear on
> > whether we need a lockdep map for each callback, or whether some can
> > be shared.
> 
> I was thinking about doing something like this..
> 
> IMHO only range_end needs annotation, the other ops are either already
> non-sleeping or only used by KVM.

This isnt' about sleeping, this is about locking loops. And the biggest
risk for that is from driver code, and at least hmm_mirror only has the
driver code callback on invalidate_range_start. Once thing I discovered
using this (and it would be really hard to spot, it's deeply neested) is
that i915 userptr.

Even if i915 userptr would use hmm_mirror (to fix the issue you mention
below), if we then switch the annotation to invalidate_range_end nothing
interesting would ever come from this. Well, the only thing it'd catch is
issues in hmm_mirror, but I think core mm review will catch that before it
reaches us :-)

> BTW, I have found it strange that i915 only uses
> invalidate_range_start. Not really sure how it is able to do
> that. Would love to know the answer :)

I suspect it's broken :-/ Our userptr is ... not the best. Part of the
motivation here.

> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> >  include/linux/mmu_notifier.h | 6 ++++++
> >  mm/mmu_notifier.c            | 7 +++++++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> > index b6c004bd9f6a..9dd38c32fc53 100644
> > +++ b/include/linux/mmu_notifier.h
> > @@ -42,6 +42,10 @@ enum mmu_notifier_event {
> >  
> >  #ifdef CONFIG_MMU_NOTIFIER
> >  
> > +#ifdef CONFIG_LOCKDEP
> > +extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
> > +#endif
> 
> I wonder what the trade off is having a global map vs a map in each
> mmu_notifier_mm ?

Less reports, specifically no reports involving multiple different mmu
notifiers to build the entire chain. But I'm assuming it's possible to
combine them in one mm (kvm+gpu+infiniband in one process sounds like
something someone could reasonably do), and it will help to make sure
everyone follows the same rules.
> 
> >  /*
> >   * The mmu notifier_mm structure is allocated and installed in
> >   * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
> > @@ -310,10 +314,12 @@ static inline void mmu_notifier_change_pte(struct mm_struct *mm,
> >  static inline void
> >  mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
> >  {
> > +	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
> >  	if (mm_has_notifiers(range->mm)) {
> >  		range->flags |= MMU_NOTIFIER_RANGE_BLOCKABLE;
> >  		__mmu_notifier_invalidate_range_start(range);
> >  	}
> > +	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
> >  }
> 
> Also range_end should have this too - it has all the same
> constraints. I think it can share the map. So 'range_start_map' is
> probably not the right name.
> 
> It may also make some sense to do a dummy acquire/release under the
> mm_take_all_locks() to forcibly increase map coverage and reduce the
> scenario complexity required to hit bugs.
> 
> And if we do decide on the reclaim thing in my other email then the
> reclaim dependency can be reliably injected by doing:
> 
>  fs_reclaim_acquire();
>  lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
>  lock_map_release(&__mmu_notifier_invalidate_range_start_map);
>  fs_reclaim_release();
> 
> If I understand lockdep properly..

Ime fs_reclaim injects the mmu_notifier map here reliably as soon as
you've thrown out the first pagecache mmap on any process. That "make sure
we inject it quickly" is why the lockdep is _outside_ of the
mm_has_notifiers() check. So no further injection needed imo.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
