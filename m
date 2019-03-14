Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F329AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB302184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfCNQQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:16:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfCNQQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:16:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F86F8553B;
        Thu, 14 Mar 2019 16:16:38 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 375A117CEB;
        Thu, 14 Mar 2019 16:16:34 +0000 (UTC)
Date:   Thu, 14 Mar 2019 12:16:30 -0400
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
Message-ID: <20190314161630.GS25147@redhat.com>
References: <20190311093701.15734-1-peterx@redhat.com>
 <58e63635-fc1b-cb53-a4d1-237e6b8b7236@oracle.com>
 <20190313060023.GD2433@xz-x1>
 <3714d120-64e3-702e-6eef-4ef253bdb66d@redhat.com>
 <20190313185230.GH25147@redhat.com>
 <1934896481.7779933.1552504348591.JavaMail.zimbra@redhat.com>
 <20190313234458.GJ25147@redhat.com>
 <298b9469-abd2-b02b-5c71-529b8976a46c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298b9469-abd2-b02b-5c71-529b8976a46c@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 14 Mar 2019 16:16:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:58:15AM +0100, Paolo Bonzini wrote:
> On 14/03/19 00:44, Andrea Arcangeli wrote:
> > Then I thought we can add a tristate so an open of /dev/kvm would also
> > allow the syscall to make things more user friendly because
> > unprivileged containers ideally should have writable mounts done with
> > nodev and no matter the privilege they shouldn't ever get an hold on
> > the KVM driver (and those who do, like kubevirt, will then just work).
> 
> I wouldn't even bother with the KVM special case.  Containers can use
> seccomp if they want a fine-grained policy.

We can have a single boolean 0|1 and stick to a simpler sysctl and no
gid and if you want to use userfaultfd you need to enable it for all
users. I agree seccomp already provides more than enough granularity
to do more finegrined choices.

So this will be for who's paranoid and prefers to disable userfaultfd
as a whole as an hardening feature like the bpf sysctl allows: it will
allow to block uffd syscall without having to rebuild the kernel with
CONFIG_USERFAULTFD=n in environments where seccomp cannot be easily
enabled (i.e. without requiring userland changes).

That's very fine with me, but then it wasn't me complaining in the
first place. Kees?

If the above is ok, we can implement it as a static key, not that the
syscall itself is particularly performance critical but it'll be
simple enough as a boolean (only the ioctl are performance critical
but those are unaffected).

The blog post about UAF is not particularly interesting in my view,
unless both of the following points are true 1) it can be also proven
that the very same two UAF bugs, cannot be exploited by other means
(as far as I can tell it can be exploited by other means regardless of
userfaultfd) and 2) the slab randomization was actually enabled (99%
of the time in all POC all randomization features like kalsr are
incidentally disabled first to facilitate publishing papers and blog
posts, but those are really the features intended to reduce the
reproduciblity of exploits against UAF bugs, not disabling userfaultfd
which only provides a minor advantage, and unlike in PoC environments,
we enable those slab randomization in production 100% of the time
whenever they're available in the kernel).

Thanks,
Andrea
