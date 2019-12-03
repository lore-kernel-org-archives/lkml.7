Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D49C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EEC206DC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfLCCXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:23:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfLCCXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 21:23:17 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D3460D6C91A6AB2F5720;
        Tue,  3 Dec 2019 10:23:15 +0800 (CST)
Received: from [127.0.0.1] (10.57.71.8) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 10:23:10 +0800
Subject: Re: ITS restore/save state when HCC == 0
To:     Marc Zyngier <maz@kernel.org>
CC:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Yangyingliang <yangyingliang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <fd89d78030914d19939a1fc1c6eb5048@huawei.com>
 <e04e35e0a14f1507ac4a3d56899adcae@www.loen.fr>
From:   Yao HongBo <yaohongbo@huawei.com>
Message-ID: <c8649d75-a9b8-4680-c253-3172774ac33d@huawei.com>
Date:   Tue, 3 Dec 2019 10:23:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e04e35e0a14f1507ac4a3d56899adcae@www.loen.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.71.8]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/2019 9:22 PM, Marc Zyngier wrote:
> Hi Yaohongbo,
> 
> In the future, please refrain from sending HTML emails, they
> don't render very well and force me to reformat your email
> by hand.

Sorry. I'll pay attention to this next time.

> On 2019-12-02 12:52, yaohongbo wrote:
>> Hi, marc.
>>
>> I met a problem with GIC ITS when I try to power off gic logic in
>> suspend.
>>
>> In hisilicon hip08, the value of GIC_TYPER.HCC is zero, so that
>> ITS_FLAGS_SAVE_SUSPEND_STATE will have no chance to be set to 1.
> 
> And that's a good thing. HCC indicates that you have collections that
> are backed by registers, and not memory. Which means that once the GIC
> is powered off, the state is lost.
> 
>> It goes well for s4, when I simply remove the condition judgement in
>> the code.
> 
> What is "s4"? Doing so means you are reprogramming the ITS with mappings
> that already exist in the tables, and that is UNPRED territory.

Sorry, I didn't describe it clearly.
S4 means "suspend to disk".
In s4, The its will reinit and malloc an new its address.

My expectation is to reprogram the ITS with original mappings. If ITS_FLAGS_SAVE_SUSPEND_STATE
is not set, i'll have no chance to use the original its table mappings.

What should i do if i want to restore its state with hcc == 0?

Thanks,
Hongbo.
> <quote>
> Behavior is unpredictable if there are interrupts that are mapped to the
> specified collection and the collection is currently mapped to a Redistributor
> [...]
> </quote>
> 
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>
>> @@ -3670,8 +3670,8 @@ static int __init its_probe_one(struct resource
>> *res,
>>
>>  ctlr |= GITS_CTLR_ImDe;
>>
>>  writel_relaxed(ctlr, its->base + GITS_CTLR);
>>
>> - if (GITS_TYPER_HCC(typer))
>>
>> - its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
>>
>> + its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
>>
>>  err = its_init_domain(handle, its);
>>
>>  if (err)
>>
>> @@ -4005,3 +4005,17 @@ int __init its_init(struct fwnode_handle
>> *handle, struct rdists *rdists,
>>
>>  return 0;
>>
>> }
>>
>> Do you have any suggestion for this case?
> 
> The expectations are that across a GIC power-off, the firmware
> will restore the state of the GIC (recondiguring the various
> memory tables), and that this is enough for the ITS to be
> functional again, having reloaded its state from memory.
> 
> Does firmware perform this on your machine? Or are there
> implementation-specific issues that require the ITS to be
> reprogrammed?
> 
> Thanks,
> 
>         M.

