Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8247C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A486C2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfCTObu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:31:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfCTObu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:31:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DFCE6765DF5636A4B0E4;
        Wed, 20 Mar 2019 22:31:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 22:31:37 +0800
Subject: Re: [RFC] Question about enable doorbell irq and halt_poll process
To:     "Tangnianyao (ICT)" <tangnianyao@huawei.com>,
        <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
References: <0fb3c9ba-8428-ea6c-2973-952624f601cc@huawei.com>
CC:     <wanghaibin.wang@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>
From:   Heyi Guo <guoheyi@huawei.com>
Message-ID: <f04863f2-1b50-3c66-e4cb-0cd8da239c77@huawei.com>
Date:   Wed, 20 Mar 2019 22:31:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <0fb3c9ba-8428-ea6c-2973-952624f601cc@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Marc and Christoffer...


On 2019/3/19 21:25, Tangnianyao (ICT) wrote:
> Hi, all
>
> Using gicv4, when guest is waiting for irq, it sends wfi and traps to kvm.
> When vlpi is forwarded to PE after its_vpe_deschedule, before halt_poll in
> kvm_vcpu_block, halt_poll may increase latency for this vlpi getting to guest.
> In halt_poll process, it checks if there's pending irq for vcpu using pending_last.
> However, doorbell is not enable at this moment and vlpi or doorbell can not set
> pending_last true, to stop halt_poll. It will run until halt_poll time ends, if
> there's no other physical irq coming in the meantime. And then vcpu is scheduled out.
> This pending vlpi has to wait for vcpu getting schedule in next time.
>
> Should we enable doorbell before halt_poll process ?
>
>
> .
>


