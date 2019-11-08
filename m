Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7D6FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C089720673
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SgKfRGUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391156AbfKHTKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:10:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57512 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388018AbfKHTKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:10:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8J3vtK078095;
        Fri, 8 Nov 2019 19:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=hbg3DDTni8M/rgsCn9U3MFMumS+aykGsqnuwmha715Q=;
 b=SgKfRGUD9CKmat/E11tN9oQZS82RkjlOAlHJdjRXdGBhN1Tajtr1paOCnZPHrzzyiJfG
 ry+0wQoI8ZLUMr23Jtr1TRf/qofz1gX+sf27/uQf0LU7a+nITKZi8Q5aL0pbutvVMj/B
 3TaiK6BG3Mjkmg67LwGFuAWBNBdsRtRFFSItHSUPUuW7bHjiN4v+mgEFME5pcBTuU5A/
 nobU0FqHHrDxCJvsn9zqw9DrBP2u0DOCpMMZYc1q+GR7yARCnRvA3tYJ0OC3FptNteax
 8LV0pZzBbQ1/kostYEQcloeuUzuPHU1D8CGNFlMNZSUriMj2yWv06/9hCMA7cA2pP9LU /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2w41w175sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 19:10:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8J2q8w117672;
        Fri, 8 Nov 2019 19:10:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2w4k33v07c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 19:10:26 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA8JAOBA010812;
        Fri, 8 Nov 2019 19:10:24 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 11:10:24 -0800
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
To:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <20191107190628.22667-1-longman@redhat.com>
 <20191107195441.GF11823@bombadil.infradead.org>
 <ed46ef09-7766-eb80-a4ad-4c72d8dba188@oracle.com>
 <20191108020456.sulyjskhq3s5zcaa@linux-p48b>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ea057d15-5205-9992-af95-b2727df577c4@oracle.com>
Date:   Fri, 8 Nov 2019 11:10:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191108020456.sulyjskhq3s5zcaa@linux-p48b>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080187
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 6:04 PM, Davidlohr Bueso wrote:
> On Thu, 07 Nov 2019, Mike Kravetz wrote:
> 
>> Note that huge_pmd_share now increments the page count with the semaphore
>> held just in read mode.  It is OK to do increments in parallel without
>> synchronization.  However, we don't want anyone else changing the count
>> while that check in huge_pmd_unshare is happening.  Hence, the need for
>> taking the semaphore in write mode.
> 
> This would be a nice addition to the changelog methinks.

Last night I remembered there is one place where we currently take
i_mmap_rwsem in read mode and potentially call huge_pmd_unshare.  That
is in try_to_unmap_one.  Yes, there is a potential race here today.
But that race is somewhat contained as you need two threads doing some
combination of page migration and page poisoning to race.  This change
now allows migration or poisoning to race with page fault.  I would
really prefer if we do not open up the race window in this manner.

Getting this right in the try_to_unmap_one case is a bit tricky.  I had
code to do this in the past that was part of a bigger hugetlb synchronization
change.  All those changes got reverted (commit ddeaab32a89f), but I
believe it is possible to change try_to_unmap_one calling sequences
without introducing other issues.

Bottom line is that more changes are needed in this patch.  I'll work
on those changes unless someone else volunteers.  It will likely take me
one or two days to come up with and test proposed changes.
-- 
Mike Kravetz
