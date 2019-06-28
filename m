Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A96D208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5VXljABH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfF1Wg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:36:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37136 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfF1WgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:36:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SMYaNi081645;
        Fri, 28 Jun 2019 22:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5BXhuEPFDddiNAekJ5I66ugIZ3EfVPNNcHP0UgKmH0Q=;
 b=5VXljABHIjidxf57ErkYPFevR2jYLr2wVGjAft6Mg6kxKJlEcuPUPxmVLLaSUNDB8snT
 MgP4XvSli4cRvyVCs9jRVuqvDJWTqFAo6g1+zej/pz18mozLa782ppJEPGz9G4y9AE6o
 rHS+NOIQYUgWWgwKGU1+MEt7B64GTiVOpP0Zpqks64FTacCvwIUrMrCkm/Wx4+VDWTct
 AcQ32t6H7CeIz5yGlhqDZceWBo1nWdkuPLRMaNKDx8BVQCYNRN3s6+JSUc8hYXz5YnwY
 F94fRkEapNe1cAdOrupa6iWPY8RcQmV7gkCp1rQeQ/JHauQv+ZSKg/slYWp+spezFIp1 Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t9cyqyn13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 22:34:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SMXaR9104757;
        Fri, 28 Jun 2019 22:34:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7e675n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 22:34:55 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5SMYrei010475;
        Fri, 28 Jun 2019 22:34:54 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 15:34:53 -0700
Subject: Re: [PATCH v3 5/7] sched: SIS_CORE to disable idle core search
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-6-subhra.mazumdar@oracle.com>
 <0e0f3347-c262-2917-76d7-88dddf4e9122@linux.ibm.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <59ab08d5-8b7c-00b9-230b-7c0b307a675f@oracle.com>
Date:   Fri, 28 Jun 2019 15:29:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0e0f3347-c262-2917-76d7-88dddf4e9122@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280258
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/28/19 12:01 PM, Parth Shah wrote:
>
> On 6/27/19 6:59 AM, subhra mazumdar wrote:
>> Use SIS_CORE to disable idle core search. For some workloads
>> select_idle_core becomes a scalability bottleneck, removing it improves
>> throughput. Also there are workloads where disabling it can hurt latency,
>> so need to have an option.
>>
>> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
>> ---
>>   kernel/sched/fair.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index c1ca88e..6a74808 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6280,9 +6280,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>   	if (!sd)
>>   		return target;
>>
>> -	i = select_idle_core(p, sd, target);
>> -	if ((unsigned)i < nr_cpumask_bits)
>> -		return i;
>> +	if (sched_feat(SIS_CORE)) {
>> +		i = select_idle_core(p, sd, target);
>> +		if ((unsigned)i < nr_cpumask_bits)
>> +			return i;
>> +	}
> This can have significant performance loss if disabled. The select_idle_core spreads
> workloads quickly across the cores, hence disabling this leaves much of the work to
> be offloaded to load balancer to move task across the cores. Latency sensitive
> and long running multi-threaded workload should see the regression under this conditions.
Yes in case of SPARC SMT8 I did notice that (see cover letter). That's why
it is a feature that is ON by default, but can be turned OFF for specific
workloads on x86 SMT2 that can benefit from it.
> Also, systems like POWER9 has sd_llc as a pair of core only. So it
> won't benefit from the limits and hence also hiding your code in select_idle_cpu
> behind static keys will be much preferred.
If it doesn't hurt then I don't see the point.

Thanks,
Subhra

