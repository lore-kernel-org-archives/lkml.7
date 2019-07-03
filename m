Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D7C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0692085A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JS1USi8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGCDyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:54:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47344 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGCDyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:54:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x633mRCJ016020;
        Wed, 3 Jul 2019 03:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=TWpylE82lBvMKs8+jsPbiXQoKt46pPZ3syGJQR8z4bI=;
 b=JS1USi8bah7CLVwZI/QOGkm3hb9mhrUCKUJWZGh6TeRAjV8LhO0XaQ0ftWl0WuCS/nPk
 9W9qUaOVRKwfgHA64+oPkqUpUqYXRO2o7N4jRw/ixbAX4qWphWmNZxNGXWrtDFGbJZeC
 gGnf8MU5g5QH5XX15ilqQ9olMYbRPFesHv6CKZAighwneJfBdYRG7IFiFTkIsHeIrs+z
 HauvTcPnTLSXYvFzSpwoIYKbLI+ol+NRP2CZVi1LyM7IuMptz2i1m1KMvBqKJitchMCQ
 C+U5qPtElPR84RFzyQphOCysiWexGP9dFxmQ8KNdwqeNcSNYkmX0E6EcEpQ9gaIsRgI6 rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2te61e6yaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 03:52:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x633qsdK027668;
        Wed, 3 Jul 2019 03:52:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tebqgv8s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 03:52:53 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x633qeCT031951;
        Wed, 3 Jul 2019 03:52:45 GMT
Received: from Subhras-MacBook-Pro.local (/73.252.215.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 20:52:40 -0700
Subject: Re: [RESEND PATCH v3 0/7] Improve scheduler scalability for fast path
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, Paul Turner <pjt@google.com>,
        riel@surriel.com, morten.rasmussen@arm.com
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190701090204.GQ3402@hirez.programming.kicks-ass.net>
 <20190701135552.kb4os6bxxhh2lyw6@e110439-lin>
 <81b2288a-579d-8dd1-f179-d672cf1edd68@oracle.com>
 <20190702085437.gzu7ilubbi5jx6sp@e110439-lin>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <384db1d1-e2e3-9a5c-568c-c7441706700f@oracle.com>
Date:   Tue, 2 Jul 2019 20:52:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702085437.gzu7ilubbi5jx6sp@e110439-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907030047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907030046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/2/19 1:54 AM, Patrick Bellasi wrote:
> Wondering if searching and preempting needs will ever be conflicting?
> I guess the winning point is that we don't commit behaviors to
> userspace, but just abstract concepts which are turned into biases.
>
> I don't see conflicts right now: if you are latency tolerant that
> means you can spend more time to try finding a better CPU (e.g. we can
> use the energy model to compare multiple CPUs) _and/or_ give the
> current task a better chance to complete by delaying its preemption.
OK
>
>> Otherwise sounds like a good direction to me. For the searching aspect, can
>> we map latency nice values to the % of cores we search in select_idle_cpu?
>> Thus the search cost can be controlled by latency nice value.
> I guess that's worth a try, only caveat I see is that it's turning the
> bias into something very platform specific. Meaning, the same
> latency-nice value on different machines can have very different
> results.
>
> Would not be better to try finding a more platform independent mapping?
>
> Maybe something time bounded, e.g. the higher the latency-nice the more
> time we can spend looking for CPUs?
The issue I see is suppose we have a range of latency-nice values, then it
should cover the entire range of search (one core to all cores). As Peter
said some workloads will want to search the LLC fully. If we have absolute
time, the map of latency-nice values range to them will be arbitrary. If
you have something in mind let me know, may be I am thinking differently.
>
>> But the issue is if more latency tolerant workloads set to less
>> search, we still need some mechanism to achieve good spread of
>> threads.
> I don't get this example: why more latency tolerant workloads should
> require less search?
I guess I got the definition of "latency tolerant" backwards.
>
>> Can we keep the sliding window mechanism in that case?
> Which one? Sorry did not went through the patches, can you briefly
> resume the idea?
If a workload has set it to low latency tolerant, then the search will be
less. That can lead to localization of threads on a few CPUs as we are not
searching the entire LLC even if there are idle CPUs available. For this
I had introduced a per-CPU variable (for the target CPU) to track the
boundary of search so that every time it will start from the boundary, thus
sliding the window. So even if we are searching very little the search
window keeps shifting and gives us a good spread. This is orthogonal to the
latency-nice thing.
>
>> Also will latency nice do anything for select_idle_core and
>> select_idle_smt?
> I guess principle the same bias can be used at different levels, maybe
> with different mappings.
Doing it for select_idle_core will have the issue that the dynamic flag
(whether an idle core is present or not) can only be updated by threads
which are doing the full search.

Thanks,
Subhra

> In the mobile world use-case we will likely use it only to switch from
> select_idle_sibling to the energy aware slow path. And perhaps to see
> if we can bias the wakeup preemption granularity.
>
> Best,
> Patrick
>
