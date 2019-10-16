Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878C7FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6782067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TDdl8b/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393552AbfJPPVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:21:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37930 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392877AbfJPPVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:21:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GF4lBs149062;
        Wed, 16 Oct 2019 15:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=1k/exljLrxFAW5tfrPeMCcZcoF6D571S9KzF3OmzfC8=;
 b=TDdl8b/hQnTmo4V3Sc3k+P1chL1cyQMGLN+bP2ef9psad4wdHM8KhoWjapkmtsRQZora
 cvF+xZdFWYrEo+YWfdhBh/lq48hH5nNpuD57S9DlY3lVy4JqxjXaOWBTPEatVnHPOfOL
 kGX1YVgkkM8PRZkg0S4sIBjgMGfRq5Al4l8EIhWNrJdBkNC6bbs08oR1ZKtaeMuBe/rD
 ECYVHYkW9bJk4PB2my5vDk+NwXx6OPnJoBqZmblGZExc4sPX9tW2fKHEo4bKlf0wjXAG
 qgdhz12CxUC8f/5keIn5p4AJATqSG25I0QpvWCF/DnKxTz9AMxU0wnQVu8vDyHDWzWY+ FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vk7frfk81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 15:21:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GF3Zd4042845;
        Wed, 16 Oct 2019 15:21:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vnf7tjwvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 15:21:46 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9GFLj01002476;
        Wed, 16 Oct 2019 15:21:45 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Oct 2019 08:21:45 -0700
Subject: Re: [PATCH] hugetlb: Fix clang compilation warning
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20191016142324.52250-1-vincenzo.frascino@arm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <29fdadee-2e0c-0886-73b3-358f983fd1fd@oracle.com>
Date:   Wed, 16 Oct 2019 08:21:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191016142324.52250-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=708
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910160130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=768 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/19 7:23 AM, Vincenzo Frascino wrote:
> Building the kernel with a recent version of clang I noticed the warning
> below:
> 
> mm/hugetlb.c:4055:40: warning: expression does not compute the number of
> elements in this array; element type is 'unsigned long', not 'u32'
> (aka 'unsigned int') [-Wsizeof-array-div]
>         hash = jhash2((u32 *)&key, sizeof(key)/sizeof(u32), 0);
>                                           ~~~ ^
> mm/hugetlb.c:4049:16: note: array 'key' declared here
>         unsigned long key[2];
>                       ^
> mm/hugetlb.c:4055:40: note: place parentheses around the 'sizeof(u32)'
> expression to silence this warning
>         hash = jhash2((u32 *)&key, sizeof(key)/sizeof(u32), 0);
>                                               ^  CC      fs/ext4/ialloc.o
> 
> Fix the warning adding parentheses around the sizeof(u32) expression.
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks,

However, this is already addressed in Andrew's tree.
https://ozlabs.org/~akpm/mmotm/broken-out/hugetlbfs-hugetlb_fault_mutex_hash-cleanup.patch

-- 
Mike Kravetz
