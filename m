Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151EBC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31E620656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfEHPFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:05:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbfEHPFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:05:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8C7C87885B1C5FA26FE;
        Wed,  8 May 2019 23:05:32 +0800 (CST)
Received: from [127.0.0.1] (10.184.38.59) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 May 2019
 23:05:26 +0800
Subject: Re: [PATCH] ftrace: enable trampoline when rec count decrement to one
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <mingo@redhat.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        <bobo.shaobowang@huawei.com>
References: <1556969979-111047-1-git-send-email-cj.chengjian@huawei.com>
 <20190505153447.594d4eab@oasis.local.home>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <e45dec40-d068-be47-7cbb-1b897e48c306@huawei.com>
Date:   Wed, 8 May 2019 23:02:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190505153447.594d4eab@oasis.local.home>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.38.59]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Steven


On 2019/5/6 3:34, Steven Rostedt wrote:
>
> Thanks for the patch. There was some race condition that prevented me
> from doing this in the first place, but unfortunately, I don't remember
> what that was :-/
>
> I'll have to think about this before applying this patch.
>
> Maybe there isn't a race condition, and I was just playing it safe, as
> there was a race condition between switching from regs caller back to
> non regs caller.
>
> -- Steve
> .


function tracer uses ftrace_caller() and livepatch uses 
ftrace_regs_caller().

I can modify my testcase to trigger this race condition.


#enable livepatch
insmod klp_unshare_files.ko
cat /sys/kernel/debug/tracing/enabled_functions
         unshare_files (1) R I	tramp: 0xffffffffc0008000 (klp_ftrace_handler+0x0/0xa0) ->ftrace_ops_assist_func+0x0/0xf0
[NOW, the rec caller is ftracer_regs_caller TRAMPOLINE]

#function tracer
echo unshare_files > /sys/kernel/debug/tracing/set_ftrace_filter
echo function > /sys/kernel/debug/tracing/current_tracer
cat /sys/kernel/debug/tracing/enabled_functions
         unshare_files (2) R I ->ftrace_ops_list_func+0x0/0x170
[NOW, the rec caller is ftracer_regs_caller]


# disable livepatch
echo 0 > /sys/kernel/livepatch/klp_unshare_files/enabled
rmmod klp_unshare_files


cat /sys/kernel/debug/tracing/enabled_functions
         unshare_files (1)    	tramp: 0xffffffffc0005000 (function_trace_call+0x0/0x120) ->function_trace_call+0x0/0x120
[NOW, the rec caller is ftrace_caller TRAMPOLINE]

So, the caller switch from regs caller back to non regs caller
when disable the livepatch. Could this testcase cause the race
condition ? BUT, Nothing happened here.

What will happen when the race triggers ? What can I do.


Thanks.

Cheng Jian.




