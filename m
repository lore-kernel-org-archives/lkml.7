Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D45AC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D6820652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbfCFG0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:26:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbfCFG0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:26:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x266Ob4N140616
        for <linux-kernel@vger.kernel.org>; Wed, 6 Mar 2019 01:26:38 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r27e7by4e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 01:26:38 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 6 Mar 2019 06:26:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Mar 2019 06:26:29 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x266QSxR44171442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Mar 2019 06:26:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B016AA4064;
        Wed,  6 Mar 2019 06:26:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A2C9A405F;
        Wed,  6 Mar 2019 06:26:27 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Mar 2019 06:26:27 +0000 (GMT)
Date:   Wed, 6 Mar 2019 08:26:25 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+cbb52e396df3e565ab02@syzkaller.appspotmail.com>,
        Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: KASAN: use-after-free Read in get_mem_cgroup_from_mm
References: <00000000000006457e057c341ff8@google.com>
 <5C7BFE94.6070500@huawei.com>
 <CACT4Y+Z+CH0UTdSz-w_woMPrBwg-GuobV1Su4qd9ReffTkyfVg@mail.gmail.com>
 <5C7D2F82.40907@huawei.com>
 <CACT4Y+agwaszODNGJHCqn4fSk4Le9exn3Cau0nornJ0RaTpDJw@mail.gmail.com>
 <5C7D4500.3070607@huawei.com>
 <CACT4Y+b6y_3gTpR8LvNREHOV0TP7jB=Zp1L03dzpaz_SaeESng@mail.gmail.com>
 <5C7E1A38.2060906@huawei.com>
 <20190306020540.GA23850@redhat.com>
 <5C7F6048.2050802@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C7F6048.2050802@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19030606-0016-0000-0000-0000025E5E5B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030606-0017-0000-0000-000032B8E47D
Message-Id: <20190306062625.GA3549@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903060044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 06, 2019 at 01:53:12PM +0800, zhong jiang wrote:
> On 2019/3/6 10:05, Andrea Arcangeli wrote:
> > Hello everyone,
> >
> > [ CC'ed Mike and Peter ]
> >
> > On Tue, Mar 05, 2019 at 02:42:00PM +0800, zhong jiang wrote:
> >> On 2019/3/5 14:26, Dmitry Vyukov wrote:
> >>> On Mon, Mar 4, 2019 at 4:32 PM zhong jiang <zhongjiang@huawei.com> wrote:
> >>>> On 2019/3/4 22:11, Dmitry Vyukov wrote:
> >>>>> On Mon, Mar 4, 2019 at 3:00 PM zhong jiang <zhongjiang@huawei.com> wrote:
> >>>>>> On 2019/3/4 15:40, Dmitry Vyukov wrote:
> >>>>>>> On Sun, Mar 3, 2019 at 5:19 PM zhong jiang <zhongjiang@huawei.com> wrote:
> >>>>>>>> Hi, guys
> >>>>>>>>
> >>>>>>>> I also hit the following issue. but it fails to reproduce the issue by the log.
> >>>>>>>>
> >>>>>>>> it seems to the case that we access the mm->owner and deference it will result in the UAF.
> >>>>>>>> But it should not be possible that we specify the incomplete process to be the mm->owner.
> >>>>>>>>
> >>>>>>>> Any thoughts?
> >>>>>>> FWIW syzbot was able to reproduce this with this reproducer.
> >>>>>>> This looks like a very subtle race (threaded reproducer that runs
> >>>>>>> repeatedly in multiple processes), so most likely we are looking for
> >>>>>>> something like few instructions inconsistency window.
> >>>>>>>
> >>>>>> I has a little doubtful about the instrustions inconsistency window.
> >>>>>>
> >>>>>> I guess that you mean some smb barriers should be taken into account.:-)
> >>>>>>
> >>>>>> Because IMO, It should not be the lock case to result in the issue.
> >>>>> Since the crash was triggered on x86 _most likley_ this is not a
> >>>>> missed barrier. What I meant is that one thread needs to executed some
> >>>>> code, while another thread is stopped within few instructions.
> >>>>>
> >>>>>
> >>>> It is weird and I can not find any relationship you had said with the issue.:-(
> >>>>
> >>>> Because It is the cause that mm->owner has been freed, whereas we still deference it.
> >>>>
> >>>> From the lastest freed task call trace, It fails to create process.
> >>>>
> >>>> Am I miss something or I misunderstand your meaning. Please correct me.
> >>> Your analysis looks correct. I am just saying that the root cause of
> >>> this use-after-free seems to be a race condition.
> >>>
> >>>
> >>>
> >> Yep, Indeed,  I can not figure out how the race works. I will dig up further.
> > Yes it's a race condition.
> >
> > We were aware about the non-cooperative fork userfaultfd feature
> > creating userfaultfd file descriptor that gets reported to the parent
> > uffd, despite they belong to mm created by failed forks.
> >
> > https://www.spinics.net/lists/linux-mm/msg136357.html
> >
> 
> Hi, Andrea
> 
> I still not clear why uffd ioctl can use the incomplete process as the mm->owner.
> and how to produce the race.

There is a C reproducer in  the syzcaller report:

https://syzkaller.appspot.com/x/repro.c?x=172fa5a3400000
 
> From your above explainations,   My underdtanding is that the process handling do_exexve
> will have a temporary mm,  which will be used by the UUFD ioctl.

The race is between userfaultfd operation and fork() failure:

forking thread                  | userfaultfd monitor thread
--------------------------------+-------------------------------
fork()                          |
  dup_mmap()                    |
    dup_userfaultfd()           |
    dup_userfaultfd_complete()  |
                                |  read(UFFD_EVENT_FORK)
                                |  uffdio_copy()
                                |    mmget_not_zero()
    goto bad_fork_something     |
    ...                         |
bad_fork_free:                  |
      free_task()               |
                                |  mem_cgroup_from_task()
                                |       /* access stale mm->owner */
 
> Thanks,
> zhong jiang

-- 
Sincerely yours,
Mike.

