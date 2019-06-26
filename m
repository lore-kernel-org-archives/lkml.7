Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F29C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F312086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfFZHoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:44:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfFZHoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:44:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C4045D672;
        Wed, 26 Jun 2019 07:43:54 +0000 (UTC)
Received: from xz-x1 (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FC9C1001B04;
        Wed, 26 Jun 2019 07:43:36 +0000 (UTC)
Date:   Wed, 26 Jun 2019 15:43:30 +0800
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
Message-ID: <20190626074330.GB24379@xz-x1>
References: <20190620022008.19172-1-peterx@redhat.com>
 <20190620022008.19172-3-peterx@redhat.com>
 <CAHk-=wiGphH2UL+To5rASyFoCk6=9bROUkGDWSa_rMu9Kgb0yw@mail.gmail.com>
 <20190624074250.GF6279@xz-x1>
 <CAHk-=whRw_6ZTj=AT=cRoSTyoEk2-hiqJoNkqgWE-gSRVE5YwQ@mail.gmail.com>
 <20190625053047.GC10020@xz-x1>
 <CAHk-=wjxOz5RXpFTU=wSJg4Mjg1ugOBhBVppSTH6qjZPxpGOKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxOz5RXpFTU=wSJg4Mjg1ugOBhBVppSTH6qjZPxpGOKg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 26 Jun 2019 07:44:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:59:58AM +0800, Linus Torvalds wrote:
> On Tue, Jun 25, 2019 at 1:31 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Yes that sounds reasonable to me, and that matches perfectly with
> > TASK_INTERRUPTIBLE and TASK_KILLABLE.  The only thing that I am a bit
> > uncertain is whether we should define FAULT_FLAG_INTERRUPTIBLE as a
> > new bit or make it simply a combination of:
> >
> >   FAULT_FLAG_KILLABLE | FAULT_FLAG_USER
> 
> It needs to be a new bit, I think.
> 
> Some things could potentially care about the difference between "can I
> abort this thing because the task will *die* and never see the end
> result" and "can I abort this thing because it will be retried".
> 
> For a regular page fault, maybe FAULT_FLAG_INTERRUPTBLE will always be
> set for the same things that set FAULT_FLAG_KILLABLE when it happens
> from user mode, but at least conceptually I think they are different,
> and it could make a difference for things like get_user_pages() or
> similar.
> 
> Also, I actually don't think we should ever expose FAULT_FLAG_USER to
> any fault handlers anyway. It has a very specific meaning for memory
> cgroup handling, and no other fault handler should likely ever care
> about "was this a user fault". So I'd actually prefer for people to
> ignore and forget that hacky flag entirely, rather than give it subtle
> semantic meaning together with KILLABLE.

OK.

> 
> [ Side note: this is the point where I may soon lose internet access,
> so I'll probably not be able to participate in the discussion any more
> for a while ]

Appreciate for these suggestions.  I'll prepare something with that
new bit and see whether that could be accepted.  I'll also try to
split those out of the bigger series.

Thanks,

-- 
Peter Xu
