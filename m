Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BF9C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4846721479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="riEb/0iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfGAWOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 18:14:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfGAWOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 18:14:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61M90wO042017;
        Mon, 1 Jul 2019 22:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=en4SXX022hwvX0x9G0+SnC+PnaP8ULXzHBhOeJ5wAfo=;
 b=riEb/0iHU4DXypD8J+7SMIGCa9AdG//i4jdeiMmo8To4sgCcO28Ik0Lz0JZrZ4KqsGCM
 QGIy/DNuQqpDiFO0txlZkRqg06IZxFWAd0zbK+Wg30lyVmcU8uPUpcExXuReeoDh5R5g
 AXVDJPLa9eZ+kDJCFsheVK19WeAAkKQyPRg4m8GX1M8yN1twpXWwW0u4zL9N9XOPEAFW
 13CXQrCbkKzGVxzguEpOUNqcOgDvv+5leNHbImAF4ImYvqohkaRFim43Hl0eVytTEzJ6
 8x4nk/qgYU7aLhM1NByhw9tgKHCfRBrWq4ep2GBEDkJHRmx2oIxiasPB7aUxsqsvbkIj 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2te61e050p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 22:14:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61MCxh2098486;
        Mon, 1 Jul 2019 22:13:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tebqg5w2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 22:13:59 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x61MDwgS024959;
        Mon, 1 Jul 2019 22:13:58 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 15:13:58 -0700
Subject: Re: [PATCH V3 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU
 isn't found
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, songliubraving@fb.com
References: <cover.1561523542.git.viresh.kumar@linaro.org>
 <eeafa25fdeb6f6edd5b2da716bc8f0ba7708cbcf.1561523542.git.viresh.kumar@linaro.org>
 <32bd769c-b692-8896-5cc9-d19ab0a23abb@oracle.com>
 <20190701080349.homlsgia4fuaitek@vireshk-i7>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <aeaa0dd5-8512-1b60-eb10-6a4aecfaaca3@oracle.com>
Date:   Mon, 1 Jul 2019 15:08:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190701080349.homlsgia4fuaitek@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010258
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/1/19 1:03 AM, Viresh Kumar wrote:
> On 28-06-19, 18:16, Subhra Mazumdar wrote:
>> On 6/25/19 10:06 PM, Viresh Kumar wrote:
>>> We try to find an idle CPU to run the next task, but in case we don't
>>> find an idle CPU it is better to pick a CPU which will run the task the
>>> soonest, for performance reason.
>>>
>>> A CPU which isn't idle but has only SCHED_IDLE activity queued on it
>>> should be a good target based on this criteria as any normal fair task
>>> will most likely preempt the currently running SCHED_IDLE task
>>> immediately. In fact, choosing a SCHED_IDLE CPU over a fully idle one
>>> shall give better results as it should be able to run the task sooner
>>> than an idle CPU (which requires to be woken up from an idle state).
>>>
>>> This patch updates both fast and slow paths with this optimization.
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>    kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++----------
>>>    1 file changed, 33 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 1277adc3e7ed..2e0527fd468c 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -5376,6 +5376,15 @@ static struct {
>>>    #endif /* CONFIG_NO_HZ_COMMON */
>>> +/* CPU only has SCHED_IDLE tasks enqueued */
>>> +static int sched_idle_cpu(int cpu)
>>> +{
>>> +	struct rq *rq = cpu_rq(cpu);
>>> +
>>> +	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
>>> +			rq->nr_running);
>>> +}
>>> +
>> Shouldn't this check if rq->curr is also sched idle?
> Why wouldn't the current set of checks be enough to guarantee that ?
I thought nr_running does not include the on-cpu thread.
>
>> And why not drop the rq->nr_running non zero check?
> Because CPU isn't sched-idle if nr_running and idle_h_nr_running are both 0,
> i.e. it is an IDLE cpu in that case. And so I thought it is important to have
> this check as well.
>
idle_cpu() not only checks nr_running is 0 but also rq->curr == rq->idle
