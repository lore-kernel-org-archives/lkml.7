Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B099C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ECD2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VokRmQk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfGSC5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 22:57:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57806 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfGSC5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 22:57:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6J2rxKp113651;
        Fri, 19 Jul 2019 02:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1VoY01PKSy90HXxuK3RrXrwbc97dVgJ7w52K1v+rBB0=;
 b=VokRmQk/XQQEQ21G9/DwmaIrRn6rk7SQFABaxLILpHxaf0ZLlBLUFGrkX0wxqCOW8LZq
 L5dibcflcvcq/GSvZTnVgBs1cwYhPIc3QWL6KUjXwEd02fyxbKnSslQg/SsNwLeqHt7f
 CHFRNzELowftmG+i6h+ZXC4rJtaLE2GanniQO21uwAJGYv6GigOzFozzj2VnfzCl2Nlf
 PTMPoyum0t2U852jok3XWH63eUCR/XMjyX2Ij1bU9WogSo9pXahJCFtWrnyKlhe+QIJH
 WP4nFIKjjFpCn4QwwqjeRLNh1JvEtPawptiujYT2pBbnhd7pScX569ZX6US0aWXGyupF VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78q4505-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 02:57:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6J2rBQp015296;
        Fri, 19 Jul 2019 02:55:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tsmcdbmsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 02:55:13 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6J2t75Z004407;
        Fri, 19 Jul 2019 02:55:07 GMT
Received: from Subhras-MacBook-Pro.local (/103.217.243.4)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jul 2019 02:55:07 +0000
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
 <a91c09ce-aec1-eaa1-4daf-70024cebf360@oracle.com>
 <20190718113758.GN3402@hirez.programming.kicks-ass.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <067f898a-3d3b-0ff5-724e-50ed2e989286@oracle.com>
Date:   Fri, 19 Jul 2019 08:25:01 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718113758.GN3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=828
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907190031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=873 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907190031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/18/19 5:07 PM, Peter Zijlstra wrote:
> On Wed, Jul 17, 2019 at 08:31:25AM +0530, Subhra Mazumdar wrote:
>> On 7/2/19 10:58 PM, Peter Zijlstra wrote:
>>> On Wed, Jun 26, 2019 at 03:47:17PM -0700, subhra mazumdar wrote:
>>>> The soft affinity CPUs present in the cpumask cpus_preferred is used by the
>>>> scheduler in two levels of search. First is in determining wake affine
>>>> which choses the LLC domain and secondly while searching for idle CPUs in
>>>> LLC domain. In the first level it uses cpus_preferred to prune out the
>>>> search space. In the second level it first searches the cpus_preferred and
>>>> then cpus_allowed. Using affinity_unequal flag it breaks early to avoid
>>>> any overhead in the scheduler fast path when soft affinity is not used.
>>>> This only changes the wake up path of the scheduler, the idle balancing
>>>> is unchanged; together they achieve the "softness" of scheduling.
>>> I really dislike this implementation.
>>>
>>> I thought the idea was to remain work conserving (in so far as that
>>> we're that anyway), so changing select_idle_sibling() doesn't make sense
>>> to me. If there is idle, we use it.
>>>
>>> Same for newidle; which you already retained.
>> The scheduler is already not work conserving in many ways. Soft affinity is
>> only for those who want to use it and has no side effects when not used.
>> Also the way scheduler is implemented in the first level of search it may
>> not be possible to do it in a work conserving way, I am open to ideas.
> I really don't understand the premise of this soft affinity stuff then.
>
> I understood it was to allow spreading if under-utilized, but group when
> over-utilized, but you're arguing for the exact opposite, which doesn't
> make sense.
You are right on the premise. The whole knob thing came into existence
because I couldn't make the first level of search work conserving. I am
concerned that trying to make that work conserving can introduce
significant latency in the code path when SA is used. I have made the
second level of search work conserving when we search the LLC domain.

Having said that, SA need not necessarily be binary i.e only spill over to
the allowed set if the preferred set is 100% utilized (work conserving).
The spill over can happen before that and SA can have a degree of softness.

The above two points made me go down the knob path for the first level of
search.
