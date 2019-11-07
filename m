Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66D8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903E5214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lyUHD3j2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKGV5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:57:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55112 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfKGV5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:57:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7LsAw3049731;
        Thu, 7 Nov 2019 21:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Dik0Wbe8xfvCNxL25I+EKXZS20yL32hP2fDZMMFGX1A=;
 b=lyUHD3j2VvWy9gKAnjTce0sXewOpRzlQTUJ9AeNzq3S8JE8VbPdto+CmegDOGxZPrQsk
 rCvSF9tWOvzTcHYbot4PgSVMW+iafPntyHSunac96TSKI4r7IuVJSqicr8Wo8XRcoMiq
 MuGODM6I8qtYIvQJAn+JWS7uoLqpyyugVL4qGsT3HkzVp555bWIZzzawexDcRgkREhVf
 SEzpRiavA9o7VBbC1cjAdEbJL3/TpX0NuNqKj+SydMUEd9muzxE3RLfj3/zJsrCZ1mDd
 NBuS6G0H2VLavVDOviaDWktdJoK0Tt030WwyJ+bkipfGtPS1ICQLqwSO5TGe81owuvU3 aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2w41w19a7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 21:56:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7LsG4p196563;
        Thu, 7 Nov 2019 21:56:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2w4k2x6egg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 21:56:47 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA7Luj0B016191;
        Thu, 7 Nov 2019 21:56:45 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 13:56:45 -0800
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <20191107190628.22667-1-longman@redhat.com>
 <20191107195441.GF11823@bombadil.infradead.org>
 <ed46ef09-7766-eb80-a4ad-4c72d8dba188@oracle.com>
Message-ID: <136eb24b-049e-9ebf-598d-1292d61d49fd@oracle.com>
Date:   Thu, 7 Nov 2019 13:56:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <ed46ef09-7766-eb80-a4ad-4c72d8dba188@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070202
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 1:49 PM, Mike Kravetz wrote:
> On 11/7/19 11:54 AM, Matthew Wilcox wrote:
>> Are there other current users of the write lock that could use a read lock?
>> At first blush, it would seem that unmap_ref_private() also only needs
>> a read lock on the i_mmap tree.  I don't think hugetlb_change_protection()
>> needs the write lock either.  Nor retract_page_tables().

Sorry, I missed retract_page_tables which is not part of hugetlb code.
The comments below do not apply to retract_page_tables.  Someone would
need to take a closer look to see if that really needs write mode.
-- 
Mike Kravetz

> 
> I believe that the semaphore still needs to be held in write mode while
> calling huge_pmd_unshare (as is done in the call sites above).  Why?
> There is this check for sharing in huge_pmd_unshare,
> 
> 	if (page_count(virt_to_page(ptep)) == 1)
> 		return 0;	// implies no sharing
> 
> Note that huge_pmd_share now increments the page count with the semaphore
> held just in read mode.  It is OK to do increments in parallel without
> synchronization.  However, we don't want anyone else changing the count
> while that check in huge_pmd_unshare is happening.  Hence, the need for
> taking the semaphore in write mode.
> 
