Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AF021872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfCOI1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:27:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfCOI1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:27:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E259A3083392;
        Fri, 15 Mar 2019 08:27:04 +0000 (UTC)
Received: from xz-x1 (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9CFE1001DEB;
        Fri, 15 Mar 2019 08:26:54 +0000 (UTC)
Date:   Fri, 15 Mar 2019 16:26:55 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        kvm@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] userfaultfd: allow to forbid unprivileged users
Message-ID: <20190315082655.GA6654@xz-x1>
References: <20190311093701.15734-1-peterx@redhat.com>
 <58e63635-fc1b-cb53-a4d1-237e6b8b7236@oracle.com>
 <20190313060023.GD2433@xz-x1>
 <dd56566e-7b7f-51f6-bf01-ffda530a8073@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd56566e-7b7f-51f6-bf01-ffda530a8073@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 15 Mar 2019 08:27:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:50:48AM -0700, Mike Kravetz wrote:
> On 3/12/19 11:00 PM, Peter Xu wrote:
> > On Tue, Mar 12, 2019 at 12:59:34PM -0700, Mike Kravetz wrote:
> >> On 3/11/19 2:36 AM, Peter Xu wrote:
> >>>
> >>> The "kvm" entry is a bit special here only to make sure that existing
> >>> users like QEMU/KVM won't break by this newly introduced flag.  What
> >>> we need to do is simply set the "unprivileged_userfaultfd" flag to
> >>> "kvm" here to automatically grant userfaultfd permission for processes
> >>> like QEMU/KVM without extra code to tweak these flags in the admin
> >>> code.
> >>
> >> Another user is Oracle DB, specifically with hugetlbfs.  For them, we would
> >> like to add a special case like kvm described above.  The admin controls
> >> who can have access to hugetlbfs, so I think adding code to the open
> >> routine as in patch 2 of this series would seem to work.
> > 
> > Yes I think if there's an explicit and safe place we can hook for
> > hugetlbfs then we can do the similar trick as KVM case.  Though I
> > noticed that we can not only create hugetlbfs files under the
> > mountpoint (which the admin can control), but also using some other
> > ways.  The question (of me... sorry if it's a silly one!) is whether
> > all other ways to use hugetlbfs is still under control of the admin.
> > One I know of is memfd_create() which seems to be doable even as
> > unprivileged users.  If so, should we only limit the uffd privilege to
> > those hugetlbfs users who use the mountpoint directly?
> 
> Wow!  I did not realize that apps which specify mmap(MAP_HUGETLB) do not
> need any special privilege to use huge pages.  Honestly, I am not sure if
> that was by design or a bug.  The memfd_create code is based on the MAP_HUGETLB
> code and also does not need any special privilege.  Not to sidetrack this
> discussion, but people on Cc may know if this is a bug or by design.  My
> opinion is that huge pages are a limited resource and should be under control.
> One needs to be a member of a special group (or root) to access via System V
> interfaces.

Yeah I completely agree that huge pages should need some special
care...

> 
> The DB use case only does mmap of files in an explicitly mounted filesystem.
> So, limiting it in that manner would work for them.
> 
> > Another question is about fork() of privileged processes - for KVM we
> > only grant privilege for the exact process that opened the /dev/kvm
> > node, and the privilege will be lost for any forked childrens.  Is
> > that the same thing for OracleDB/Hugetlbfs?
> 
> I need to confirm with the DB people, but it is my understanding that the
> exact process which does the open/mmap will be the one using userfaultfd.

It'll be nice if these can be confirmed and if above proposal could
still be an alternative for us (grant privilege for processes who do
mknod() upon the hugetlbfs mountpoint; drop privilege when fork as
usual), since IMHO it is still the simplest approach comparing to what
we've discussed in the other threads...

Thanks,

-- 
Peter Xu
