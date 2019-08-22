Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4876CC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBF221848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfHVGk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:40:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728405AbfHVGk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:40:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7M6ajgD056934
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:40:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhnug0ac1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:40:54 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 22 Aug 2019 07:40:53 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 22 Aug 2019 07:40:49 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7M6eRIb38863218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 06:40:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B6FDAE04D;
        Thu, 22 Aug 2019 06:40:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DBFEAE045;
        Thu, 22 Aug 2019 06:40:47 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 22 Aug 2019 06:40:47 +0000 (GMT)
Date:   Thu, 22 Aug 2019 09:40:45 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chester Lin <clin@suse.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Gary Lin <GLin@suse.com>, Joey Lee <JLee@suse.com>
Subject: Re: [PATCH] arm: skip nomap memblocks while finding the
 lowmem/highmem boundary
References: <20190822034425.25899-1-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822034425.25899-1-clin@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19082206-0020-0000-0000-000003625C21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082206-0021-0000-0000-000021B79599
Message-Id: <20190822064045.GB18872@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 03:45:34AM +0000, Chester Lin wrote:
> adjust_lowmem_bounds() checks every memblocks in order to find the boundary
> between lowmem and highmem. However some memblocks could be marked as NOMAP
> so they are not used by kernel, which should be skipped while calculating
> the boundary.
> 
> Signed-off-by: Chester Lin <clin@suse.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/arm/mm/mmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 426d9085396b..b86dba44d828 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1181,6 +1181,9 @@ void __init adjust_lowmem_bounds(void)
>  		phys_addr_t block_start = reg->base;
>  		phys_addr_t block_end = reg->base + reg->size;
>  
> +		if (memblock_is_nomap(reg))
> +			continue;
> +
>  		if (reg->base < vmalloc_limit) {
>  			if (block_end > lowmem_limit)
>  				/*
> -- 
> 2.22.0
> 

-- 
Sincerely yours,
Mike.

