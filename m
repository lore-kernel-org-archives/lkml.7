Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3819C2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfCYQOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:14:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfCYQOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:14:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PGE5ls107453
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 12:14:08 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rf1duu2s6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 12:14:08 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 25 Mar 2019 16:14:05 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Mar 2019 16:14:02 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2PGE1FV46596148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 16:14:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D478CA405B;
        Mon, 25 Mar 2019 16:14:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03454A4054;
        Mon, 25 Mar 2019 16:14:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.192])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Mar 2019 16:14:00 +0000 (GMT)
Date:   Mon, 25 Mar 2019 18:13:59 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] RISC-V: Fix memory reservation in setup_bootmem()
References: <20190325092234.5451-1-anup.patel@wdc.com>
 <20190325092234.5451-3-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325092234.5451-3-anup.patel@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032516-0012-0000-0000-00000306EFF6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032516-0013-0000-0000-0000213E14EF
Message-Id: <20190325161358.GA4783@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:23:09AM +0000, Anup Patel wrote:
> Currently, the setup_bootmem() reserves memory from RAM start to the
> kernel end. This prevents us from exploring ways to use the RAM below
> (or before) the kernel start hence this patch updates setup_bootmem()
> to only reserve memory from the kernel start to the kernel end.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Suggested-by: please :)

> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/riscv/mm/init.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 8cf9ff1f9058..3e66b7cb3a61 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -29,6 +29,8 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
>  							__page_aligned_bss;
>  EXPORT_SYMBOL(empty_zero_page);
>  
> +extern char _start[];
> +
>  static void __init zone_sizes_init(void)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
> @@ -108,23 +110,21 @@ void __init setup_bootmem(void)
>  {
>  	struct memblock_region *reg;
>  	phys_addr_t mem_size = 0;
> +	phys_addr_t vmlinux_end = __pa(&_end);
> +	phys_addr_t vmlinux_start = __pa(&_start);
>  
>  	/* Find the memory region containing the kernel */
>  	for_each_memblock(memory, reg) {
> -		phys_addr_t vmlinux_end = __pa(_end);
>  		phys_addr_t end = reg->base + reg->size;
>  
> -		if (reg->base <= vmlinux_end && vmlinux_end <= end) {
> -			/*
> -			 * Reserve from the start of the region to the end of
> -			 * the kernel
> -			 */
> -			memblock_reserve(reg->base, vmlinux_end - reg->base);
> +		if (reg->base <= vmlinux_end && vmlinux_end <= end)
>  			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
> -		}
>  	}
>  	BUG_ON(mem_size == 0);
>  
> +	/* Reserve from the start of the kernel to the end of the kernel */
> +	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> +
>  	set_max_mapnr(PFN_DOWN(mem_size));
>  	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
>  
> @@ -196,7 +196,6 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>   */
>  asmlinkage void __init setup_vm(void)
>  {
> -	extern char _start;
>  	uintptr_t i;
>  	uintptr_t pa = (uintptr_t) &_start;
>  	pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

