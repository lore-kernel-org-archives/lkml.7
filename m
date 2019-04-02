Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127A6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3082084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfDBIfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:35:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbfDBIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:35:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x328T2U4026248
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 04:35:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rm1nd8qn9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 04:35:05 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 2 Apr 2019 09:35:03 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 09:35:01 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x328Z0TP61669568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 08:35:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E58054C040;
        Tue,  2 Apr 2019 08:34:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 364934C050;
        Tue,  2 Apr 2019 08:34:59 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  2 Apr 2019 08:34:59 +0000 (GMT)
Date:   Tue, 2 Apr 2019 11:34:57 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Fix Maximum Physical Memory 2GiB option for
 64bit systems
References: <20190402055902.14017-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402055902.14017-1-anup.patel@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19040208-0028-0000-0000-0000035C41CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040208-0029-0000-0000-0000241B4508
Message-Id: <20190402083456.GA2153@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:02:38AM +0000, Anup Patel wrote:
> The Maximum Physical Memory 2GiB option for 64bit systems is currently
> broken because kernel hangs at boot-time when this option is enabled
> and the underlying system has more than 2GiB memory.
> 
> This issue can be easily reproduced on SiFive Unleashed board where
> we have 8GiB of memory.
> 
> This patch fixes above issue by reserving unusable memory region in
> setup_bootmem().
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/mm/init.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 5fd8c922e1c2..6b063f20a9d0 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -121,6 +121,14 @@ void __init setup_bootmem(void)
>  			 */
>  			memblock_reserve(reg->base, vmlinux_end - reg->base);
>  			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
> +
> +			/*
> +			 * Reserve from the end of usable area to the end of
> +			 * region
> +			 */
> +			if ((reg->base + mem_size) < end)
> +				memblock_reserve(reg->base + mem_size,
> +						 end - reg->base - mem_size);

The memory above MAXPHYSMEM should not be reserved. It should be either
removed from memblock with memblock_remove or not added at the first place.

Frankly, I fail to understand the logic behind setting PAGE_OFFSET to
MAXPHYSMEM and then using PAGE_OFFSET as the limit for accessible physical
memory. Still, as it is there, you can set MAX_MEMBLOCK_ADDR=PAGE_OFFSET in
arch/riscv/include/page.h and then early_init_dt_add_memory_arch() will
simply ignore the memory above PAGE_OFFSET.

More sustainable fix for the long term, IMHO, would be to break
PAGE_OFFSET and MAXPHYSMEM interdependency.


>  		}
>  	}
>  	BUG_ON(mem_size == 0);
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

