Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AA5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF96206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKKLds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:33:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbfKKLds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:33:48 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABBXKFC036678;
        Mon, 11 Nov 2019 06:33:26 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w76aq9hhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 06:33:26 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xABBXP3F037122;
        Mon, 11 Nov 2019 06:33:25 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w76aq9h51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 06:33:25 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xABBUr2o002969;
        Mon, 11 Nov 2019 11:32:56 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2w5n361psm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 11:32:56 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xABBWtD454788524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 11:32:55 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 871B928059;
        Mon, 11 Nov 2019 11:32:55 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 547E028058;
        Mon, 11 Nov 2019 11:32:50 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.36.163])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Nov 2019 11:32:49 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 Q)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc/mm: Initialize the HPTE encoding values
In-Reply-To: <20190830120712.22971-2-ldufour@linux.ibm.com>
References: <20190830120712.22971-1-ldufour@linux.ibm.com> <20190830120712.22971-2-ldufour@linux.ibm.com>
Date:   Thu, 12 Sep 2019 19:02:40 +0530
Message-ID: <87v9txzll3.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:

> Before reading the HPTE encoding values we initialize all of them to -1 (an
> invalid value) to later being able to detect the initialized ones.
>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

We already do this in mmu_psize_set_default_penc() ?

> ---
>  arch/powerpc/mm/book3s64/hash_utils.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> index c3bfef08dcf8..2039bc315459 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -408,7 +408,7 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
>  {
>  	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
>  	const __be32 *prop;
> -	int size = 0;
> +	int size = 0, idx, base_idx;
>  
>  	/* We are scanning "cpu" nodes only */
>  	if (type == NULL || strcmp(type, "cpu") != 0)
> @@ -418,6 +418,11 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
>  	if (!prop)
>  		return 0;
>  
> +	/* Set all the penc values to invalid */
> +	for (base_idx = 0; base_idx < MMU_PAGE_COUNT; base_idx++)
> +		for (idx = 0; idx < MMU_PAGE_COUNT; idx++)
> +			mmu_psize_defs[base_idx].penc[idx] = -1;
> +
>  	pr_info("Page sizes from device-tree:\n");
>  	size /= 4;
>  	cur_cpu_spec->mmu_features &= ~(MMU_FTR_16M_PAGE);
> @@ -426,7 +431,6 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
>  		unsigned int slbenc = be32_to_cpu(prop[1]);
>  		unsigned int lpnum = be32_to_cpu(prop[2]);
>  		struct mmu_psize_def *def;
> -		int idx, base_idx;
>  
>  		size -= 3; prop += 3;
>  		base_idx = get_idx_from_shift(base_shift);
> -- 
> 2.23.0
