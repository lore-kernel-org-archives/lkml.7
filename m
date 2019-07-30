Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F12C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D502206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbfG3Is4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:48:56 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15795 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728761AbfG3Isz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:48:55 -0400
X-IronPort-AV: E=Sophos;i="5.64,326,1559491200"; 
   d="scan'208";a="72514925"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jul 2019 16:48:53 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id C6B944CDE88A;
        Tue, 30 Jul 2019 16:48:56 +0800 (CST)
Received: from [10.167.215.46] (10.167.215.46) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Tue, 30 Jul 2019 16:48:51 +0800
Message-ID: <5D400472.3080701@cn.fujitsu.com>
Date:   Tue, 30 Jul 2019 16:48:50 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <gorcunov@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sys_prctl(): remove unsigned comparision with less
 than zero
References: <20190723094809.GE4832@uranus.lan>  <1563934308-20833-1-git-send-email-xuyang2018.jy@cn.fujitsu.com> <20190724191448.4db70a34f8b89bd8bdc085f5@linux-foundation.org> <5D391DC0.3050100@cn.fujitsu.com>
In-Reply-To: <5D391DC0.3050100@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.46]
X-yoursite-MailScanner-ID: C6B944CDE88A.A0854
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on 2019/07/25 11:10, Yang Xu wrote:

>>> --- a/kernel/sys.c
>>> +++ b/kernel/sys.c
>>> @@ -2372,7 +2372,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>>                error = current->timer_slack_ns;
>>>            break;
>>>        case PR_SET_TIMERSLACK:
>>> -        if (arg2<= 0)
>>> +        if (arg2 == 0)
>>>                current->timer_slack_ns =
>>>                        current->default_timer_slack_ns;
>> A number of years ago Linus expressed approval of such comparisons with
>> unsigned quantities.  He felt that it improves readability a little -
>> the reader doesn't have to scroll back and check the type.
> Hi Andrew
>
>     It sounds good. ButWe still have to look at the actual situation. In here, this comparisons with unsigned
> quantities doesn't improvereadability. In turn, the code give user a wrongdescription  as man page said "
> If arg2 is less than or equal to zero, the "current" timer slack is reset to the thread's default" timer slack value."
> If we set -1 in user space, we pass it into kernel as ULONG_MAX, it will not use default timer_slack value.
> Also, I guess that if value has no actual sense we can use this comparisons. In here, arg2 represents slack time.
> time will never less than 0.
> ps: whether we change or not change this comparisons, it doesn't affect logic. So if you think this patch is meaningless,
> I will accept it.
Hi Andrew
   what do you think about it? update it or keep it.

Thanks
Yang Xu



