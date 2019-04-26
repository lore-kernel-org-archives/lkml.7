Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AC0C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DE22077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfDZIUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:20:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfDZIUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:20:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E75E02147DE2A2CE49E9;
        Fri, 26 Apr 2019 16:19:57 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Apr 2019
 16:19:51 +0800
Subject: Re: [RFC PATCH 0/3] Enable kprobe to monitor sdei event handler
To:     James Morse <james.morse@arm.com>
CC:     <huawei.libin@huawei.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1555070699-3685-1-git-send-email-wangxiongfeng2@huawei.com>
 <d197785a-9e3b-2c88-d882-b59075a38264@arm.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <21ba32f1-6291-ac0a-43d3-77b5f17517a3@huawei.com>
Date:   Fri, 26 Apr 2019 16:19:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d197785a-9e3b-2c88-d882-b59075a38264@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for your reply!

On 2019/4/25 0:20, James Morse wrote:
> Hi Xiongfeng Wang,
> 
> On 12/04/2019 13:04, Xiongfeng Wang wrote:
>> When I use kprobe to monitor a sdei event handler,
> 
> Don't do this! SDEI is like an NMI, it isn't safe to kprobe it as it can interrupt the
> kprobe code, causing it become re-entrant.
> 
> 
>> the CPU will hang. It's
>> because when I probe the event handler, the instruction will be replaced with 
>> brk instruction and brk exception is unmaskable. But 'vbar_el1' contains 
>> 'tramp_vectors' in '_sdei_handler' when SDEI events interrupt userspace, so
>> we will go to the wrong place if brk exception happens.
> 
> This was lucky! Its even more fun if the SDEI event interrupted a guest: the kvm vectors
> will give you a hyp-panic.
> 
> The __kprobes and NOKPROBE_SYMBOL() litter should stop you doing this.
> 
> 
>> I notice that 'ghes_sdei_normal_callback' call several funtions that are not
>> marked as 'nokprobe'.
> 
> Bother. We should probably blacklist those too, its not safe.
> 
> 
>> So I was wondering if we can enable kprobe in '_sdei_handler'.
> 
> I don't think this can be done safely.
> 
> 
> If you need to monitor your SDEI event handler you can just use printk(). Once nmi_enter()
> has been called these are safe as they stash data in a per-cpu buffer. The SDEI handler
> will exit via the IRQ vector if it can, which will cause this buffer to be flushed to the
> console in a timely manner.
> 

Thanks for your advice. I agree it's really not a good idea to take exception in NMI context.

> 
> Why do you need to kprobe an NMI handler?
> 

Because that 'Pseudo NMI' has a great effect on performance, we are still planning to
use SDEI for hardlockup detection.

When someone kprobe the functions in _sdei_handler, things will go wrong.
It's not that we want to monitor the SDEI event handler. It's just that we want to make sure
the system goes well even some people are monitoring any functions available. Some test engineer
may test 'kprobe' by monitoring all the functions that are allowed to be kprobed.
Anyway, thanks for your advice. I think I will need to mark all the functions called
in __sdei_handler as 'nokprobe'.

Thanks,
Xiongfeng

> 
> 
> Thanks!
> 
> James
> 
> .
> 

