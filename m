Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293FCC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA40A2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eR4K+ubh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfKGVuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:50:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52764 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGVuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:50:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7Ln8UK033167;
        Thu, 7 Nov 2019 21:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=JOiMpIMuzkYYPmC19kfrXihQ9r3/nAyAF0rQELnGtrA=;
 b=eR4K+ubhN0/lrGO2pFeQKCgt0FG1+3rl3CuT9/oIA8tWurYylZTxlZxgbaCY9hmepMlW
 xxVXgBqsRTWzM99h2ofljbzzYEDEFmf0htjkCtLm/t7WIWEh7h42DEdIMIaFh/tAniEW
 lcrs9VKUPd05esnbaK8udEq6aTeMO3LcUutP48+okaqO4CcK4HbFM1vwmzBtvQ+vhj5Z
 o1VAeOqRTbVej2vhou2sWga3Qy+gbRwA28NP1MHTPneOO0v/+7gp8pBDmJ81CibJNm+J
 OThpHBFmuVCGyvktuJyi4PpmlANdEc4V7FahmV3uPXbf2C29ZM/9hRCBcqS+efi1ZcBw ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2w41w118rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 21:50:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7Ln6o9181290;
        Thu, 7 Nov 2019 21:49:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2w4k2x5hv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 21:49:59 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA7LnvNK003884;
        Thu, 7 Nov 2019 21:49:57 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 13:49:57 -0800
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ed46ef09-7766-eb80-a4ad-4c72d8dba188@oracle.com>
Date:   Thu, 7 Nov 2019 13:49:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191107195441.GF11823@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=982
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 11:54 AM, Matthew Wilcox wrote:
> Are there other current users of the write lock that could use a read lock?
> At first blush, it would seem that unmap_ref_private() also only needs
> a read lock on the i_mmap tree.  I don't think hugetlb_change_protection()
> needs the write lock either.  Nor retract_page_tables().

I believe that the semaphore still needs to be held in write mode while
calling huge_pmd_unshare (as is done in the call sites above).  Why?
There is this check for sharing in huge_pmd_unshare,

	if (page_count(virt_to_page(ptep)) == 1)
		return 0;	// implies no sharing

Note that huge_pmd_share now increments the page count with the semaphore
held just in read mode.  It is OK to do increments in parallel without
synchronization.  However, we don't want anyone else changing the count
while that check in huge_pmd_unshare is happening.  Hence, the need for
taking the semaphore in write mode.
-- 
Mike Kravetz
