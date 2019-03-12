Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198E6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F942147A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfCLM3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:29:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfCLM3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:29:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C073307CDEA;
        Tue, 12 Mar 2019 12:29:39 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 230E01001E6A;
        Tue, 12 Mar 2019 12:29:29 +0000 (UTC)
Date:   Tue, 12 Mar 2019 20:29:27 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] userfaultfd: allow to forbid unprivileged users
Message-ID: <20190312122927.GF14108@xz-x1>
References: <20190311093701.15734-1-peterx@redhat.com>
 <20190312070147.GC9497@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190312070147.GC9497@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 12 Mar 2019 12:29:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 09:01:47AM +0200, Mike Rapoport wrote:
> Hi Peter,
> 
> On Mon, Mar 11, 2019 at 05:36:58PM +0800, Peter Xu wrote:
> > Hi,
> > 
> > (The idea comes from Andrea, and following discussions with Mike and
> >  other people)
> > 
> > This patchset introduces a new sysctl flag to allow the admin to
> > forbid users from using userfaultfd:
> > 
> >   $ cat /proc/sys/vm/unprivileged_userfaultfd
> >   [disabled] enabled kvm
> > 
> >   - When set to "disabled", all unprivileged users are forbidden to
> >     use userfaultfd syscalls.
> > 
> >   - When set to "enabled", all users are allowed to use userfaultfd
> >     syscalls.
> > 
> >   - When set to "kvm", all unprivileged users are forbidden to use the
> >     userfaultfd syscalls, except the user who has permission to open
> >     /dev/kvm.
> > 
> > This new flag can add one more layer of security to reduce the attack
> > surface of the kernel by abusing userfaultfd.  Here we grant the
> > thread userfaultfd permission by checking against CAP_SYS_PTRACE
> > capability.  By default, the value is "disabled" which is the most
> > strict policy.  Distributions can have their own perferred value.
> > 
> > The "kvm" entry is a bit special here only to make sure that existing
> > users like QEMU/KVM won't break by this newly introduced flag.  What
> > we need to do is simply set the "unprivileged_userfaultfd" flag to
> > "kvm" here to automatically grant userfaultfd permission for processes
> > like QEMU/KVM without extra code to tweak these flags in the admin
> > code.
> > 
> > Patch 1:  The interface patch to introduce the flag
> > 
> > Patch 2:  The KVM related changes to detect opening of /dev/kvm
> > 
> > Patch 3:  Apply the flag to userfaultfd syscalls
>  
> I'd appreciate to see "Patch 4: documentation update" ;-)
> It'd be also great to update the man pages after this is merged.

Oops, sorry!  I should have remembered that.

> 
> Except for the comment to patch 1, feel free to add
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks Mike!  I'll take it for 2/3 until I got confirmation from you
on patch 1.

Regards,

-- 
Peter Xu
