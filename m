Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361CBC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C5020848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfEPLHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:07:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726363AbfEPLHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:07:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GAvt2Q133883
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:07:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sh6cas43k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:07:28 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 16 May 2019 12:07:25 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 12:07:20 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GB7Jc336438152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 11:07:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31EFC4C04A;
        Thu, 16 May 2019 11:07:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1A4E4C044;
        Thu, 16 May 2019 11:07:17 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 16 May 2019 11:07:17 +0000 (GMT)
Date:   Thu, 16 May 2019 14:07:16 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v2 2/2] amr64: map FDT as RW for early_init_dt_scan()
References: <20190513003819.356-1-hsinyi@chromium.org>
 <20190513003819.356-2-hsinyi@chromium.org>
 <20190513085853.GB9271@rapoport-lnx>
 <CAJMQK-hKrU2J0_uGe3eO_JTNwM=HRkXbDx2u45izcdD7wqwGeQ@mail.gmail.com>
 <20190514154223.GA11115@rapoport-lnx>
 <CAJMQK-gMa81kHaTS1kwTcOy+Avt5GsmNcagfscdLdmzS31Tobw@mail.gmail.com>
 <CAKv+Gu8T-=inrckZmzQLk7abZtvkdE-nK_Qgcn+bbtovubzrkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8T-=inrckZmzQLk7abZtvkdE-nK_Qgcn+bbtovubzrkQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19051611-0028-0000-0000-0000036E4F1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051611-0029-0000-0000-0000242DE950
Message-Id: <20190516110715.GA19122@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 10:11:53PM +0200, Ard Biesheuvel wrote:
> On Wed, 15 May 2019 at 12:24, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > On Tue, May 14, 2019 at 11:42 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > > I'm not sure if early console is available at the time kaslr_early_init()
> > > is called, but if yes, running with memblock=debug may shed some light.
> > >
> > > > I didn't trace the real reason causing this. But in this case, maybe
> > > > don't call memblock_reserve() in kaslr?
> > >
> > > My concern that this uncovered a real bug which might hit us later.
> > >
> > Hi Mike,
> > Thanks for the hint. I tried on my device but seems that earlycon
> > happens after the warning call trace, so can't more information.
> >
> > Since on my device kaslr will be runned, I tried call
> > memblock_reserve() in kaslr and not in
> > setup_machine_fdt()#fixmap_remap_fdt, but got following warning
> >
> 
> I realize this is not documented sufficiently in the commit log, but
> the reason I introduced the separate __fixmap_remap_fdt() [which does
> not call memblock_reserve()] was that the KASLR init code should set
> as little global state as possible, given that it is called with the
> kernel mapped at the wrong virtual address.
> 
> The KASLR boot sequence is something like
> - map kernel at default [unrandomized] address
> - apply relocations and clear BSS
> - run KASLR init to map and parse the FDT [*]
> - if KASLR is enabled, unmap the kernel and remap it at the randomized address
> - apply relocations and clear BSS
> - proceed with start_kernel()
>
> The issue you are seeing is caused by the fact that the memblock
> bookkeeping gets into an inconsistent state due to the 2nd clearing of
> BSS.

Ah, now the warning makes perfect sense :)
Thanks!

> [*] The reason we need to map the FDT this early is to obtain the
> random seed, and to check whether 'nokaslr' was passed on the kernel
> command line. The reason arm64 deviates from other architectures in
> this regard is that we don't have a decompressor, and so there is no
> other execution context available where we can run C code to parse the
> FDT etc before we enter the kernel proper.
> 
> 
> 
> 
> > [    0.000000] memblock_remove:
> > [0x0001000000000000-0x0000fffffffffffe] arm64_memblock_init+0x28/0x224
> > [    0.000000] memblock_remove:
> > [0x0000004040000000-0x000000403ffffffe] arm64_memblock_init+0x64/0x224
> > [    0.000000] memblock_reserve:
> > [0x0000000040080000-0x00000000413c3fff]
> > arm64_memblock_init+0x188/0x224
> > [    0.000000] WARNING: CPU: 0 PID: 0 at
> > /mnt/host/source/src/third_party/kernel/v4.19/mm/memblock.c:583
> > memblock_add_range+0x1bc/0x1c8
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.38 #222
> > [    0.000000] Hardware name: MediaTek kukui rev2 board (DT)
> > [    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
> > [    0.000000] pc : memblock_add_range+0x1bc/0x1c8
> > [    0.000000] lr : memblock_add_range+0x30/0x1c8
> > [    0.000000] sp : ffffffab68603ea0
> > [    0.000000] x29: ffffffab68603ef0 x28: 0000000040954324
> > [    0.000000] x27: 0000000040080000 x26: 0000000000080000
> > [    0.000000] x25: 0000000080127e4b x24: ffffffab68716000
> > [    0.000000] x23: ffffffab680b5000 x22: 0000000001344000
> > [    0.000000] x21: 0000000040080000 x20: 0000000000000000
> > [    0.000000] x19: ffffffab6864bf00 x18: 00000000fffffc94
> > [    0.000000] x17: 000000000000003c x16: ffffffab67d49064
> > [    0.000000] x15: 0000000000000006 x14: 626d656d5f34366d
> > [    0.000000] x13: 7261205d66666633 x12: 0000000000000000
> > [    0.000000] x11: 0000000000000000 x10: ffffffffffffffff
> > [    0.000000] x9 : 0000000000011547 x8 : ffffffab68765690
> > [    0.000000] x7 : 696e695f6b636f6c x6 : ffffffab6875dd41
> > [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
> > [    0.000000] x3 : ffffffab678a24a0 x2 : 0000000001344000
> > [    0.000000] x1 : 0000000040080000 x0 : ffffffab6864bf00
> > [    0.000000] Call trace:
> > [    0.000000]  memblock_add_range+0x1bc/0x1c8
> > [    0.000000]  memblock_reserve+0x60/0xac
> > [    0.000000]  arm64_memblock_init+0x188/0x224
> > [    0.000000]  setup_arch+0x138/0x19c
> > [    0.000000]  start_kernel+0x68/0x380
> > [    0.000000] random: get_random_bytes called from
> > print_oops_end_marker+0x3c/0x58 with crng_init=0
> > [    0.000000] ---[ end trace ea99802b425f7adf ]---
> > [    0.000000] memblock_reserve:
> > [0x000000005f800000-0x000000005f811536]
> > early_init_dt_reserve_memory_arch+0x38/0x48
> > [    0.000000] memblock_reserve:
> > [0x00000000ffe00000-0x00000000ffffffff]
> > early_init_dt_reserve_memory_arch+0x38/0x48
> >
> > So I guess we just can't call memblock_reserve() in kaslr?
> 

-- 
Sincerely yours,
Mike.

