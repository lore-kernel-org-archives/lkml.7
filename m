Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6251C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FE720675
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Boh3XzRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfDVV3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:29:30 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45784 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfDVV33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:29:29 -0400
Received: by mail-vk1-f194.google.com with SMTP id h127so2718189vkd.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6ZNX8PzZTc2KzrAqgh1Ng4laLRheQ1IuJOBZqlb3Bs=;
        b=Boh3XzRNxD117G85f/L05gtwAnDAfHoPs9C1FhzigFYfOnfP0eH2Ibrg1KsROyHkXG
         E5FokjelGfi7bsSOKsnu/qDQybbKcNTShOUMhOPHQUSZLq3sTgesj44PcT+sLLvcP0u1
         0zprQt1JN4vP4+kxx0XnT7UE+8fflPPsY81LEbfMtNSQFyD/dmCc6KkcEq7RHfflccuJ
         k7oxWsl6T6plZHXzE7oObRUH+TJBP6n7E8Xh9mkAtD3F0D5QHEPkcEPDVzor0meP454r
         ivW5OATTTiYvx8CEC+AWPGD54CmOlxJRr3T9iS5AqO1cuZY4F8dg8Bfqa3XGFY4IJ/lb
         1TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6ZNX8PzZTc2KzrAqgh1Ng4laLRheQ1IuJOBZqlb3Bs=;
        b=cc2Ie+jt11c6CIRyc5/4AzQF0wy1xyd06ORqjPOtbT/xP+bsgKkl8Ci4O7XcDHH8po
         SpUUUGydlMRX0bYbp/SIBFaHaBFHmWFVDIaWV2DxAIMGuo/SbrNgUaD5ynJoGJBBXtUO
         bALNXZZHFBZQ2L0VF/E4PSH0XArDVMYKSeC13XYcM4HIKcCA0d2AnaUU68wz2qgsSQM1
         ZH6+NA+cSn6mngrZLXQbdTd0hOcEiPvM7s0zem4sDRyKLs6VB0/nHecsYPqzdLO1wDSc
         xOubgbnVeh9DMJ8D+unxG08Cv0NfTNJWYo7Fxqt41ZVrgtyHeK6Fp75xswazbutJNfiq
         Wx6Q==
X-Gm-Message-State: APjAAAWwajJ+4nzKdJ/3j+MYmL//4I8hUQ46eOaACQbcN3DQW083eUBE
        le7Gc7W7jL9287T1OMUdMe20oZeiXI3zqQyGjooExw==
X-Google-Smtp-Source: APXvYqyayLq7fveYwsVJYv2RL6WtmqgCh4VRowXNECgcbX8d5XclmkCqh6hazJDdUL3SB6G8DBLVF2TroVADzI3hjsU=
X-Received: by 2002:a1f:a0d2:: with SMTP id j201mr11280429vke.37.1555968568316;
 Mon, 22 Apr 2019 14:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
In-Reply-To: <20190416134522.17540-1-ldufour@linux.ibm.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Mon, 22 Apr 2019 14:29:16 -0700
Message-ID: <CANN689F1h9XoHPzr_FQY2WfN5bb2TTd6M3HLqoJ-DQuHkNbA7g@mail.gmail.com>
Subject: Re: [PATCH v12 00/31] Speculative page faults
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, dave@stgolabs.net,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        mpe@ellerman.id.au, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, haren@linux.vnet.ibm.com,
        Nick Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thanks a lot for copying me on this patchset. It took me a few days to
go through it - I had not been following the previous iterations of
this series so I had to catch up. I will be sending comments for
individual commits, but before tat I would like to discuss the series
as a whole.

I think these changes are a big step in the right direction. My main
reservation about them is that they are additive - adding some complexity
for speculative page faults - and I wonder if it'd be possible, over the
long term, to replace the existing complexity we have in mmap_sem retry
mechanisms instead of adding to it. This is not something that should
block your progress, but I think it would be good, as we introduce spf,
to evaluate whether we could eventually get all the way to removing the
mmap_sem retry mechanism, or if we will actually have to keep both.


The proposed spf mechanism only handles anon vmas. Is there a
fundamental reason why it couldn't handle mapped files too ?
My understanding is that the mechanism of verifying the vma after
taking back the ptl at the end of the fault would work there too ?
The file has to stay referenced during the fault, but holding the vma's
refcount could be made to cover that ? the vm_file refcount would have
to be released in __free_vma() instead of remove_vma; I'm not quite sure
if that has more implications than I realize ?

The proposed spf mechanism only works at the pte level after the page
tables have already been created. The non-spf page fault path takes the
mm->page_table_lock to protect against concurrent page table allocation
by multiple page faults; I think unmapping/freeing page tables could
be done under mm->page_table_lock too so that spf could implement
allocating new page tables by verifying the vma after taking the
mm->page_table_lock ?

The proposed spf mechanism depends on ARCH_HAS_PTE_SPECIAL.
I am not sure what is the issue there - is this due to the vma->vm_start
and vma->vm_pgoff reads in *__vm_normal_page() ?


My last potential concern is about performance. The numbers you have
look great, but I worry about potential regressions in PF performance
for threaded processes that don't currently encounter contention
(i.e. there may be just one thread actually doing all the work while
the others are blocked). I think one good proxy for measuring that
would be to measure a single threaded workload - kernbench would be
fine - without the special-case optimization in patch 22 where
handle_speculative_fault() immediately aborts in the single-threaded case.

Reviewed-by: Michel Lespinasse <walken@google.com>
This is for the series as a whole; I expect to do another review pass on
individual commits in the series when we have agreement on the toplevel
stuff (I noticed a few things like out-of-date commit messages but that's
really minor stuff).


I want to add a note about mmap_sem. In the past there has been
discussions about replacing it with an interval lock, but these never
went anywhere because, mostly, of the fact that such mechanisms were
too expensive to use in the page fault path. I think adding the spf
mechanism would invite us to revisit this issue - interval locks may
be a great way to avoid blocking between unrelated mmap_sem writers
(for example, do not delay stack creation for new threads while a
large mmap or munmap may be going on), and probably also to handle
mmap_sem readers that can't easily use the spf mechanism (for example,
gup callers which make use of the returned vmas). But again that is a
separate topic to explore which doesn't have to get resolved before
spf goes in.
