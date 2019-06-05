Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAABC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F9C206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RwobizMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfFEQFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:05:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59068 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFEQFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:05:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55FxDiW087274;
        Wed, 5 Jun 2019 16:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1vdDqwlpsmUpFZr2sH68Dl3KCcVcT+dZOWpsdlqCuuk=;
 b=RwobizMb+qO6Ig04WCxpayxl+qZzJtAGKgx+NxYcyWIUmpDmSWlDwyar655Jr4coh3/N
 hy1cFArG3e41Hst86GQWrpoAqTGLpd8oQYf3MjOxh4OE9E/M+3wY1cLgyLavvAMonD/K
 MTVZQsWsJ8Xud7KaYm3ycIibo/9e6o83Jo0RR/rkGAZWq72oGeRTdvKzbBdox4tzuoyN
 SPRlD8dODPNEgLldfmZYbOsVOpjtDzxWW7hZWCVNxG6AgdEzfQQ+sbK/r7cbAc89120B
 B8iiLZQtk1GD5DhfgF/sgHtZgoTxaXAwLrm8QEl2gjFVxad/y4O760iuoZzrkLc1X1XP Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2suevdkwdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 16:05:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55G52pL055753;
        Wed, 5 Jun 2019 16:05:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2swngm15yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 16:05:24 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x55G5MMO007220;
        Wed, 5 Jun 2019 16:05:22 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 09:05:22 -0700
Subject: Re: question: should_compact_retry limit
To:     Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>
References: <6377c199-2b9e-e30d-a068-c304d8a3f706@oracle.com>
 <908c1454-6ae5-87ca-c6a5-e542fbafa866@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3bc00340-1e81-4f08-37f8-28388b7fba3b@oracle.com>
Date:   Wed, 5 Jun 2019 09:05:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <908c1454-6ae5-87ca-c6a5-e542fbafa866@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/19 12:58 AM, Vlastimil Babka wrote:
> On 6/5/19 1:30 AM, Mike Kravetz wrote:
>> While looking at some really long hugetlb page allocation times, I noticed
>> instances where should_compact_retry() was returning true more often that
>> I expected.  In one allocation attempt, it returned true 765668 times in a
>> row.  To me, this was unexpected because of the following:
>>
>> #define MAX_COMPACT_RETRIES 16
>> int max_retries = MAX_COMPACT_RETRIES;
>>
>> However, if should_compact_retry() returns true via the following path we
>> do not increase the retry count.
>>
>> 	/*
>> 	 * make sure the compaction wasn't deferred or didn't bail out early
>> 	 * due to locks contention before we declare that we should give up.
>> 	 * But do not retry if the given zonelist is not suitable for
>> 	 * compaction.
>> 	 */
>> 	if (compaction_withdrawn(compact_result)) {
>> 		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
>> 		goto out;
>> 	}
>>
>> Just curious, is this intentional?
> 
> Hmm I guess we didn't expect compaction_withdrawn() to be so
> consistently returned. Do you know what value of compact_result is there
> in your test?

Added some instrumentation to record values and ran test,

557904 Total

549186 COMPACT_DEFERRED
  8718 COMPACT_PARTIAL_SKIPPED

Do note that this is not my biggest problem with these allocations.  That is
should_continue_reclaim returning true more often that in should.  Still
trying to get more info on that.  This was just something curious I also
discovered.
-- 
Mike Kravetz
