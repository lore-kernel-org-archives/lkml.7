Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAC3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CD5218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfC2Pgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:36:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728853AbfC2Pgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:36:40 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DBB675080E40E009727B;
        Fri, 29 Mar 2019 23:36:31 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Fri, 29 Mar 2019
 23:36:22 +0800
Subject: Re: [RFC PATCH] irqchip/gic-v3: Make gic_handle_irq() notrace
To:     Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <julien.thierry@arm.com>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <james.morse@arm.com>, <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1553865808-30604-1-git-send-email-yuzenghui@huawei.com>
 <237b00d0-8a8d-ede6-91b1-c3e23e61925c@arm.com>
 <20190329105332.6b7fc1ae@gandalf.local.home>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <e08f603a-29d4-07a7-35b9-68fcdf50b338@huawei.com>
Date:   Fri, 29 Mar 2019 23:35:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190329105332.6b7fc1ae@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 2019/3/29 22:53, Steven Rostedt wrote:
> On Fri, 29 Mar 2019 13:58:40 +0000
> Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
>> On the other hand, if you can generate pseudo-NMIs, you could end-up
>> tracing gic_handle_irq whilst being inside the tracing code with
>> interrupts being notionally disabled (and that could be pretty bad).
> 
> Actually, that should still be safe. The tracing code is expected to
> trace NMIs.
> 
> Now the entry of an NMI can be an issue because of the way tracing is
> enabled. But this would also cause function tracing to crash, which was
> not stated. Does function tracing have the same issue, or is this just
> with function_graph tracing?

This is just with function_graph tracing. Function tracing works fine.

> 
> This is because a breakpoint is added to all the places that are going
> to be traced so that the "nops" at the beginning of function calls are
> going to be converted to calls to the tracer. Now that means a
> breakpoint is being added at the beginning of gic_handle_irq(). I don't
> know how this pseudo NMI works, but we have notrace set for do_NMI
> because breakpoints at the entry (before it can fix things) causes
> issues. But this still doesn't make sense because the gic_handle_irq()
> call doesn't fix things up either, so other functions that are traced
> by gic_handle_irq() should blow up too, which appears (by the patch)
> not to be the case.

Thanks for your explanation. I will read the code around further, and
get back to you if there's any discovery.


thanks,

zenghui

> 
> -- Steve
> 
> .
> 

