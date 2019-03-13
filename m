Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899FCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E9C2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCMGAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:00:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfCMGAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 02:00:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA00688E52;
        Wed, 13 Mar 2019 06:00:40 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB48B27CD9;
        Wed, 13 Mar 2019 06:00:26 +0000 (UTC)
Date:   Wed, 13 Mar 2019 14:00:23 +0800
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
Message-ID: <20190313060023.GD2433@xz-x1>
References: <20190311093701.15734-1-peterx@redhat.com>
 <58e63635-fc1b-cb53-a4d1-237e6b8b7236@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58e63635-fc1b-cb53-a4d1-237e6b8b7236@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 13 Mar 2019 06:00:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:59:34PM -0700, Mike Kravetz wrote:
> On 3/11/19 2:36 AM, Peter Xu wrote:
> > 
> > The "kvm" entry is a bit special here only to make sure that existing
> > users like QEMU/KVM won't break by this newly introduced flag.  What
> > we need to do is simply set the "unprivileged_userfaultfd" flag to
> > "kvm" here to automatically grant userfaultfd permission for processes
> > like QEMU/KVM without extra code to tweak these flags in the admin
> > code.
> 
> Another user is Oracle DB, specifically with hugetlbfs.  For them, we would
> like to add a special case like kvm described above.  The admin controls
> who can have access to hugetlbfs, so I think adding code to the open
> routine as in patch 2 of this series would seem to work.

Yes I think if there's an explicit and safe place we can hook for
hugetlbfs then we can do the similar trick as KVM case.  Though I
noticed that we can not only create hugetlbfs files under the
mountpoint (which the admin can control), but also using some other
ways.  The question (of me... sorry if it's a silly one!) is whether
all other ways to use hugetlbfs is still under control of the admin.
One I know of is memfd_create() which seems to be doable even as
unprivileged users.  If so, should we only limit the uffd privilege to
those hugetlbfs users who use the mountpoint directly?

Another question is about fork() of privileged processes - for KVM we
only grant privilege for the exact process that opened the /dev/kvm
node, and the privilege will be lost for any forked childrens.  Is
that the same thing for OracleDB/Hugetlbfs?

> 
> However, I can imagine more special cases being added for other users.  And,
> once you have more than one special case then you may want to combine them.
> For example, kvm and hugetlbfs together.

It looks fine to me if we're using MMF_USERFAULTFD_ALLOW flag upon
mm_struct, since that seems to be a very general flag that can be used
by anything we want to grant privilege for, not only KVM?

Thanks,

-- 
Peter Xu
