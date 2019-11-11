Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E38C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55ADA21872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKKV5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:57:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42718 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbfKKV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:57:03 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABLr4Hp053919
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:57:01 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w5s55x0mt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:57:01 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 11 Nov 2019 21:56:59 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Nov 2019 21:56:55 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xABLusSA55640234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 21:56:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BB70A405F;
        Mon, 11 Nov 2019 21:56:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72048A4060;
        Mon, 11 Nov 2019 21:56:51 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.207.107])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Nov 2019 21:56:51 +0000 (GMT)
Date:   Mon, 11 Nov 2019 22:56:48 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: Re: [PATCH] RISC-V: Add address map dumper
References: <1573450015-16475-1-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573450015-16475-1-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19111121-0020-0000-0000-00000385517D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111121-0021-0000-0000-000021DB564D
Message-Id: <20191111215647.GB10647@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=822 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 11, 2019 at 05:27:25AM +0000, Yash Shah wrote:
> Add support for dumping the kernel address space layout to the console.
> User can enable CONFIG_DEBUG_VM_LAYOUT to dump the virtual memory region
> into dmesg buffer during boot-up.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
> This patch is based on Linux 5.4-rc6 and tested on SiFive HiFive Unleashed
> board.
> ---
>  arch/riscv/Kconfig.debug |  9 +++++++++
>  arch/riscv/mm/init.c     | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
> index e69de29..cdedfd3 100644
> --- a/arch/riscv/Kconfig.debug
> +++ b/arch/riscv/Kconfig.debug
> @@ -0,0 +1,9 @@
> +config DEBUG_VM_LAYOUT

I believe this could be enabled when CONFIG_DEBUG_VM=y without adding yet
another architecture specific Kconfig option.

> +	bool "Print virtual memory layout on boot up"
> +	depends on DEBUG_KERNEL
> +	help
> +	  Say Y here if you want to dump the kernel virtual memory layout to
> +	  dmesg log on boot up. This information is only useful for kernel
> +	  developers who are working in architecture specific areas of the
> +	  kernel. It is probably not a good idea to enable this feature in a
> +	  production kernel.
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 79cfb35..fcb8144 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -55,6 +55,36 @@ void __init mem_init(void)
>  	memblock_free_all();
>  
>  	mem_init_print_info(NULL);
> +#ifdef CONFIG_DEBUG_VM_LAYOUT
> +#define MLK(b, t) b, t, (((t) - (b)) >> 10)
> +#define MLM(b, t) b, t, (((t) - (b)) >> 20)
> +#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
> +
> +
> +	pr_notice("Virtual kernel memory layout:\n"
> +			"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> +			"    vmemmap : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> +			"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> +			"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> +			"      .init : 0x%px - 0x%px   (%4td kB)\n"
> +			"      .text : 0x%px - 0x%px   (%4td kB)\n"
> +			"      .data : 0x%px - 0x%px   (%4td kB)\n"
> +			"       .bss : 0x%px - 0x%px   (%4td kB)\n",
> +
> +			MLK(FIXADDR_START, FIXADDR_TOP),
> +			MLM(VMEMMAP_START, VMEMMAP_END),
> +			MLM(VMALLOC_START, VMALLOC_END),
> +			MLM(PAGE_OFFSET, (unsigned long)high_memory),
> +
> +			MLK_ROUNDUP(__init_begin, __init_end),
> +			MLK_ROUNDUP(_text, _etext),
> +			MLK_ROUNDUP(_sdata, _edata),
> +			MLK_ROUNDUP(__bss_start, __bss_stop));
> +
> +#undef MLK
> +#undef MLM
> +#undef MLK_ROUNDUP
> +#endif
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

