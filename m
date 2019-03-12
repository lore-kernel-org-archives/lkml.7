Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF01C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF317214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCLMnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:43:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfCLMnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:43:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78BAF30842CD;
        Tue, 12 Mar 2019 12:43:16 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45797648C2;
        Tue, 12 Mar 2019 12:43:05 +0000 (UTC)
Date:   Tue, 12 Mar 2019 20:43:02 +0800
From:   Peter Xu <peterx@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Mel Gorman <mgorman@suse.de>, linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 0/3] userfaultfd: allow to forbid unprivileged users
Message-ID: <20190312124302.GA2433@xz-x1>
References: <20190311093701.15734-1-peterx@redhat.com>
 <20190312074951.i2md3npcjcceywqj@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190312074951.i2md3npcjcceywqj@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 12 Mar 2019 12:43:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kirill,

On Tue, Mar 12, 2019 at 10:49:51AM +0300, Kirill A. Shutemov wrote:
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
> 
> CC linux-api@
> 
> This is unusual way to return current value for sysctl. Does it work fine
> with sysctl tool?

It can work, though it displays the same as "cat":

$ sysctl vm.unprivileged_userfaultfd
vm.unprivileged_userfaultfd = disabled enabled [kvm] 

> 
> Have you considered to place the switch into /sys/kernel/mm instead?
> I doubt it's the last tunable for userfaultfd. Maybe we should have an
> directory for it under /sys/kernel/mm?

I haven't thought about sysfs, if that's preferred I can consider to
switch to that.  And yes I think creating a directory should be a good
idea.

Thanks,

-- 
Peter Xu
