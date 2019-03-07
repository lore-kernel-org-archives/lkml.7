Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13050C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC96A20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfCGH6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:58:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57534 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbfCGH6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:58:21 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ECEA3652F26AB03354C5;
        Thu,  7 Mar 2019 15:58:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Mar 2019
 15:58:16 +0800
Message-ID: <5C80CF16.70109@huawei.com>
Date:   Thu, 7 Mar 2019 15:58:14 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Andrea Arcangeli <aarcange@redhat.com>
CC:     Peter Xu <peterx@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        syzbot <syzbot+cbb52e396df3e565ab02@syzkaller.appspotmail.com>,
        Michal Hocko <mhocko@kernel.org>, <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: KASAN: use-after-free Read in get_mem_cgroup_from_mm
References: <CACT4Y+agwaszODNGJHCqn4fSk4Le9exn3Cau0nornJ0RaTpDJw@mail.gmail.com> <5C7D4500.3070607@huawei.com> <CACT4Y+b6y_3gTpR8LvNREHOV0TP7jB=Zp1L03dzpaz_SaeESng@mail.gmail.com> <5C7E1A38.2060906@huawei.com> <20190306020540.GA23850@redhat.com> <5C7F6048.2050802@huawei.com> <20190306062625.GA3549@rapoport-lnx> <5C7F7992.7050806@huawei.com> <20190306081201.GC11093@xz-x1> <5C7FC5F4.40903@huawei.com> <20190306182944.GE23850@redhat.com>
In-Reply-To: <20190306182944.GE23850@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/7 2:29, Andrea Arcangeli wrote:
> Hello Zhong,
>
> On Wed, Mar 06, 2019 at 09:07:00PM +0800, zhong jiang wrote:
>> The patch use call_rcu to delay free the task_struct, but It is possible to free the task_struct
>> ahead of get_mem_cgroup_from_mm. is it right?
> Yes it is possible to free before get_mem_cgroup_from_mm, but if it's
> freed before get_mem_cgroup_from_mm rcu_read_lock,
> rcu_dereference(mm->owner) will return NULL in such case and there
> will be no problem.
Yes
> The simple fix also clears the mm->owner of the failed-fork-mm before
> doing the call_rcu. The call_rcu delays the freeing after no other CPU
> runs in between rcu_read_lock/unlock anymore. That guarantees that
> those critical section will see mm->owner == NULL if the freeing of
> the task strut already happened.
We has set the mm->owner to NULL when child process fails to fork ahead of freeing
the task struct.

Have those critical section  chance to see the mm->owner, which is not NULL.

I has tested the patch.  Not Oops and panic appear  so far.

Thanks,
zhong jiang
> The solution Mike suggested for this and that we were wondering as
> ideal in the past for the signal issue too, is to move the uffd
> delivery at a point where fork is guaranteed to succeed. We should
> probably try that too to see how it looks like and if it can be done
> in a not intrusive way, but the simple fix that uses RCU should work
> too.
>
> Rolling back in case of errors inside fork itself isn't easily doable:
> the moment we push the uffd ctx to the other side of the uffd pipe
> there's no coming back as that information can reach the userland of
> the uffd monitor/reader thread immediately after. The rolling back is
> really the other thread failing at mmget_not_zero eventually. It's the
> userland that has to rollback in such case when it gets a -ESRCH
> retval.
>
> Note that this fork feature is only ever needed in the non-cooperative
> case, these things never need to happen when userfaultfd is used by an
> app (or a lib) that is aware that it is using userfaultfd.
>
> Thanks,
> Andrea
>
> .
>


