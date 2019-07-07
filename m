Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CCAC48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 16:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3FD2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 16:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfGGQss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 12:48:48 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:47548 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfGGQss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 12:48:48 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A6C1B3AACD8
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2019 15:14:39 +0000 (UTC)
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.12] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E391BC0002;
        Sun,  7 Jul 2019 15:14:22 +0000 (UTC)
Subject: Re: [PATCH v3 0/2] Hugetlbfs support for riscv
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hanjun Guo <guohanjun@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20190701175900.4034-1-alex@ghiti.fr>
 <alpine.DEB.2.21.9999.1907031344330.10620@viisi.sifive.com>
 <c06441fd-0022-8fb9-36b0-2f5d956c3ed5@ghiti.fr>
 <alpine.DEB.2.21.9999.1907040429170.24872@viisi.sifive.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <040f378d-e483-fa3a-28f4-fdb1bb62591d@ghiti.fr>
Date:   Sun, 7 Jul 2019 11:14:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1907040429170.24872@viisi.sifive.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: sv-FI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/4/19 7:35 AM, Paul Walmsley wrote:
> On Thu, 4 Jul 2019, Alexandre Ghiti wrote:
>
>> On 7/4/19 12:57 AM, Paul Walmsley wrote:
>>> On Mon, 1 Jul 2019, Alexandre Ghiti wrote:
>>>
>>>> - libhugetlbfs testsuite on riscv64/2M:
>>>>     - brk_near_huge triggers an assert in malloc.c, does not on x86.
>>> I was able to reproduce the 2MB megapages test results on rv64 QEMU.  On a
>>> HiFive Unleashed, though, a few more tests fail:
> [ ... ]
>
>>> - One of the heapshrink tests fails ("Heap did not shrink")
>>>
>>>     # LD_PRELOAD="obj64/libhugetlbfs_privutils.so obj64/libhugetlbfs.so
>>> tests/obj64/libheapshrink.so" HUGETLB_MORECORE_SHRINK=yes
>>> HUGETLB_MORECORE=yes tests/obj64/heapshrink
>>>     Starting testcase "tests/obj64/heapshrink", pid 753
>>>     FAIL    Heap did not shrink
>>>     #
>>>
>>> Some of these may be related to the top-down mmap work, but there might be
>>> more work to do on actual hardware.
>>
>> I don't think this is related to top-down mmap layout, this test only
>> mmaps a huge page. It might be interesting to see more verbose messages
>> adding HUGETLB_VERBOSE=99 when launching the test.
> Here is the HUGETLB_VERBOSE=99 output from the above heapshrink test on an
> FU540:
>
> libhugetlbfs [(none):86]: INFO: Found pagesize 2048 kB
> libhugetlbfs [(none):86]: INFO: Parsed kernel version: [5] . [2] . [0]  [pre-release: 6]
> libhugetlbfs [(none):86]: INFO: Feature private_reservations is present in this kernel
> libhugetlbfs [(none):86]: INFO: Feature noreserve_safe is present in this kernel
> libhugetlbfs [(none):86]: INFO: Feature map_hugetlb is present in this kernel
> libhugetlbfs [(none):86]: INFO: Kernel has MAP_PRIVATE reservations.  Disabling heap prefaulting.
> libhugetlbfs [(none):86]: INFO: Kernel supports MAP_HUGETLB
> libhugetlbfs [(none):86]: INFO: HUGETLB_SHARE=0, sharing disabled
> libhugetlbfs [(none):86]: INFO: HUGETLB_NO_RESERVE=no, reservations enabled
> libhugetlbfs [(none):86]: INFO: No segments were appropriate for remapping
> libhugetlbfs [(none):86]: INFO: setup_morecore(): heapaddr = 0x2aaac00000
> libhugetlbfs [(none):86]: INFO: hugetlbfs_morecore(1052672) = ...
> libhugetlbfs [(none):86]: INFO: heapbase = 0x2aaac00000, heaptop = 0x2aaac00000, mapsize = 0, delta=1052672
> libhugetlbfs [(none):86]: INFO: Attempting to map 2097152 bytes
> libhugetlbfs [(none):86]: INFO: ... = 0x2aaac00000
> libhugetlbfs [(none):86]: INFO: hugetlbfs_morecore(0) = ...
> libhugetlbfs [(none):86]: INFO: heapbase = 0x2aaac00000, heaptop = 0x2aaad01000, mapsize = 200000, delta=-1044480
> libhugetlbfs [(none):86]: INFO: ... = 0x2aaad01000
> Starting testcase "tests/obj64/heapshrink", pid 86
> libhugetlbfs [(none):86]: INFO: hugetlbfs_morecore(33558528) = ...
> libhugetlbfs [(none):86]: INFO: heapbase = 0x2aaac00000, heaptop = 0x2aaad01000, mapsize = 200000, delta=32514048
> libhugetlbfs [(none):86]: INFO: Attempting to map 33554432 bytes
> libhugetlbfs [(none):86]: INFO: ... = 0x2aaad01000
> FAIL    Heap did not shrink
>
>
> This is with this hugepage configuration:
>
> # /usr/local/bin/hugeadm --pool-list
>        Size  Minimum  Current  Maximum  Default
>     2097152       64       64       64        *
> #
>

Ok thanks for that, but it does not say much :)

While trying to understand why it may fail on HW, I actually failed to 
reproduce the results on qemu (I did not
check the results for v3 and I recently switched from yocto to buildroot 
so I lost my configuration...).

What configuration do you use to reproduce the results on qemu ?

FYI, while playing around, I noticed that with qemu v4.0.0, 
icache_hygiene stalls whereas with
v3.1.0, it does not but I did not investigate though.

Thanks,

Alex


> - Paul
