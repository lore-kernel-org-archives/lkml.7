Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E02C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3693421907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfDXNrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:47:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727337AbfDXNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:47:25 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ODjRkL022575
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:47:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s2ryag37y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:47:23 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 24 Apr 2019 14:47:21 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 14:47:15 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3ODlEUv48758842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 13:47:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC6EAE051;
        Wed, 24 Apr 2019 13:47:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A550AE059;
        Wed, 24 Apr 2019 13:47:13 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Apr 2019 13:47:13 +0000 (GMT)
Date:   Wed, 24 Apr 2019 16:47:11 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] mips: Print the kernel virtual mem layout on
 debugging
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
 <20190423224748.3765-11-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423224748.3765-11-fancer.lancer@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19042413-0028-0000-0000-00000365163A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042413-0029-0000-0000-000024246895
Message-Id: <20190424134711.GE6278@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=567 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 01:47:46AM +0300, Serge Semin wrote:
> It is useful at least for debugging to have the kernel virtual
> memory layout printed at boot time so to have the full information
> about the booted kernel. Make the printing optional and available
> only when DEBUG_KERNEL config is enabled so not to leak a sensitive
> kernel information.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  arch/mips/mm/init.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index bbb196ad5f26..c338bbd03b2a 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -31,6 +31,7 @@
>  #include <linux/gfp.h>
>  #include <linux/kcore.h>
>  #include <linux/initrd.h>
> +#include <linux/sizes.h>
>  
>  #include <asm/bootinfo.h>
>  #include <asm/cachectl.h>
> @@ -56,6 +57,53 @@ unsigned long empty_zero_page, zero_page_mask;
>  EXPORT_SYMBOL_GPL(empty_zero_page);
>  EXPORT_SYMBOL(zero_page_mask);
>  
> +/*
> + * Print out the kernel virtual memory layout
> + */
> +#define MLK(b, t) (void *)b, (void *)t, ((t) - (b)) >> 10
> +#define MLM(b, t) (void *)b, (void *)t, ((t) - (b)) >> 20
> +#define MLK_ROUNDUP(b, t) (void *)b, (void *)t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
> +static void __init mem_print_kmap_info(void)
> +{
> +#ifdef CONFIG_DEBUG_KERNEL

Maybe CONFIG_DEBUG_VM?

> +	pr_notice("Kernel virtual memory layout:\n"
> +		  "    lowmem  : 0x%px - 0x%px  (%4ld MB)\n"
> +		  "      .text : 0x%px - 0x%px  (%4td kB)\n"
> +		  "      .data : 0x%px - 0x%px  (%4td kB)\n"
> +		  "      .init : 0x%px - 0x%px  (%4td kB)\n"
> +		  "      .bss  : 0x%px - 0x%px  (%4td kB)\n"
> +		  "    vmalloc : 0x%px - 0x%px  (%4ld MB)\n"
> +#ifdef CONFIG_HIGHMEM
> +		  "    pkmap   : 0x%px - 0x%px  (%4ld MB)\n"
> +#endif
> +		  "    fixmap  : 0x%px - 0x%px  (%4ld kB)\n",
> +		  MLM(PAGE_OFFSET, (unsigned long)high_memory),
> +		  MLK_ROUNDUP(_text, _etext),
> +		  MLK_ROUNDUP(_sdata, _edata),
> +		  MLK_ROUNDUP(__init_begin, __init_end),
> +		  MLK_ROUNDUP(__bss_start, __bss_stop),
> +		  MLM(VMALLOC_START, VMALLOC_END),
> +#ifdef CONFIG_HIGHMEM
> +		  MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE)),
> +#endif
> +		  MLK(FIXADDR_START, FIXADDR_TOP));
> +
> +	/* Check some fundamental inconsistencies. May add something else? */
> +#ifdef CONFIG_HIGHMEM
> +	BUILD_BUG_ON(VMALLOC_END < PAGE_OFFSET);
> +	BUG_ON(VMALLOC_END < (unsigned long)high_memory);
> +	BUILD_BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) < PAGE_OFFSET);
> +	BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) <
> +		(unsigned long)high_memory);
> +#endif
> +	BUILD_BUG_ON(FIXADDR_TOP < PAGE_OFFSET);
> +	BUG_ON(FIXADDR_TOP < (unsigned long)high_memory);
> +#endif /* CONFIG_DEBUG_KERNEL */
> +}
> +#undef MLK
> +#undef MLM
> +#undef MLK_ROUNDUP
> +
>  /*
>   * Not static inline because used by IP27 special magic initialization code
>   */
> @@ -479,6 +527,7 @@ void __init mem_init(void)
>  	setup_zero_pages();	/* Setup zeroed pages.  */
>  	mem_init_free_highmem();
>  	mem_init_print_info(NULL);
> +	mem_print_kmap_info();
>  
>  #ifdef CONFIG_64BIT
>  	if ((unsigned long) &_text > (unsigned long) CKSEG0)
> -- 
> 2.21.0
> 

-- 
Sincerely yours,
Mike.

