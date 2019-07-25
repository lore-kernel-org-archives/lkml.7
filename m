Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498CFC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCD721852
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389720AbfGYDLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:11:02 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:57997 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388594AbfGYDLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:11:01 -0400
X-IronPort-AV: E=Sophos;i="5.64,305,1559491200"; 
   d="scan'208";a="72161282"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jul 2019 11:11:00 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 10AD04CDE64D;
        Thu, 25 Jul 2019 11:10:59 +0800 (CST)
Received: from [10.167.215.46] (10.167.215.46) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Thu, 25 Jul 2019 11:11:00 +0800
Message-ID: <5D391DC0.3050100@cn.fujitsu.com>
Date:   Thu, 25 Jul 2019 11:10:56 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <gorcunov@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sys_prctl(): remove unsigned comparision with less
 than zero
References: <20190723094809.GE4832@uranus.lan>  <1563934308-20833-1-git-send-email-xuyang2018.jy@cn.fujitsu.com> <20190724191448.4db70a34f8b89bd8bdc085f5@linux-foundation.org>
In-Reply-To: <20190724191448.4db70a34f8b89bd8bdc085f5@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.46]
X-yoursite-MailScanner-ID: 10AD04CDE64D.A18B6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on 2019/07/25 10:14, Andrew Morton wrote:

> On Wed, 24 Jul 2019 10:11:48 +0800 Yang Xu<xuyang2018.jy@cn.fujitsu.com>  wrote:
>
>> Currently, when calling prctl(PR_SET_TIMERSLACK, arg2), arg2 is an
>> unsigned long value, arg2 will never<  0. Negative judgment is
>> meaningless, so remove it.
>>
>> ...
>>
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -2372,7 +2372,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>   			error = current->timer_slack_ns;
>>   		break;
>>   	case PR_SET_TIMERSLACK:
>> -		if (arg2<= 0)
>> +		if (arg2 == 0)
>>   			current->timer_slack_ns =
>>   					current->default_timer_slack_ns;
> A number of years ago Linus expressed approval of such comparisons with
> unsigned quantities.  He felt that it improves readability a little -
> the reader doesn't have to scroll back and check the type.
Hi Andrew

    It sounds good. ButWe still have to look at the actual situation. In here, this comparisons with unsigned
quantities doesn't improvereadability. In turn, the code give user a wrongdescription  as man page said "
If arg2 is less than or equal to zero, the "current" timer slack is reset to the thread's default" timer slack value."

If we set -1 in user space, we pass it into kernel as ULONG_MAX, it will not use default timer_slack value.

Also, I guess that if value has no actual sense we can use this comparisons. In here, arg2 represents slack time.
time will never less than 0.

ps: whether we change or not change this comparisons, it doesn't affect logic. So if you think this patch is meaningless,
I will accept it.

Thanks
Yang Xu

>
>
>
>



