Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796C9C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548A320835
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfI0CBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:01:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbfI0CBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 22:01:35 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F33E9AE4EF0C1B462D03;
        Fri, 27 Sep 2019 10:01:30 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Sep 2019
 10:01:20 +0800
Subject: Re: [PATCH 10/35] irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER)
 allocation
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-11-maz@kernel.org>
 <155660c2-7f30-e188-ca8d-c37fabea6d97@huawei.com>
 <6f4ccdfd-4b63-04cb-e7c0-f069e620127f@kernel.org>
 <14111988-74c9-12c3-1322-1580ff6ba11f@huawei.com>
 <c4d63ccd-b5b2-007f-6174-1a9d20f3669d@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <56ddfedd-5d8c-0507-c164-b04d63f51a1e@huawei.com>
Date:   Fri, 27 Sep 2019 09:59:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <c4d63ccd-b5b2-007f-6174-1a9d20f3669d@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/26 23:57, Marc Zyngier wrote:
> On 26/09/2019 16:19, Zenghui Yu wrote:
>> On 2019/9/25 22:41, Marc Zyngier wrote:
>>>
>>> Indeed. The whole idea is that ITSs and RDs can share a vPE table if
>>> they are in the same affinity group (such as a socket, for example).
>>> This is what is missing from v4.0 where the ITS knows about vPEs, but
>>> doesn't know about residency. With that in place, the HW is able to do a
>>> lot more for us.
>>
>> Thanks for your education!
>>
>> I really want to know *how* does GICv4.1 ITS know about the vPE
>> residency (in hardware level)?
> 
> Hey, I'm a SW guy, I don't design the hardware! ;-)
> 
>> I can understand that Redistributor can easily achieve it by
>> VPENDBASER's Valid and vPEID field.  And it's necessary for ITS to
>> know the residency so that it can determine whether it's appropriate
>> to trigger default doorbell for vPE.  But I have no knowledge about
>> how can it be achieved in hardware details.
> 
> My take is that the RD and the ITS can communicate over the shared
> table, hence my remark above about SVPET==0. But as I said, I'm not a HW
> guy.

;-) I should have asked our GIC engineers for these things.


Thanks,
zenghui

