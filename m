Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DEAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1229D20850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfCTTGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:06:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfCTTGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:06:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB61A3003BD6;
        Wed, 20 Mar 2019 19:06:36 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEDEF6012C;
        Wed, 20 Mar 2019 19:06:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x2KJ6UT5018077;
        Wed, 20 Mar 2019 15:06:30 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x2KJ6Tjd018073;
        Wed, 20 Mar 2019 15:06:29 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 20 Mar 2019 15:06:29 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Nikos Tsironis <ntsironis@arrikto.com>
cc:     snitzer@redhat.com, agk@redhat.com, dm-devel@redhat.com,
        paulmck@linux.ibm.com, hch@infradead.org, iliastsi@arrikto.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] dm snapshot: Improve performance using a more
 fine-grained locking scheme
In-Reply-To: <20190317122258.21760-1-ntsironis@arrikto.com>
Message-ID: <alpine.LRH.2.02.1903201506020.17844@file01.intranet.prod.int.rdu2.redhat.com>
References: <20190317122258.21760-1-ntsironis@arrikto.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 20 Mar 2019 19:06:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Acked-by: Mikulas Patocka <mpatocka@redhat.com>



On Sun, 17 Mar 2019, Nikos Tsironis wrote:

> dm-snapshot uses a single mutex to serialize every access to the
> snapshot state, including accesses to the exception hash tables. This
> mutex is a bottleneck preventing dm-snapshot to scale as the number of
> threads doing IO increases.
> 
> The major contention points are __origin_write()/snapshot_map() and
> pending_complete(), i.e., the submission and completion of pending
> exceptions.
> 
> This patchset substitutes the single mutex with:
> 
>   * A read-write semaphore, which protects the mostly read fields of the
>     snapshot structure.
> 
>   * Per-bucket bit spinlocks, that protect accesses to the exception
>     hash tables.
> 
> fio benchmarks using the null_blk device show significant performance
> improvements as the number of worker processes increases. Write latency
> is almost halved and write IOPS are nearly doubled.
> 
> The relevant patch provides detailed benchmark results.
> 
> A summary of the patchset follows:
> 
>   1. The first patch removes an unnecessary use of WRITE_ONCE() in
>      hlist_add_behind().
> 
>   2. The second patch adds two helper functions to linux/list_bl.h,
>      which is used to implement the per-bucket bit spinlocks in
>      dm-snapshot.
> 
>   3. The third patch removes the need to sleep holding the snapshot lock
>      in pending_complete(), thus allowing us to replace the mutex with
>      the per-bucket bit spinlocks.
> 
>   4. Patches 4, 5 and 6 change the locking scheme, as described
>      previously.
> 
> Changes in v3:
>   - Don't use WRITE_ONCE() in hlist_bl_add_behind(), as it's not needed.
>   - Fix hlist_add_behind() to also not use WRITE_ONCE().
>   - Use uintptr_t instead of unsigned long in hlist_bl_add_before().
> 
> v2: https://www.redhat.com/archives/dm-devel/2019-March/msg00007.html
> 
> Changes in v2:
>   - Split third patch of v1 into three patches: 3/5, 4/5, 5/5.
> 
> v1: https://www.redhat.com/archives/dm-devel/2018-December/msg00161.html
> 
> Nikos Tsironis (6):
>   list: Don't use WRITE_ONCE() in hlist_add_behind()
>   list_bl: Add hlist_bl_add_before/behind helpers
>   dm snapshot: Don't sleep holding the snapshot lock
>   dm snapshot: Replace mutex with rw semaphore
>   dm snapshot: Make exception tables scalable
>   dm snapshot: Use fine-grained locking scheme
> 
>  drivers/md/dm-exception-store.h |   3 +-
>  drivers/md/dm-snap.c            | 359 +++++++++++++++++++++++++++-------------
>  include/linux/list.h            |   2 +-
>  include/linux/list_bl.h         |  26 +++
>  4 files changed, 269 insertions(+), 121 deletions(-)
> 
> -- 
> 2.11.0
> 
