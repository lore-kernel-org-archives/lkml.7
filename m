Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822EDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611312196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKKQHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:07:44 -0500
Received: from foss.arm.com ([217.140.110.172]:47544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfKKQHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:07:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05B0B31B;
        Mon, 11 Nov 2019 08:07:43 -0800 (PST)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6C8A3F534;
        Mon, 11 Nov 2019 08:07:41 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: Rename WORKAROUND_1165522 to SPECULATIVE_AT
To:     Marc Zyngier <maz@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <20191111141157.55062-1-steven.price@arm.com>
 <20191111141157.55062-2-steven.price@arm.com>
 <160a852027f4481cc63aed72c4f4a409@www.loen.fr>
From:   Steven Price <steven.price@arm.com>
Message-ID: <013eec05-b558-d97a-bf95-248a62f25dc5@arm.com>
Date:   Mon, 11 Nov 2019 16:07:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <160a852027f4481cc63aed72c4f4a409@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2019 15:42, Marc Zyngier wrote:
> Hi Steven,
> 
> On 2019-11-11 15:21, Steven Price wrote:
>> Cortex-A55 is affected by a similar erratum, so rename the existing
>> workaround for errarum 1165522 so it can be used for both errata.
> 
> nit: erratum

Thanks, I do seem to have trouble spelling it correctly :)

>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  arch/arm64/Kconfig                |  4 ++++
>>  arch/arm64/include/asm/cpucaps.h  |  2 +-
>>  arch/arm64/include/asm/kvm_host.h |  2 +-
>>  arch/arm64/include/asm/kvm_hyp.h  |  3 +--
>>  arch/arm64/kernel/cpu_errata.c    | 17 +++++++++++++----
>>  arch/arm64/kvm/hyp/switch.c       |  2 +-
>>  arch/arm64/kvm/hyp/tlb.c          |  4 ++--
>>  7 files changed, 23 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 3f047afb982c..6cb4eff602c6 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -510,9 +510,13 @@ config ARM64_ERRATUM_1418040
>>
>>        If unsure, say Y.
>>
>> +config ARM64_WORKAROUND_SPECULATIVE_AT
>> +    bool
>> +
>>  config ARM64_ERRATUM_1165522
>>      bool "Cortex-A76: Speculative AT instruction using out-of-context
>> translation regime could cause subsequent request to generate an
>> incorrect translation"
>>      default y
>> +    select ARM64_WORKAROUND_SPECULATIVE_AT
> 
> I'd object that ARM64_ERRATUM_1319367 (and its big brother 1319537)
> are also related to speculative AT execution, and yet are not covered
> by this configuration symbol.

Good point.

> I can see three solutions to this:
> 
> - Either you call it SPECULATIVE_AT_VHE and introduce SPECULATIVE_AT_NVHE
>   for symmetry

Tempting...

> - Or you make SPECULATIVE_AT cover all the speculative AT errata, which
>   may or may not work...

This actually sounds the neatest, but I'm not sure whether there's going
to be any conflicts between VHE/NVHE. I'll prototype this and see how
ugly it is.

> - Or even better, you just ammend the documentation to say that 1165522
>   also covers the newly found A55 one (just like we have for A57/A72)

Well Mark Rutland disliked my initial thoughts about just including both
errata in one option like that - hence the refactoring in this patch.
Although of course that's exactly what's happened with 1319367/1319537...

> What do you think?

I'll have a go at SPECULATIVE_AT covering both VHE/NVHE - from an
initial look it seems like it should work and it would be neat if it
does. In particular it should avoid the necessity to require VHE when
the erratum is present.

Otherwise I guess SPECULATIVE_AT_{,N}VHE is probably second best.

Thanks,

Steve
