Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76854C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4583E2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FVH/1fBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfENQDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:03:53 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35382 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENQDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:03:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EFrh4T075818;
        Tue, 14 May 2019 16:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LKX2pJCZMM1fM5+jEyMtPXBt1Ui1VdtBDPvhsBNL6VM=;
 b=FVH/1fBVq/9bb+b70RdubSY71Oyx9B4cg5tSjA/xyWD1lO4HlKakAfyzhJG+ogf1EUso
 zyPY6j9o64v1FPRW5c8/st1MX63dHPSPq7nTHRNsxl1ug/vTW8kbay97eCLhZMVK35iu
 ckHACP/VX5R0Fct1yr7wy9sZXjZ0QP/c0V9mCBIbjFrQ2mU9IXwxU1cufpGH73v7hqLd
 oeSW/hjJX8SksaBF9Sri2LOLxKy6izpfVXxbq61m0qvtJ0TMPWESyUCT9piVoKmoEreb
 IgIGrweG0ngmlbXXXNd3Th8cGvXvHwtr6224ljvbNExUSaq18EOcpsr+DLxmBkX/fGI9 wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2sdkwdqc1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 16:03:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EG3LuL022208;
        Tue, 14 May 2019 16:03:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2se0tw84k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 16:03:27 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4EG3NOK000843;
        Tue, 14 May 2019 16:03:25 GMT
Received: from [172.10.12.21] (/24.113.124.115)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 May 2019 09:03:23 -0700
Subject: Re: [RFC V2 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU
 isn't found
To:     Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>
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
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <05ffe5f4-4324-2977-e46e-155e1aef57fa@oracle.com>
Date:   Tue, 14 May 2019 12:03:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513113518.GQ2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140113
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/2019 7:35 AM, Peter Zijlstra wrote:
> On Mon, May 13, 2019 at 03:04:18PM +0530, Viresh Kumar wrote:
>> On 10-05-19, 09:21, Peter Zijlstra wrote:
> 
>>> I don't hate his per se; but the whole select_idle_sibling() thing is
>>> something that needs looking at.
>>>
>>> There was the task stealing thing from Steve that looked interesting and
>>> that would render your apporach unfeasible.
>>
>> I am surely missing something as I don't see how that patchset will
>> make this patchset perform badly, than what it already does.
> 
> Nah; I just misremembered. I know Oracle has a patch set poking at
> select_idle_siblings() _somewhere_ (as do I), and I just found the wrong
> one.
> 
> Basically everybody is complaining select_idle_sibling() is too
> expensive for checking the entire LLC domain, except for FB (and thus
> likely some other workloads too) that depend on it to kill their tail
> latency.
> 
> But I suppose we could still do this, even if we scan only a subset of
> the LLC, just keep track of the last !idle CPU running only SCHED_IDLE
> tasks and pick that if you do not (in your limited scan) find a better
> candidate.

Subhra posted a patch that incrementally searches for an idle CPU in the LLC,
remembering the last CPU examined, and searching a fixed number of CPUs from there.
That technique is compatible with the one that Viresh suggests; the incremental
search would stop if a SCHED_IDLE cpu was found.

I also fiddled with select_idle_sibling, maintaining a per-LLC bitmap of idle CPUs,
updated with atomic operations.  Performance was basically unchanged for the
workloads I tested, and I inserted timers around the idle search showing it was
a very small fraction of time both before and after my changes.  That led me to
ignore the push side and optimize the pull side with task stealing.

I would be very interested in hearing from folks that have workloads that demonstrate
that select_idle_sibling is too expensive.

- Steve
