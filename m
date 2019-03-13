Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FBEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F9E2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCMXzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:55:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfCMXzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:55:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49E6730018EB;
        Wed, 13 Mar 2019 23:55:40 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8461F60F94;
        Wed, 13 Mar 2019 23:55:35 +0000 (UTC)
Date:   Wed, 13 Mar 2019 19:55:34 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
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
Message-ID: <20190313235534.GK25147@redhat.com>
References: <20190311093701.15734-1-peterx@redhat.com>
 <58e63635-fc1b-cb53-a4d1-237e6b8b7236@oracle.com>
 <20190313060023.GD2433@xz-x1>
 <3714d120-64e3-702e-6eef-4ef253bdb66d@redhat.com>
 <20190313185230.GH25147@redhat.com>
 <e1fcdd99-20d3-c161-8a05-b98b8036137c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1fcdd99-20d3-c161-8a05-b98b8036137c@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 13 Mar 2019 23:55:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 01:01:40PM -0700, Mike Kravetz wrote:
> On 3/13/19 11:52 AM, Andrea Arcangeli wrote:
> > 
> > hugetlbfs is more complicated to detect, because even if you inherit
> > it from fork(), the services that mounts the fs may be in a different
> > container than the one that Oracle that uses userfaultfd later on down
> > the road from a different context. And I don't think it would be ok to
> > allow running userfaultfd just because you can open a file in an
> > hugetlbfs file system. With /dev/kvm it's a bit different, that's
> > chmod o-r by default.. no luser should be able to open it.
> > 
> > Unless somebody suggests a consistent way to make hugetlbfs "just
> > work" (like we could achieve clean with CRIU and KVM), I think Oracle
> > will need a one liner change in the Oracle setup to echo into that
> > file in addition of running the hugetlbfs mount.
> 
> I think you are suggesting the DB setup process enable uffd for all users.
> Correct?

Yes. In addition of the hugetlbfs setup, various apps requires to also
increase fs.inotify.max_user_watches or file-max and other tweaks,
this would be one of those tweaks.

> This may be too simple, and I don't really like group access, but how about
> just defining a uffd group?  If you are in the group you can make uffd
> system calls.

Everything is possible, I'm just afraid it gets too complex.

So you suggest to echo a gid into the file?
