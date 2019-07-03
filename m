Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676C0C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA0720645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mlmuaMzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfGCW53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:57:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46625 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfGCW53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:57:29 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so8738289iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uJUFOB1+pEjI3tqctrrTDNSdgarQtW2/vrE2Xz2pZ+I=;
        b=mlmuaMzWXwGNHTh1m9kPgfFo2Tw4pDtMkFdH4Q8+iwU6WOvBBv+g+2gbbLw3KWFaqb
         7FLAJSeHJgfzvHDK607Tlpd1IPoKX4mLRsWOcFka5tUNQoVMczZpTuh4/w9bFwzUXmPy
         UuCtSXoCq+HxS1tFFUH0y6rS8oD7aTWevTQPPr6ajTGvc9FGNDQrr3XF7LflhJeAMWGe
         SAmyBrF5/20cB6m7c25cdcrCzB28DIl9S1l7bCcUpCLgUd8bNVkX+R1x2h/BvXuYjhMZ
         YAUMvPh7JwSlOBjQVaVRhrOUuJHYb9xQ1QCSO3s9QqsWqosKNro4zaqPQrztFo4bJFQk
         bflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uJUFOB1+pEjI3tqctrrTDNSdgarQtW2/vrE2Xz2pZ+I=;
        b=LtORqu33j5hyr5Csbqw/B98DiIWJOfmBvvohKfhuwv9+Z+dfSEOH69t5YZCUR7dH01
         e1F/Y3CqHx8ajVbjbPE6AeVGhRk1R/ZYDlyOrpOolFVlgQuhZoKK7L/eDg7fRhV50N8I
         +XFMj4tQIlp3CwnEeWFSoZ0H23UZBgt0TGe7ZxheiKb8jiItosS0NWwtY5JfzcStdDG/
         7SEToUhxoocQboc+YXSTZGrJEJ2XvdRqGyhLR/KSjotQABJzl1KbFN40+CEXb+TEYUQN
         F9HlomOB8FgAyZasEent1Fekzk6+9K5Zr61dkEH1kHHbGfQnHVD8yKA4RpSGA4I/xyEV
         Lljg==
X-Gm-Message-State: APjAAAUs/sirBEfHFj/Yif8l1OH6sSzGtGkXs+obW4FIO9nFHY2vj/Xx
        BSH2fZi+ImStiUjiY9eMEvWHHg==
X-Google-Smtp-Source: APXvYqyCZRuDgBNhLr4vL06qazVYpkUtLUhcx0drufzzinnuyuFvTR6JEyWtD29EbtSghjg4j3uMvQ==
X-Received: by 2002:a5e:9747:: with SMTP id h7mr1968603ioq.299.1562194647999;
        Wed, 03 Jul 2019 15:57:27 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id a7sm3741904iok.19.2019.07.03.15.57.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 15:57:27 -0700 (PDT)
Date:   Wed, 3 Jul 2019 15:57:26 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alexandre Ghiti <alex@ghiti.fr>
cc:     Hanjun Guo <guohanjun@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/2] Hugetlbfs support for riscv
In-Reply-To: <20190701175900.4034-1-alex@ghiti.fr>
Message-ID: <alpine.DEB.2.21.9999.1907031344330.10620@viisi.sifive.com>
References: <20190701175900.4034-1-alex@ghiti.fr>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks for writing and testing these patches, and thanks for your patience 
waiting for reviews and testing.

On Mon, 1 Jul 2019, Alexandre Ghiti wrote:

> This series introduces hugetlbfs support for both riscv 32/64. Riscv32           
> is architecturally limited to huge pages of size 4MB whereas riscv64 has         
> 2MB/1G huge pages support. Transparent huge page support is not                  
> implemented here, I will submit another series later.                            
>                                                                                  

[ ... ]

> This series was validated using libhugetlbfs testsuite ported to riscv64         
> without linker script support.                                                   
> (https://github.com/AlexGhiti/libhugetlbfs.git, branch dev/alex/riscv).          
>                                                                                  
> - libhugetlbfs testsuite on riscv64/2M:                                          
>   - brk_near_huge triggers an assert in malloc.c, does not on x86.               

I was able to reproduce the 2MB megapages test results on rv64 QEMU.  On a 
HiFive Unleashed, though, a few more tests fail:

- icache_hygiene fails ("icache unclean")

  # LD_LIBRARY_PATH=obj64 ./tests/obj64/icache-hygiene
  Starting testcase "./tests/obj64/icache-hygiene", pid 732
  SIGILL at 0x15559fff80 (sig_expected=0x15559fff80)
  SIGILL at 0x1555dfff80 (sig_expected=0x1555dfff80)
  SIGILL at 0x15561fff80 (sig_expected=0x15561fff80)
  SIGILL at 0x15565fff80 (sig_expected=0x15565fff80)
  SIGILL at 0x15569fff80 (sig_expected=0x15569fff80)
  SIGILL at 0x1556dfff80 (sig_expected=(nil))
  FAIL   SIGILL somewhere unexpected
  #

- One of the heapshrink tests fails ("Heap did not shrink")

  # LD_PRELOAD="obj64/libhugetlbfs_privutils.so obj64/libhugetlbfs.so tests/obj64/libheapshrink.so" HUGETLB_MORECORE_SHRINK=yes HUGETLB_MORECORE=yes tests/obj64/heapshrink
  Starting testcase "tests/obj64/heapshrink", pid 753
  FAIL    Heap did not shrink
  #

Some of these may be related to the top-down mmap work, but there might be 
more work to do on actual hardware.

> - libhugetlbfs testsuite on riscv64/1G:                                          
>   - brk_near_huge triggers an assert in malloc.c, does not on x86.               
>   - mmap-gettest, mmap-cow: testsuite passes the number of default free          
>     pages as parameters and then fails for 1G which is not the default.          
>     Otherwise succeeds when given the right number of pages.                     
>   - map_high_truncate_2 fails on x86 too: 0x60000000 is not 1G aligned           
>     and fails at line 694 of fs/hugetlbfs/inode.c.                               
>   - heapshrink on 1G fails on x86 too, not investigated.                         
>   - counters.sh on 1G fails on x86 too: alloc_surplus_huge_page returns          
>     NULL in case of gigantic pages.                                              
>   - icache-hygiene succeeds after patch #3 of this series which lowers           
>     the base address of mmap.                                                    
>   - fallocate_stress.sh on 1G never ends, on x86 too, not investigated.          

I can reproduce some of these here on QEMU.  But for reasons that are 
unclear to me, 1G gigapages aren't working on the HiFive Unleashed here.

In any case, these patches are clearly a good start, so I've queued 
them for v5.3.


- Paul
