Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413F4C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132662084A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfENPmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:42:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbfENPmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:42:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EFdS7k155723
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 11:42:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sfyqwakn0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 11:42:36 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 14 May 2019 16:42:34 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 May 2019 16:42:28 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4EFgRUt61341910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 15:42:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 130254C040;
        Tue, 14 May 2019 15:42:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B24674C052;
        Tue, 14 May 2019 15:42:25 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 14 May 2019 15:42:25 +0000 (GMT)
Date:   Tue, 14 May 2019 18:42:24 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v2 2/2] amr64: map FDT as RW for early_init_dt_scan()
References: <20190513003819.356-1-hsinyi@chromium.org>
 <20190513003819.356-2-hsinyi@chromium.org>
 <20190513085853.GB9271@rapoport-lnx>
 <CAJMQK-hKrU2J0_uGe3eO_JTNwM=HRkXbDx2u45izcdD7wqwGeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-hKrU2J0_uGe3eO_JTNwM=HRkXbDx2u45izcdD7wqwGeQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19051415-0020-0000-0000-0000033C9A11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051415-0021-0000-0000-0000218F56C0
Message-Id: <20190514154223.GA11115@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 07:14:32PM +0800, Hsin-Yi Wang wrote:
> On Mon, May 13, 2019 at 4:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> 
> >
> > This makes the fdt mapped without the call to meblock_reserve(fdt) which
> > makes the fdt memory available for memblock allocations.
> >
> > Chances that is will be actually allocated are small, but you know, things
> > happen.
> >
> > IMHO, instead of calling directly __fixmap_remap_fdt() it would be better
> > to add pgprot parameter to fixmap_remap_fdt(). Then here and in kaslr.c it
> > can be called with PAGE_KERNEL and below with PAGE_KERNEL_RO.
> >
> > There is no problem to call memblock_reserve() for the same area twice,
> > it's essentially a NOP.
> >
> Thanks for the suggestion. Will update fixmap_remap_fdt() in next patch.
> 
> However, I tested on some arm64 platform, if we also call
> memblock_reserve() in kaslr.c, would cause warning[1] when
> memblock_reserve() is called again in setup_machine_fdt(). The warning
> comes from https://elixir.bootlin.com/linux/latest/source/mm/memblock.c#L601
> ```
> if (type->regions[0].size == 0) {
>   WARN_ON(type->cnt != 1 || type->total_size);
>   ...
> ```
> 
> Call memblock_reserve() multiple times after setup_machine_fdt()
> doesn't have such warning though.

I'm not sure if early console is available at the time kaslr_early_init()
is called, but if yes, running with memblock=debug may shed some light.
 
> I didn't trace the real reason causing this. But in this case, maybe
> don't call memblock_reserve() in kaslr?

My concern that this uncovered a real bug which might hit us later.

> [1]
> [    0.000000] WARNING: CPU: 0 PID: 0 at
> /mnt/host/source/src/third_party/kernel/v4.19/mm/memblock.c:583
> memblock_add_range+0x1bc/0x1c8
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.38 #125
> [    0.000000] pstate: 600001c5 (nZCv dAIF -PAN -UAO)
> [    0.000000] pc : memblock_add_range+0x1bc/0x1c8
> [    0.000000] lr : memblock_add_range+0x30/0x1c8
> [    0.000000] sp : ffffff9b5e203e80
> [    0.000000] x29: ffffff9b5e203ed0 x28: 0000000040959324
> [    0.000000] x27: 0000000040080000 x26: 0000000000080000
> [    0.000000] x25: 0000000080127e4b x24: 0000000000000000
> [    0.000000] x23: 0000001b55000000 x22: 000000000001152b
> [    0.000000] x21: 000000005f800000 x20: 0000000000000000
> [    0.000000] x19: ffffff9b5e24bf00 x18: 00000000ffffffb8
> [    0.000000] x17: 000000000000003c x16: ffffffbefea00000
> [    0.000000] x15: ffffffbefea00000 x14: ffffff9b5e3c17d8
> [    0.000000] x13: 00e8000000000713 x12: 0000000000000000
> [    0.000000] x11: ffffffbefea00000 x10: 00e800005f800710
> [    0.000000] x9 : 000000000001152b x8 : ffffff9b5e365690
> [    0.000000] x7 : 6f20646573616228 x6 : 0000000000000002
> [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
> [    0.000000] x3 : 0000000000200000 x2 : 000000000001152b
> [    0.000000] x1 : 000000005f800000 x0 : ffffff9b5e24bf00
> [    0.000000] Call trace:
> [    0.000000]  memblock_add_range+0x1bc/0x1c8
> [    0.000000]  memblock_reserve+0x60/0xac
> [    0.000000]  fixmap_remap_fdt+0x4c/0x78
> [    0.000000]  setup_machine_fdt+0x64/0xfc
> [    0.000000]  setup_arch+0x68/0x1e0
> [    0.000000]  start_kernel+0x68/0x380
> 

-- 
Sincerely yours,
Mike.

