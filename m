Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FEF218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfCOP6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:58:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729347AbfCOP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:58:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2FFs0kf120572
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 11:58:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r8cv38j87-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 11:58:39 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 15 Mar 2019 15:58:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Mar 2019 15:58:32 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2FFwVh134537610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Mar 2019 15:58:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7B7E42047;
        Fri, 15 Mar 2019 15:58:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB89C42042;
        Fri, 15 Mar 2019 15:58:30 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.220])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 15 Mar 2019 15:58:30 +0000 (GMT)
Date:   Fri, 15 Mar 2019 17:58:29 +0200
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
 <20190314065311.GC24380@rapoport-lnx>
 <CAAhSdy2uEgyvs=5NdoZ3H208qeDGJ9OrTOeaz6HQ+1va+R3dUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2uEgyvs=5NdoZ3H208qeDGJ9OrTOeaz6HQ+1va+R3dUA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19031515-4275-0000-0000-0000031B761D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031515-4276-0000-0000-00003829EC7E
Message-Id: <20190315155828.GB920@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903150113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:28:32PM +0530, Anup Patel wrote:
> On Thu, Mar 14, 2019 at 12:23 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Thu, Mar 14, 2019 at 02:36:01AM +0530, Anup Patel wrote:
> > > On Thu, Mar 14, 2019 at 12:01 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > >
> > > > On Tue, Mar 12, 2019 at 10:08:22PM +0000, Anup Patel wrote:
> > > > > Currently, we have to boot RISCV64 kernel from a 2MB aligned physical
> > > > > address and RISCV32 kernel from a 4MB aligned physical address. This
> > > > > constraint is because initial pagetable setup (i.e. setup_vm()) maps
> > > > > entire RAM using hugepages (i.e. 2MB for 3-level pagetable and 4MB for
> > > > > 2-level pagetable).
> > > > >
> > > > > Further, the above booting contraint also results in memory wastage
> > > > > because if we boot kernel from some <xyz> address (which is not same as
> > > > > RAM start address) then RISCV kernel will map PAGE_OFFSET virtual address
> > > > > lineraly to <xyz> physical address and memory between RAM start and <xyz>
> > > > > will be reserved/unusable.
> > > > >
> > > > > For example, RISCV64 kernel booted from 0x80200000 will waste 2MB of RAM
> > > > > and RISCV32 kernel booted from 0x80400000 will waste 4MB of RAM.
> > > > >
> > > > > This patch re-writes the initial pagetable setup code to allow booting
> > > > > RISV32 and RISCV64 kernel from any 4KB (i.e. PAGE_SIZE) aligned address.
> > > > >
> > > > > To achieve this:
> > > > > 1. We map kernel, dtb and only some amount of RAM (few MBs) using 4KB
> > > > >    mappings in setup_vm() (called from head.S)
> > > > > 2. Once we reach paging_init() (called from setup_arch()) after
> > > > >    memblock setup, we map all available memory banks using 4KB
> > > > >    mappings and memblock APIs.
> > > >
> > > > I'm not really familiar with RISC-V, but my guess would be that you'd get
> > > > worse TLB performance with 4KB mappings. Not mentioning the amount of
> > > > memory required for the page table itself.
> > >
> > > I agree we will see a hit in TLB performance due to 4KB mappings.
> > >
> > > To address this we can create, 2MB (or 4MB on 32bit system) mappings
> > > whenever load_pa is aligned to it otherwise we prefer 4KB mappings. In other
> > > words, we create bigger mappings whenever possible and fallback to 4KB
> > > mappings when not possible.
> > >
> > > This way if kernel is booted from 2MB (or 4MB) aligned address then we will
> > > see good TLB performance for kernel addresses. Also, users are still free to
> > > boot Linux RISC-V kernel from any 4KB aligned address.
> > >
> > > Of course, we will have to document this as part of Linux RISC-V booting
> > > requirements under Documentation/ (which does not exist currently).
> > >
> > > >
> > > > If the only goal is to utilize the physical memory below the kernel, it
> > > > simply should not be reserved at the first place, something like:
> > >
> > > Well, our goal was two-fold:
> > >
> > > 1. We wanted to unify boot-time alignment requirements for 32bit and
> > > 64bit RISC-V systems
> >
> > Can't they both start from 4MB aligned address provided the memory below
> > the kernel can be freed?
> 
> Yes, they can both start from 4MB aligned address.
> 
> >
> > > 2. Save memory by allowing users to place kernel just after the runtime
> > > firmware at starting of RAM.
> >
> > If the firmware should be alive after kernel boot, it's memory is the only
> > part that should be reserved below the kernel. Otherwise, the entire region
> > <physical memory start> - <kernel start> can be free.
> >
> > Using 4K pages for the swapper_pg_dir is quite a change and I'm not
> > convinced its really justified.
> 
> I understand your concern about TLB performance and more page
> tables.
> 
> Not just 2MB/4MB mappings, we should be able to create even 1GB
> mappings as well for good TLB performance.
> 
> I suggest we should use best possible mapping size (4KB, 2MB, or
> 1GB) based on alignment of kernel load address. This way users can
> boot from any 4KB aligned address and setup_vm() will try to use
> biggest possible mapping size.
> 
> For example, If the kernel load address is aligned to 2MB then we 2MB
> mappings bigger mappings and use fewer page tables. Same thing
> possible for 1GB mappings as well.

I still don't get why it is that important to relax alignment of the kernel
load address. Provided you can use the memory below the kernel, it really
should not matter.

> Regards,
> Anup
> 

-- 
Sincerely yours,
Mike.

