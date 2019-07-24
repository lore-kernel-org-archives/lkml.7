Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD30DC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EDF2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4rBK7kYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfGXSYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:24:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40492 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387480AbfGXSYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:24:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OIOEQ6084431;
        Wed, 24 Jul 2019 18:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=F3bCNko/rlePxa3FH2qI7hAkpjKGdcXc+ZaXjXWxwWs=;
 b=4rBK7kYk81nIlg+q6ud+iGNCmIEvwySL4JpAGr5Kd6GCcPqEvkp4UpknCHXhCMv5AxV1
 WDbzijod6es/JLIdMfu3FRoHeey8drmLBnc5H0V6B1zkrwOstFmIiTpJvQJbkGRXXMZp
 f9k2X5Dt/UbqAJioyixCLfmGHYkgrbe+vUpD9UenMNBsWxSCI+9qT9ooULHlPjhe5dqw
 1K4qYCmcwCiWImUe6iMzGzBg17g6cWqiGTAZWUaa4xI9++WKZKyYKBlMFvVEM267mh3I
 DkvAS1OuOu0LVNuArAHvmbYFKpbWI+urqDSZiKXMVeccExMcOY/IsJ8qw9LiMBgJMqX4 AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tx61by5eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 18:24:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OICkCE099366;
        Wed, 24 Jul 2019 18:24:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tx60xvpar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 18:24:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6OIOBW1013593;
        Wed, 24 Jul 2019 18:24:11 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 11:24:11 -0700
Subject: Re: [PATCH] mm/rmap.c: remove set but not used variable 'cstart'
To:     YueHaibing <yuehaibing@huawei.com>, akpm@linux-foundation.org,
        jglisse@redhat.com, kirill.shutemov@linux.intel.com,
        rcampbell@nvidia.com, ktkhai@virtuozzo.com,
        colin.king@canonical.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20190724141453.38536-1-yuehaibing@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <10d2821c-cc56-961b-8f43-ae9097ed0621@oracle.com>
Date:   Wed, 24 Jul 2019 11:24:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190724141453.38536-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240195
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/19 7:14 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> mm/rmap.c: In function page_mkclean_one:
> mm/rmap.c:906:17: warning: variable cstart set but not used [-Wunused-but-set-variable]
> 
> It is not used any more since
> commit cdb07bdea28e ("mm/rmap.c: remove redundant variable cend")

It appears Commit 0f10851ea475 ("mm/mmu_notifier: avoid double notification
when it is useless") is what removed the use of cstart and cend.  And, they
should have been removed then.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  mm/rmap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index ec1af8b..40e4def 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -903,10 +903,9 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
>  	mmu_notifier_invalidate_range_start(&range);
>  
>  	while (page_vma_mapped_walk(&pvmw)) {
> -		unsigned long cstart;
>  		int ret = 0;
>  
> -		cstart = address = pvmw.address;
> +		address = pvmw.address;
>  		if (pvmw.pte) {
>  			pte_t entry;
>  			pte_t *pte = pvmw.pte;
> @@ -933,7 +932,6 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
>  			entry = pmd_wrprotect(entry);
>  			entry = pmd_mkclean(entry);
>  			set_pmd_at(vma->vm_mm, address, pmd, entry);
> -			cstart &= PMD_MASK;
>  			ret = 1;
>  #else
>  			/* unexpected pmd-mapped page? */
> 
