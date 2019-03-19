Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A544C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646A92082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfCSS2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfCSS2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:28:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11AFA81F31;
        Tue, 19 Mar 2019 18:28:43 +0000 (UTC)
Received: from work-vm (ovpn-117-168.ams2.redhat.com [10.36.117.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1867F611CD;
        Tue, 19 Mar 2019 18:28:25 +0000 (UTC)
Date:   Tue, 19 Mar 2019 18:28:23 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd/sysctl: add
 vm.unprivileged_userfaultfd
Message-ID: <20190319182822.GK2727@work-vm>
References: <20190319030722.12441-1-peterx@redhat.com>
 <20190319030722.12441-2-peterx@redhat.com>
 <20190319110236.b6169d6b469a587a852c7e09@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319110236.b6169d6b469a587a852c7e09@linux-foundation.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Mar 2019 18:28:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@linux-foundation.org) wrote:
> On Tue, 19 Mar 2019 11:07:22 +0800 Peter Xu <peterx@redhat.com> wrote:
> 
> > Add a global sysctl knob "vm.unprivileged_userfaultfd" to control
> > whether userfaultfd is allowed by unprivileged users.  When this is
> > set to zero, only privileged users (root user, or users with the
> > CAP_SYS_PTRACE capability) will be able to use the userfaultfd
> > syscalls.
> 
> Please send along a full description of why you believe Linux needs
> this feature, for me to add to the changelog.  What is the benefit to
> our users?  How will it be used?
> 
> etcetera.  As it was presented I'm seeing no justification for adding
> the patch!

How about:

---
Userfaultfd can be misued to make it easier to exploit existing use-after-free
(and similar) bugs that might otherwise only make a short window
or race condition available.  By using userfaultfd to stall a kernel
thread, a malicious program can keep some state, that it wrote, stable
for an extended period, which it can then access using an existing
exploit.   While it doesn't cause the exploit itself, and while it's not
the only thing that can stall a kernel thread when accessing a memory location,
it's one of the few that never needs priviledge.

Add a flag, allowing userfaultfd to be restricted, so that in general 
it won't be useable by arbitrary user programs, but in environments that
require userfaultfd it can be turned back on.

---

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
