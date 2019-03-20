Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFADAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D7520828
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCTAVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:21:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfCTAVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:21:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 337B8811A9;
        Wed, 20 Mar 2019 00:21:04 +0000 (UTC)
Received: from xz-x1 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 054F74D9E6;
        Wed, 20 Mar 2019 00:20:52 +0000 (UTC)
Date:   Wed, 20 Mar 2019 08:20:43 +0800
From:   Peter Xu <peterx@redhat.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <20190320002042.GA8956@xz-x1>
References: <20190319030722.12441-1-peterx@redhat.com>
 <20190319030722.12441-2-peterx@redhat.com>
 <20190319110236.b6169d6b469a587a852c7e09@linux-foundation.org>
 <20190319182822.GK2727@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190319182822.GK2727@work-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 20 Mar 2019 00:21:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 06:28:23PM +0000, Dr. David Alan Gilbert wrote:
> * Andrew Morton (akpm@linux-foundation.org) wrote:
> > On Tue, 19 Mar 2019 11:07:22 +0800 Peter Xu <peterx@redhat.com> wrote:
> > 
> > > Add a global sysctl knob "vm.unprivileged_userfaultfd" to control
> > > whether userfaultfd is allowed by unprivileged users.  When this is
> > > set to zero, only privileged users (root user, or users with the
> > > CAP_SYS_PTRACE capability) will be able to use the userfaultfd
> > > syscalls.
> > 
> > Please send along a full description of why you believe Linux needs
> > this feature, for me to add to the changelog.  What is the benefit to
> > our users?  How will it be used?
> > 
> > etcetera.  As it was presented I'm seeing no justification for adding
> > the patch!
> 
> How about:
> 
> ---
> Userfaultfd can be misued to make it easier to exploit existing use-after-free
> (and similar) bugs that might otherwise only make a short window
> or race condition available.  By using userfaultfd to stall a kernel
> thread, a malicious program can keep some state, that it wrote, stable
> for an extended period, which it can then access using an existing
> exploit.   While it doesn't cause the exploit itself, and while it's not
> the only thing that can stall a kernel thread when accessing a memory location,
> it's one of the few that never needs priviledge.
> 
> Add a flag, allowing userfaultfd to be restricted, so that in general 
> it won't be useable by arbitrary user programs, but in environments that
> require userfaultfd it can be turned back on.

Thanks for the quick write up, Dave!  I definitely should have some
justification in the cover letter and carry it until the last version.
Sorry to be unclear at the first glance.

-- 
Peter Xu
