Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4872C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75AE208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X/wbCO64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfHOJcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:32:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55096 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:32:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so743965wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EexUI7pBO+y+x9iztzk6muOC5V/JyQ3M/ih3wi+9iUo=;
        b=X/wbCO64nDBxAR7srA/xsH1W7BhyQJ7EWOaub7eQ7JF70Y5IGtkMUVmZB4XNSbUBrb
         aPk+Cm1w8Ce2Yvf9liGUPvmWCwn7KuJN8r6BQQ67OpUhjBuqW8dAz/ekw9OttDvPpKxg
         qi3z5/Txu+/6Y1vnz+2B5PKDIOYepvv9RXXJZFMme9sEvQtS141a/2orR3GY2yu31ESs
         eh+Qc/KNlpGwsh7dir4e8cA57eODbD/4BVa/OXHdOdqf59sOtiXXUptDVEc7cscDndds
         FG0Zmd5kMUfwBVjwJEu2zgqDtKlf3YcWqmzcJlEeZ9ECfTKNa+MEhRL+UaT/slwvjBig
         CXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EexUI7pBO+y+x9iztzk6muOC5V/JyQ3M/ih3wi+9iUo=;
        b=YizC3ZTOHvtYjttRVvNsYy9FSGA9UgX05Uzk9B/lJh11TCYafnKCwqbkFvXo2tG7Hy
         IZOpYL/GRT3Yql3HXxbk60tnHqGj1FetWGQqzZzWweQo4+oFMz1bPD0Ds/P4Vny0n4yr
         sUbJjGJrwHsjmP5ZdM9LNG65vXk3EJk9jYHUWO8LYtoFFNYKnSDEjOcz9LNgI/jlzVS8
         TITa9V9RZAG+evS8c51SNXyqcadnElE1XXsMvn3+UyoMNtDVH9e33lRrko8LliCgsb3z
         GM3HERjTPLtSYEKR4ICSCXhE47xienkdpCsoPG9fFBT6intrJtQlJE7ytC713RpAfsiZ
         28fQ==
X-Gm-Message-State: APjAAAWqh9dN7hFIhGQ1oODOj1GU2nUtAwdF+OZiqSe0iUaRW5hUPYa1
        3A9J3IVLOdcUzfiQHellP0tOpBjv15e6sUoyEJ3gEw==
X-Google-Smtp-Source: APXvYqwaoEp4p8qd4nLLFuVvTor4VW6XOYc3SA4YE1R6968lwPSgPaOoqq3r/wfRSvZ0CVJY/uCdMd5pz4tVO05YGGM=
X-Received: by 2002:a1c:2dcf:: with SMTP id t198mr1707704wmt.147.1565861524605;
 Thu, 15 Aug 2019 02:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190109203911.7887-1-logang@deltatee.com> <20190109203911.7887-3-logang@deltatee.com>
 <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com>
 <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com> <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com>
 <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com> <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com>
 <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com> <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com>
 <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com> <CAEbi=3dC86dhGdwdarS_x+6-5=WPydUBKjo613qRZxKLDAqU_g@mail.gmail.com>
 <5506c875-9387-acc9-a7fe-5b7c10036c40@deltatee.com> <alpine.DEB.2.21.9999.1908130921170.30024@viisi.sifive.com>
 <e1f78a33-18bb-bd6e-eede-e5e86758a4d0@deltatee.com> <CAEbi=3f+JDywuHYspfYKuC8z2wm8inRenBz+3DYbKK3ixFjU_g@mail.gmail.com>
 <8b7b6285-dd85-5895-8653-be1f6f08cca8@deltatee.com>
In-Reply-To: <8b7b6285-dd85-5895-8653-be1f6f08cca8@deltatee.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Thu, 15 Aug 2019 17:31:52 +0800
Message-ID: <CAHCEeh+us9N5_AMAJp41Ob9R9PD=JfWLcUrU+gU54xf8NKddJw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Greentime Hu <green.hu@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

On Thu, Aug 15, 2019 at 6:21 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hey,
>
> On 2019-08-14 7:35 a.m., Greentime Hu wrote:
> > How about this fix? Not sure if it is good for everyone.
>
> I applied your fix to the patch and it seems ok. But it doesn't seem to
> work on a recent version of the kernel. Have you got it working on v5.3?
> It seems the following patch breaks things:
>
> 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
>
> I don't really have time right now to debug this any further.
>

I just tried v5.3-rc4 and it failed. I try to debug this case.
I found it failed might be because of an unmapped virtual address is used
in memblocks_present() -> memblock_alloc ().

In this commit 671f9a3e2e24 ("RISC-V: Setup initial page tables in two
stages"), it finishes all the VA/PA mapping after setup_vm_final() is
called.
So we have to call memblocks_present() and sparse_init() right after
setup_vm_final().

Here is my patch and I tested with memory-with-hole.
It can boot normally in Unleashed board after applying this patch.

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 27d1d847fb2d..35aacb0c93e5 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -138,8 +138,6 @@ void __init setup_bootmem(void)
                                  PFN_PHYS(end_pfn - start_pfn),
                                  &memblock.memory, 0);
        }
-       memblocks_present();
-       sparse_init();
 }

 unsigned long va_pa_offset;
@@ -452,6 +450,8 @@ static void __init setup_vm_final(void)
 void __init paging_init(void)
 {
        setup_vm_final();
+       memblocks_present();
+       sparse_init();
        setup_zero_page();
        zone_sizes_init();
 }

Test case:
memory@80000000 {
        device_type = "memory";
        reg = <0x0 0x80000000 0x0 0x80000000>;
};
memory@180000000 {
        device_type = "memory";
        reg = <0x1 0x80000000 0x0 0x40000000>;
};


# cat /proc/meminfo
MemTotal:        3003496 kB
MemFree:         2986584 kB
MemAvailable:    2970176 kB
Buffers:               0 kB
Cached:             3540 kB
SwapCached:            0 kB
Active:             3920 kB
Inactive:             68 kB
Active(anon):       3920 kB
Inactive(anon):       68 kB
Active(file):          0 kB
Inactive(file):        0 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:           528 kB
Mapped:             1984 kB
Shmem:              3540 kB
KReclaimable:        688 kB
Slab:               5700 kB
SReclaimable:        688 kB
SUnreclaim:         5012 kB
KernelStack:         424 kB
PageTables:           80 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     1501748 kB
Committed_AS:       3200 kB
VmallocTotal:   67108863 kB
VmallocUsed:          12 kB
VmallocChunk:          0 kB
Percpu:              272 kB
# uname -a
Linux buildroot 5.3.0-rc4-00001-g44404421c481-dirty #10 SMP Thu Aug 15
16:28:24 DST 2019 riscv64 GNU/Lin[ 2352.443621] random: fast init done
ux
# zcat /proc/config.gz |grep SPARSE
CONFIG_SPARSE_IRQ=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
# CONFIG_INPUT_SPARSEKMAP is not set
