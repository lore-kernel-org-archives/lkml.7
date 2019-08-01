Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA53C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C948206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wv/oDHey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfHAUdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:33:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39656 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHAUdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:33:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x71KSLqj133217;
        Thu, 1 Aug 2019 20:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6xycjKuoswkI3FDwNMe3S7sf751k8TRmInp/HgRG2MU=;
 b=wv/oDHeyvBT0sPyOQx7oO3lLMjIG5xHqdsGqoVf6Eh6PmhHRfwkdcJw/9psrj2DmFIFp
 PbNJO2w1S7CTXJAUhyNNYh9qvCYXUDeqRyhlsrlxn1LS9W+iMc4qs+dZyiM4Oj5cVfTr
 4kYf1d+L6rJjF6UoO3vvryhdryEVBxKWw2KuwdGzEleFEseJCjYd8OcfH+C/0b+WbvwI
 M2qEtowCyQpAZhgEsOVHJyB9msWXiS8Dy9LfUYu6Q6K41eiUILbox1I68rgtacJsw7Hn
 prTXWnLNQkoI4myh+uXP8mWepMOfs5Bu1MUYU5HxP/LT6pdkDU4ZZRpEqmat0jfi7EBN UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u0ejpx50e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Aug 2019 20:33:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x71KWudn053509;
        Thu, 1 Aug 2019 20:33:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2u2jp6jfk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Aug 2019 20:33:06 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x71KX3A9010841;
        Thu, 1 Aug 2019 20:33:03 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Aug 2019 13:33:03 -0700
Subject: Re: [RFC PATCH 2/3] mm, compaction: use MIN_COMPACT_COSTLY_PRIORITY
 everywhere for costly orders
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190724175014.9935-1-mike.kravetz@oracle.com>
 <20190724175014.9935-3-mike.kravetz@oracle.com>
 <278da9d8-6781-b2bc-8de6-6a71e879513c@suse.cz>
 <0942e0c2-ac06-948e-4a70-a29829cbcd9c@oracle.com>
 <89ba8e07-b0f8-4334-070e-02fbdfc361e3@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2f1d6779-2b87-4699-abf7-0aa59a2e74d9@oracle.com>
Date:   Thu, 1 Aug 2019 13:33:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <89ba8e07-b0f8-4334-070e-02fbdfc361e3@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908010216
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908010215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/19 6:01 AM, Vlastimil Babka wrote:
> Could you try testing the patch below instead? It should hopefully
> eliminate the stalls. If it makes hugepage allocation give up too early,
> we'll know we have to involve __GFP_RETRY_MAYFAIL in allowing the
> MIN_COMPACT_PRIORITY priority. Thanks!

Thanks.  This patch does eliminate the stalls I was seeing.

In my testing, there is little difference in how many hugetlb pages are
allocated.  It does not appear to be giving up/failing too early.  But,
this is only with __GFP_RETRY_MAYFAIL.  The real concern would with THP
requests.  Any suggestions on how to test that?

-- 
Mike Kravetz

> ----8<----
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 9569e7c786d3..b8bfe8d5d2e9 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -129,11 +129,7 @@ static inline bool compaction_failed(enum compact_result result)
>  	return false;
>  }
>  
> -/*
> - * Compaction  has backed off for some reason. It might be throttling or
> - * lock contention. Retrying is still worthwhile.
> - */
> -static inline bool compaction_withdrawn(enum compact_result result)
> +static inline bool compaction_needs_reclaim(enum compact_result result)
>  {
>  	/*
>  	 * Compaction backed off due to watermark checks for order-0
> @@ -142,6 +138,15 @@ static inline bool compaction_withdrawn(enum compact_result result)
>  	if (result == COMPACT_SKIPPED)
>  		return true;
>  
> +	return false;
> +}
> +
> +/*
> + * Compaction  has backed off for some reason. It might be throttling or
> + * lock contention. Retrying is still worthwhile.
> + */
> +static inline bool compaction_withdrawn(enum compact_result result)
> +{
>  	/*
>  	 * If compaction is deferred for high-order allocations, it is
>  	 * because sync compaction recently failed. If this is the case
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 272c6de1bf4e..3dfce1f79112 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3965,6 +3965,11 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  	if (compaction_failed(compact_result))
>  		goto check_priority;
>  
> +	if (compaction_needs_reclaim(compact_result)) {
> +		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
> +		goto out;
> +	}
> +
>  	/*
>  	 * make sure the compaction wasn't deferred or didn't bail out early
>  	 * due to locks contention before we declare that we should give up.
> @@ -3972,8 +3977,7 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  	 * compaction.
>  	 */
>  	if (compaction_withdrawn(compact_result)) {
> -		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
> -		goto out;
> +		goto check_priority;
>  	}
>  
>  	/*
> 
