Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9313DC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E4620725
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfK3G60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 01:58:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6737 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfK3G60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 01:58:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 98767B9740C456E26BB8;
        Sat, 30 Nov 2019 14:58:24 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 14:58:17 +0800
Subject: Re: [PATCH] kvm/arm64: change gicv3_cpuif to static likely branch
To:     Marc Zyngier <maz@kernel.org>
References: <20191130031443.41696-1-guoheyi@huawei.com>
 <86mucdzx45.wl-maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
From:   Guoheyi <guoheyi@huawei.com>
Message-ID: <496cb45d-c312-295c-18f2-633ec5acc976@huawei.com>
Date:   Sat, 30 Nov 2019 14:58:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <86mucdzx45.wl-maz@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/30 14:39, Marc Zyngier wrote:
> On Sat, 30 Nov 2019 03:14:43 +0000,
> Heyi Guo <guoheyi@huawei.com> wrote:
>> Platforms running hypervisor nowadays are normally powerful servers
>> which at least support GICv3, so it should be better to switch
>> kvm_vgic_global_state.gicv3_cpuif to static likely branch, which can
>> reduce two "b" instructions to a single "nop" for GICv3 branches.
>>
>> We don't update arm32 specific code for they may still only have
>> GICv2.
> There is a number of disputable statements here.
>
> Out of the fairly large zoo of arm64 systems I have access to, 75% of
> them are based on GICv2, so they are still the overwhelming majority.
> Yes, they all run KVM (otherwise I would ignore them).
Really? I'm surprised to know that... Sorry I didn't see such GICv2 
platforms in my work, so I made the wrong assumption.
I don't expect much performance improvement for GICv3 platforms. The 
precondition for this patch is that few platforms running KVM are using 
GICv2. If it is not right, please just ignore it.

Thanks,
HG

>
> Furthermore, I would expect that "powerful servers" are perfectly
> capable to execute a couple of branches without breaking a sweat.
>
> Finally, you don't provide any number supporting that:
>
> - GICv3 systems see a performance improvement across the large variety
>    of CPU implementations
> - GICv2 systems don't see a performance regression
>
> Once you provide such numbers, I'll reevaluate my position. Until
> then, I'm not considering this kind of change.
>
> Thanks,
>
> 	M.
>


