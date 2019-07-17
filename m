Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36481C76188
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F4B20693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h+yY1PAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfGQDDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 23:03:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53590 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfGQDDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 23:03:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H305bL187745;
        Wed, 17 Jul 2019 03:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Zcf8XHNH6AKcoMzW8D9TJdHEYqPx5ohKeQB8GKEQW18=;
 b=h+yY1PAE9k5doutiH94Vaf/FFmar9UmVwy9FcjfKXj0S4EALW5C+lqHO1/2n0mY9872P
 DIk7X/lTSbYl3a3odydBtKUCazX2I5qg82rwNKr2P0CYZnNCEJSoOv4SnYumB+LBx9ep
 pK//VNQjubti3+AuomTLwVQghrVkozNmq49NEJOBo5k/sUaZOHyCR0rJHQo31okSmRsH
 9W0R/pO/vTr7U52PQi+3fAe92sNgTQWfBS2/O7MgpaZYmRqN6AWrnqKuA97dvVFy+nQQ
 /m2ff5pMRb+gu02sS2u1egFw5jpLj6ZXDo8GjEIrRVwpPx6Vz/zcMkmHYB5q3awhPTgy vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78pqts2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 03:01:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H2vLIl112827;
        Wed, 17 Jul 2019 03:01:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tsmcc57d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 03:01:34 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6H31W4Z006981;
        Wed, 17 Jul 2019 03:01:33 GMT
Received: from Subhras-MacBook-Pro.local (/103.87.143.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 03:01:32 +0000
Subject: Re: [RFC PATCH 2/3] sched: change scheduler to give preference to
 soft affinity CPUs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        prakash.sangappa@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, Paul Turner <pjt@google.com>
References: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
 <20190626224718.21973-3-subhra.mazumdar@oracle.com>
 <20190702172851.GA3436@hirez.programming.kicks-ass.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <a91c09ce-aec1-eaa1-4daf-70024cebf360@oracle.com>
Date:   Wed, 17 Jul 2019 08:31:25 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190702172851.GA3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/2/19 10:58 PM, Peter Zijlstra wrote:
> On Wed, Jun 26, 2019 at 03:47:17PM -0700, subhra mazumdar wrote:
>> The soft affinity CPUs present in the cpumask cpus_preferred is used by the
>> scheduler in two levels of search. First is in determining wake affine
>> which choses the LLC domain and secondly while searching for idle CPUs in
>> LLC domain. In the first level it uses cpus_preferred to prune out the
>> search space. In the second level it first searches the cpus_preferred and
>> then cpus_allowed. Using affinity_unequal flag it breaks early to avoid
>> any overhead in the scheduler fast path when soft affinity is not used.
>> This only changes the wake up path of the scheduler, the idle balancing
>> is unchanged; together they achieve the "softness" of scheduling.
> I really dislike this implementation.
>
> I thought the idea was to remain work conserving (in so far as that
> we're that anyway), so changing select_idle_sibling() doesn't make sense
> to me. If there is idle, we use it.
>
> Same for newidle; which you already retained.
The scheduler is already not work conserving in many ways. Soft affinity is
only for those who want to use it and has no side effects when not used.
Also the way scheduler is implemented in the first level of search it may
not be possible to do it in a work conserving way, I am open to ideas.
>
> This then leaves regular balancing, and for that we can fudge with
> can_migrate_task() and nr_balance_failed or something.
Possibly but I don't know if similar performance behavior can be achieved
by the periodic load balancer. Do you want a performance comparison of the
two approaches?
>
> And I also really don't want a second utilization tipping point; we
> already have the overloaded thing.
The numbers in the cover letter show that a static tipping point will not
work for all workloads. What soft affinity is doing is essentially trading
off cache coherence for more CPU. The optimum tradeoff point will vary
from workload to workload and the system metrics of coherence overhead etc.
If we just use the domain overload that becomes a static definition of
tipping point, we need something tunable that captures this tradeoff. The
ratio of CPU util seemed to work well and capture that.
>
> I also still dislike how you never looked into the numa balancer, which
> already has peferred_nid stuff.
Not sure if you mean using the existing NUMA balancer or enhancing it. If
the former, I have numbers in the cover letter that show NUMA balancer is
not making any difference. I allocated memory of each DB instance to one
NUMA node using numactl, but NUMA balancer still migrated pages, so numactl
only seems to control the initial allocation. Secondly even though NUMA
balancer migrated pages it had no performance benefit as compared to
disabling it.
