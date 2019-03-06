Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144A6C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A0220840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfCFNHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:07:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726429AbfCFNHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:07:08 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EAEBA2FA65824E1C345B;
        Wed,  6 Mar 2019 21:07:05 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Mar 2019
 21:07:02 +0800
Message-ID: <5C7FC5F4.40903@huawei.com>
Date:   Wed, 6 Mar 2019 21:07:00 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Peter Xu <peterx@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
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
References: <CACT4Y+Z+CH0UTdSz-w_woMPrBwg-GuobV1Su4qd9ReffTkyfVg@mail.gmail.com> <5C7D2F82.40907@huawei.com> <CACT4Y+agwaszODNGJHCqn4fSk4Le9exn3Cau0nornJ0RaTpDJw@mail.gmail.com> <5C7D4500.3070607@huawei.com> <CACT4Y+b6y_3gTpR8LvNREHOV0TP7jB=Zp1L03dzpaz_SaeESng@mail.gmail.com> <5C7E1A38.2060906@huawei.com> <20190306020540.GA23850@redhat.com> <5C7F6048.2050802@huawei.com> <20190306062625.GA3549@rapoport-lnx> <5C7F7992.7050806@huawei.com> <20190306081201.GC11093@xz-x1>
In-Reply-To: <20190306081201.GC11093@xz-x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/6 16:12, Peter Xu wrote:
> On Wed, Mar 06, 2019 at 03:41:06PM +0800, zhong jiang wrote:
>> On 2019/3/6 14:26, Mike Rapoport wrote:
>>> Hi,
>>>
>>> On Wed, Mar 06, 2019 at 01:53:12PM +0800, zhong jiang wrote:
>>>> On 2019/3/6 10:05, Andrea Arcangeli wrote:
>>>>> Hello everyone,
>>>>>
>>>>> [ CC'ed Mike and Peter ]
>>>>>
>>>>> On Tue, Mar 05, 2019 at 02:42:00PM +0800, zhong jiang wrote:
>>>>>> On 2019/3/5 14:26, Dmitry Vyukov wrote:
>>>>>>> On Mon, Mar 4, 2019 at 4:32 PM zhong jiang <zhongjiang@huawei.com> wrote:
>>>>>>>> On 2019/3/4 22:11, Dmitry Vyukov wrote:
>>>>>>>>> On Mon, Mar 4, 2019 at 3:00 PM zhong jiang <zhongjiang@huawei.com> wrote:
>>>>>>>>>> On 2019/3/4 15:40, Dmitry Vyukov wrote:
>>>>>>>>>>> On Sun, Mar 3, 2019 at 5:19 PM zhong jiang <zhongjiang@huawei.com> wrote:
>>>>>>>>>>>> Hi, guys
>>>>>>>>>>>>
>>>>>>>>>>>> I also hit the following issue. but it fails to reproduce the issue by the log.
>>>>>>>>>>>>
>>>>>>>>>>>> it seems to the case that we access the mm->owner and deference it will result in the UAF.
>>>>>>>>>>>> But it should not be possible that we specify the incomplete process to be the mm->owner.
>>>>>>>>>>>>
>>>>>>>>>>>> Any thoughts?
>>>>>>>>>>> FWIW syzbot was able to reproduce this with this reproducer.
>>>>>>>>>>> This looks like a very subtle race (threaded reproducer that runs
>>>>>>>>>>> repeatedly in multiple processes), so most likely we are looking for
>>>>>>>>>>> something like few instructions inconsistency window.
>>>>>>>>>>>
>>>>>>>>>> I has a little doubtful about the instrustions inconsistency window.
>>>>>>>>>>
>>>>>>>>>> I guess that you mean some smb barriers should be taken into account.:-)
>>>>>>>>>>
>>>>>>>>>> Because IMO, It should not be the lock case to result in the issue.
>>>>>>>>> Since the crash was triggered on x86 _most likley_ this is not a
>>>>>>>>> missed barrier. What I meant is that one thread needs to executed some
>>>>>>>>> code, while another thread is stopped within few instructions.
>>>>>>>>>
>>>>>>>>>
>>>>>>>> It is weird and I can not find any relationship you had said with the issue.:-(
>>>>>>>>
>>>>>>>> Because It is the cause that mm->owner has been freed, whereas we still deference it.
>>>>>>>>
>>>>>>>> From the lastest freed task call trace, It fails to create process.
>>>>>>>>
>>>>>>>> Am I miss something or I misunderstand your meaning. Please correct me.
>>>>>>> Your analysis looks correct. I am just saying that the root cause of
>>>>>>> this use-after-free seems to be a race condition.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>> Yep, Indeed,  I can not figure out how the race works. I will dig up further.
>>>>> Yes it's a race condition.
>>>>>
>>>>> We were aware about the non-cooperative fork userfaultfd feature
>>>>> creating userfaultfd file descriptor that gets reported to the parent
>>>>> uffd, despite they belong to mm created by failed forks.
>>>>>
>>>>> https://www.spinics.net/lists/linux-mm/msg136357.html
>>>>>
>>>> Hi, Andrea
>>>>
>>>> I still not clear why uffd ioctl can use the incomplete process as the mm->owner.
>>>> and how to produce the race.
>>> There is a C reproducer in  the syzcaller report:
>>>
>>> https://syzkaller.appspot.com/x/repro.c?x=172fa5a3400000
>>>  
>>>> From your above explainations,   My underdtanding is that the process handling do_exexve
>>>> will have a temporary mm,  which will be used by the UUFD ioctl.
>>> The race is between userfaultfd operation and fork() failure:
>>>
>>> forking thread                  | userfaultfd monitor thread
>>> --------------------------------+-------------------------------
>>> fork()                          |
>>>   dup_mmap()                    |
>>>     dup_userfaultfd()           |
>>>     dup_userfaultfd_complete()  |
>>>                                 |  read(UFFD_EVENT_FORK)
>>>                                 |  uffdio_copy()
>>>                                 |    mmget_not_zero()
>>>     goto bad_fork_something     |
>>>     ...                         |
>>> bad_fork_free:                  |
>>>       free_task()               |
>>>                                 |  mem_cgroup_from_task()
>>>                                 |       /* access stale mm->owner */
>>>  
>> Hi, Mike
> Hi, Zhong,
>
>> forking thread fails to create the process ,and then free the allocated task struct.
>> Other userfaultfd monitor thread should not access the stale mm->owner.
>>
>> The parent process and child process do not share the mm struct.  Userfaultfd monitor thread's
>> mm->owner should not point to the freed child task_struct.
> IIUC the problem is that above mm (of the mm->owner) is the child
> process's mm rather than the uffd monitor's.  When
> dup_userfaultfd_complete() is called there will be a new userfaultfd
> context sent to the uffd monitor thread which linked to the chlid
> process's mm, and if the monitor thread do UFFDIO_COPY upon the newly
> received userfaultfd it'll operate on that new mm too.
Thank Mike and Peter for further explanation. I get it.

Yes, The race indeed will result in the issue.

but as for the patch Andrea has posted. I still has a little worry.

The patch use call_rcu to delay free the task_struct, but It is possible to free the task_struct
ahead of get_mem_cgroup_from_mm. is it right?

Thanks,
zhong jiang
>> and due to the existence of tasklist_lock,  we can not specify the mm->owner to freed task_struct.
>>
>> I miss something,=-O
>>
>> Thanks,
>> zhong jiang
>>>> Thanks,
>>>> zhong jiang
>>
> Regards,
>


