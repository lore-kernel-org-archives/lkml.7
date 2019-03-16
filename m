Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EAFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D6D218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCPTm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 15:42:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPTm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 15:42:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D5F3C057E68;
        Sat, 16 Mar 2019 19:42:26 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08A9B1001DE9;
        Sat, 16 Mar 2019 19:42:23 +0000 (UTC)
Date:   Sat, 16 Mar 2019 15:42:22 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+cbb52e396df3e565ab02@syzkaller.appspotmail.com>,
        Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: KASAN: use-after-free Read in get_mem_cgroup_from_mm
Message-ID: <20190316194222.GA29767@redhat.com>
References: <CACT4Y+Z+CH0UTdSz-w_woMPrBwg-GuobV1Su4qd9ReffTkyfVg@mail.gmail.com>
 <5C7D2F82.40907@huawei.com>
 <CACT4Y+agwaszODNGJHCqn4fSk4Le9exn3Cau0nornJ0RaTpDJw@mail.gmail.com>
 <5C7D4500.3070607@huawei.com>
 <CACT4Y+b6y_3gTpR8LvNREHOV0TP7jB=Zp1L03dzpaz_SaeESng@mail.gmail.com>
 <5C7E1A38.2060906@huawei.com>
 <20190306020540.GA23850@redhat.com>
 <5C821550.50506@huawei.com>
 <20190315213944.GD9967@redhat.com>
 <5C8CC42E.1090208@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C8CC42E.1090208@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 16 Mar 2019 19:42:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 05:38:54PM +0800, zhong jiang wrote:
> On 2019/3/16 5:39, Andrea Arcangeli wrote:
> > On Fri, Mar 08, 2019 at 03:10:08PM +0800, zhong jiang wrote:
> >> I can reproduce the issue in arm64 qemu machine.  The issue will leave after applying the
> >> patch.
> >>
> >> Tested-by: zhong jiang <zhongjiang@huawei.com>
> > Thanks a lot for the quick testing!
> >
> >> Meanwhile,  I just has a little doubt whether it is necessary to use RCU to free the task struct or not.
> >> I think that mm->owner alway be NULL after failing to create to process. Because we call mm_clear_owner.
> > I wish it was enough, but the problem is that the other CPU may be in
> > the middle of get_mem_cgroup_from_mm() while this runs, and it would
> > dereference mm->owner while it is been freed without the call_rcu
> > affter we clear mm->owner. What prevents this race is the
> As you had said, It would dereference mm->owner after we clear mm->owner.
> 
> But after we clear mm->owner,  mm->owner should be NULL.  Is it right?
> 
> And mem_cgroup_from_task will check the parameter. 
> you mean that it is possible after checking the parameter to  clear the owner .
> and the NULL pointer will trigger. :-(

Dereference mm->owner didn't mean reading the value of the mm->owner
pointer, it really means to dereference the value of the pointer. It's
like below:

get_mem_cgroup_from_mm()		failing fork()
----					---
task = mm->owner
					mm->owner = NULL;
					free(mm->owner)
*task /* use after free */

We didn't set mm->owner to NULL before, so the window for the race was
larger, but setting mm->owner to NULL only hides the problem and it
can still happen (albeit with a smaller window).

If get_mem_cgroup_from_mm() can see at any time mm->owner not NULL,
then the free of the task struct must be delayed until after
rcu_read_unlock has returned in get_mem_cgroup_from_mm(). This is
the standard RCU model, the freeing must be delayed until after the
next quiescent point.

BTW, both mm_update_next_owner() and mm_clear_owner() should have used
WRITE_ONCE when they write to mm->owner, I can update that too but
it's just to not to make assumptions that gcc does the right thing
(and we still rely on gcc to do the right thing in other places) so
that is just an orthogonal cleanup.

Thanks,
Andrea
