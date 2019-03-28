Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35522C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED84F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfC1Fzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 01:55:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725806AbfC1Fzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 01:55:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2S5nIHE072437
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 01:55:37 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rgq2wkdek-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 01:55:37 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 28 Mar 2019 05:55:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 05:55:26 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2S5tOJu54198406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 05:55:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2EBD4C046;
        Thu, 28 Mar 2019 05:55:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 517B94C05C;
        Thu, 28 Mar 2019 05:55:22 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 28 Mar 2019 05:55:22 +0000 (GMT)
Date:   Thu, 28 Mar 2019 07:55:20 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Guo Ren <ren_guo@c-sky.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH AUTOSEL 5.0 008/262] swiotlb: add checks for the return
 value of memblock_alloc*()
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-8-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327180158.10245-8-sashal@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032805-0012-0000-0000-0000030830CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032805-0013-0000-0000-0000213F6046
Message-Id: <20190328055520.GA14864@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=52 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1031 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 27, 2019 at 01:57:43PM -0400, Sasha Levin wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> [ Upstream commit a0bf842e89a3842162aa8514b9bf4611c86fee10 ]
> 
> Add panic() calls if memblock_alloc() returns NULL.
> 
> The panic() format duplicates the one used by memblock itself and in
> order to avoid explosion with long parameters list replace open coded
> allocation size calculations with a local variable.

This patch is a part of a series that removes panic() calls from memblock
allocators rather than a fix.
 
> Link: http://lkml.kernel.org/r/1548057848-15136-19-git-send-email-rppt@linux.ibm.com
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Guo Ren <ren_guo@c-sky.com>				[c-sky]
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Juergen Gross <jgross@suse.com>			[Xen]
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c873f9cc2146..41224f0ec40e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -191,6 +191,7 @@ void __init swiotlb_update_mem_attributes(void)
>  int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  {
>  	unsigned long i, bytes;
> +	size_t alloc_size;
>  
>  	bytes = nslabs << IO_TLB_SHIFT;
>  
> @@ -203,12 +204,18 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
>  	 * between io_tlb_start and io_tlb_end.
>  	 */
> -	io_tlb_list = memblock_alloc(
> -				PAGE_ALIGN(io_tlb_nslabs * sizeof(int)),
> -				PAGE_SIZE);
> -	io_tlb_orig_addr = memblock_alloc(
> -				PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)),
> -				PAGE_SIZE);
> +	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(int));
> +	io_tlb_list = memblock_alloc(alloc_size, PAGE_SIZE);
> +	if (!io_tlb_list)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> +		      __func__, alloc_size, PAGE_SIZE);
> +
> +	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t));
> +	io_tlb_orig_addr = memblock_alloc(alloc_size, PAGE_SIZE);
> +	if (!io_tlb_orig_addr)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> +		      __func__, alloc_size, PAGE_SIZE);
> +
>  	for (i = 0; i < io_tlb_nslabs; i++) {
>  		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
>  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
> -- 
> 2.19.1
> 

-- 
Sincerely yours,
Mike.

