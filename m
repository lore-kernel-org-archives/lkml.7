Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98716C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770A020652
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfFYFba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:31:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFYFb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:31:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 290548E223;
        Tue, 25 Jun 2019 05:31:05 +0000 (UTC)
Received: from xz-x1 (unknown [10.66.60.185])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BB435D9C3;
        Tue, 25 Jun 2019 05:30:49 +0000 (UTC)
Date:   Tue, 25 Jun 2019 13:30:47 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 02/25] mm: userfault: return VM_FAULT_RETRY on signals
Message-ID: <20190625053047.GC10020@xz-x1>
References: <20190620022008.19172-1-peterx@redhat.com>
 <20190620022008.19172-3-peterx@redhat.com>
 <CAHk-=wiGphH2UL+To5rASyFoCk6=9bROUkGDWSa_rMu9Kgb0yw@mail.gmail.com>
 <20190624074250.GF6279@xz-x1>
 <CAHk-=whRw_6ZTj=AT=cRoSTyoEk2-hiqJoNkqgWE-gSRVE5YwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whRw_6ZTj=AT=cRoSTyoEk2-hiqJoNkqgWE-gSRVE5YwQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 25 Jun 2019 05:31:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 09:31:42PM +0800, Linus Torvalds wrote:
> On Mon, Jun 24, 2019 at 3:43 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Should we still be able to react on signal_pending() as part of fault
> > handling (because that's what this patch wants to do, at least for an
> > user-mode page fault)?  Please kindly correct me if I misunderstood...
> 
> I think that with this patch (modulo possible fix-ups) then yes, as
> long as we're returning to user mode we can do signal_pending() and
> return RETRY.
> 
> But I think we really want to add a new FAULT_FLAG_INTERRUPTIBLE bit
> for that (the same way we already have FAULT_FLAG_KILLABLE for things
> that can react to fatal signals), and only do it when that is set.
> Then the page fault handler can set that flag when it's doing a
> user-mode page fault.
> 
> Does that sound reasonable?

Yes that sounds reasonable to me, and that matches perfectly with
TASK_INTERRUPTIBLE and TASK_KILLABLE.  The only thing that I am a bit
uncertain is whether we should define FAULT_FLAG_INTERRUPTIBLE as a
new bit or make it simply a combination of:

  FAULT_FLAG_KILLABLE | FAULT_FLAG_USER

The problem is that when we do set_current_state() with either
TASK_INTERRUPTIBLE or TASK_KILLABLE we'll only choose one of them, but
never both.  Here since the fault flag is a bitmask then if we
introduce a new FAULT_FLAG_INTERRUPTIBLE bit and use it in the fault
flags then we should probably be sure that FAULT_FLAG_KILLABLE is also
set when with that (since IMHO it won't make much sense to make a page
fault "interruptable" but "un-killable"...).  Considering that
TASK_INTERRUPTIBLE should also always in user-mode page faults so this
dependency seems to exist with FAULT_FLAG_USER.  Then I'm thinking
maybe using the combination to express the meaning that "we would like
this page fault to be interruptable, even for general userspace
signals" would be nicer?

AFAIK currently only handle_userfault() have such code to handle
normal signals besides SIGKILL, and it was trying to detect this using
this rule already:

	return_to_userland =
		(vmf->flags & (FAULT_FLAG_USER|FAULT_FLAG_KILLABLE)) ==
		(FAULT_FLAG_USER|FAULT_FLAG_KILLABLE);

Then if we define that globally and officially then we can probably
replace this simply with:

	return_to_userland = vmf->flags & FAULT_FLAG_INTERRUPTIBLE;

What do you think?

Thanks,

-- 
Peter Xu
