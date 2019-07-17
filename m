Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9F0C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34272182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563375636;
	bh=/hXc0okAjpHRhsmnfoanm/BcZUkXMPwYAD8zseHGmFo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Ym0teakWYJHl+7ciQ7U+OpaREMpVPrgUyAhdeAfvcVz8glgry3di2m0N7RqEKkqvK
	 HBlqiUmkTvjElKZPJwXXNcA34mSX2X54NV4p2ksM0W6klzxv8IL2gYXczPLHYm/CPY
	 2jNPEFtnqkDtLJ8BXL3XExMhDc8Z3U04Y9P4WjYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfGQPAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:00:35 -0400
Received: from foss.arm.com ([217.140.110.172]:48156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfGQPAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:00:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B405337;
        Wed, 17 Jul 2019 08:00:34 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0A773F71A;
        Wed, 17 Jul 2019 08:00:32 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm/arm64: Assign pmc->idx before
 kvm_pmu_stop_counter()
To:     Julien Thierry <julien.thierry@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, james.morse@arm.com, suzuki.poulose@arm.com,
        julien.thierry.kdev@gmail.com, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com, andrew.murray@arm.com
References: <1563366019-31200-1-git-send-email-yuzenghui@huawei.com>
 <01fa98c1-8274-445c-5e04-219372920ba2@arm.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <26b64d48-5ff9-7d62-bc44-601fdcc43223@kernel.org>
Date:   Wed, 17 Jul 2019 16:00:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <01fa98c1-8274-445c-5e04-219372920ba2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2019 14:44, Julien Thierry wrote:
> Hi Zenghui,
> 
> On 17/07/2019 13:20, Zenghui Yu wrote:
>> We use "pmc->idx" and the "chained" bitmap to determine if the pmc is
>> chained, in kvm_pmu_pmc_is_chained().  But idx might be uninitialized
>> (and random) when we doing this decision, through a KVM_ARM_VCPU_INIT
>> ioctl -> kvm_pmu_vcpu_reset(). And the test_bit() against this random
>> idx will potentially hit a KASAN BUG [1].
>>
>> Fix it by moving the assignment of idx before kvm_pmu_stop_counter().
>>
>> [1] https://www.spinics.net/lists/kvm-arm/msg36700.html
>>
>> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
>> Suggested-by: Andrew Murray <andrew.murray@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>> ---
>>  virt/kvm/arm/pmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>> index 3dd8238..521bfdd 100644
>> --- a/virt/kvm/arm/pmu.c
>> +++ b/virt/kvm/arm/pmu.c
>> @@ -225,8 +225,8 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
>>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>>  
>>  	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
>> -		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
>>  		pmu->pmc[i].idx = i;
> 
> Yes, this is kind of a static property that should really be part of a
> "kvm_pmu_vcpu_init()" or "kvm_pmu_vcpu_create()" and is not expected to
> be modified across resets...
> 
> There is no such function at the time and I'm unsure whether this
> warrants creating that separate function (I would still suggest creating
> it to make things clearer).

Yup, that's pretty bad, now that you mention it. I'd be all for the
introduction of kvm_pmu_vcpu_init(), given that we already have
kvm_pmu_vcpu_destroy().

> 
>> +		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
> 
> Whatever other opinions are on splitting pmu_vcpu_init/reset, that
> change makes sense and fixes the issue:
> 
> Acked-by: Julien Thierry <julien.thierry@arm.com>
> 
>>  	}
>>  
>>  	bitmap_zero(vcpu->arch.pmu.chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
>>
> 
> Cheers,
> 

Zenghui, could you please update your patch to take the above into account?

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
