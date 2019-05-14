Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7128DC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3D320879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tAKVGsi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfENRlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:41:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46088 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfENRlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:41:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EHd3OO162112;
        Tue, 14 May 2019 17:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=p33uS+TUiN9yF3So3JOzWSY5vzWOrHkF0MG7IR3jVx8=;
 b=tAKVGsi8XeFr0YF3AWuAwEuX06KjNk5z3brmC7KG8+WuHsnLDQ5qPU74tJDsQqrxFtpg
 0eCGwHdRpTj2hK1l7jW3LtRrazR2BKlEF548tGX7TuAxPaLZkep8AQ9yF9StzU63IjJl
 yl4yMfj6mtc6EZ1qgX14uvy+4F7nBnViQb09U4YeTP/Zk+hkCpS6PI5rzvo+ep/EVd9H
 zjYrfvFTnBS/4SJSAAkMO1ViF1xMdEpLn1NCzK8Sv1Z2ouwKbiw9Jdb7BNpzMSA/Bnv2
 wnl+fsOZ5Hxztf2l2uLcUAkUkCavNykD5SvnfUusRp4806+vtB7yorLvBUOLVqVSkNcC tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sdnttqt8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 17:40:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EHeBdx030778;
        Tue, 14 May 2019 17:40:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2sf3cnd6u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 17:40:51 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4EHeo8C023556;
        Tue, 14 May 2019 17:40:50 GMT
Received: from [10.132.91.213] (/10.132.91.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 May 2019 10:40:50 -0700
Subject: Re: [RFC V2 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU
 isn't found
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
To:     Steven Sistare <steven.sistare@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     songliubraving@fb.com, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org
References: <cover.1556182964.git.viresh.kumar@linaro.org>
 <59b37c56b8fcb834f7d3234e776eaeff74ad117f.1556182965.git.viresh.kumar@linaro.org>
 <20190510072125.GG2623@hirez.programming.kicks-ass.net>
 <20190513093418.altqhlhu4zsu75t4@vireshk-i7>
 <20190513113518.GQ2623@hirez.programming.kicks-ass.net>
 <05ffe5f4-4324-2977-e46e-155e1aef57fa@oracle.com>
 <b5f84cce-8000-d9c9-26ae-e34c9ca53ed5@oracle.com>
Message-ID: <da8789d4-3ded-63be-d6f5-1dbe736be104@oracle.com>
Date:   Tue, 14 May 2019 10:36:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <b5f84cce-8000-d9c9-26ae-e34c9ca53ed5@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140121
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/14/19 10:27 AM, Subhra Mazumdar wrote:
>
> On 5/14/19 9:03 AM, Steven Sistare wrote:
>> On 5/13/2019 7:35 AM, Peter Zijlstra wrote:
>>> On Mon, May 13, 2019 at 03:04:18PM +0530, Viresh Kumar wrote:
>>>> On 10-05-19, 09:21, Peter Zijlstra wrote:
>>>>> I don't hate his per se; but the whole select_idle_sibling() thing is
>>>>> something that needs looking at.
>>>>>
>>>>> There was the task stealing thing from Steve that looked 
>>>>> interesting and
>>>>> that would render your apporach unfeasible.
>>>> I am surely missing something as I don't see how that patchset will
>>>> make this patchset perform badly, than what it already does.
>>> Nah; I just misremembered. I know Oracle has a patch set poking at
>>> select_idle_siblings() _somewhere_ (as do I), and I just found the 
>>> wrong
>>> one.
>>>
>>> Basically everybody is complaining select_idle_sibling() is too
>>> expensive for checking the entire LLC domain, except for FB (and thus
>>> likely some other workloads too) that depend on it to kill their tail
>>> latency.
>>>
>>> But I suppose we could still do this, even if we scan only a subset of
>>> the LLC, just keep track of the last !idle CPU running only SCHED_IDLE
>>> tasks and pick that if you do not (in your limited scan) find a better
>>> candidate.
>> Subhra posted a patch that incrementally searches for an idle CPU in 
>> the LLC,
>> remembering the last CPU examined, and searching a fixed number of 
>> CPUs from there.
>> That technique is compatible with the one that Viresh suggests; the 
>> incremental
>> search would stop if a SCHED_IDLE cpu was found.
> This was the last version of patchset I sent:
> https://lkml.org/lkml/2018/6/28/810
>
> Also select_idle_core is a net -ve for certain workloads like OLTP. So I
> had put a SCHED_FEAT to be able to disable it.
Forgot to add, the cpumask_weight computation may not be O(1) with large
number of CPUs, so needs to be precomputed in a per-cpu variable to further
optimize. That part is missing from the above patchset.
>
> Thanks,
> Subhra
>>
>> I also fiddled with select_idle_sibling, maintaining a per-LLC bitmap 
>> of idle CPUs,
>> updated with atomic operations.  Performance was basically unchanged 
>> for the
>> workloads I tested, and I inserted timers around the idle search 
>> showing it was
>> a very small fraction of time both before and after my changes.  That 
>> led me to
>> ignore the push side and optimize the pull side with task stealing.
>>
>> I would be very interested in hearing from folks that have workloads 
>> that demonstrate
>> that select_idle_sibling is too expensive.
>>
>> - Steve
