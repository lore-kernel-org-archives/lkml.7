Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10948C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B692173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565279390;
	bh=reIA9LZPgnzCSkG6NfyJ3L//undePSgnT8fqTxyiVU0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=A5UB37lvJdbt2W5MtvC/B3CKjLB2TtjlVeqcAwYdyQ2/IbaN/0BqW2n/cUCqyVJdS
	 20L9W3EDurtoqEnDlmqyQpgTi4qMHnwT6xiLXHkobOZZ4MwHIivSMnEmiaxGF6g4oA
	 9kAdNKvqqf1h0OxJxTbXpio4Hoz3shfxIOVCNk70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403866AbfHHPtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:49:49 -0400
Received: from foss.arm.com ([217.140.110.172]:35216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbfHHPtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:49:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 593D01596;
        Thu,  8 Aug 2019 08:49:48 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5E283F706;
        Thu,  8 Aug 2019 08:49:46 -0700 (PDT)
Subject: Re: [PATCH 9/9] arm64: Retrieve stolen time as paravirtualized guest
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190802145017.42543-1-steven.price@arm.com>
 <20190802145017.42543-10-steven.price@arm.com> <20190804105353.5e9824dc@why>
 <dc8a1e56-7b52-cc8f-265d-27eb5f458613@arm.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <7108a70b-dafd-507b-8509-f4a092ef24af@kernel.org>
Date:   Thu, 8 Aug 2019 16:49:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dc8a1e56-7b52-cc8f-265d-27eb5f458613@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2019 16:29, Steven Price wrote:
> On 04/08/2019 10:53, Marc Zyngier wrote:
>> On Fri,  2 Aug 2019 15:50:17 +0100
>> Steven Price <steven.price@arm.com> wrote:
>>
>>> Enable paravirtualization features when running under a hypervisor
>>> supporting the PV_TIME_ST hypercall.
>>>
>>> For each (v)CPU, we ask the hypervisor for the location of a shared
>>> page which the hypervisor will use to report stolen time to us. We set
>>> pv_time_ops to the stolen time function which simply reads the stolen
>>> value from the shared page for a VCPU. We guarantee single-copy
>>> atomicity using READ_ONCE which means we can also read the stolen
>>> time for another VCPU than the currently running one while it is
>>> potentially being updated by the hypervisor.
>>>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>>  arch/arm64/kernel/Makefile |   1 +
>>>  arch/arm64/kernel/kvm.c    | 155 +++++++++++++++++++++++++++++++++++++

[...]

>>> +static int __init kvm_guest_init(void)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	if (!has_kvm_steal_clock())
>>> +		return 0;
>>> +
>>> +	ret = kvm_arm_init_stolen_time();
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	pv_ops.time.steal_clock = kvm_steal_clock;
>>> +
>>> +	static_key_slow_inc(&paravirt_steal_enabled);
>>> +	if (steal_acc)
>>> +		static_key_slow_inc(&paravirt_steal_rq_enabled);
>>> +
>>> +	pr_info("using stolen time PV\n");
>>> +
>>> +	return 0;
>>> +}
>>> +early_initcall(kvm_guest_init);
>>
>> Is there any reason why we wouldn't directly call into this rather than
>> using an initcall?
> 
> I'm not sure where the direct call would go - any pointers?

I'd be temped to say arch/arm64/kernel/time.c:time_init(), provided that
there is no issue with the CPU hotplug lock (I remember hitting that a
while ago).

	M.
-- 
Jazz is not dead, it just smells funny...
