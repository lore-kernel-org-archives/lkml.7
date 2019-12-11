Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ADDC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDE72073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WWAQ9j0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLKWFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:05:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38476 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLKWFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:05:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBM4Kp5075000;
        Wed, 11 Dec 2019 22:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=S3/2cBQC/3H5HMlJ2A++KZb9hX+olhUCPRwQJZDDG9U=;
 b=WWAQ9j0AOPxeRtiBKMoEf4pyTGFX73lY/rhBwiVS6H4GYr/WCm/Bz0B3TtM9dpSkTUfT
 qDiAi/lDiZrj66Km+ufseknNUfmS7feiIlpgV+3mqhbYc8vifdIZISH4PGxLoBK/ZOBG
 Xba50frE30lBct5Rwx9yRbn+XCIuLGmkFqm0TXoej8k00qE4W2w0fiks6WOHPKlQwrx6
 o0TbGNmgsRsuhckQuxpsy5mQ3BxLgnoHnz8uurs0bZiPHl06zjkcCEQ10AJA/ECwa1gS
 B7UTv10EnsB24S2PK6n1fB+70D24pxrIVnrfWoPMiE7KtOYM7+p5mWtdfEkwFexKQCjq qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wr4qrqdeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 22:04:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBM4K1C033997;
        Wed, 11 Dec 2019 22:04:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wtqgdj28k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 22:04:40 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBBM4ck3004625;
        Wed, 11 Dec 2019 22:04:38 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Dec 2019 14:04:38 -0800
Subject: Re: [PATCH v2] hugetlbfs: Disable softIRQ when taking hugetlb_lock
To:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>
References: <20191211194615.18502-1-longman@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
Date:   Wed, 11 Dec 2019 14:04:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211194615.18502-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Michal

Sorry for the late reply on this effort.

On 12/11/19 11:46 AM, Waiman Long wrote:
> The following lockdep splat was observed when a certain hugetlbfs test
> was run:
> 
> [  612.388273] ================================
> [  612.411273] WARNING: inconsistent lock state
> [  612.432273] 4.18.0-159.el8.x86_64+debug #1 Tainted: G        W --------- -  -
> [  612.469273] --------------------------------
> [  612.489273] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [  612.517273] swapper/30/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
> [  612.541273] ffffffff9acdc038 (hugetlb_lock){+.?.}, at: free_huge_page+0x36f/0xaa0
> [  612.576273] {SOFTIRQ-ON-W} state was registered at:
> [  612.598273]   lock_acquire+0x14f/0x3b0
> [  612.616273]   _raw_spin_lock+0x30/0x70
> [  612.634273]   __nr_hugepages_store_common+0x11b/0xb30
> [  612.657273]   hugetlb_sysctl_handler_common+0x209/0x2d0
> [  612.681273]   proc_sys_call_handler+0x37f/0x450
> [  612.703273]   vfs_write+0x157/0x460
> [  612.719273]   ksys_write+0xb8/0x170
> [  612.736273]   do_syscall_64+0xa5/0x4d0
> [  612.753273]   entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> [  612.777273] irq event stamp: 691296
> [  612.794273] hardirqs last  enabled at (691296): [<ffffffff99bb034b>] _raw_spin_unlock_irqrestore+0x4b/0x60
> [  612.839273] hardirqs last disabled at (691295): [<ffffffff99bb0ad2>] _raw_spin_lock_irqsave+0x22/0x81
> [  612.882273] softirqs last  enabled at (691284): [<ffffffff97ff0c63>] irq_enter+0xc3/0xe0
> [  612.922273] softirqs last disabled at (691285): [<ffffffff97ff0ebe>] irq_exit+0x23e/0x2b0
> [  612.962273]
> [  612.962273] other info that might help us debug this:
> [  612.993273]  Possible unsafe locking scenario:
> [  612.993273]
> [  613.020273]        CPU0
> [  613.031273]        ----
> [  613.042273]   lock(hugetlb_lock);
> [  613.057273]   <Interrupt>
> [  613.069273]     lock(hugetlb_lock);
> [  613.085273]
> [  613.085273]  *** DEADLOCK ***
>       :
> [  613.245273] Call Trace:
> [  613.256273]  <IRQ>
> [  613.265273]  dump_stack+0x9a/0xf0
> [  613.281273]  mark_lock+0xd0c/0x12f0
> [  613.297273]  ? print_shortest_lock_dependencies+0x80/0x80
> [  613.322273]  ? sched_clock_cpu+0x18/0x1e0
> [  613.341273]  __lock_acquire+0x146b/0x48c0
> [  613.360273]  ? trace_hardirqs_on+0x10/0x10
> [  613.379273]  ? trace_hardirqs_on_caller+0x27b/0x580
> [  613.401273]  lock_acquire+0x14f/0x3b0
> [  613.419273]  ? free_huge_page+0x36f/0xaa0
> [  613.440273]  _raw_spin_lock+0x30/0x70
> [  613.458273]  ? free_huge_page+0x36f/0xaa0
> [  613.477273]  free_huge_page+0x36f/0xaa0
> [  613.495273]  bio_check_pages_dirty+0x2fc/0x5c0
> [  613.516273]  clone_endio+0x17f/0x670 [dm_mod]
> [  613.536273]  ? disable_discard+0x90/0x90 [dm_mod]
> [  613.558273]  ? bio_endio+0x4ba/0x930
> [  613.575273]  ? blk_account_io_completion+0x400/0x530
> [  613.598273]  blk_update_request+0x276/0xe50
> [  613.617273]  scsi_end_request+0x7b/0x6a0
> [  613.636273]  ? lock_downgrade+0x6f0/0x6f0
> [  613.654273]  scsi_io_completion+0x1c6/0x1570
> [  613.674273]  ? sd_completed_bytes+0x3a0/0x3a0 [sd_mod]
> [  613.698273]  ? scsi_mq_requeue_cmd+0xc0/0xc0
> [  613.718273]  blk_done_softirq+0x22e/0x350
> [  613.737273]  ? blk_softirq_cpu_dead+0x230/0x230
> [  613.758273]  __do_softirq+0x23d/0xad8
> [  613.776273]  irq_exit+0x23e/0x2b0
> [  613.792273]  do_IRQ+0x11a/0x200
> [  613.806273]  common_interrupt+0xf/0xf
> [  613.823273]  </IRQ>

This is interesting.  I'm trying to wrap my head around how we ended up
with a BIO pointing to a hugetlbfs page.  My 'guess' is that user space
code passed an address to some system call or driver.  And, that system
call or driver set up the IO.  For the purpose of addressing this issue,
it does not matter.  I am just a little confused/curious.

> Since hugetlb_lock can be taken from both process and softIRQ contexts,
> we need to protect the lock from nested locking by disabling softIRQ
> using spin_lock_bh() before taking it.
> 
> Currently, only free_huge_page() is known to be called from softIRQ
> context.

We discussed this exact same issue more than a year ago.  See,
https://lkml.org/lkml/2018/9/5/398

At that time, the only 'known' caller of put_page for a hugetlbfs page from
softirq context was in powerpc specific code.  IIRC, Aneesh addressed the
issue last year by modifying the powerpc specific code.  The more general
issue in the hugetlbfs code was never addressed. :(

As part of the discussion in the previous e-mail thread, the issue of
whether we should address put_page for hugetlbfs pages for only softirq
or extend to hardirq context was discussed.  The conclusion (or at least
suggestion from Andrew and Michal) was that we should modify code to allow
for calls from hardirq context.  The reasoning IIRC, was that put_page of
other pages was allowed from hardirq context, so hugetlbfs pages should be
no different.

Matthew, do you think that reasoning from last year is still valid?  Should
we be targeting soft or hard irq calls?

One other thing.  free_huge_page may also take a subpool specific lock via
spin_lock().  See hugepage_subpool_put_pages.  This would also need to take
irq context into account.
-- 
Mike Kravetz
