Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44732CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1468D21479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eq0UIKx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbfJ1Vzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:55:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50466 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfJ1Vzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:55:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SLdedh130336;
        Mon, 28 Oct 2019 21:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=vW9HPKVYMznqHzF8geI9qQef2HKilZPmiEdrUsUJ6Ks=;
 b=Eq0UIKx91jjWil8T1A6jc/VIEHLt1oXjm7U+Y4vFJ8AmcPVJXc66x17iqaUQEChXE3/o
 jyjYrhagg5tuHOYcLDjVh/9mVroLzVrfUEAVWyApK+eXpM3nPo/1RvDkmb2plcjtpWqP
 t638uJ8rJHgt4oZa6UN9UCdROif13ewM2IwzkEXxdw2Dd8VauknTgIdx0bCSIiTW0Y30
 V4j2rK5Y0acric3eJ3sKiGdLhF+jbqsh7SLLxmRRyFDNhQtQukPKMTKpu2rjaYo00eQh
 azdStuF6XdYSjGQKaONEa1NgC/4MCaQBbCqEmIwDAQUj7sk4tTCKlMnHjn+Gyhidg+S7 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vvdju50s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 21:55:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SLh7wX136377;
        Mon, 28 Oct 2019 21:55:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vvyn0fp59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 21:55:22 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9SLtFuP000759;
        Mon, 28 Oct 2019 21:55:15 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 14:55:14 -0700
Subject: Re: [PATCH] mm: huge_pte_offset() returns pte_t *, not integer
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191016095111.29163-1-ben.dooks@codethink.co.uk>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <bd0ac181-7334-9970-b16a-ce7fd78d30ec@oracle.com>
Date:   Mon, 28 Oct 2019 14:55:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016095111.29163-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280203
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Andrew
There are already a few hugetlbfs cleanups in the mm tree.

On 10/16/19 2:51 AM, Ben Dooks (Codethink) wrote:
> The huge_pte_offset() returns a pte_t *, not an integer
> so when huge-tlb is off, the replacement inline macro
> should return a pte_t * too.
> 
> This fixes the following sparse warning:
> 
> mm/page_vma_mapped.c:156:29: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

That is simple enough,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/hugetlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 53fc34f930d0..e42c76aa1577 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -185,7 +185,7 @@ static inline void hugetlb_show_meminfo(void)
>  #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
>  #define hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
>  				src_addr, pagep)	({ BUG(); 0; })
> -#define huge_pte_offset(mm, address, sz)	0
> +#define huge_pte_offset(mm, address, sz)	(pte_t *)NULL
>  
>  static inline bool isolate_huge_page(struct page *page, struct list_head *list)
>  {
> 
