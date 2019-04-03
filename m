Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFDDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BD32075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDCPYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:24:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfDCPYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:24:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [10.3.19.210])
        by Forcepoint Email with ESMTP id DAEF9EEF218A8A575B54;
        Wed,  3 Apr 2019 23:23:57 +0800 (CST)
Received: from [127.0.0.1] (10.184.212.80) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 23:23:50 +0800
From:   "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [RFC PATCH] irqchip/gic-v3: Make gic_handle_irq() notrace
To:     Julien Thierry <julien.thierry@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>, <rostedt@goodmis.org>
CC:     <mark.rutland@arm.com>, <suzuki.poulose@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <james.morse@arm.com>,
        <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        "huawei.libin@huawei.com >> libin 00196512" <huawei.libin@huawei.com>
References: <1553865808-30604-1-git-send-email-yuzenghui@huawei.com>
 <237b00d0-8a8d-ede6-91b1-c3e23e61925c@arm.com>
 <bf434b0c-2b17-b92d-3171-a57203486c84@huawei.com>
 <aad77b33-7eb0-57a6-2d60-1cb717c1e1c7@arm.com>
Message-ID: <73ec5893-ae0e-64a4-a914-18a09059a5ce@huawei.com>
Date:   Wed, 3 Apr 2019 23:23:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <aad77b33-7eb0-57a6-2d60-1cb717c1e1c7@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.212.80]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 2019/4/2 22:00, Julien Thierry wrote:
I meet this issue by coincidence before too.

> I finally found out what happens.
> 
> When using interrupt priority masking, at the begining of
> gic_handle_irq(), we are in this awkward state where we still have the I
> bit set and PMR unmasked (this is because we cannot ack the interrupt
> that was signaled if it has lower priority than the current priority mask).
> 
> To try and keep things simple, we decided that local_irq_*() would only
> deal with PMR (when using priority masking). With one additional case
> being that, if PSR.I is set when saving flags, we'd represent it in the
> form of a value of PMR (i.e. GIC_PRIO_IRQOFF), so that irqs_disabled()
> and such would still accurately state that no interrupt could happen in
> those sections. The assumption was that in the few sections were we are
> having the PSR.I set, we wouldn't care about having interrupts disabled
> with PSR.I or PMR. And now that assumption appears to be wrong:
I am confused of the logic of the save and restore here, why can't we do the
save & restore exactly?

> trace_graph_entry(), called at the begining of gic_handle_irq() when
> enabling the tracer, does use local_irq_save/restore(). The save
> operation returns flags GIC_PRIO_IRQOFF (because PSR.I is set when we
> enter gic_handle_irq() ). The restore operation will then proceed to
> mask PMR, once we get back to gic_handle_irq() we can't acknowledge the
> interrupt we just received...
> 
> The function tracer does not appear to save/restore flags on function
> entry (I saw save/restore operations in the stack tracer but for some
> reason couldn't get them to trigger the issue).
> 
> To confirm this, I checked with the following diff (which is not a fix,
> it is better to mark gic_handle_irq() as notrace if I don't find
> something more suitable).
> 
I am convinced a notrace marking here will walkaround this issue，but i am
afraid there is still some trouble like this else.
I send my modification to solve this issue just now, it is tested ok so far,
but i am not particularly sure, could you please have a look?

Thanks,
Wei

