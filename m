Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50AAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E86A22CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfH0HcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:32:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbfH0HcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:32:18 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7R7WCRA118696
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 03:32:17 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umw4wp68w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 03:32:16 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 27 Aug 2019 08:32:05 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Aug 2019 08:32:01 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7R7Vc0m37290412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 07:31:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A664711C10F;
        Tue, 27 Aug 2019 07:32:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB49711C112;
        Tue, 27 Aug 2019 07:31:59 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Aug 2019 07:31:59 +0000 (GMT)
Date:   Tue, 27 Aug 2019 10:31:58 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Qian Cai <cai@lca.pw>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Don't manually decrement num_poisoned_pages
References: <20190827053656.32191-1-alastair@au1.ibm.com>
 <20190827053656.32191-2-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827053656.32191-2-alastair@au1.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19082707-0012-0000-0000-0000034361AD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082707-0013-0000-0000-0000217D98DC
Message-Id: <20190827073157.GB682@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:36:54PM +1000, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Use the function written to do it instead.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/sparse.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 72f010d9bff5..e41917a7e844 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -11,6 +11,8 @@
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
>  
>  #include "internal.h"
>  #include <asm/dma.h>
> @@ -898,7 +900,7 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
>  
>  	for (i = 0; i < nr_pages; i++) {
>  		if (PageHWPoison(&memmap[i])) {
> -			atomic_long_sub(1, &num_poisoned_pages);
> +			num_poisoned_pages_dec();
>  			ClearPageHWPoison(&memmap[i]);
>  		}
>  	}
> -- 
> 2.21.0
> 

-- 
Sincerely yours,
Mike.

