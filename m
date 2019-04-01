Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C60EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ABD206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tJaYRICc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfDAVjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:39:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50376 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfDAVje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:39:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x31LXxVH165824;
        Mon, 1 Apr 2019 21:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XfDzD4vAZC/JVATNC4UDEF7mqisZp7Wn46lAtr7gXvw=;
 b=tJaYRICcdXgHGPqGCJhJ9X2EgLsLtmBQ8gPhqJek1KBYd8gJ0DhyKJKBEVihKUItgsh2
 QlrSnpWl1WFe/hbKZ26GMjELUfFkxLZlbhbld8NOsU5/EDa75OJm2UnO3klih6JbVcPw
 Toe0I3KUfDlcPfjZ9YRJJGVQFy1VbdyJGMszRpLGcwioWS7eYjDh1HJp5sCzkn/dS6lm
 Sx3YYTDv3YFBbuqlCeAvFVngwMS748+HJU31UdJVyFCgTbeRitMor9BoUQmHActmy1iO
 hYFvgXM2lBCAJ5e1q6aOks6LAd0jqRgpba3BSkK3lZ3HFjKXk9qtLuLkLKEoLyZx3FM9 VA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2rj13q1h6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 21:39:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x31LctKZ004678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 21:38:56 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x31LcsxO025394;
        Mon, 1 Apr 2019 21:38:54 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 14:38:54 -0700
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
References: <fcad329b-e421-624a-0d1a-a98466eaf2ed@oracle.com>
 <1553866527-18879-1-git-send-email-jdesfossez@digitalocean.com>
 <6e8e6fa0-8976-5e97-d90c-af0b4a6fc8b2@oracle.com>
Message-ID: <cd11cde9-4aed-b02f-cae5-170bb6fa686b@oracle.com>
Date:   Mon, 1 Apr 2019 14:35:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6e8e6fa0-8976-5e97-d90c-af0b4a6fc8b2@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/19 3:23 PM, Subhra Mazumdar wrote:
>
> On 3/29/19 6:35 AM, Julien Desfossez wrote:
>> On Fri, Mar 22, 2019 at 8:09 PM Subhra Mazumdar 
>> <subhra.mazumdar@oracle.com>
>> wrote:
>>> Is the core wide lock primarily responsible for the regression? I ran
>>> upto patch
>>> 12 which also has the core wide lock for tagged cgroups and also calls
>>> newidle_balance() from pick_next_task(). I don't see any 
>>> regression.  Of
>>> course
>>> the core sched version of pick_next_task() may be doing more but
>>> comparing with
>>> the __pick_next_task() it doesn't look too horrible.
>> On further testing and investigation, we also agree that spinlock 
>> contention
>> is not the major cause for the regression, but we feel that it should 
>> be one
>> of the major contributing factors to this performance loss.
>>
>>
> I finally did some code bisection and found the following lines are
> basically responsible for the regression. Commenting them out I don't see
> the regressions. Can you confirm? I am yet to figure if this is needed 
> for
> the correctness of core scheduling and if so can we do this better?
>
> -------->8-------------
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fe3918c..3b3388a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3741,8 +3741,8 @@ pick_next_task(struct rq *rq, struct task_struct 
> *prev, struct rq_flags *rf)
>                                  * If there weren't no cookies; we 
> don't need
>                                  * to bother with the other siblings.
> */
> -                               if (i == cpu && !rq->core->core_cookie)
> -                                       goto next_class;
> +                               //if (i == cpu && !rq->core->core_cookie)
> +                                       //goto next_class;
>
> continue;
>                         }
AFAICT this condition is not needed for correctness as cookie matching will
sill be enforced. Peter any thoughts? I get the following numbers with 1 DB
and 2 DB instance.

1 DB instance
users  baseline   %idle  core_sched %idle
16     1          84     -5.5% 84
24     1          76     -5% 76
32     1          69     -0.45% 69

2 DB instance
users  baseline   %idle  core_sched %idle
16     1          66     -23.8% 69
24     1          54     -3.1% 57
32     1          42     -21.1%      48
