Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E96CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0125B20880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TQQ9v9pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfHERMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:12:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54134 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHERMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:12:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75H3sjK061339;
        Mon, 5 Aug 2019 17:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=M9bY9Pzah3vwaWk6X2k5w90BuewkWsP/a3iHmuqn4vU=;
 b=TQQ9v9pEOnPEMUzjiwi5MhXEN+ROGs4/CPuW+WytrSx8AuAaSlFVE4Bov/MLshh3lxHo
 AM6p325OZus1x8S7qc2Ogvcl4fXYJGFl7w1156tSSoQhiPnUOu0Du3jCINBxd6ouU8S/
 IDAnhP9a4LttZwTBzvaGEmBZmTa1E0DZOu0+1ejqANDXzNe9o+WK2AK+mGZ9ftkJGo7H
 iqMf2OWXmw1WYLaEq6RfVUum3HiBeHCE7cvpSfFIC+hfdIfTzJAb5yG2ZgRMtvFyzXN5
 V3m7WZ1YzF4Qicfm+Srafye8yBK3uErKDqugpWUTkBCCAqvP+S6doBwMw8tN/v8yhtJP UQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u51ptrpd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 17:12:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75H6WBe000838;
        Mon, 5 Aug 2019 17:12:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u50abxx9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 17:12:05 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x75HC1OG030472;
        Mon, 5 Aug 2019 17:12:01 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Aug 2019 10:12:01 -0700
Subject: Re: [PATCH 3/3] hugetlbfs: don't retry when pool page allocations
 start to fail
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190802223930.30971-1-mike.kravetz@oracle.com>
 <20190802223930.30971-4-mike.kravetz@oracle.com>
 <b7cb558b-ae88-ae87-425a-18f9f1553f00@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <dfb0f20f-7a2d-3228-5c0d-9da4793f575c@oracle.com>
Date:   Mon, 5 Aug 2019 10:12:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b7cb558b-ae88-ae87-425a-18f9f1553f00@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908050185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908050185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/19 2:28 AM, Vlastimil Babka wrote:
> On 8/3/19 12:39 AM, Mike Kravetz wrote:
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
> Looks like only part of the (agreed with) suggestions were implemented?

My bad, I pulled in the wrong patch.

> - set_max_huge_pages() returns -ENOMEM if nodemask can't be allocated,
> but hugetlb_hstate_alloc_pages() doesn't.

That is somewhat intentional.  The calling context of the two routines is
significantly different.   hugetlb_hstate_alloc_pages is called at boot time
to handle command line parameters.  And, hugetlb_hstate_alloc_pages does not
return a value as it is of type void.

We 'could' print out a warning here.  But, if we can't allocate a node mask
I am pretty sure we will not be able to boot.  I will add a comment.

> - there's still __GFP_NORETRY in nodemask allocations
> - (cosmetics) Mel pointed out that NODEMASK_FREE() works fine with NULL
> pointers

-- 
Mike Kravetz
