Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B6EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33832075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="El6ZUPgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKGTci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:32:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43170 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfKGTch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:32:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7JP2w3119269;
        Thu, 7 Nov 2019 19:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=tZ3pQcc3LeqFaEpO6hpLV/tKBa5ycbr9oiR/e6A4So4=;
 b=El6ZUPgq90XLasjGS2Mko2oSA6VAktVVmCi42MKqifTGLvf6gVcHmh0g01XAi48rPyx+
 gyB60cihjLlX1sG4OMeJaLomizt/0eEpGYB1R9l3GRwNb2QVjhtxDSR/OKY2nubFJUic
 3ewBLOMCHVTKRt+rQTkgHPTtkmmCIiC4iyRTVljwJ3QA5gwQ855teL+uqzpVQfBrrgna
 nR6C7PwWGD6ZaK86f8KsQ4gwGVu9TaEQ8Wytr92sOop/ck3m48s6Bi8DOiKxY4BHS0Bc
 dgHVohtV+oh7eUYyOZ6YyNzBB+6cx++RL4bVvBNdUiqUh/w9IS2k5cOC04+AoRXdvnyk Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w41w18jfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 19:32:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7JVibr156318;
        Thu, 7 Nov 2019 19:32:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2w41wfpde6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 19:32:12 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA7JVvVR002151;
        Thu, 7 Nov 2019 19:31:57 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 11:31:57 -0800
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <20191107190628.22667-1-longman@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ae9384e6-ac8d-8dd3-54c4-34d368c9515c@oracle.com>
Date:   Thu, 7 Nov 2019 11:31:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191107190628.22667-1-longman@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070184
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 11:06 AM, Waiman Long wrote:
> A customer with large SMP systems (up to 16 sockets) with application
> that uses large amount of static hugepages (~500-1500GB) are experiencing
> random multisecond delays. These delays was caused by the long time it
> took to scan the VMA interval tree with mmap_sem held.
> 
> The sharing of huge PMD does not require changes to the i_mmap at all.
> As a result, we can just take the read lock and let other threads
> searching for the right VMA to share in parallel. Once the right
> VMA is found, either the PMD lock (2M huge page for x86-64) or the
> mm->page_table_lock will be acquired to perform the actual PMD sharing.
> 
> Lock contention, if present, will happen in the spinlock. That is much
> better than contention in the rwsem where the time needed to scan the
> the interval tree is indeterminate.
> 
> With this patch applied, the customer is seeing significant improvements
> over the unpatched kernel.

Thanks for getting this tested in the customers environment!

> Signed-off-by: Waiman Long <longman@redhat.com>

Just a small typo in the comment, otherwise.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> ---
>  mm/hugetlb.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b45a95363a84..087e7ff00137 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4842,7 +4842,11 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
>  	if (!vma_shareable(vma, addr))
>  		return (pte_t *)pmd_alloc(mm, pud, addr);
>  
> -	i_mmap_lock_write(mapping);
> +	/*
> +	 * PMD sharing does not require changes to i_mmap. So a read lock
> +	 * is enuogh.

s/enuogh/enough/

> +	 */
> +	i_mmap_lock_read(mapping);
>  	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
>  		if (svma == vma)
>  			continue;
> @@ -4872,7 +4876,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
>  	spin_unlock(ptl);
>  out:
>  	pte = (pte_t *)pmd_alloc(mm, pud, addr);
> -	i_mmap_unlock_write(mapping);
> +	i_mmap_unlock_read(mapping);
>  	return pte;
>  }
>  
> 

-- 
Mike Kravetz
