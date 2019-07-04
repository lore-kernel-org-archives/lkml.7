Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67535C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3506F218BC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfGDGd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:33:59 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43227 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfGDGd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:33:59 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0B08460004;
        Thu,  4 Jul 2019 06:33:44 +0000 (UTC)
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
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <c06441fd-0022-8fb9-36b0-2f5d956c3ed5@ghiti.fr>
Date:   Thu, 4 Jul 2019 08:33:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1907031344330.10620@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/19 12:57 AM, Paul Walmsley wrote:
> Hi Alex,
>
> Thanks for writing and testing these patches, and thanks for your patience
> waiting for reviews and testing.


No problem :)


> On Mon, 1 Jul 2019, Alexandre Ghiti wrote:
>
>> This series introduces hugetlbfs support for both riscv 32/64. Riscv32
>> is architecturally limited to huge pages of size 4MB whereas riscv64 has
>> 2MB/1G huge pages support. Transparent huge page support is not
>> implemented here, I will submit another series later.
>>                                                                                   
> [ ... ]
>
>> This series was validated using libhugetlbfs testsuite ported to riscv64
>> without linker script support.
>> (https://github.com/AlexGhiti/libhugetlbfs.git, branch dev/alex/riscv).
>>                                                                                   
>> - libhugetlbfs testsuite on riscv64/2M:
>>    - brk_near_huge triggers an assert in malloc.c, does not on x86.
> I was able to reproduce the 2MB megapages test results on rv64 QEMU.  On a
> HiFive Unleashed, though, a few more tests fail:
>
> - icache_hygiene fails ("icache unclean")
>
>    # LD_LIBRARY_PATH=obj64 ./tests/obj64/icache-hygiene
>    Starting testcase "./tests/obj64/icache-hygiene", pid 732
>    SIGILL at 0x15559fff80 (sig_expected=0x15559fff80)
>    SIGILL at 0x1555dfff80 (sig_expected=0x1555dfff80)
>    SIGILL at 0x15561fff80 (sig_expected=0x15561fff80)
>    SIGILL at 0x15565fff80 (sig_expected=0x15565fff80)
>    SIGILL at 0x15569fff80 (sig_expected=0x15569fff80)
>    SIGILL at 0x1556dfff80 (sig_expected=(nil))
>    FAIL   SIGILL somewhere unexpected
>    #
>
> - One of the heapshrink tests fails ("Heap did not shrink")
>
>    # LD_PRELOAD="obj64/libhugetlbfs_privutils.so obj64/libhugetlbfs.so tests/obj64/libheapshrink.so" HUGETLB_MORECORE_SHRINK=yes HUGETLB_MORECORE=yes tests/obj64/heapshrink
>    Starting testcase "tests/obj64/heapshrink", pid 753
>    FAIL    Heap did not shrink
>    #
>
> Some of these may be related to the top-down mmap work, but there might be
> more work to do on actual hardware.


I don't think this is related to top-down mmap layout, this test only 
mmaps a huge page.
It might be interesting to see more verbose messages adding 
HUGETLB_VERBOSE=99
when launching the test.


>
>> - libhugetlbfs testsuite on riscv64/1G:
>>    - brk_near_huge triggers an assert in malloc.c, does not on x86.
>>    - mmap-gettest, mmap-cow: testsuite passes the number of default free
>>      pages as parameters and then fails for 1G which is not the default.
>>      Otherwise succeeds when given the right number of pages.
>>    - map_high_truncate_2 fails on x86 too: 0x60000000 is not 1G aligned
>>      and fails at line 694 of fs/hugetlbfs/inode.c.
>>    - heapshrink on 1G fails on x86 too, not investigated.
>>    - counters.sh on 1G fails on x86 too: alloc_surplus_huge_page returns
>>      NULL in case of gigantic pages.
>>    - icache-hygiene succeeds after patch #3 of this series which lowers
>>      the base address of mmap.
>>    - fallocate_stress.sh on 1G never ends, on x86 too, not investigated.
> I can reproduce some of these here on QEMU.  But for reasons that are
> unclear to me, 1G gigapages aren't working on the HiFive Unleashed here.
>
> In any case, these patches are clearly a good start, so I've queued
> them for v5.3.
>
>
> - Paul
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
