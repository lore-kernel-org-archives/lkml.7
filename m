Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1672C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0DE206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M5yzPnMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391061AbfIEWGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 18:06:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47198 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfIEWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:06:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85Lwik6061277;
        Thu, 5 Sep 2019 22:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=6m0wNY0YUJozesvcC8oR/h0z6F04mPR6003eI4nQW1U=;
 b=M5yzPnMrktlfIRZRfOn/SKqjbCV5hlKtFIsb+qzEG3CdS+IsyuVFbCLwMrDPtZwuO/lc
 Z+eXDCIYmW8O+5Dfn0zOUqA35t9Vx8lPjCLej4mqtWs1jo5bb+ZB7cDsFLHtPFMUO/YM
 dsiDkx4Cc9ROxNkL0K3iGOmIV/39fWOPHYtmGMJRHyNZvPdBt52kkAYcaGYoEvBeKUe7
 HToRqC0hQozJBWQaWDK5xz5KjaJ3OyZMrtw8o47Ju7XpD8xkC7QJiYoDi3bcXtaq1kmV
 7/e/QQGtfJJ2xRROS/fMFz4QPc6F9ONi3ceR2NZ7C0BS1bYOFd3K8xi8TQFzoZol1ykA RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uuaqj01ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 22:06:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85M48o0072464;
        Thu, 5 Sep 2019 22:06:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2uu1b93y07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 22:06:13 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x85M6BFD001986;
        Thu, 5 Sep 2019 22:06:11 GMT
Received: from [10.132.91.113] (/10.132.91.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Sep 2019 15:06:10 -0700
Subject: Re: [RFC PATCH 3/9] sched: add sched feature to disable idle core
 search
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net,
        parth@linux.ibm.com
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-4-subhra.mazumdar@oracle.com> <87mufj2gju.fsf@arm.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <031de1c0-c5a5-ea88-1e9c-836452fccf9c@oracle.com>
Date:   Thu, 5 Sep 2019 15:02:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87mufj2gju.fsf@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050206
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/5/19 3:17 AM, Patrick Bellasi wrote:
> On Fri, Aug 30, 2019 at 18:49:38 +0100, subhra mazumdar wrote...
>
>> Add a new sched feature SIS_CORE to have an option to disable idle core
>> search (select_idle_core).
>>
>> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
>> ---
>>   kernel/sched/features.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
>> index 858589b..de4d506 100644
>> --- a/kernel/sched/features.h
>> +++ b/kernel/sched/features.h
>> @@ -57,6 +57,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>>    */
>>   SCHED_FEAT(SIS_AVG_CPU, false)
>>   SCHED_FEAT(SIS_PROP, true)
>> +SCHED_FEAT(SIS_CORE, true)
> Why do we need a sched_feature? If you think there are systems in
> which the usage of latency-nice does not make sense for in "Select Idle
> Sibling", then we should probably better add a new Kconfig option.
This is not for latency-nice but to be able to disable a different aspect
of the scheduler, i.e searching for idle cores. This can be made part of
latency-nice (i.e not do idle core search if latency-nice is below a
certain value) but even then having a feature to disable it doesn't hurt.
>
> If that's the case, you can probably use the init/Kconfig's
> "Scheduler features" section, recently added by:
>
>    commit 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
>
>>   /*
>>    * Issue a WARN when we do multiple update_rq_clock() calls
> Best,
> Patrick
>
