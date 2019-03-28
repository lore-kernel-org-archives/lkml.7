Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8C5C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35292184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfC1Vaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 17:30:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfC1Vav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 17:30:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC16237E88;
        Thu, 28 Mar 2019 21:30:50 +0000 (UTC)
Received: from redhat.com (ovpn-121-118.rdu2.redhat.com [10.10.121.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAF10891DE;
        Thu, 28 Mar 2019 21:30:49 +0000 (UTC)
Date:   Thu, 28 Mar 2019 17:30:47 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 10/11] mm/hmm: add helpers for driver to safely take
 the mmap_sem v2
Message-ID: <20190328213047.GB13560@redhat.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-11-jglisse@redhat.com>
 <9df742eb-61ca-3629-a5f4-8ad1244ff840@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9df742eb-61ca-3629-a5f4-8ad1244ff840@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 28 Mar 2019 21:30:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 01:54:01PM -0700, John Hubbard wrote:
> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > The device driver context which holds reference to mirror and thus to
> > core hmm struct might outlive the mm against which it was created. To
> > avoid every driver to check for that case provide an helper that check
> > if mm is still alive and take the mmap_sem in read mode if so. If the
> > mm have been destroy (mmu_notifier release call back did happen) then
> > we return -EINVAL so that calling code knows that it is trying to do
> > something against a mm that is no longer valid.
> > 
> > Changes since v1:
> >     - removed bunch of useless check (if API is use with bogus argument
> >       better to fail loudly so user fix their code)
> > 
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  include/linux/hmm.h | 50 ++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 47 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > index f3b919b04eda..5f9deaeb9d77 100644
> > --- a/include/linux/hmm.h
> > +++ b/include/linux/hmm.h
> > @@ -438,6 +438,50 @@ struct hmm_mirror {
> >  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm);
> >  void hmm_mirror_unregister(struct hmm_mirror *mirror);
> >  
> > +/*
> > + * hmm_mirror_mm_down_read() - lock the mmap_sem in read mode
> > + * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
> > + * Returns: -EINVAL if the mm is dead, 0 otherwise (lock taken).
> > + *
> > + * The device driver context which holds reference to mirror and thus to core
> > + * hmm struct might outlive the mm against which it was created. To avoid every
> > + * driver to check for that case provide an helper that check if mm is still
> > + * alive and take the mmap_sem in read mode if so. If the mm have been destroy
> > + * (mmu_notifier release call back did happen) then we return -EINVAL so that
> > + * calling code knows that it is trying to do something against a mm that is
> > + * no longer valid.
> > + */
> > +static inline int hmm_mirror_mm_down_read(struct hmm_mirror *mirror)
> 
> Hi Jerome,
> 
> Let's please not do this. There are at least two problems here:
> 
> 1. The hmm_mirror_mm_down_read() wrapper around down_read() requires a 
> return value. This is counter to how locking is normally done: callers do
> not normally have to check the return value of most locks (other than
> trylocks). And sure enough, your own code below doesn't check the return value.
> That is a pretty good illustration of why not to do this.

Please read the function description this is not about checking lock
return value it is about checking wether we are racing with process
destruction and avoid trying to take lock in such cases so that driver
do abort as quickly as possible when a process is being kill.

> 
> 2. This is a weird place to randomly check for semi-unrelated state, such 
> as "is HMM still alive". By that I mean, if you have to detect a problem
> at down_read() time, then the problem could have existed both before and
> after the call to this wrapper. So it is providing a false sense of security,
> and it is therefore actually undesirable to add the code.

It is not, this function is use in device page fault handler which will
happens asynchronously from CPU event or process lifetime when a process
is killed or is dying we do want to avoid useless page fault work and
we do want to avoid blocking the page fault queue of the device. This
function reports to the caller that the process is dying and that it
should just abort the page fault and do whatever other device specific
thing that needs to happen.

> 
> If you insist on having this wrapper, I think it should have approximately 
> this form:
> 
> void hmm_mirror_mm_down_read(...)
> {
> 	WARN_ON(...)
> 	down_read(...)
> } 

I do insist as it is useful and use by both RDMA and nouveau and the
above would kill the intent. The intent is do not try to take the lock
if the process is dying.


> 
> > +{
> > +	struct mm_struct *mm;
> > +
> > +	/* Sanity check ... */
> > +	if (!mirror || !mirror->hmm)
> > +		return -EINVAL;
> > +	/*
> > +	 * Before trying to take the mmap_sem make sure the mm is still
> > +	 * alive as device driver context might outlive the mm lifetime.
> 
> Let's find another way, and a better place, to solve this problem.
> Ref counting?

This has nothing to do with refcount or use after free or anthing
like that. It is just about checking wether we are about to do
something pointless. If the process is dying then it is pointless
to try to take the lock and it is pointless for the device driver
to trigger handle_mm_fault().

> 
> > +	 *
> > +	 * FIXME: should we also check for mm that outlive its owning
> > +	 * task ?
> > +	 */
> > +	mm = READ_ONCE(mirror->hmm->mm);
> > +	if (mirror->hmm->dead || !mm)
> > +		return -EINVAL;
> > +
> > +	down_read(&mm->mmap_sem);
> > +	return 0;
> > +}
> > +
> > +/*
> > + * hmm_mirror_mm_up_read() - unlock the mmap_sem from read mode
> > + * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
> > + */
> > +static inline void hmm_mirror_mm_up_read(struct hmm_mirror *mirror)
> > +{
> > +	up_read(&mirror->hmm->mm->mmap_sem);
> > +}
> > +
> >  
> >  /*
> >   * To snapshot the CPU page table you first have to call hmm_range_register()
> > @@ -463,7 +507,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
> >   *          if (ret)
> >   *              return ret;
> >   *
> > - *          down_read(mm->mmap_sem);
> > + *          hmm_mirror_mm_down_read(mirror);
> 
> See? The normal down_read() code never needs to check a return value, so when
> someone does a "simple" upgrade, it introduces a fatal bug here: if the wrapper
> returns early, then the caller proceeds without having acquired the mmap_sem.

That convertion is useless can't remember why i did it.

> >   *      again:
> >   *
> >   *          if (!hmm_range_wait_until_valid(&range, TIMEOUT)) {
> > @@ -476,13 +520,13 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
> >   *
> >   *          ret = hmm_range_snapshot(&range); or hmm_range_fault(&range);
> >   *          if (ret == -EAGAIN) {
> > - *              down_read(mm->mmap_sem);
> > + *              hmm_mirror_mm_down_read(mirror);
> 
> Same problem here.

Again useless i can't remember why i did that one. This helper is
intended to be use by driver.

Cheers,
Jérôme
