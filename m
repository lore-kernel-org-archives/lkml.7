Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FFDC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 01:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B06208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 01:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GQ0jzzrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF2BWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 21:22:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33962 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF2BWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 21:22:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5T1Ixaq093372;
        Sat, 29 Jun 2019 01:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=fBGmRTkrzzmqFmPm0DXAkq8x/dtU+TebvIHnF1bOMkU=;
 b=GQ0jzzrVlKOppRKt/M1ZZ/8kWsNAA5b6xOUPTPkXAc9SvcNnc8JaZN9R1XinKMKhi4Th
 3VT7+lswdz0AGc0amxE/XqGSiq/VUrA7e4bk2+pnLQr62gt8GP5+o5giLIHqvlXEE0F3
 ioFHPbZv+ayXjc1DcATePJq+1axPTJN0oFXtYHVuoSR+zDMWl4qtbxi3rZ37YRYTmJ9Y
 aW16wfAsPCWd/7o0b8trsV/4SYwprcL40e2AiHE8nK+BN5KvjHC2LAz9RrSt1JzT6hqA
 2PS7kIPnwVtSd4dDu4vkZbyRkfLQkJNdHXHzS1glbuVyxSxwG8ljNL3se+TGpPY7Rs38 ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9q80m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jun 2019 01:21:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5T1LXe1185556;
        Sat, 29 Jun 2019 01:21:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tat7e7h6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jun 2019 01:21:37 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5T1LY34029233;
        Sat, 29 Jun 2019 01:21:36 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 18:21:34 -0700
Subject: Re: [PATCH V3 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU
 isn't found
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, songliubraving@fb.com
References: <cover.1561523542.git.viresh.kumar@linaro.org>
 <eeafa25fdeb6f6edd5b2da716bc8f0ba7708cbcf.1561523542.git.viresh.kumar@linaro.org>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <32bd769c-b692-8896-5cc9-d19ab0a23abb@oracle.com>
Date:   Fri, 28 Jun 2019 18:16:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <eeafa25fdeb6f6edd5b2da716bc8f0ba7708cbcf.1561523542.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906290012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906290013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/19 10:06 PM, Viresh Kumar wrote:
> We try to find an idle CPU to run the next task, but in case we don't
> find an idle CPU it is better to pick a CPU which will run the task the
> soonest, for performance reason.
>
> A CPU which isn't idle but has only SCHED_IDLE activity queued on it
> should be a good target based on this criteria as any normal fair task
> will most likely preempt the currently running SCHED_IDLE task
> immediately. In fact, choosing a SCHED_IDLE CPU over a fully idle one
> shall give better results as it should be able to run the task sooner
> than an idle CPU (which requires to be woken up from an idle state).
>
> This patch updates both fast and slow paths with this optimization.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++----------
>   1 file changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1277adc3e7ed..2e0527fd468c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5376,6 +5376,15 @@ static struct {
>   
>   #endif /* CONFIG_NO_HZ_COMMON */
>   
> +/* CPU only has SCHED_IDLE tasks enqueued */
> +static int sched_idle_cpu(int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
> +			rq->nr_running);
> +}
> +
Shouldn't this check if rq->curr is also sched idle? And why not drop the
rq->nr_running non zero check?
