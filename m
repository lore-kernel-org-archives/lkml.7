Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9495CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CABD2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCTGJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:09:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31937 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbfCTGJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:09:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB45883F40;
        Wed, 20 Mar 2019 06:09:09 +0000 (UTC)
Received: from sky.random (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C5652E02F;
        Wed, 20 Mar 2019 06:09:03 +0000 (UTC)
Date:   Tue, 19 Mar 2019 14:07:29 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
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
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/1] userfaultfd/sysctl: add
 vm.unprivileged_userfaultfd
Message-ID: <20190319180729.GA27618@redhat.com>
References: <20190319030722.12441-1-peterx@redhat.com>
 <20190319030722.12441-2-peterx@redhat.com>
 <20190319071104.GA6392@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319071104.GA6392@rapoport-lnx>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 20 Mar 2019 06:09:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 19, 2019 at 09:11:04AM +0200, Mike Rapoport wrote:
> Hi Peter,
> 
> On Tue, Mar 19, 2019 at 11:07:22AM +0800, Peter Xu wrote:
> > Add a global sysctl knob "vm.unprivileged_userfaultfd" to control
> > whether userfaultfd is allowed by unprivileged users.  When this is
> > set to zero, only privileged users (root user, or users with the
> > CAP_SYS_PTRACE capability) will be able to use the userfaultfd
> > syscalls.
> > 
> > Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
> > Suggested-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> Just one minor note below

This looks fine with me too.

> > +	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
> > +		return -EPERM;

The only difference between the bpf sysctl and the userfaultfd sysctl
this way is that the bpf sysctl adds the CAP_SYS_ADMIN capability
requirement, while userfaultfd adds the CAP_SYS_PTRACE requirement,
because the userfaultfd monitor is more likely to need CAP_SYS_PTRACE
already if it's doing other kind of tracking on processes runtime, in
addition of userfaultfd. In other words both syscalls works only for
root, when the two sysctl are opt-in set to 1.

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
