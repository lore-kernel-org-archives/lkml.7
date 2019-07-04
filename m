Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEAFC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D884D218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LtQddHxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfGDLfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 07:35:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38092 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfGDLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:35:25 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so12209307ioa.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 04:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3Jp4ssk/tg2iD8nW0ro2U7UKtJbPzstlWX8tfroZV5Q=;
        b=LtQddHxOwEM7iJpSljY6j4pPGJF2FOg4bbny538Cm89igIF6rP1CaCJh0lw9pagf4z
         r9PhETn5XbnST8Pd2jVKIJN++Q7a0Ioqbp0zLw/2RUXVMw2NWZxsVTt5LuQ9QjGiM8te
         Hci78N0siChPeIwHb2rGX7jWup+bvLk5qhM7TBcLViacr4HP+Qi6jNc97GHTfq+qDyuB
         xQBg5K1UOk9L0N9SnpUm0nEo2KBOiDqO8Cr7TBx3TiKpCWV6BeYD2D85rfFtMvHuvtNZ
         db2nO8Oc/CaDMG9I06sfJHT2fAaYlITMARosY1goa4ozJAG2/sizqb/XVAW9mOlxNui2
         POQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3Jp4ssk/tg2iD8nW0ro2U7UKtJbPzstlWX8tfroZV5Q=;
        b=FZZNkfTGxMsK6/2FVAwPj4utkDge84o3xaIcG8P8gCqId3hOMiYkDjB9d87hcdgS6x
         ywgYb9pU91ykYIKjKsJ3c8goIUMUj7414KsoxzbgrEeYxy8V8wwlb44un5GymomHo/Kt
         5nuE2Gn6IIpTdVXbCnumED/nZ588c9h0YecEm0B9zyAmsH37riMp5qZZNtorp8q//A2m
         13zSfCtKRrEdM3M4as/2IDU78PEdKUfdBx4oC5MhiM+lZr+zrSkDofVIZzdB+3+82YNz
         oFcHdtsm2TyiLADOUjXX7sciWyavITqxbNkx0Wlad/SrZODcqMr76bsiMw8VTfq4nYuc
         d6ew==
X-Gm-Message-State: APjAAAWEAPkZegffGK6snui7IXv4B897b1dO6IZvPnwhYYywat7VPxOQ
        z9wOxTlAvqeg4uygoPJ7Y5IpIw==
X-Google-Smtp-Source: APXvYqynvovPh8WYFyY8sEb0/88FT+bBN0Il6kgEz6q0BL4v6jisjzQGkuUtgxSYQzDmiQeF+0rmbg==
X-Received: by 2002:a6b:dd17:: with SMTP id f23mr4103381ioc.213.1562240124009;
        Thu, 04 Jul 2019 04:35:24 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id i3sm3931703ion.9.2019.07.04.04.35.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 04:35:23 -0700 (PDT)
Date:   Thu, 4 Jul 2019 04:35:23 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alexandre Ghiti <alex@ghiti.fr>
cc:     Albert Ou <aou@eecs.berkeley.edu>,
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
Subject: Re: [PATCH v3 0/2] Hugetlbfs support for riscv
In-Reply-To: <c06441fd-0022-8fb9-36b0-2f5d956c3ed5@ghiti.fr>
Message-ID: <alpine.DEB.2.21.9999.1907040429170.24872@viisi.sifive.com>
References: <20190701175900.4034-1-alex@ghiti.fr> <alpine.DEB.2.21.9999.1907031344330.10620@viisi.sifive.com> <c06441fd-0022-8fb9-36b0-2f5d956c3ed5@ghiti.fr>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019, Alexandre Ghiti wrote:

> On 7/4/19 12:57 AM, Paul Walmsley wrote:
> > On Mon, 1 Jul 2019, Alexandre Ghiti wrote:
> > 
> > > - libhugetlbfs testsuite on riscv64/2M:
> > >    - brk_near_huge triggers an assert in malloc.c, does not on x86.
> > I was able to reproduce the 2MB megapages test results on rv64 QEMU.  On a
> > HiFive Unleashed, though, a few more tests fail:

[ ... ]

> > - One of the heapshrink tests fails ("Heap did not shrink")
> > 
> >    # LD_PRELOAD="obj64/libhugetlbfs_privutils.so obj64/libhugetlbfs.so
> > tests/obj64/libheapshrink.so" HUGETLB_MORECORE_SHRINK=yes
> > HUGETLB_MORECORE=yes tests/obj64/heapshrink
> >    Starting testcase "tests/obj64/heapshrink", pid 753
> >    FAIL    Heap did not shrink
> >    #
> > 
> > Some of these may be related to the top-down mmap work, but there might be
> > more work to do on actual hardware.
> 
> 
> I don't think this is related to top-down mmap layout, this test only 
> mmaps a huge page. It might be interesting to see more verbose messages 
> adding HUGETLB_VERBOSE=99 when launching the test.

Here is the HUGETLB_VERBOSE=99 output from the above heapshrink test on an 
FU540:

libhugetlbfs [(none):86]: INFO: Found pagesize 2048 kB
libhugetlbfs [(none):86]: INFO: Parsed kernel version: [5] . [2] . [0]  [pre-release: 6]
libhugetlbfs [(none):86]: INFO: Feature private_reservations is present in this kernel
libhugetlbfs [(none):86]: INFO: Feature noreserve_safe is present in this kernel
libhugetlbfs [(none):86]: INFO: Feature map_hugetlb is present in this kernel
libhugetlbfs [(none):86]: INFO: Kernel has MAP_PRIVATE reservations.  Disabling heap prefaulting.
libhugetlbfs [(none):86]: INFO: Kernel supports MAP_HUGETLB
libhugetlbfs [(none):86]: INFO: HUGETLB_SHARE=0, sharing disabled
libhugetlbfs [(none):86]: INFO: HUGETLB_NO_RESERVE=no, reservations enabled
libhugetlbfs [(none):86]: INFO: No segments were appropriate for remapping
libhugetlbfs [(none):86]: INFO: setup_morecore(): heapaddr = 0x2aaac00000
libhugetlbfs [(none):86]: INFO: hugetlbfs_morecore(1052672) = ...
libhugetlbfs [(none):86]: INFO: heapbase = 0x2aaac00000, heaptop = 0x2aaac00000, mapsize = 0, delta=1052672
libhugetlbfs [(none):86]: INFO: Attempting to map 2097152 bytes
libhugetlbfs [(none):86]: INFO: ... = 0x2aaac00000
libhugetlbfs [(none):86]: INFO: hugetlbfs_morecore(0) = ...
libhugetlbfs [(none):86]: INFO: heapbase = 0x2aaac00000, heaptop = 0x2aaad01000, mapsize = 200000, delta=-1044480
libhugetlbfs [(none):86]: INFO: ... = 0x2aaad01000
Starting testcase "tests/obj64/heapshrink", pid 86
libhugetlbfs [(none):86]: INFO: hugetlbfs_morecore(33558528) = ...
libhugetlbfs [(none):86]: INFO: heapbase = 0x2aaac00000, heaptop = 0x2aaad01000, mapsize = 200000, delta=32514048
libhugetlbfs [(none):86]: INFO: Attempting to map 33554432 bytes
libhugetlbfs [(none):86]: INFO: ... = 0x2aaad01000
FAIL    Heap did not shrink


This is with this hugepage configuration:

# /usr/local/bin/hugeadm --pool-list
      Size  Minimum  Current  Maximum  Default
   2097152       64       64       64        *
#


- Paul
