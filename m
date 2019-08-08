Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51057C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F55E218B6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbfHHPN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:13:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbfHHPN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:13:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 606B93066FA7;
        Thu,  8 Aug 2019 15:13:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86F145D9E1;
        Thu,  8 Aug 2019 15:13:51 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x78FDo4j019011;
        Thu, 8 Aug 2019 11:13:50 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x78FDoGF019007;
        Thu, 8 Aug 2019 11:13:50 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 8 Aug 2019 11:13:50 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Mike Snitzer <msnitzer@redhat.com>, junxiao.bi@oracle.com,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        honglei.wang@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] direct-io: use GFP_NOIO to avoid deadlock
In-Reply-To: <20190808135329.GG5482@bombadil.infradead.org>
Message-ID: <alpine.LRH.2.02.1908081112580.18950@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1908080540240.15519@file01.intranet.prod.int.rdu2.redhat.com> <20190808135329.GG5482@bombadil.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 08 Aug 2019 15:13:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Aug 2019, Matthew Wilcox wrote:

> On Thu, Aug 08, 2019 at 05:50:10AM -0400, Mikulas Patocka wrote:
> > A deadlock with this stacktrace was observed.
> > 
> > The obvious problem here is that in the call chain 
> > xfs_vm_direct_IO->__blockdev_direct_IO->do_blockdev_direct_IO->kmem_cache_alloc 
> > we do a GFP_KERNEL allocation while we are in a filesystem driver and in a 
> > block device driver.
> 
> But that's not the problem.  The problem is the loop driver calls into the
> filesystem without calling memalloc_noio_save() / memalloc_noio_restore().
> There are dozens of places in XFS which use GFP_KERNEL allocations and
> all can trigger this same problem if called from the loop driver.

OK. I'll send a new patch that sets PF_MEMALLOC_NOIO in the loop driver.

Mikulas
