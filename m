Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948D5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DF921019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfCMSwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:52:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMSwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:52:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5726307E042;
        Wed, 13 Mar 2019 18:52:36 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6BA46058F;
        Wed, 13 Mar 2019 18:52:31 +0000 (UTC)
Date:   Wed, 13 Mar 2019 14:52:30 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        kvm@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] userfaultfd: allow to forbid unprivileged users
Message-ID: <20190313185230.GH25147@redhat.com>
References: <20190311093701.15734-1-peterx@redhat.com>
 <58e63635-fc1b-cb53-a4d1-237e6b8b7236@oracle.com>
 <20190313060023.GD2433@xz-x1>
 <3714d120-64e3-702e-6eef-4ef253bdb66d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3714d120-64e3-702e-6eef-4ef253bdb66d@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 13 Mar 2019 18:52:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Mar 13, 2019 at 09:22:31AM +0100, Paolo Bonzini wrote:
> On 13/03/19 07:00, Peter Xu wrote:
> >> However, I can imagine more special cases being added for other users.  And,
> >> once you have more than one special case then you may want to combine them.
> >> For example, kvm and hugetlbfs together.
> > It looks fine to me if we're using MMF_USERFAULTFD_ALLOW flag upon
> > mm_struct, since that seems to be a very general flag that can be used
> > by anything we want to grant privilege for, not only KVM?
> 
> Perhaps you can remove the fork() limitation, and add a new suboption to
> prctl(PR_SET_MM) that sets/resets MMF_USERFAULTFD_ALLOW.  If somebody
> wants to forbid unprivileged userfaultfd and use KVM, they'll have to
> use libvirt or some other privileged management tool.
> 
> We could also add support for this prctl to systemd, and then one could
> do "systemd-run -pAllowUserfaultfd=yes COMMAND".

systemd can already implement -pAllowUserfaultfd=no with seccomp if it
wants. It can also implement -yes if by default turns off userfaultfd
like firejail -seccomp would do.

If the end goal is to implement the filtering with an userland policy
instead of a kernel policy, seccomp enabled for all services sounds
reasonable. It's very unlikely you'll block only userfaultfd, firejail
-seccomp by default blocks dozen of syscalls that are unnecessary
99.9% of the time.

This is not about implementing an userland flexible policy, it's just
a simple kernel policy, to use until userland disables the kernel
policy to takeover with seccomp across the board.

I wouldn't like this too be too complicated because this is already
theoretically overlapping 100% with seccomp.

hugetlbfs is more complicated to detect, because even if you inherit
it from fork(), the services that mounts the fs may be in a different
container than the one that Oracle that uses userfaultfd later on down
the road from a different context. And I don't think it would be ok to
allow running userfaultfd just because you can open a file in an
hugetlbfs file system. With /dev/kvm it's a bit different, that's
chmod o-r by default.. no luser should be able to open it.

Unless somebody suggests a consistent way to make hugetlbfs "just
work" (like we could achieve clean with CRIU and KVM), I think Oracle
will need a one liner change in the Oracle setup to echo into that
file in addition of running the hugetlbfs mount.

Note that DPDK host bridge process will also need a one liner change
to do a dummy open/close of /dev/kvm to unblock the syscall.

Thanks,
Andrea
