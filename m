Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C47AC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468882146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfEMI7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:59:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727401AbfEMI7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:59:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4D8qlIk132744
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:59:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sf55rrvrw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:59:05 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 13 May 2019 09:59:03 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 May 2019 09:58:58 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4D8wvf637159054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 08:58:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2957BAE056;
        Mon, 13 May 2019 08:58:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74B12AE055;
        Mon, 13 May 2019 08:58:55 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.235])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 13 May 2019 08:58:55 +0000 (GMT)
Date:   Mon, 13 May 2019 11:58:53 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        boot-architecture@lists.linaro.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513003819.356-2-hsinyi@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19051308-0028-0000-0000-0000036D0DA1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051308-0029-0000-0000-0000242C99BF
Message-Id: <20190513085853.GB9271@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 08:38:19AM +0800, Hsin-Yi Wang wrote:
> Currently in arm64, FDT is mapped to RO before it's passed to
> early_init_dt_scan(). However, there might be some code that needs
> to modify FDT during init. Map FDT to RW until unflatten DT.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  arch/arm64/kernel/setup.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 413d566405d1..08b22c1e72a9 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -179,9 +179,13 @@ static void __init smp_build_mpidr_hash(void)
>  		pr_warn("Large number of MPIDR hash buckets detected\n");
>  }
>  
> +extern void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size,
> +				       pgprot_t prot);
> +
>
>  static void __init setup_machine_fdt(phys_addr_t dt_phys)
>  {
> -	void *dt_virt = fixmap_remap_fdt(dt_phys);
> +	int size;
> +	void *dt_virt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
>  	const char *name;
  
This makes the fdt mapped without the call to meblock_reserve(fdt) which
makes the fdt memory available for memblock allocations.

Chances that is will be actually allocated are small, but you know, things
happen.

IMHO, instead of calling directly __fixmap_remap_fdt() it would be better
to add pgprot parameter to fixmap_remap_fdt(). Then here and in kaslr.c it
can be called with PAGE_KERNEL and below with PAGE_KERNEL_RO.

There is no problem to call memblock_reserve() for the same area twice,
it's essentially a NOP.
 
>  	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
> @@ -320,6 +324,9 @@ void __init setup_arch(char **cmdline_p)
>  	/* Parse the ACPI tables for possible boot-time configuration */
>  	acpi_boot_table_init();
>  
> +	/* remap fdt to RO */
> +	fixmap_remap_fdt(__fdt_pointer);
> +
>  	if (acpi_disabled)
>  		unflatten_device_tree();
>  
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

