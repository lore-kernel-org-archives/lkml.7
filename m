Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4F8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117BD21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408706AbfJYJIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:08:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408378AbfJYJIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:08:05 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 718267F90D984722DF34;
        Fri, 25 Oct 2019 17:08:03 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 17:07:55 +0800
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Use the exact ITSList for VMOVP
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <wanghaibin.wang@huawei.com>, <jiayanlei@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1571802386-2680-1-git-send-email-yuzenghui@huawei.com>
 <0f99f6a4ea567f53d38fb3bc0e6f59e4@www.loen.fr>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <6bc4a648-4308-3ff8-8e73-d90040e74c99@huawei.com>
Date:   Fri, 25 Oct 2019 17:06:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <0f99f6a4ea567f53d38fb3bc0e6f59e4@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/25 16:24, Marc Zyngier wrote:
> On 2019-10-23 04:46, Zenghui Yu wrote:
>> On a system without Single VMOVP support (say GITS_TYPER.VMOVP == 0),
>> we will map vPEs only on ITSs that will actually control interrupts
>> for the given VM.  And when moving a vPE, the VMOVP command will be
>> issued only for those ITSs.
>>
>> But when issuing VMOVPs we seemed fail to present the exact ITSList
>> to ITSs who are actually included in the synchronization operation.
>> The its_list_map we're currently using includes all ITSs in the system,
>> even though some of them don't have the corresponding vPE mapping at all.
>>
>> Introduce get_its_list() to get the per-VM its_list_map, to indicate
>> which ITSs have vPE mappings for the given VM, and use this map as
>> the expected ITSList when building VMOVP. This is hopefully a performance
>> gain not to do some synchronization with those unsuspecting ITSs.
>> And initialize the whole command descriptor to zero at beginning, since
>> the seq_num and its_list should be RES0 when GITS_TYPER.VMOVP == 1.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> 
> I've applied this as a fix for 5.4. In the future, please cc LKML on all
> IRQ-related patches (as documented in MAINTAINERS).

I got it, thanks.


Zenghui

