Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF4F21917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfCUVGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:06:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfCUVGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:06:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B46F33092654;
        Thu, 21 Mar 2019 21:06:22 +0000 (UTC)
Received: from sky.random (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 041685D6B3;
        Thu, 21 Mar 2019 21:06:18 +0000 (UTC)
Date:   Thu, 21 Mar 2019 17:06:17 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd/sysctl: add
 vm.unprivileged_userfaultfd
Message-ID: <20190321210617.GB22094@redhat.com>
References: <20190319030722.12441-1-peterx@redhat.com>
 <20190319030722.12441-2-peterx@redhat.com>
 <20190319110236.b6169d6b469a587a852c7e09@linux-foundation.org>
 <20190319182822.GK2727@work-vm>
 <20190320190112.GD23793@redhat.com>
 <20190321134335.GB1146@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321134335.GB1146@42.do-not-panic.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 21 Mar 2019 21:06:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Mar 21, 2019 at 01:43:35PM +0000, Luis Chamberlain wrote:
> On Wed, Mar 20, 2019 at 03:01:12PM -0400, Andrea Arcangeli wrote:
> > but
> > that would be better be achieved through SECCOMP and not globally.'.
> 
> That begs the question why not use seccomp for this? What if everyone
> decided to add a knob for all syscalls to do the same? For the commit
> log, why is it OK then to justify a knob for this syscall?

That's a good point and it's obviously more secure because you can
block a lot more than just bpf and userfaultfd: however not all
syscalls have CONFIG_USERFAULTFD=n or CONFIG_BPF_SYSCALL=n that you
can set to =n at build time, then they'll return -ENOSYS (implemented
as sys_ni_syscall in the =n case).

The point of the bpf (already included upstream) and userfaultfd
(proposed) sysctl is to avoid users having to rebuild the kernel if
they want to harden their setup without being forced to run all
containers under seccomp, just like they could by setting those two
config options "=n" at build time.

So you can see it like allowing a runtime selection of
CONFIG_USERFAULTFD and CONFIG_BPF_SYSCALL without the kernel build
time config forcing the decision on behalf of the end user.

Thanks,
Andrea
