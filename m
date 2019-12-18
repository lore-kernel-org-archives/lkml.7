Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F78AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB4A206D3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TkBgMn6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLRBDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:03:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfLRBDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:03:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI0sKHu195418;
        Wed, 18 Dec 2019 01:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=VzNr3mtovpYgknCrTIqWhDMYUWOCljTypRXPcwhoaQA=;
 b=TkBgMn6Bpl7VIJ3ExLN1BVn/rRVHjwhCn3GgXft68V0UFkja8OiZcsDhL0lbdQU8Ctg9
 swuX+IuTd//saCps6jvFPcBG6i88SYbwJAMpNDLUCfooBEqfeyu8UhmMhVSI9w4GbrJ4
 NJNwDgChhKea/MJUyjd/5Kmv/Z3D3W5BeLPa9dMGh6le8ChtSUBsOrOnu1cYbdpCVwmW
 Pb4gDmM9RrlKgsejEGLCtl7MZcvdq6wX43NCJK28k4CCWYJ+xPQ6ukUUPBLMtjdT9lzr
 uSf4gl/46eieaKCFWQtG31/HjCkrxNfhc8x6Wg3+ggSzkUAUlkBH6K5izMaapijaysNe UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wvqpqaa24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 01:02:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI0wvuw167129;
        Wed, 18 Dec 2019 01:02:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wxm5kx7n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 01:02:02 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBI11xjJ007072;
        Wed, 18 Dec 2019 01:01:59 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 17:01:59 -0800
Subject: Re: [PATCH v3] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
References: <20191217170331.30893-1-longman@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8e4b9a22-a0ca-1659-9f5b-6e1acff5a57b@oracle.com>
Date:   Tue, 17 Dec 2019 17:01:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217170331.30893-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 9:03 AM, Waiman Long wrote:
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
> 
> Both the hugetbl_lock and the subpool lock can be acquired in
> free_huge_page(). One way to solve the problem is to make both locks
> irq-safe. However, Mike Kravetz had learned that the hugetlb_lock is
> held for a linear scan of ALL hugetlb pages during a cgroup reparentling
> operation. So it is just too long to have irq disabled unless we can
> break hugetbl_lock down into finer-grained locks with shorter lock
> hold times.
> 
> Another alternative is to defer the freeing to a workqueue job.  This
> patch implements the deferred freeing by adding a free_hpage_workfn()
> work function to do the actual freeing. The free_huge_page() call in
> a non-task context saves the page to be freed in the hpage_freelist
> linked list in a lockless manner using the llist APIs.
> 
> The generic workqueue is used to process the work, but a dedicated
> workqueue can be used instead if it is desirable to have the huge page
> freed ASAP.
> 
---->
> Thanks to Kirill Tkhai <ktkhai@virtuozzo.com> for suggesting the use
> of llist APIs which simplfy the code.
> 
>  [v2: Add more comment & remove unneeded racing check]
>  [v3: Update commit log, remove pr_debug & use llist APIs]
<----

IMO, Those lines should not be in the commit message.

> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

I would just drop this 'Reported-by: Aneesh ...'.  Yes, Aneesh did report
a problem that was triggered by the same underlying issue.  But the splat
he reported was very different.

> Signed-off-by: Waiman Long <longman@redhat.com>

Thanks for doing this,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
