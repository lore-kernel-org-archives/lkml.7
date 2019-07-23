Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E81C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC3C223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfGWILT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:11:19 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18448 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729455AbfGWILS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:11:18 -0400
X-IronPort-AV: E=Sophos;i="5.64,298,1559491200"; 
   d="scan'208";a="72014385"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jul 2019 16:11:14 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id DA0F64CDBF7D;
        Tue, 23 Jul 2019 16:11:12 +0800 (CST)
Received: from [10.167.215.46] (10.167.215.46) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Tue, 23 Jul 2019 16:11:10 +0800
Message-ID: <5D36C11D.1070804@cn.fujitsu.com>
Date:   Tue, 23 Jul 2019 16:11:09 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Cyrill Gorcunov <gorcunov@gmail.com>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sys_prctl(): simplify arg2 judgment when calling PR_SET_TIMERSLACK
References: <1563852653-2382-1-git-send-email-xuyang2018.jy@cn.fujitsu.com> <20190723072338.GD4832@uranus.lan>
In-Reply-To: <20190723072338.GD4832@uranus.lan>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.46]
X-yoursite-MailScanner-ID: DA0F64CDBF7D.A3BE5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on 2019/07/23 15:23, Cyrill Gorcunov wrote:

> On Tue, Jul 23, 2019 at 11:30:53AM +0800, Yang Xu wrote:
>> arg2 will never<  0, for its type is 'unsigned long'. So negative
>> judgment is meaningless.
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   kernel/sys.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 2969304c29fe..399457d26bef 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -2372,11 +2372,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>   			error = current->timer_slack_ns;
>>   		break;
>>   	case PR_SET_TIMERSLACK:
>> -		if (arg2<= 0)
>> +		if (arg2)
>> +			current->timer_slack_ns = arg2;
>> +		else
>>   			current->timer_slack_ns =
>>   					current->default_timer_slack_ns;
>> -		else
>> -			current->timer_slack_ns = arg2;
>>   		break;
>>   	case PR_MCE_KILL:
>>   		if (arg4 | arg5)
> > From a glance it looks correct to me, but then...
>
> 1) you might simply compare with zero, iow if (arg2 == 0)
>     instead of changing 7 lines
Hi Cyril

Indeed.  simply compare with zero might be better.

> 2) according to man page passing negative value should be acceptable,
>     though it never worked as expected. I've been grepping "git log"
>     for this file and the former API is coming from
>
> commit 6976675d94042fbd446231d1bd8b7de71a980ada
> Author: Arjan van de Ven<arjan@linux.intel.com>
> Date:   Mon Sep 1 15:52:40 2008 -0700
>
>      hrtimer: create a "timer_slack" field in the task struct
>
> which is 11 years old by now. Nobody complained so far even when man
> page is saying pretty obviously
>
>         PR_SET_TIMERSLACK (since Linux 2.6.28)
>                Each thread has two associated timer slack values:  a  "default"
>                value, and a "current" value.  This operation sets the "current"
>                timer slack value for the calling  thread.   If  the  nanosecond
>                value  supplied in arg2 is greater than zero, then the "current"
>                value is set to this value.  If arg2 is less than  or  equal  to
>                zero,  the  "current"  timer  slack  is  reset  to  the thread's
>                "default" timer slack value.
>
> So i think to match the man page (and assuming that accepting negative value
> has been supposed) we should rather do
>
> 	if ((long)arg2<  0)
Looks correct. But if we set a ULONG_MAX(PR_GET_TIMERSLACK also limits ULONG_MAX)
value(about 4s) on 32bit machine, this code will think this value is a negative value and use default value.

I guess man page was written as "less than or equal to zero" because of this confusing code(arg2<=0, but arg2
is an unsinged long value).
I think we can change this man page and also add bounds value description.

Also, I found a patch about arg2 is an unsigned long value

commit 7fe5e04292e71af34ae171b88caa2a139e0b6125
Author: Chen Gang<gang.chen@asianux.com>
Date:   Thu Feb 21 16:43:06 2013 -0800

     sys_prctl(): arg2 is unsigned long which is never<  0

     arg2 will never<  0, for its type is 'unsigned long'

     Also, use the provided macros.

What do you think about it ?

> Thoughts?
>
>
>



