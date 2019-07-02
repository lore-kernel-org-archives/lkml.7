Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBE2C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF97021479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lUfzdCzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfGBAIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:08:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34520 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfGBAIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:08:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6204287022201;
        Tue, 2 Jul 2019 00:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=W5Q+NkHpzRK/P7xEh54iSkYNc3/t6agDnWcFSfwc5W4=;
 b=lUfzdCzurW0l+g+6kS6bCNBdI0RrWuhRpJFso1wTg8RYtLSoTbfF00NPWM9akaXhrY7C
 J9J7YUwApCsC3rz6+CpfD+TBdEtup1nPc72DjIpjWBs0xq4S8+PpqPeY6t67OdulQzNA
 aI8/B6ZLPwF1ziyvqHAYkXIG5Xr3nYP0MkSIVu/WzdVfAIUhA3zdt50bqo92OiMOLwH0
 ibjcy7EHlhBKr7PHGp6JeyI9oZ97l/FoCkMjpAjTmO/eccd/zpbc5s2WhWmDOn7IhB0y
 OM5fn4FdJgzVgtLBXaFeg+wszT2B13niyJLE4Q2fKZVTxFmQDoMApsuTBOYRBFVg0z5b cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tbgdsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 00:06:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6202hMB077713;
        Tue, 2 Jul 2019 00:06:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tebqg6vjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 00:06:26 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6206HWB029180;
        Tue, 2 Jul 2019 00:06:22 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 17:06:17 -0700
Subject: Re: [RESEND PATCH v3 0/7] Improve scheduler scalability for fast path
To:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, Paul Turner <pjt@google.com>,
        riel@surriel.com, morten.rasmussen@arm.com
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190701090204.GQ3402@hirez.programming.kicks-ass.net>
 <20190701135552.kb4os6bxxhh2lyw6@e110439-lin>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <81b2288a-579d-8dd1-f179-d672cf1edd68@oracle.com>
Date:   Mon, 1 Jul 2019 17:01:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190701135552.kb4os6bxxhh2lyw6@e110439-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010280
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010281
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/1/19 6:55 AM, Patrick Bellasi wrote:
> On 01-Jul 11:02, Peter Zijlstra wrote:
>> On Wed, Jun 26, 2019 at 06:29:12PM -0700, subhra mazumdar wrote:
>>> Hi,
>>>
>>> Resending this patchset, will be good to get some feedback. Any suggestions
>>> that will make it more acceptable are welcome. We have been shipping this
>>> with Unbreakable Enterprise Kernel in Oracle Linux.
>>>
>>> Current select_idle_sibling first tries to find a fully idle core using
>>> select_idle_core which can potentially search all cores and if it fails it
>>> finds any idle cpu using select_idle_cpu. select_idle_cpu can potentially
>>> search all cpus in the llc domain. This doesn't scale for large llc domains
>>> and will only get worse with more cores in future.
>>>
>>> This patch solves the scalability problem by:
>>>   - Setting an upper and lower limit of idle cpu search in select_idle_cpu
>>>     to keep search time low and constant
>>>   - Adding a new sched feature SIS_CORE to disable select_idle_core
>>>
>>> Additionally it also introduces a new per-cpu variable next_cpu to track
>>> the limit of search so that every time search starts from where it ended.
>>> This rotating search window over cpus in LLC domain ensures that idle
>>> cpus are eventually found in case of high load.
>> Right, so we had a wee conversation about this patch series at OSPM, and
>> I don't see any of that reflected here :-(
>>
>> Specifically, given that some people _really_ want the whole L3 mask
>> scanned to reduce tail latency over raw throughput, while you guys
>> prefer the other way around, it was proposed to extend the task model.
>>
>> Specifically something like a latency-nice was mentioned (IIRC) where a
> Right, AFAIR PaulT suggested to add support for the concept of a task
> being "latency tolerant": meaning we can spend more time to search for
> a CPU and/or avoid preempting the current task.
>
Wondering if searching and preempting needs will ever be conflicting?
Otherwise sounds like a good direction to me. For the searching aspect, can
we map latency nice values to the % of cores we search in select_idle_cpu?
Thus the search cost can be controlled by latency nice value. But the issue
is if more latency tolerant workloads set to less search, we still need
some mechanism to achieve good spread of threads. Can we keep the sliding
window mechanism in that case? Also will latency nice do anything for
select_idle_core and select_idle_smt?
