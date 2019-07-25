Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70478C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAFE218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="plsu6r8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfGYVLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:11:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55166 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfGYVLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:11:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PGv9ND008688;
        Thu, 25 Jul 2019 17:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BXt4ZTjon02rBlSAS5SUMkhrj4K/BTJhzHlU3Vmid/s=;
 b=plsu6r8RTf9N+SMlN9Cxk32QxhiS3IWD++laWBrE8vbiVMS2WYlw/FGHZscInnbveUY5
 3SaBY7qToy5VICuPGo5YBzgBE8zsjvkd4ZtFqiwVX1A8gokTU3/uVO1nSOMF/7EHLJsJ
 Xul9KEad+cKUWgutVTDtsVNklntSE0ZYfbqvj/fLER20Sr5IstrN0zuQsXxHhahNOIWJ
 LyA9keeYdZz6a0WtmftUdHjZY+zN94LNlR+G3n2ao/G/O30ay8mkmEAQsA4NBSzpy4Ld
 NsyDVh5XKx5HvyRcimnEYnX8kCptmJGweNNxkcyYTnDkWt0sYgZKkGDHYDaP6+D5A98/ lQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tx61c5e6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 17:15:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PFwHsM078851;
        Thu, 25 Jul 2019 17:15:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tx60yemca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 17:15:36 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6PHFUGZ008590;
        Thu, 25 Jul 2019 17:15:31 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jul 2019 10:15:30 -0700
Subject: Re: [RFC PATCH 3/3] hugetlbfs: don't retry when pool page allocations
 start to fail
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190724175014.9935-1-mike.kravetz@oracle.com>
 <20190724175014.9935-4-mike.kravetz@oracle.com>
 <20190725081350.GD2708@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6a7f3705-9550-e22f-efa1-5e3616351df6@oracle.com>
Date:   Thu, 25 Jul 2019 10:15:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190725081350.GD2708@suse.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 1:13 AM, Mel Gorman wrote:
> On Wed, Jul 24, 2019 at 10:50:14AM -0700, Mike Kravetz wrote:
>> When allocating hugetlbfs pool pages via /proc/sys/vm/nr_hugepages,
>> the pages will be interleaved between all nodes of the system.  If
>> nodes are not equal, it is quite possible for one node to fill up
>> before the others.  When this happens, the code still attempts to
>> allocate pages from the full node.  This results in calls to direct
>> reclaim and compaction which slow things down considerably.
>>
>> When allocating pool pages, note the state of the previous allocation
>> for each node.  If previous allocation failed, do not use the
>> aggressive retry algorithm on successive attempts.  The allocation
>> will still succeed if there is memory available, but it will not try
>> as hard to free up memory.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> set_max_huge_pages can fail the NODEMASK_ALLOC() alloc which you handle
> *but* in the event of an allocation failure this bug can silently recur.
> An informational message might be justified in that case in case the
> stall should recur with no hint as to why.

Right.
Perhaps a NODEMASK_ALLOC() failure should just result in a quick exit/error.
If we can't allocate a node mask, it is unlikely we will be able to allocate
a/any huge pages.  And, the system must be extremely low on memory and there
are likely other bigger issues.

There have been discussions elsewhere about discontinuing the use of
NODEMASK_ALLOC() and just putting the mask on the stack.  That may be
acceptable here as well.

>                                            Technically passing NULL into
> NODEMASK_FREE is also safe as kfree (if used for that kernel config) can
> handle freeing of a NULL pointer. However, that is cosmetic more than
> anything. Whether you decide to change either or not;

Yes.
I will clean up with an updated series after more feedback.

> 
> Acked-by: Mel Gorman <mgorman@suse.de>
> 

Thanks!
-- 
Mike Kravetz
