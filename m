Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD0BC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC1D2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gyFIyQee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfGBQc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:32:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59514 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGBQc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:32:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x62GSjVN126940;
        Tue, 2 Jul 2019 16:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=V6zyJ4bO2QMT00Z6oYGNErrb5xIXIwQiZGKmcQuzSec=;
 b=gyFIyQeeU5V1VJjfKmFjM/pM6f4ampcnzQOlLRpS+gt7MbfLfyVcaBzfCE8SeCxLbySp
 1xUrQmltUD4dDLQr0ccuHPXpE6x632WkOgiCgLIGmgp/At38DyNXffTtgaULh7ZPHuXv
 91YymBTqLrozEf6sZxI9nP0qjSGce1poGN2GV0P4ZfIAsfszsCiAsdrBGlzcUrC3nvg/
 cdpjzESaxvP+ruG5xc8THyz1Ty8ecUA3mA8bXaFEdgnU/Hvvvy3BRO3XpDRu38Gh0EAF
 c5iNnj20Q3GwASLouGMl8/TBDOZDK+iRv5QgCxbdl/DxnMR4DUrGRFI8JxQ46R2iZscJ qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2te61pvrn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 16:32:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x62GWXgl149557;
        Tue, 2 Jul 2019 16:32:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tebakv5k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 16:32:33 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x62GWVaa019385;
        Tue, 2 Jul 2019 16:32:31 GMT
Received: from Subhras-MacBook-Pro.local (/73.252.215.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 09:32:30 -0700
Subject: Re: [PATCH V3 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU
 isn't found
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, songliubraving@fb.com
References: <cover.1561523542.git.viresh.kumar@linaro.org>
 <eeafa25fdeb6f6edd5b2da716bc8f0ba7708cbcf.1561523542.git.viresh.kumar@linaro.org>
 <32bd769c-b692-8896-5cc9-d19ab0a23abb@oracle.com>
 <20190701080349.homlsgia4fuaitek@vireshk-i7>
 <aeaa0dd5-8512-1b60-eb10-6a4aecfaaca3@oracle.com>
 <20190702083517.GY3419@hirez.programming.kicks-ass.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <1fe415a7-a396-508c-f459-0ddcc36f3360@oracle.com>
Date:   Tue, 2 Jul 2019 09:32:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702083517.GY3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/2/19 1:35 AM, Peter Zijlstra wrote:
> On Mon, Jul 01, 2019 at 03:08:41PM -0700, Subhra Mazumdar wrote:
>> On 7/1/19 1:03 AM, Viresh Kumar wrote:
>>> On 28-06-19, 18:16, Subhra Mazumdar wrote:
>>>> On 6/25/19 10:06 PM, Viresh Kumar wrote:
>>>>> @@ -5376,6 +5376,15 @@ static struct {
>>>>>     #endif /* CONFIG_NO_HZ_COMMON */
>>>>> +/* CPU only has SCHED_IDLE tasks enqueued */
>>>>> +static int sched_idle_cpu(int cpu)
>>>>> +{
>>>>> +	struct rq *rq = cpu_rq(cpu);
>>>>> +
>>>>> +	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
>>>>> +			rq->nr_running);
>>>>> +}
>>>>> +
>>>> Shouldn't this check if rq->curr is also sched idle?
>>> Why wouldn't the current set of checks be enough to guarantee that ?
>> I thought nr_running does not include the on-cpu thread.
> It very much does.
>
>>>> And why not drop the rq->nr_running non zero check?
>>> Because CPU isn't sched-idle if nr_running and idle_h_nr_running are both 0,
>>> i.e. it is an IDLE cpu in that case. And so I thought it is important to have
>>> this check as well.
>>>
>> idle_cpu() not only checks nr_running is 0 but also rq->curr == rq->idle
> idle_cpu() will try very hard to declare a CPU !idle. But I don't see
> how that it relevant. sched_idle_cpu() will only return true if there
> are only SCHED_IDLE tasks on the CPU. Viresh's test is simple and
> straight forward.

OK makes sense.

Thanks,
Subhra

