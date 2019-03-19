Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF97DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2302146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfCSUnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:43:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbfCSUnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:43:09 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JKYSZW012005
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:43:09 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rb75vsch1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:43:08 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 19 Mar 2019 20:43:01 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 20:42:57 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JKh1nV8192020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 20:43:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49C0252059;
        Tue, 19 Mar 2019 20:43:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.239])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 18F775204F;
        Tue, 19 Mar 2019 20:43:00 +0000 (GMT)
Date:   Tue, 19 Mar 2019 22:42:54 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Philip Derrin <philip@cog.systems>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] ARM: mm: make use of new memblocks_present() helper
References: <20190319181357.9305-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319181357.9305-1-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19031920-0016-0000-0000-00000264DC73
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031920-0017-0000-0000-000032BFF2FF
Message-Id: <20190319204253.GB17966@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:13:57PM -0600, Logan Gunthorpe wrote:
> Cleanup the arm_memory_present() function seeing it's very
> similar to other arches.
> 
> The new memblocks_present() helper checks for node ids which the
> arm version did not. However, this is equivalent seeing
> HAVE_MEMBLOCK_NODE_MAP should be false in this arch and therefore
> memblock_get_region_node() should return 0.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Philip Derrin <philip@cog.systems>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Strangely, I've got a feeling I've already reviewed such patch from a
different person...

> ---
>  arch/arm/mm/init.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> This is just a resend.
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 478ea8b7db87..6c50dd407ba8 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -182,21 +182,6 @@ int pfn_valid(unsigned long pfn)
>  EXPORT_SYMBOL(pfn_valid);
>  #endif
> 
> -#ifndef CONFIG_SPARSEMEM
> -static void __init arm_memory_present(void)
> -{
> -}
> -#else
> -static void __init arm_memory_present(void)
> -{
> -	struct memblock_region *reg;
> -
> -	for_each_memblock(memory, reg)
> -		memory_present(0, memblock_region_memory_base_pfn(reg),
> -			       memblock_region_memory_end_pfn(reg));
> -}
> -#endif
> -
>  static bool arm_memblock_steal_permitted = true;
> 
>  phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
> @@ -292,7 +277,7 @@ void __init bootmem_init(void)
>  	 * Sparsemem tries to allocate bootmem in memory_present(),
>  	 * so must be done after the fixed reservations
>  	 */
> -	arm_memory_present();
> +	memblocks_present();
> 
>  	/*
>  	 * sparse_init() needs the bootmem allocator up and running.
> --
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

