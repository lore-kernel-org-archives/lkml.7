Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC16C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB14620693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfCMTMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfCMTMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:12:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A331F3006030;
        Wed, 13 Mar 2019 19:12:29 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 694536591E;
        Wed, 13 Mar 2019 19:12:29 +0000 (UTC)
Received: from zmail18.collab.prod.int.phx2.redhat.com (zmail18.collab.prod.int.phx2.redhat.com [10.5.83.21])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 09413181A136;
        Wed, 13 Mar 2019 19:12:29 +0000 (UTC)
Date:   Wed, 13 Mar 2019 15:12:28 -0400 (EDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
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
Message-ID: <1934896481.7779933.1552504348591.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190313185230.GH25147@redhat.com>
References: <20190311093701.15734-1-peterx@redhat.com> <58e63635-fc1b-cb53-a4d1-237e6b8b7236@oracle.com> <20190313060023.GD2433@xz-x1> <3714d120-64e3-702e-6eef-4ef253bdb66d@redhat.com> <20190313185230.GH25147@redhat.com>
Subject: Re: [PATCH 0/3] userfaultfd: allow to forbid unprivileged users
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [93.56.166.5, 10.4.196.11, 10.5.101.130, 10.4.195.27]
Thread-Topic: userfaultfd: allow to forbid unprivileged users
Thread-Index: 6Xwu07wo6ALzDU1D4rR00nCA3NmgqQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 13 Mar 2019 19:12:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Mar 13, 2019 at 09:22:31AM +0100, Paolo Bonzini wrote:
> Unless somebody suggests a consistent way to make hugetlbfs "just
> work" (like we could achieve clean with CRIU and KVM), I think Oracle
> will need a one liner change in the Oracle setup to echo into that
> file in addition of running the hugetlbfs mount.

Hi Andrea, can you explain more in detail the risks of enabling
userfaultfd for unprivileged users?

Paolo

> Note that DPDK host bridge process will also need a one liner change
> to do a dummy open/close of /dev/kvm to unblock the syscall.
> 
> Thanks,
> Andrea
> 
