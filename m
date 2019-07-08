Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3997C606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B6D2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfGHKml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 06:42:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbfGHKml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 06:42:41 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 213007686DB78DAE8ABD;
        Mon,  8 Jul 2019 18:42:39 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.120) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 8 Jul 2019
 18:42:26 +0800
Subject: Re: [PATCH] time: Validate the usec before covert to nsec in
 do_adjtimex
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <john.stultz@linaro.org>, <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1562572504-142115-1-git-send-email-zhangxiaoxu5@huawei.com>
 <alpine.DEB.2.21.1907081124000.3648@nanos.tec.linutronix.de>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <2c4e8e8d-6e90-0d09-cf28-45330eb598ce@huawei.com>
Date:   Mon, 8 Jul 2019 18:42:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907081124000.3648@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.189.120]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2019/7/8 17:24, Thomas Gleixner Ð´µÀ:
> On Mon, 8 Jul 2019, ZhangXiaoxu wrote:
> 
>> When covert the usec to nsec, it will multiple 1000, it maybe
>> overflow and lead an undefined behavior.
>>
>> For example, users may input an negative tv_usec values when
>> call adjtimex syscall, then multiple 1000 maybe overflow it
>> to a positive and legal number.
>>
>> So, we should validate the usec before coverted it to nsec.
> 
> That's correct, but the actuall inject function wants to keep the sanity
> check,
timekeeping_inject_offset is called only by timekeeping_warp_clock and do_adjtimex.
The do_adjtimex already validate it, and timekeeping_warp_clock is set tv_nsec=0.
We keep the sanity check is for some other maybe use this function?
I had send a v2 to keep the sanity check in timekeeping_inject_offset.

Thanks.
> 
> Thanks,
> 
> 	tglx
> 
> .
> 

