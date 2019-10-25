Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BC1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD10D21928
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbfJYCYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 22:24:35 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:51073 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728416AbfJYCYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:24:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=shannon.zhao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tg7Ey22_1571970253;
Received: from 30.43.121.138(mailfrom:shannon.zhao@linux.alibaba.com fp:SMTPD_---0Tg7Ey22_1571970253)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Oct 2019 10:24:32 +0800
Subject: Re: [PATCH RFC 0/7] Support KVM being compiled as a kernel module on
 arm64
To:     James Morse <james.morse@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        suzuki.poulose@arm.com, christoffer.dall@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
 <8cbd81d6-4ab8-9d2a-5162-8782201cd13d@arm.com>
From:   Shannon Zhao <shannon.zhao@linux.alibaba.com>
Message-ID: <975a0c6f-fdff-556f-b447-06edf24141df@linux.alibaba.com>
Date:   Fri, 25 Oct 2019 10:24:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8cbd81d6-4ab8-9d2a-5162-8782201cd13d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2019/10/24 18:58, James Morse wrote:
> Hi Shannon,
> 
> On 24/10/2019 11:27, Shannon Zhao wrote:
>> Curently KVM ARM64 doesn't support to compile as a kernel module. It's
>> useful to compile KVM as a module.
> 
>> For example, it could reload kvm without rebooting host machine.
> 
> What problem does this solve?
> 
> KVM has some funny requirements that aren't normal for a module. On v8.0 hardware it must
> have an idmap. Modules don't usually expect their code to be physically contiguous, but
> KVM does. KVM influences they way some of the irqchip stuff is set up during early boot
> (EOI mode ... not that I understand it).
> 
> (I think KVM-as-a-module on x86 is an artifact of how it was developed)
> 
> 
>> This patchset support this feature while there are some limitations
>> to be solved. But I just send it out as RFC to get more suggestion and
>> comments.
> 
>> Curently it only supports for VHE system due to the hyp code section
>> address variables like __hyp_text_start.
> 
> We still need to support !VHE systems, and we need to do it with a single image.
> 
I didn't make it clear. With this patchset we still support !VHE systems 
by choose CONFIG_KVM_ARM_HOST as y and by default CONFIG_KVM_ARM_HOST is 
y. And during module init, I add a check to avoid wrong usage for kvm 
module.

if (IS_MODULE(CONFIG_KVM_ARM_HOST) && !is_kernel_in_hyp_mode()) {
         kvm_err("kvm arm kernel module only supports for VHE system\n");
         return -ENODEV;
}


> 
>> Also it can't call
>> kvm_update_va_mask when loading kvm module and kernel panic with below
>> errors. So I make kern_hyp_va into a nop funtion.
> 
> Making this work for the single-Image on v8.0 is going to be a tremendous amount of work.
> What is the payoff?
> 
Actually we can limit this feature only working for VHE systems and 
don't influence !VHE systems.

Thanks,
Shannon
