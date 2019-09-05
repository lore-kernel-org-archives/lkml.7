Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CBAC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C747206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dYXtS8J5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbfIEUyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:54:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42738 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfIEUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:54:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85KsKcK178893;
        Thu, 5 Sep 2019 20:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=LobIa40dQfX3Mwk3VFS2lCym9vgLwHXTJbr7YdB/OiA=;
 b=dYXtS8J5HRY0+pbcFqRdELFbQADyrvTgmyjjhgpNUDBxJkELpMVJKW/v/6I9NqgO1y3I
 gdXlqffIQzIsV2OLfzm6zJJElL2AbcAvOxhb/TubR/3Osmy90aqIhAUlCo1momVjqFl8
 vt5eM6ct4a8jGgKg9V8FIoJ3NfZcWLU1ermXvHlERSnZRb45cV20aDqt2HGgFcp8OcWH
 Fv+DnnZE/Uo8rQLvHNQCEjVszwKZzbqQNBvn6m9bTAJTwAZGE4zBMT7Ro15Nq+ieCnUP
 T7pAnBSo8qnixoQvDaV1vNzxc8YUcEo1DN55jaWKDRgNnRZrhhuZVOMKKwv8ehjX7EIN zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2uu9h3g30u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 20:54:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85KsP1M065217;
        Thu, 5 Sep 2019 20:54:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2utvr46tna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 20:54:38 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x85KrWxF014027;
        Thu, 5 Sep 2019 20:53:32 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Sep 2019 13:53:31 -0700
Subject: Re: [rfc 3/4] mm, page_alloc: avoid expensive reclaim when compaction
 may not succeed
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909041253390.94813@chino.kir.corp.google.com>
 <20190905090009.GF3838@dhcp22.suse.cz>
 <fab91766-da33-d62f-59fb-c226e4790a91@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3468b605-a3a9-6978-9699-57c52a90bd7e@oracle.com>
Date:   Thu, 5 Sep 2019 13:53:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fab91766-da33-d62f-59fb-c226e4790a91@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050195
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/19 4:22 AM, Vlastimil Babka wrote:
> On 9/5/19 11:00 AM, Michal Hocko wrote:
>> [Ccing Mike for checking on the hugetlb side of this change]
>> On Wed 04-09-19 12:54:22, David Rientjes wrote:
>>> @@ -4458,6 +4458,28 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>>>  		if (page)
>>>  			goto got_pg;
>>>  
>>> +		 if (order >= pageblock_order && (gfp_mask & __GFP_IO)) {
>>> +			/*
>>> +			 * If allocating entire pageblock(s) and compaction
>>> +			 * failed because all zones are below low watermarks
>>> +			 * or is prohibited because it recently failed at this
>>> +			 * order, fail immediately.
>>> +			 *
>>> +			 * Reclaim is
>>> +			 *  - potentially very expensive because zones are far
>>> +			 *    below their low watermarks or this is part of very
>>> +			 *    bursty high order allocations,
>>> +			 *  - not guaranteed to help because isolate_freepages()
>>> +			 *    may not iterate over freed pages as part of its
>>> +			 *    linear scan, and
>>> +			 *  - unlikely to make entire pageblocks free on its
>>> +			 *    own.
>>> +			 */
>>> +			if (compact_result == COMPACT_SKIPPED ||
>>> +			    compact_result == COMPACT_DEFERRED)
>>> +				goto nopage;
> 
> As I said, I expect this will make hugetlbfs reservations fail
> prematurely - Mike can probably confirm or disprove that.

I don't have a specific test for this.  It is somewhat common for people
to want to allocate "as many hugetlb pages as possible".  Therefore, they
will try to allocate more pages than reasonable for their environment and
take what they can get.  I 'tested' by simply creating some background
activity and then seeing how many hugetlb pages could be allocated.  Of
course, many tries over time in a loop.

This patch did not cause premature allocation failures in my limited testing.
The number of pages which could be allocated with and without patch were
pretty much the same.

Do note that I tested on top of Andrew's tree which contains this series:
http://lkml.kernel.org/r/20190806014744.15446-1-mike.kravetz@oracle.com
Patch 3 in that series causes allocations to fail sooner in the case of
COMPACT_DEFERRED:
http://lkml.kernel.org/r/20190806014744.15446-4-mike.kravetz@oracle.com

hugetlb allocations have the __GFP_RETRY_MAYFAIL flag set.  They are willing
to retry and wait and callers are aware of this.  Even though my limited
testing did not show regressions caused by this patch, I would prefer if the
quick exit did not apply to __GFP_RETRY_MAYFAIL requests.
-- 
Mike Kravetz
