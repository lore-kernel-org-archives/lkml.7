Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192BDC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E549B21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qECwcshm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfGSHYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:24:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46712 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfGSHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:24:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6J7Itmf100116;
        Fri, 19 Jul 2019 07:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=87OIeSK1sKiVNRTyJCB3x8F8M7//ifJ6aAgQH0sNrRw=;
 b=qECwcshmJd9jAAhPFEhwo5ilQFHYWfpV7v3ax5bpkxbUbTNoYV+NeDep95NkU74EHbbN
 19tVZu1hoGfkG2lqWtK+ukTdjidIpRRp5+c5Z8patXqVtEV2qb1v8Vqy3MqtsvcIcySz
 1zgyTk+kXOmsQqMo5wUZURdYO2LEVnJNYI0MbILovqIVtKDimInA16kXQ3pivoWThD6b
 6GKkAomZ9yNwfz9+/zjf+ljaDLp/vkf+Y2kfZKFk7RIWqqg4S9qN1oBx7W8uYSM4lRmq
 fWrUQXu6XDYMgOYBN5THyiomwZDXx/ovGWT+AiWhLpsrmXnb5TZWwvQ36bkvhFmIP/3B dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tq78q4wdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 07:23:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6J7MZns049621;
        Fri, 19 Jul 2019 07:23:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tt77j5mnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 07:23:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6J7NQYH009729;
        Fri, 19 Jul 2019 07:23:31 GMT
Received: from Subhras-MacBook-Pro.local (/103.217.243.4)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jul 2019 07:23:26 +0000
Subject: Re: [RFC PATCH 3/3] sched: introduce tunables to control soft
 affinity
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, prakash.sangappa@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
References: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
 <20190626224718.21973-4-subhra.mazumdar@oracle.com>
 <20190718100816.GA19218@linux.vnet.ibm.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <81034dd8-4074-e716-c3e8-5a23cbb6bb8d@oracle.com>
Date:   Fri, 19 Jul 2019 12:53:19 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718100816.GA19218@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907190083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907190082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/18/19 3:38 PM, Srikar Dronamraju wrote:
> * subhra mazumdar <subhra.mazumdar@oracle.com> [2019-06-26 15:47:18]:
>
>> For different workloads the optimal "softness" of soft affinity can be
>> different. Introduce tunables sched_allowed and sched_preferred that can
>> be tuned via /proc. This allows to chose at what utilization difference
>> the scheduler will chose cpus_allowed over cpus_preferred in the first
>> level of search. Depending on the extent of data sharing, cache coherency
>> overhead of the system etc. the optimal point may vary.
>>
>> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
>> ---
> Correct me but this patchset only seems to be concentrated on the wakeup
> path, I don't see any changes in the regular load balancer or the
> numa-balancer. If system is loaded or tasks are CPU intensive, then wouldn't
> these tasks be moved to cpus_allowed instead of cpus_preferred and hence
> breaking this soft affinity.
>
The new idle is purposefully unchanged, if threads get stolen to the allowed
set from the preferred set that's intended, together with the enqueue side
it will achieve softness of affinity.
