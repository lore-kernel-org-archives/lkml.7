Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E7DC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6152147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CSOoOFmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfHEQzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:55:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59582 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfHEQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:55:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75GiGpV039612;
        Mon, 5 Aug 2019 16:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=AiaTx4RKmFmDRhFvPbii96+I2RlIDqHm4KrNnvPT2u0=;
 b=CSOoOFmzfLHDAKdLl74xlQAFf0qqaSWA0Jy+V82mmEXmE6i1X98vzhCO8kFn5IgwLuko
 3KqiIPAx8c5Ri17YNKlWNUKtja37et/tXJRXH3sTvMC0oIDWxlXWvBDiNCePg/k+H/y9
 YMya9tabSBUyrVgtRwswkL1zFE402XivlgzI3AxiwEzHXT6AcEUBNCw4gwQLX8DMM3hn
 ntGN2gO8CApvxyYzP5ovCBKpgfSLqhs/ldzrQiR8+k9m4LlvsNmQHJd0pvb3MYuOpgbJ
 MtBmxe90hEUBgDUQoKTg5mxLWaGpypmAD23wcspqqzlODjj+7RtneACpVf6+ysxWEfoR bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u51ptrk2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 16:54:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75GkrJB140464;
        Mon, 5 Aug 2019 16:54:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u51kmnj6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 16:54:52 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x75GskDR008576;
        Mon, 5 Aug 2019 16:54:46 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Aug 2019 09:54:46 -0700
Subject: Re: [PATCH 1/3] mm, reclaim: make should_continue_reclaim perform
 dryrun detection
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190802223930.30971-1-mike.kravetz@oracle.com>
 <20190802223930.30971-2-mike.kravetz@oracle.com>
 <bb16d3f0-0984-be32-4346-358abad92c4c@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e2252a42-063a-8f34-c300-9250d783b2fb@oracle.com>
Date:   Mon, 5 Aug 2019 09:54:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <bb16d3f0-0984-be32-4346-358abad92c4c@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=962
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908050184
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=987 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908050184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/19 1:42 AM, Vlastimil Babka wrote:
> On 8/3/19 12:39 AM, Mike Kravetz wrote:
>> From: Hillf Danton <hdanton@sina.com>
>>
>> Address the issue of should_continue_reclaim continuing true too often
>> for __GFP_RETRY_MAYFAIL attempts when !nr_reclaimed and nr_scanned.
>> This could happen during hugetlb page allocation causing stalls for
>> minutes or hours.
>>
>> We can stop reclaiming pages if compaction reports it can make a progress.
>> A code reshuffle is needed to do that.
> 
>> And it has side-effects, however,
>> with allocation latencies in other cases but that would come at the cost
>> of potential premature reclaim which has consequences of itself.
> 
> Based on Mel's longer explanation, can we clarify the wording here? e.g.:
> 
> There might be side-effect for other high-order allocations that would
> potentially benefit from more reclaim before compaction for them to be
> faster and less likely to stall, but the consequences of
> premature/over-reclaim are considered worse.
> 
>> We can also bail out of reclaiming pages if we know that there are not
>> enough inactive lru pages left to satisfy the costly allocation.
>>
>> We can give up reclaiming pages too if we see dryrun occur, with the
>> certainty of plenty of inactive pages. IOW with dryrun detected, we are
>> sure we have reclaimed as many pages as we could.
>>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Hillf Danton <hdanton@sina.com>
>> Tested-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Acked-by: Mel Gorman <mgorman@suse.de>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> I will send some followup cleanup.
> 
> There should be also Mike's SOB?

Will do.
My apologies, the process of handling patches created by others is new
to me.

Also, will incorporate Mel's explanation.
-- 
Mike Kravetz
