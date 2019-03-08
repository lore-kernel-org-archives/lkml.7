Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888FCC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584CC20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LhpYaZ+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfCHXJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:09:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53208 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHXJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:09:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x28Mxf6F034820;
        Fri, 8 Mar 2019 23:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=MlrqfkIJzhllHP39N+GxECtianeHnH71ODnNMXPX7j0=;
 b=LhpYaZ+Cto/lOfYldn+yp+D/UxbGdR5bCd2Bvox/AruamCjVdbBiyYAVFlcourm04krB
 IRhYETgocaxPaGyG+Ncw/3WdLztXJjDCDw1dEgyjiPLWgUydc2Mcoptm9PHcXtI+GiSo
 pE2qLZLFdKQiGuSQb8Wl4YmBFhx3dFQ1qPiauV9iZO6DAAqSuJ2wjSqHxoRpzWp/pq5L
 i4z5fsCxb/tq7ki1RN3PZ6r/iH1v7EnD417dQqj00EnR3NRN4ljJEf6umS6nCnmk/sUc
 HzoIb6/lcC3LttflgYPCJAF1Eh3Lu12zZjKds173TcPnKmMoYuIgsyph648c96bLNTpp cw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qyh8utx7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 23:09:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x28N915f031222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 23:09:02 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x28N8xpB016212;
        Fri, 8 Mar 2019 23:08:59 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Mar 2019 15:08:59 -0800
Subject: Re: [PATCH 2/2] hugetlb: use same fault hash key for shared and
 private mappings
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190308224823.15051-1-mike.kravetz@oracle.com>
 <20190308224823.15051-3-mike.kravetz@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b3741e5a-2421-1f86-b688-58dc9bd501d2@oracle.com>
Date:   Fri, 8 Mar 2019 15:08:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190308224823.15051-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9189 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=796 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 2:48 PM, Mike Kravetz wrote:
>  mm/hugetlb.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 64ef640126cd..0527732c71f0 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3904,13 +3904,8 @@ u32 hugetlb_fault_mutex_hash(struct hstate *h, struct mm_struct *mm,
>  	unsigned long key[2];
>  	u32 hash;
>  
> -	if (vma->vm_flags & VM_SHARED) {
> -		key[0] = (unsigned long) mapping;
> -		key[1] = idx;
> -	} else {
> -		key[0] = (unsigned long) mm;
> -		key[1] = address >> huge_page_shift(h);
> -	}
> +	key[0] = (unsigned long) mapping;
> +	key[1] = idx;
>  
>  	hash = jhash2((u32 *)&key, sizeof(key)/sizeof(u32), 0);

Duh!

If we no longer use mm and address they can be dropped from the function
arguments and all callers.  Before doing that, let's see if there is any
objection to using the same key for shared and private mappings.

-- 
Mike Kravetz
