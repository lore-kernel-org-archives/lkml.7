Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F373C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABDA222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkvzyHM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLKWTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:19:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56670 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726411AbfLKWTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576102794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0l7zoV2+95h99CoTxTx4tu5LuU1gFk/R9T/E2GUkPc=;
        b=SkvzyHM0E4XOVHjMrT8+sPvrJjnpn1ozMkYUmjrxustc1Aab3PnknBp0z6v9xNUZVpybZg
        +KmDE2DPZ1Wm5C43QUYD5/ynuipVF66wrwm+3aUXwrsVK6+Om1taJ4ZFWFNdtvwnwy8sqw
        s/EtYfvixmISKNKysUB6sVvOadqec18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-QJdIcJX0PhK_UHbBgAAu5g-1; Wed, 11 Dec 2019 17:19:50 -0500
X-MC-Unique: QJdIcJX0PhK_UHbBgAAu5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8831F800D41;
        Wed, 11 Dec 2019 22:19:49 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E79B691A0;
        Wed, 11 Dec 2019 22:19:48 +0000 (UTC)
Subject: Re: [PATCH v2] hugetlbfs: Disable softIRQ when taking hugetlb_lock
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
Date:   Wed, 11 Dec 2019 17:19:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 5:04 PM, Mike Kravetz wrote:
> Cc: Michal
>
> Sorry for the late reply on this effort.
>
> On 12/11/19 11:46 AM, Waiman Long wrote:
>> The following lockdep splat was observed when a certain hugetlbfs test
>> was run:
>>
>> [  612.388273] ================================
>> [  612.411273] WARNING: inconsistent lock state
>> [  612.432273] 4.18.0-159.el8.x86_64+debug #1 Tainted: G        W --------- -  -
>> [  612.469273] --------------------------------
>> [  612.489273] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
>> [  612.517273] swapper/30/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
>> [  612.541273] ffffffff9acdc038 (hugetlb_lock){+.?.}, at: free_huge_page+0x36f/0xaa0
>> [  612.576273] {SOFTIRQ-ON-W} state was registered at:
>> [  612.598273]   lock_acquire+0x14f/0x3b0
>> [  612.616273]   _raw_spin_lock+0x30/0x70
>> [  612.634273]   __nr_hugepages_store_common+0x11b/0xb30
>> [  612.657273]   hugetlb_sysctl_handler_common+0x209/0x2d0
>> [  612.681273]   proc_sys_call_handler+0x37f/0x450
>> [  612.703273]   vfs_write+0x157/0x460
>> [  612.719273]   ksys_write+0xb8/0x170
>> [  612.736273]   do_syscall_64+0xa5/0x4d0
>> [  612.753273]   entry_SYSCALL_64_after_hwframe+0x6a/0xdf
>> [  612.777273] irq event stamp: 691296
>> [  612.794273] hardirqs last  enabled at (691296): [<ffffffff99bb034b>] _raw_spin_unlock_irqrestore+0x4b/0x60
>> [  612.839273] hardirqs last disabled at (691295): [<ffffffff99bb0ad2>] _raw_spin_lock_irqsave+0x22/0x81
>> [  612.882273] softirqs last  enabled at (691284): [<ffffffff97ff0c63>] irq_enter+0xc3/0xe0
>> [  612.922273] softirqs last disabled at (691285): [<ffffffff97ff0ebe>] irq_exit+0x23e/0x2b0
>> [  612.962273]
>> [  612.962273] other info that might help us debug this:
>> [  612.993273]  Possible unsafe locking scenario:
>> [  612.993273]
>> [  613.020273]        CPU0
>> [  613.031273]        ----
>> [  613.042273]   lock(hugetlb_lock);
>> [  613.057273]   <Interrupt>
>> [  613.069273]     lock(hugetlb_lock);
>> [  613.085273]
>> [  613.085273]  *** DEADLOCK ***
>>       :
>> [  613.245273] Call Trace:
>> [  613.256273]  <IRQ>
>> [  613.265273]  dump_stack+0x9a/0xf0
>> [  613.281273]  mark_lock+0xd0c/0x12f0
>> [  613.297273]  ? print_shortest_lock_dependencies+0x80/0x80
>> [  613.322273]  ? sched_clock_cpu+0x18/0x1e0
>> [  613.341273]  __lock_acquire+0x146b/0x48c0
>> [  613.360273]  ? trace_hardirqs_on+0x10/0x10
>> [  613.379273]  ? trace_hardirqs_on_caller+0x27b/0x580
>> [  613.401273]  lock_acquire+0x14f/0x3b0
>> [  613.419273]  ? free_huge_page+0x36f/0xaa0
>> [  613.440273]  _raw_spin_lock+0x30/0x70
>> [  613.458273]  ? free_huge_page+0x36f/0xaa0
>> [  613.477273]  free_huge_page+0x36f/0xaa0
>> [  613.495273]  bio_check_pages_dirty+0x2fc/0x5c0
>> [  613.516273]  clone_endio+0x17f/0x670 [dm_mod]
>> [  613.536273]  ? disable_discard+0x90/0x90 [dm_mod]
>> [  613.558273]  ? bio_endio+0x4ba/0x930
>> [  613.575273]  ? blk_account_io_completion+0x400/0x530
>> [  613.598273]  blk_update_request+0x276/0xe50
>> [  613.617273]  scsi_end_request+0x7b/0x6a0
>> [  613.636273]  ? lock_downgrade+0x6f0/0x6f0
>> [  613.654273]  scsi_io_completion+0x1c6/0x1570
>> [  613.674273]  ? sd_completed_bytes+0x3a0/0x3a0 [sd_mod]
>> [  613.698273]  ? scsi_mq_requeue_cmd+0xc0/0xc0
>> [  613.718273]  blk_done_softirq+0x22e/0x350
>> [  613.737273]  ? blk_softirq_cpu_dead+0x230/0x230
>> [  613.758273]  __do_softirq+0x23d/0xad8
>> [  613.776273]  irq_exit+0x23e/0x2b0
>> [  613.792273]  do_IRQ+0x11a/0x200
>> [  613.806273]  common_interrupt+0xf/0xf
>> [  613.823273]  </IRQ>
> This is interesting.  I'm trying to wrap my head around how we ended up
> with a BIO pointing to a hugetlbfs page.  My 'guess' is that user space
> code passed an address to some system call or driver.  And, that system
> call or driver set up the IO.  For the purpose of addressing this issue,
> it does not matter.  I am just a little confused/curious.
>
>> Since hugetlb_lock can be taken from both process and softIRQ contexts,
>> we need to protect the lock from nested locking by disabling softIRQ
>> using spin_lock_bh() before taking it.
>>
>> Currently, only free_huge_page() is known to be called from softIRQ
>> context.
> We discussed this exact same issue more than a year ago.  See,
> https://lkml.org/lkml/2018/9/5/398
>
> At that time, the only 'known' caller of put_page for a hugetlbfs page from
> softirq context was in powerpc specific code.  IIRC, Aneesh addressed the
> issue last year by modifying the powerpc specific code.  The more general
> issue in the hugetlbfs code was never addressed. :(
>
> As part of the discussion in the previous e-mail thread, the issue of
> whether we should address put_page for hugetlbfs pages for only softirq
> or extend to hardirq context was discussed.  The conclusion (or at least
> suggestion from Andrew and Michal) was that we should modify code to allow
> for calls from hardirq context.  The reasoning IIRC, was that put_page of
> other pages was allowed from hardirq context, so hugetlbfs pages should be
> no different.
>
> Matthew, do you think that reasoning from last year is still valid?  Should
> we be targeting soft or hard irq calls?
>
> One other thing.  free_huge_page may also take a subpool specific lock via
> spin_lock().  See hugepage_subpool_put_pages.  This would also need to take
> irq context into account.

Thanks for the background information.

We will need to use spin_lock_irq() or spin_lock_irqsave() for allowing
hardirq context calls like what is in the v1 patch. I will look further
into the subpool specific lock also.

Cheers,
Longman

