Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6EDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8128021872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKKVzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:55:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbfKKVzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:55:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABLsJMt073254
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:55:43 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7c3sg7u0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:55:42 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 11 Nov 2019 21:55:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Nov 2019 21:55:35 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xABLtYBY59572406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 21:55:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B92611C052;
        Mon, 11 Nov 2019 21:55:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B682C11C04C;
        Mon, 11 Nov 2019 21:55:31 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.207.107])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Nov 2019 21:55:31 +0000 (GMT)
Date:   Mon, 11 Nov 2019 22:55:28 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Yash Shah <yash.shah@sifive.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: Re: [PATCH] RISC-V: Add address map dumper
References: <1573450015-16475-1-git-send-email-yash.shah@sifive.com>
 <91f35033-ffc8-cd2e-36f7-c6f4f25be36b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91f35033-ffc8-cd2e-36f7-c6f4f25be36b@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19111121-0028-0000-0000-000003B60582
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111121-0029-0000-0000-0000247905BA
Message-Id: <20191111215527.GA10647@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=963 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:14:30AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-11-10 10:27 p.m., Yash Shah wrote:
> > Add support for dumping the kernel address space layout to the console.
> > User can enable CONFIG_DEBUG_VM_LAYOUT to dump the virtual memory region
> > into dmesg buffer during boot-up.
> 
> Cool, I'd find this useful. Though, is there any reason we don't do this
> more generally for all architectures?

Some architectures do this, some don't. I don't think there's a particular
reason we don't do this generally, it just evolved that way :)
 
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> > This patch is based on Linux 5.4-rc6 and tested on SiFive HiFive Unleashed
> > board.
> > ---
> >  arch/riscv/Kconfig.debug |  9 +++++++++
> >  arch/riscv/mm/init.c     | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
> > index e69de29..cdedfd3 100644
> > --- a/arch/riscv/Kconfig.debug
> > +++ b/arch/riscv/Kconfig.debug
> > @@ -0,0 +1,9 @@
> > +config DEBUG_VM_LAYOUT
> > +	bool "Print virtual memory layout on boot up"
> > +	depends on DEBUG_KERNEL
> > +	help
> > +	  Say Y here if you want to dump the kernel virtual memory layout to
> > +	  dmesg log on boot up. This information is only useful for kernel
> > +	  developers who are working in architecture specific areas of the
> > +	  kernel. It is probably not a good idea to enable this feature in a
> > +	  production kernel.
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 79cfb35..fcb8144 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -55,6 +55,36 @@ void __init mem_init(void)
> >  	memblock_free_all();
> >  
> >  	mem_init_print_info(NULL);
> > +#ifdef CONFIG_DEBUG_VM_LAYOUT
> 
> Generally, it's best to avoid #ifdefs inside functions, it's even
> counter-indicated in the style guide[1].
> 
> > +#define MLK(b, t) b, t, (((t) - (b)) >> 10)
> > +#define MLM(b, t) b, t, (((t) - (b)) >> 20)
> > +#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
> 
> I personally find these inline defines rather ugly. Maybe it would be
> better to have a helper function that prints a single line. Also seems
> like MLK and MLK_ROUNDUP could be the same assuming the entries in MLK
> are aligned...
> 
> > +
> > +	pr_notice("Virtual kernel memory layout:\n"
> > +			"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> > +			"    vmemmap : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> > +			"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> > +			"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> > +			"      .init : 0x%px - 0x%px   (%4td kB)\n"
> > +			"      .text : 0x%px - 0x%px   (%4td kB)\n"
> > +			"      .data : 0x%px - 0x%px   (%4td kB)\n"
> > +			"       .bss : 0x%px - 0x%px   (%4td kB)\n",
> > +
> > +			MLK(FIXADDR_START, FIXADDR_TOP),
> > +			MLM(VMEMMAP_START, VMEMMAP_END),
> > +			MLM(VMALLOC_START, VMALLOC_END),
> > +			MLM(PAGE_OFFSET, (unsigned long)high_memory),
> > +
> > +			MLK_ROUNDUP(__init_begin, __init_end),
> > +			MLK_ROUNDUP(_text, _etext),
> > +			MLK_ROUNDUP(_sdata, _edata),
> > +			MLK_ROUNDUP(__bss_start, __bss_stop));
> > +
> > +#undef MLK
> > +#undef MLM
> > +#undef MLK_ROUNDUP
> > +#endif
> >  }
> >  
> >  #ifdef CONFIG_BLK_DEV_INITRD
> 
> Thanks,
> 
> Logan
> 
> [1]
> https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation

-- 
Sincerely yours,
Mike.

