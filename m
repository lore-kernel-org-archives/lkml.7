Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29200CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA1F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbfJ2Nbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:31:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388602AbfJ2Nbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:31:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B145089EF28F21D4DC20;
        Tue, 29 Oct 2019 21:31:27 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 21:31:19 +0800
Subject: Re: [PATCH 3/3] KVM: arm/arm64: vgic: Don't rely on the wrong pending
 table
To:     Auger Eric <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>
CC:     <suzuki.poulose@arm.com>, <linux-kernel@vger.kernel.org>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <wanghaibin.wang@huawei.com>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191029071919.177-1-yuzenghui@huawei.com>
 <20191029071919.177-4-yuzenghui@huawei.com> <86mudjykfa.wl-maz@kernel.org>
 <f8a30e65-7077-301a-1558-7fc504b5e891@huawei.com>
 <e2141f6a-c530-46d5-d5d9-26806b02d55b@redhat.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <01638947-ce47-2e09-68f0-a95eb6e9b2d0@huawei.com>
Date:   Tue, 29 Oct 2019 21:31:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <e2141f6a-c530-46d5-d5d9-26806b02d55b@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2019/10/29 20:49, Auger Eric wrote:
> On 10/29/19 1:27 PM, Zenghui Yu wrote:
>> okay, the remaining question is that in vgic_v3_save_pending_tables():
>>
>>      stored = val & (1U << bit_nr);
>>      if (stored == irq->pending_latch)
>>          continue;
>>
>>      if (irq->pending_latch)
>>          val |= 1 << bit_nr;
>>      else
>>          val &= ~(1 << bit_nr);
>>
>> Do we really have a scenario where irq->pending_latch==false and
>> stored==true (corresponds to the above "else") and then we clear
>> pending status of this LPI in guest memory?
>> I can not think out one now.
> 
> if you save, restore and save again. On the 1st save the LPI may be
> pending, it gets stored. On the second save the LPI may be not pending
> anymore?

I assume you mean the "restore" by vgic_its_restore_ite().

While restoring a LPI, we will sync the pending status from guest
pending table (into the software pending_latch), and clear the
corresponding bit in guest memory.
See vgic_v3_lpi_sync_pending_status().

So on the second save, the LPI can be not pending, the guest pending
table will also indicate not pending.


Thanks,
Zenghui

