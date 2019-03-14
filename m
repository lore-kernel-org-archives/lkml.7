Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7984C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E783217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfCNGxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:53:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726582AbfCNGxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:53:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2E6nIi8117151
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:53:23 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r7fmx5e97-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:53:23 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 14 Mar 2019 06:53:19 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 06:53:14 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2E6rEme22806776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 06:53:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC306A4040;
        Thu, 14 Mar 2019 06:53:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39914A405D;
        Thu, 14 Mar 2019 06:53:13 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Mar 2019 06:53:13 +0000 (GMT)
Date:   Thu, 14 Mar 2019 08:53:11 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] RISC-V: Allow booting kernel from any 4KB aligned
 address
References: <20190312220752.128141-1-anup.patel@wdc.com>
 <20190312220752.128141-4-anup.patel@wdc.com>
 <20190313183121.GB28630@rapoport-lnx>
 <CAAhSdy1mrV2CakS0cfOY8F1B7uH_yXjO3W-CiMUcYonkRnVbeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy1mrV2CakS0cfOY8F1B7uH_yXjO3W-CiMUcYonkRnVbeQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19031406-0012-0000-0000-000003026CCF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031406-0013-0000-0000-0000213995A9
Message-Id: <20190314065311.GC24380@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 02:36:01AM +0530, Anup Patel wrote:
> On Thu, Mar 14, 2019 at 12:01 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Tue, Mar 12, 2019 at 10:08:22PM +0000, Anup Patel wrote:
> > > Currently, we have to boot RISCV64 kernel from a 2MB aligned physical
> > > address and RISCV32 kernel from a 4MB aligned physical address. This
> > > constraint is because initial pagetable setup (i.e. setup_vm()) maps
> > > entire RAM using hugepages (i.e. 2MB for 3-level pagetable and 4MB for
> > > 2-level pagetable).
> > >
> > > Further, the above booting contraint also results in memory wastage
> > > because if we boot kernel from some <xyz> address (which is not same as
> > > RAM start address) then RISCV kernel will map PAGE_OFFSET virtual address
> > > lineraly to <xyz> physical address and memory between RAM start and <xyz>
> > > will be reserved/unusable.
> > >
> > > For example, RISCV64 kernel booted from 0x80200000 will waste 2MB of RAM
> > > and RISCV32 kernel booted from 0x80400000 will waste 4MB of RAM.
> > >
> > > This patch re-writes the initial pagetable setup code to allow booting
> > > RISV32 and RISCV64 kernel from any 4KB (i.e. PAGE_SIZE) aligned address.
> > >
> > > To achieve this:
> > > 1. We map kernel, dtb and only some amount of RAM (few MBs) using 4KB
> > >    mappings in setup_vm() (called from head.S)
> > > 2. Once we reach paging_init() (called from setup_arch()) after
> > >    memblock setup, we map all available memory banks using 4KB
> > >    mappings and memblock APIs.
> >
> > I'm not really familiar with RISC-V, but my guess would be that you'd get
> > worse TLB performance with 4KB mappings. Not mentioning the amount of
> > memory required for the page table itself.
> 
> I agree we will see a hit in TLB performance due to 4KB mappings.
> 
> To address this we can create, 2MB (or 4MB on 32bit system) mappings
> whenever load_pa is aligned to it otherwise we prefer 4KB mappings. In other
> words, we create bigger mappings whenever possible and fallback to 4KB
> mappings when not possible.
> 
> This way if kernel is booted from 2MB (or 4MB) aligned address then we will
> see good TLB performance for kernel addresses. Also, users are still free to
> boot Linux RISC-V kernel from any 4KB aligned address.
> 
> Of course, we will have to document this as part of Linux RISC-V booting
> requirements under Documentation/ (which does not exist currently).
> 
> >
> > If the only goal is to utilize the physical memory below the kernel, it
> > simply should not be reserved at the first place, something like:
> 
> Well, our goal was two-fold:
> 
> 1. We wanted to unify boot-time alignment requirements for 32bit and
> 64bit RISC-V systems

Can't they both start from 4MB aligned address provided the memory below
the kernel can be freed?

> 2. Save memory by allowing users to place kernel just after the runtime
> firmware at starting of RAM.

If the firmware should be alive after kernel boot, it's memory is the only
part that should be reserved below the kernel. Otherwise, the entire region
<physical memory start> - <kernel start> can be free.

Using 4K pages for the swapper_pg_dir is quite a change and I'm not
convinced its really justified.
 
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index b379a75..6301ced 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -108,6 +108,7 @@ void __init setup_bootmem(void)
> >         /* Find the memory region containing the kernel */
> >         for_each_memblock(memory, reg) {
> >                 phys_addr_t vmlinux_end = __pa(_end);
> > +               phys_addr_t vmlinux_start = __pa(start);
> >                 phys_addr_t end = reg->base + reg->size;
> >
> >                 if (reg->base <= vmlinux_end && vmlinux_end <= end) {
> > @@ -115,7 +116,8 @@ void __init setup_bootmem(void)
> >                          * Reserve from the start of the region to the end of
> >                          * the kernel
> >                          */
> > -                       memblock_reserve(reg->base, vmlinux_end - reg->base);
> > +                       memblock_reserve(vmlinux_start,
> > +                                        vmlinux_end - vmlinux_start);
> >                         mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
> >                 }
> >         }
> 
> Thanks for above changes. I will include them in my next revision.
> 
> Regards,
> Anup
> 

-- 
Sincerely yours,
Mike.

