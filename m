Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4B0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B642067B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pn3UjrWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404033AbfIEUpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:45:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37826 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfIEUpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:45:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85KhxwM001368;
        Thu, 5 Sep 2019 20:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=aqDnQxZxonMvjcV/XCftl9y61xAtbi3wkQPOl+rmUng=;
 b=Pn3UjrWJWLwxEHkpvou1UJExMc0Liv/nmZSrk7VX++NAw1ezKbm9WaQf4lURWXxrI1/a
 Vkw/DVE95sl5Rjy6DwZh/dXUEqp/O8E77IEdgPeQ0AY7CGOTNkOrEZtO8t0cYoaD6flW
 l1VWePBA1+IPut4Ds8jbbfmNW9ZzTnf9H4EnXfzjaLMsgN3BjKwJy2NpkWUrO7cQKjOB
 Eu2dAeOXqRApuMG7SVYk3L509nzC4N027wGWsIy4NZfcaWQnwiWk/l7Esak/m7DEsisk
 IMh/TW6L/ZwV2WJr/VxWgO8X1UDNDFeaGebBsQo6k5NqjkUHA+C9Ol5yTIpa5NLunS+T BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2uu9g9026y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 20:44:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85KhQo5157189;
        Thu, 5 Sep 2019 20:44:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2utpmbtvfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 20:44:53 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x85Kinhv005857;
        Thu, 5 Sep 2019 20:44:49 GMT
Received: from [10.132.91.113] (/10.132.91.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Sep 2019 13:44:49 -0700
Subject: Re: [RFC PATCH 7/9] sched: search SMT before LLC domain
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com,
        patrick.bellasi@arm.com
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-8-subhra.mazumdar@oracle.com>
 <20190905093127.GI2349@hirez.programming.kicks-ass.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <fadf55b2-c825-8636-6c9a-6eedf9a20733@oracle.com>
Date:   Thu, 5 Sep 2019 13:40:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905093127.GI2349@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050193
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/5/19 2:31 AM, Peter Zijlstra wrote:
> On Fri, Aug 30, 2019 at 10:49:42AM -0700, subhra mazumdar wrote:
>> Search SMT siblings before all CPUs in LLC domain for idle CPU. This helps
>> in L1 cache locality.
>> ---
>>   kernel/sched/fair.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 8856503..94dd4a32 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6274,11 +6274,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>   			return i;
>>   	}
>>   
>> -	i = select_idle_cpu(p, sd, target);
>> +	i = select_idle_smt(p, target);
>>   	if ((unsigned)i < nr_cpumask_bits)
>>   		return i;
>>   
>> -	i = select_idle_smt(p, target);
>> +	i = select_idle_cpu(p, sd, target);
>>   	if ((unsigned)i < nr_cpumask_bits)
>>   		return i;
>>   
> But it is absolutely conceptually wrong. An idle core is a much better
> target than an idle sibling.
This is select_idle_smt not select_idle_core.
