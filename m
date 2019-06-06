Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F5EC28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BE8208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559850914;
	bh=7aT1cLQVGjUeOYY5DnwTs+kTMezsNx0Ni8bpHLFeIcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BLuuXHltXJdvdBqHenKfKBJE9fCvGRiN+21Hdq3JvZoERTxoKUj91YxFE46J1fYcW
	 GAYlLqkjDMYG5YAW3Ws8GjCwWfKJ5j2iAFo1DpHDCaVBy+q+EGe1+08IuENsa1bhge
	 vlUSIo64t0J6zsRDkyUE7qaaJDPg93m6hxA5TBz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfFFTzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:55:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:56808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727512AbfFFTzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:55:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DACD6AD8A;
        Thu,  6 Jun 2019 19:55:11 +0000 (UTC)
Date:   Thu, 6 Jun 2019 21:55:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     Stable tree <stable@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Srivatsa Bhat <srivatsab@vmware.com>
Subject: Re: [RFC PATCH stable-4.4] coredump: fix race condition between
 mmget_not_zero()/get_task_mm() and core dumping
Message-ID: <20190606195505.GA7047@dhcp22.suse.cz>
References: <5756B041-C0A8-4178-9F5B-7CBF7A554E31@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5756B041-C0A8-4178-9F5B-7CBF7A554E31@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-06-19 19:42:20, Ajay Kaher wrote:
> 
> > From: Andrea Arcangeli <aarcange@redhat.com>
> >
> > Upstream 04f5866e41fb70690e28397487d8bd8eea7d712a commit.
> >
> >
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> > Hi,
> > this is based on the backport I have done for out 4.4 based distribution
> > kernel. Please double check that I haven't missed anything before
> > applying to the stable tree. I have also CCed Joel for the binder part
> > which is not in the current upstream anymore but I believe it needs the
> > check as well.
> >
> > Review feedback welcome.
> >
> > drivers/android/binder.c |  6 ++++++
> > fs/proc/task_mmu.c       | 18 ++++++++++++++++++
> > fs/userfaultfd.c         | 10 ++++++++--
> > include/linux/mm.h       | 21 +++++++++++++++++++++
> > mm/huge_memory.c         |  2 +-
> > mm/mmap.c                |  7 ++++++-
> > 6 files changed, 60 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 260ce0e60187..1fb1cddbd19a 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -570,6 +570,12 @@ static int binder_update_page_range(struct binder_proc *proc, int allocate,
> > 
> > 	if (mm) {
> > 		down_write(&mm->mmap_sem);
> > +		if (!mmget_still_valid(mm)) {
> > +			if (allocate == 0)
> > +				goto free_range;
> 
> Please cross check, free_range: should not end-up with modifications in vma.

A review from a binder expert is definitely due but this function
clearly modifies the vma. Maybe the mapping is not really that important
because the coredump would simply not see the new mapping and therefore
"only" generate an incomplete/corrupted dump rather than leak an
information. I went with a "just to be sure" approach and add the check
to all locations which might be operating on a remote mm and modify the
address space.

-- 
Michal Hocko
SUSE Labs
