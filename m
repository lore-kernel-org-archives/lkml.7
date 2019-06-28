Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDECEC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF43020828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NmrPSDVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF1Wkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:40:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50432 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF1Wkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:40:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SMYjXD075488;
        Fri, 28 Jun 2019 22:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kjjlgFi6AgD2bzIvdYF4FhcBGFgr7Z4+4fAYVr9/hzg=;
 b=NmrPSDVm9DEiOab3SuM1JEoN7CXABw5E1fcd81Jy/AIjA4QOa9vy16k/AWUCEab/j/U4
 9rXlDLMcQxGvJu8l6fqckrdUeFOlsIDcxukt0KBYCYmA/Y1Fb5mECYhUi65GN6Tqe21v
 KFqKnSVARnFrcSfosCqMBBUSu0XQ96XEHnnTaY/rsr9QBQ8j94moBNaneFJeky7af5l2
 h5PT5sBEi7Us/uTzpduMtpO8imMeUyOKJNsndVjWUXIzQk0t+sIb42zdSX+kujkUi7yN
 +ontIoOvgI3q/qofC7qGADL1NdC9K6ZyO+/duAIudWRm+cZodCBOXLMKEgz/EtWWWwCa tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t9brtqs3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 22:39:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SMdGDH067305;
        Fri, 28 Jun 2019 22:39:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t9p6w4ufh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 22:39:34 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5SMdWYA004877;
        Fri, 28 Jun 2019 22:39:32 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 15:39:32 -0700
Subject: Re: [PATCH v3 3/7] sched: rotate the cpu search window for better
 spread
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-4-subhra.mazumdar@oracle.com>
 <20190628115441.GA30685@linux.vnet.ibm.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <0dbdf3d0-8547-3290-0ad6-adf65d8aa976@oracle.com>
Date:   Fri, 28 Jun 2019 15:34:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190628115441.GA30685@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280259
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/28/19 4:54 AM, Srikar Dronamraju wrote:
> * subhra mazumdar <subhra.mazumdar@oracle.com> [2019-06-26 18:29:15]:
>
>> Rotate the cpu search window for better spread of threads. This will ensure
>> an idle cpu will quickly be found if one exists.
> While rotating the cpu search window is good, not sure if this can find a
> idle cpu quickly. The probability of finding an idle cpu still should remain
> the same. No?
>
>> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
>> ---
>>   kernel/sched/fair.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> @@ -6219,9 +6219,15 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>   		}
>>   	}
>>   
>> +	if (per_cpu(next_cpu, target) != -1)
>> +		target_tmp = per_cpu(next_cpu, target);
>> +	else
>> +		target_tmp = target;
>> +
>>   	time = local_clock();
>>   
>> -	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
>> +	for_each_cpu_wrap(cpu, sched_domain_span(sd), target_tmp) {
>> +		per_cpu(next_cpu, target) = cpu;
> Shouldn't this assignment be outside the for loop.
> With the current code,
> 1. We keep reassigning multiple times.
> 2. The last assignment happes for idle_cpu and sometimes the
> assignment is for non-idle cpu.
We want the last assignment irrespective of it was an idle cpu or not since
in both cases we want to track the boundary of search.

Thanks,
Subhra
