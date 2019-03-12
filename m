Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FFCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C59120883
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCLM0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:26:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfCLM0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:26:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6628759445;
        Tue, 12 Mar 2019 12:26:46 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10A3A6684E;
        Tue, 12 Mar 2019 12:26:35 +0000 (UTC)
Date:   Tue, 12 Mar 2019 20:26:33 +0800
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
Subject: Re: [PATCH 1/3] userfaultfd/sysctl: introduce
 unprivileged_userfaultfd
Message-ID: <20190312122633.GE14108@xz-x1>
References: <20190311093701.15734-1-peterx@redhat.com>
 <20190311093701.15734-2-peterx@redhat.com>
 <20190312065830.GB9497@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190312065830.GB9497@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 12 Mar 2019 12:26:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 08:58:30AM +0200, Mike Rapoport wrote:

[...]

> > +config USERFAULTFD_UNPRIVILEGED_DEFAULT
> > +        string "Default behavior for unprivileged userfault syscalls"
> > +        depends on USERFAULTFD
> > +        default "disabled"
> > +        help
> > +          Set this to "enabled" to allow userfaultfd syscalls from
> > +          unprivileged users.  Set this to "disabled" to forbid
> > +          userfaultfd syscalls from unprivileged users.  Set this to
> > +          "kvm" to forbid unpriviledged users but still allow users
> > +          who had enough permission to open /dev/kvm.
> 
> I'd phrase it a bit differently:
> 
> This option controls privilege level required to execute userfaultfd
                      ^
                      +---- add " the default"?

> system call.
> 
> Set this to "enabled" to allow userfaultfd system call from unprivileged
> users. 
> Set this to "disabled" to allow userfaultfd system call only for users who
> have ptrace capability.
> Set this to "kvm" to restrict userfaultfd system call usage to users with
                                                                      ^
                         add " who have ptrace capability, or" -------+

> permissions to open "/dev/kvm".

I think your version is better than mine, but I'd like to confirm
about above two extra changes before I squash them into the patch. :)

Thanks!

-- 
Peter Xu
