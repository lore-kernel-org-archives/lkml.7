Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1BFC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422BF22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfIDPxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:53:06 -0400
Received: from foss.arm.com ([217.140.110.172]:57552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730277AbfIDPxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:53:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BB8728;
        Wed,  4 Sep 2019 08:53:05 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C969A3F246;
        Wed,  4 Sep 2019 08:53:03 -0700 (PDT)
Subject: Re: [PATCH v4 05/10] KVM: arm64: Support stolen time reporting via
 shared structure
To:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-doc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20190830084255.55113-1-steven.price@arm.com>
 <20190830084255.55113-6-steven.price@arm.com>
 <d55d091f-1c0f-9c47-b7b2-95c87285335d@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <d68fd0f8-a01f-0939-8493-865c4f037783@arm.com>
Date:   Wed, 4 Sep 2019 16:53:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d55d091f-1c0f-9c47-b7b2-95c87285335d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2019 10:14, Zenghui Yu wrote:
> On 2019/8/30 16:42, Steven Price wrote:
>> Implement the service call for configuring a shared structure between a
>> VCPU and the hypervisor in which the hypervisor can write the time
>> stolen from the VCPU's execution time by other tasks on the host.
>>
>> The hypervisor allocates memory which is placed at an IPA chosen by user
>> space.
> 
> It seems that no allocation happens in the hypervisor code.  User space
> will do it instead?

Ah, yes I should update the commit message. User space does now allocate
the memory. Thanks for spotting that.

Steve

>> The hypervisor then updates the shared structure using
>> kvm_put_guest() to ensure single copy atomicity of the 64-bit value
>> reporting the stolen time in nanoseconds.
>>
>> Whenever stolen time is enabled by the guest, the stolen time counter is
>> reset.
>>
>> The stolen time itself is retrieved from the sched_info structure
>> maintained by the Linux scheduler code. We enable SCHEDSTATS when
>> selecting KVM Kconfig to ensure this value is meaningful.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> Thanks,
> zenghui
> 

