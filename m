Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B370C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603022072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NqRKUwg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfLQSF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:05:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39966 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfLQSF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:05:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBHI530v060412;
        Tue, 17 Dec 2019 18:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=PnA+O2WHlJ9qIeDFCoWNNHW0kMXEE0RDJUlIQE2HWe8=;
 b=NqRKUwg3rgy8JIQxPBGzUjZcXWgZ0UoK8Q5okYw0FcUSU/RRngs/Wi2YOiqVlPF3mSaf
 Lh2GNvKZZ6wNE/cnvnngnWad0eH886vDIMODfPqnhXuKNJLCv/Hts3aCBttatQSmy8+G
 ujJmEbAza/IJGhRQDnUw6kn12xYKoJWHguOHINa1ZMvVG65ds+9cneBS86lNR8+PscBb
 Oj6IcH5gDVF/hZM44GE7/APzf9JKuVjLpgg7rj88SikgpbfhKv7yso+g5EAewEByZKhS
 Sk3WBPrxWqmAu6vLtKNX+FeOfIISQthW2E9rhCBAMug/99s6bWJyvbp570BjiuCn60sK CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wvrcr89tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 18:05:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBHI3bo9064825;
        Tue, 17 Dec 2019 18:05:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wxm72xpbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 18:05:10 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBHI58bb016553;
        Tue, 17 Dec 2019 18:05:08 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 10:05:07 -0800
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
To:     Michal Hocko <mhocko@kernel.org>, Waiman Long <longman@redhat.com>,
        Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com, Jarod Wilson <jarod@redhat.com>
References: <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
 <d6b9743c-776c-d740-73af-a600f15b910a@oracle.com>
 <79d3a7e1-384b-b759-cd84-56253fb9ed40@redhat.com>
 <20191216132658.GG30281@dhcp22.suse.cz>
 <98ac628d-f8be-270d-80bc-bf2373299caf@redhat.com>
 <21a92649-bb9f-b024-e52b-4ce9355f973b@redhat.com>
 <20191217090054.GA31063@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ca035fbb-752d-70ff-1be8-e2d2f90b3c0e@oracle.com>
Date:   Tue, 17 Dec 2019 10:05:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217090054.GA31063@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=929
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912170142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912170142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Eric

On 12/17/19 1:00 AM, Michal Hocko wrote:
> On Mon 16-12-19 13:44:53, Waiman Long wrote:
>> On 12/16/19 10:38 AM, Waiman Long wrote:
> [...]
>>>> Can you extract guts of the testcase and integrate them into hugetlb
>>>> test suite?
>>
>> BTW, what hugetlb test suite are you talking about?
> 
> I was using tests from libhugetlbfs package in the past. There are few
> tests in LTP project but the libhugetlbfs coverage used to cover the
> largest part of the functionality.
> 
> Is there any newer home for the package than [1], Mike? Btw. would it
> mak sense to migrate those tests to a more common place, LTP or kernel
> selftests?

That is the latest home/release for libhugetlbfs.

The libhugetlbfs test suite is somewhat strange in that I suspect it started
as testing for libhugetlbfs itself.  When it was written, the thought may have
been that people would use libhugetlfs as the primary interface to hugetlb
pages.  That is not the case today.  Over time, hugetlbfs tests not associated
with libhugetlbfs were added.

If we want to migrate libhugetlbfs tests, then I think we would only want to
migrate the non-libhugetlbfs test cases.  Although, the libhugetlbfs specific
tests are useful as they 'could' point out regressions.

Added Eric (libhugetlbfs maintainer) on Cc for another opinion.

> 
> [1] https://github.com/libhugetlbfs/libhugetlbfs/tree/master/tests
> 


-- 
Mike Kravetz
