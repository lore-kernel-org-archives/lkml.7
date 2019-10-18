Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86956CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E64421897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634265AbfJRPF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:05:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388698AbfJRPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:05:28 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9IEvmLr024085
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:05:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vqcbmqjx9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:05:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Fri, 18 Oct 2019 16:05:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Oct 2019 16:05:20 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9IF5Iev52625434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 15:05:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BF9111C04A;
        Fri, 18 Oct 2019 15:05:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCEF311C04C;
        Fri, 18 Oct 2019 15:05:16 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.85.142.84])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 18 Oct 2019 15:05:16 +0000 (GMT)
Date:   Fri, 18 Oct 2019 08:05:14 -0700
From:   Ram Pai <linuxram@us.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Mike Anderson <andmike@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        mpe@ellerman.id.au
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20190911163433.12822-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911163433.12822-1-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19101815-4275-0000-0000-000003735A66
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101815-4276-0000-0000-000038867714
Message-Id: <20191018150514.GB5238@oc0525413822.ibm.com>
Subject: Re:  [PATCH] powerpc/prom_init: Undo relocation before entering secure mode
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910180139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 01:34:33PM -0300, Thiago Jung Bauermann wrote:
> The ultravisor will do an integrity check of the kernel image but we
> relocated it so the check will fail. Restore the original image by
> relocating it back to the kernel virtual base address.
> 
> This works because during build vmlinux is linked with an expected virtual
> runtime address of KERNELBASE.
> 
> Fixes: 6a9c930bd775 ("powerpc/prom_init: Add the ESM call to prom_init")
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Tested-by: Ram Pai <linuxram@us.ibm.com>


> ---
>  arch/powerpc/include/asm/elf.h         |  3 +++
>  arch/powerpc/kernel/prom_init.c        | 11 +++++++++++
>  arch/powerpc/kernel/prom_init_check.sh |  3 ++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
> index 409c9bfb43d9..57c229a86f08 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -175,4 +175,7 @@ do {									\
>  	ARCH_DLINFO_CACHE_GEOMETRY;					\
>  } while (0)
> 
> +/* Relocate the kernel image to @final_address */
> +void relocate(unsigned long final_address);
> +
>  #endif /* _ASM_POWERPC_ELF_H */
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 74f70f90eff0..44b1d404250e 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -3249,7 +3249,18 @@ static void setup_secure_guest(unsigned long kbase, unsigned long fdt)
>  	/* Switch to secure mode. */
>  	prom_printf("Switching to secure mode.\n");
> 
> +	/*
> +	 * The ultravisor will do an integrity check of the kernel image but we
> +	 * relocated it so the check will fail. Restore the original image by
> +	 * relocating it back to the kernel virtual base address.
> +	 */
> +	relocate(KERNELBASE);
> +
>  	ret = enter_secure_mode(kbase, fdt);
> +
> +	/* Relocate the kernel again. */
> +	relocate(kbase);
> +
>  	if (ret != U_SUCCESS) {
>  		prom_printf("Returned %d from switching to secure mode.\n", ret);
>  		prom_rtas_os_term("Switch to secure mode failed.\n");
> diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
> index 160bef0d553d..16535ccc0fa0 100644
> --- a/arch/powerpc/kernel/prom_init_check.sh
> +++ b/arch/powerpc/kernel/prom_init_check.sh
> @@ -26,7 +26,8 @@ _end enter_prom $MEM_FUNCS reloc_offset __secondary_hold
>  __secondary_hold_acknowledge __secondary_hold_spinloop __start
>  logo_linux_clut224 btext_prepare_BAT
>  reloc_got2 kernstart_addr memstart_addr linux_banner _stext
> -__prom_init_toc_start __prom_init_toc_end btext_setup_display TOC."
> +__prom_init_toc_start __prom_init_toc_end btext_setup_display TOC.
> +relocate"
> 
>  NM="$1"
>  OBJ="$2"

-- 
Ram Pai

