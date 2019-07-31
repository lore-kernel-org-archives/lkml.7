Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C797EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9612A214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B0Qd5xiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfGaUan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:30:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57056 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbfGaUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:30:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VKSoAM132265;
        Wed, 31 Jul 2019 20:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ddt/5lIX8ayXJee9oBrOYZKI0vvRyww4PEGThS1SSUg=;
 b=B0Qd5xizm9MPOIcD6EMz0fNmp2ZoDoZk+e9yWF46v6CS+eA473vys0aQgvUgpQyvqIOq
 MpN90lyWRgLOotRkOU6lgwMIXO9NfimWzvRE4jEbQOd5QPi7FSesEcEhXedpeGr0ILd7
 IAzM726oSN8j3V2TmzHtjqQsIErJlL6fdK3s/9edgk4ZqFs3H0ViO/ZMuCA9zjml+Q/7
 6Vu/euxYGH1j2Ejy8z+QCnd1LmMA9wk2nHaR74swuy276E7FXajri8Ph1v0PK+S9xQHz
 JvT27ED2St/Yjvj0DFoMP/GvdYtsVqq3k9ArIH2eyBg86P50toMw5I3YE4oaNLLjtxRQ ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u0ejpqjs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 20:30:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VKRunI098149;
        Wed, 31 Jul 2019 20:30:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2u2exc2qaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 20:30:28 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6VKUJUA032445;
        Wed, 31 Jul 2019 20:30:19 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 13:30:19 -0700
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0942e0c2-ac06-948e-4a70-a29829cbcd9c@oracle.com>
Date:   Wed, 31 Jul 2019 13:30:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <278da9d8-6781-b2bc-8de6-6a71e879513c@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310205
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 5:06 AM, Vlastimil Babka wrote:
> On 7/24/19 7:50 PM, Mike Kravetz wrote:
>> For PAGE_ALLOC_COSTLY_ORDER allocations, MIN_COMPACT_COSTLY_PRIORITY is
>> minimum (highest priority).  Other places in the compaction code key off
>> of MIN_COMPACT_PRIORITY.  Costly order allocations will never get to
>> MIN_COMPACT_PRIORITY.  Therefore, some conditions will never be met for
>> costly order allocations.
>>
>> This was observed when hugetlb allocations could stall for minutes or
>> hours when should_compact_retry() would return true more often then it
>> should.  Specifically, this was in the case where compact_result was
>> COMPACT_DEFERRED and COMPACT_PARTIAL_SKIPPED and no progress was being
>> made.
> 
> Hmm, the point of MIN_COMPACT_COSTLY_PRIORITY was that costly
> allocations will not reach the priority where compaction becomes too
> expensive. With your patch, they still don't reach that priority value,
> but are allowed to be thorough anyway, even sooner. That just seems like
> a wrong way to fix the problem.

Thanks Vlastimil, here is why I took the approach I did.

I instrumented some of the long stalls.  Here is one common example:
should_compact_retry returned true 5000000 consecutive times.  However,
the variable compaction_retries is zero.  We never get to the code that
increments the compaction_retries count because compaction_made_progress
is false and compaction_withdrawn is true.  As suggested earlier, I noted
why compaction_withdrawn is true.  Of the 5000000 calls,
4921875 were COMPACT_DEFERRED
78125 were COMPACT_PARTIAL_SKIPPED
Note that 5000000/64(1 << COMPACT_MAX_DEFER_SHIFT) == 78125

I then started looking into why COMPACT_DEFERRED and COMPACT_PARTIAL_SKIPPED
were being set/returned so often.
COMPACT_DEFERRED is set/returned in try_to_compact_pages.  Specifically,
		if (prio > MIN_COMPACT_PRIORITY
					&& compaction_deferred(zone, order)) {
			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
			continue;
		}
COMPACT_PARTIAL_SKIPPED is set/returned in __compact_finished. Specifically,
	if (compact_scanners_met(cc)) {
		/* Let the next compaction start anew. */
		reset_cached_positions(cc->zone);

		/* ... */

		if (cc->direct_compaction)
			cc->zone->compact_blockskip_flush = true;

		if (cc->whole_zone)
			return COMPACT_COMPLETE;
		else
			return COMPACT_PARTIAL_SKIPPED;
	}

In both cases, compact_priority being MIN_COMPACT_COSTLY_PRIORITY and not
being able to go to MIN_COMPACT_PRIORITY caused the 'compaction_withdrawn'
result to be set/returned.

I do not know the subtleties of the compaction code, but it seems like
retrying in this manner does not make sense.

>                                 If should_compact_retry() returns
> misleading results for costly allocations, then that should be fixed
> instead?
> 
> Alternatively, you might want to say that hugetlb allocations are not
> like other random costly allocations, because the admin setting
> nr_hugepages is prepared to take the cost (I thought that was indicated
> by the __GFP_RETRY_MAYFAIL flag, but seeing all the other users of it,
> I'm not sure anymore).

The example above, resulted in a stall of a little over 5 minutes.  However,
I have seen them last for hours.  Sure, the caller (admin for hugetlbfs)
knows there may be high costs.  But, I think minutes/hours to try and allocate
a single huge page is too much.  We should fail sooner that that.

>                        In that case should_compact_retry() could take
> __GFP_RETRY_MAYFAIL into account and allow MIN_COMPACT_PRIORITY even for
> costly allocations.

I'll put something like this together to test.
-- 
Mike Kravetz
