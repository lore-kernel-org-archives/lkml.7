Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27153ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED7D21928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfIKJVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:21:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfIKJVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:21:24 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E6267DBB613FD0A61D59;
        Wed, 11 Sep 2019 17:21:21 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 17:21:13 +0800
Subject: Re: [PATCH 2/2] KVM: arm/arm64: Print the EC hex value with its exact
 width
To:     Marc Zyngier <maz@kernel.org>
CC:     <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
References: <1568169216-12632-1-git-send-email-yuzenghui@huawei.com>
 <1568169216-12632-3-git-send-email-yuzenghui@huawei.com>
 <86h85js083.wl-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <e013e828-5e61-8c07-510f-6cb4c59367cf@huawei.com>
Date:   Wed, 11 Sep 2019 17:19:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <86h85js083.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/9/11 16:31, Marc Zyngier wrote:
> On Wed, 11 Sep 2019 03:33:36 +0100,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> EC is the bits [31:26] of ESR_ELx on arm64 (HSR on arm). Print the
>> hex value with its exact width (8).
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   virt/kvm/arm/trace.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
>> index 204d210d01c2..022b0a060034 100644
>> --- a/virt/kvm/arm/trace.h
>> +++ b/virt/kvm/arm/trace.h
>> @@ -42,7 +42,7 @@ TRACE_EVENT(kvm_exit,
>>   		__entry->vcpu_pc		= vcpu_pc;
>>   	),
>>   
>> -	TP_printk("%s: HSR_EC: 0x%04x (%s), PC: 0x%08lx",
>> +	TP_printk("%s: HSR_EC: 0x%02x (%s), PC: 0x%08lx",
>>   		  __print_symbolic(__entry->ret, kvm_arm_exception_type),
>>   		  __entry->esr_ec,
>>   		  __print_symbolic(__entry->esr_ec, kvm_arm_exception_class),
> 
> Although you're right that 8 bits ought to be enough, this is a change
> to the output of the tracepoint, which userspace could (does?) parse.

Well-written userspace tools should only parse the low 8 bits (if they
do parse). But even if the high bits are parsed, they're always 0.
So I don't think this change will have a bad impact on userspace.

> I'm thus reluctant to change anything there, knowing that we don't
> lose any information, and just print two extra zeroes.

Anyway this is not a fix, feel free to ignore it if you're worried about
that there might be some issues ;)

> Am I missing anything?

No.


Thanks,
zenghui

