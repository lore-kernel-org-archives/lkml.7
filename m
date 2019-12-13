Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D26C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 03:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730DB2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 03:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbfLMD2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 22:28:48 -0500
Received: from foss.arm.com ([217.140.110.172]:42198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731631AbfLMD2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 22:28:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D823630E;
        Thu, 12 Dec 2019 19:28:46 -0800 (PST)
Received: from [192.168.0.10] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 931973F52E;
        Thu, 12 Dec 2019 19:28:43 -0800 (PST)
Subject: Re: [PATCH] arm64: Introduce ISAR6 CPU ID register
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <1576145663-9909-1-git-send-email-anshuman.khandual@arm.com>
 <20191212144633.GE46910@lakrids.cambridge.arm.com>
 <be707b09-6469-d12f-07d5-50d574dc7284@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <066cec52-f939-d55d-3a8a-e061767ec8d2@arm.com>
Date:   Fri, 13 Dec 2019 08:59:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <be707b09-6469-d12f-07d5-50d574dc7284@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2019 08:52 PM, Suzuki Kuruppassery Poulose wrote:
> On 12/12/2019 14:46, Mark Rutland wrote:
>> On Thu, Dec 12, 2019 at 03:44:23PM +0530, Anshuman Khandual wrote:
>>> +#define ID_ISAR6_JSCVT_SHIFT        0
>>> +#define ID_ISAR6_DP_SHIFT        4
>>> +#define ID_ISAR6_FHM_SHIFT        8
>>> +#define ID_ISAR6_SB_SHIFT        12
>>> +#define ID_ISAR6_SPECRES_SHIFT        16
>>> +#define ID_ISAR6_BF16_SHIFT        20
>>> +#define ID_ISAR6_I8MM_SHIFT        24
>>
>>> @@ -399,6 +399,7 @@ static const struct __ftr_reg_entry {
>>>       ARM64_FTR_REG(SYS_ID_ISAR4_EL1, ftr_generic_32bits),
>>>       ARM64_FTR_REG(SYS_ID_ISAR5_EL1, ftr_id_isar5),
>>>       ARM64_FTR_REG(SYS_ID_MMFR4_EL1, ftr_id_mmfr4),
>>
>>> +    ARM64_FTR_REG(SYS_ID_ISAR6_EL1, ftr_generic_32bits),
>>
>> Using ftr_generic_32bits exposes the lowest-common-denominator for all
>> 4-bit fields in the register, and I don't think that's the right thing
>> to do here, because:
>>
>> * We have no idea what ID_ISAR6 bits [31:28] may mean in future.
>>
>> * AFAICT, the instructions described by ID_ISAR6.SPECRES (from the
>>    ARMv8.0-PredInv extension) operate on the local PE and are not
>>    broadcast. To make those work as a guest expects, the host will need
>>    to do additional things (e.g. to preserve that illusion when a vCPU is
>>    migrated from one pCPU to another and back).
>>
>> Given that, think we should add an explicit ftr_id_isar6 which only
>> exposes the fields that we're certain are safe to expose to a guest
>> (i.e. without SPECRES).
> 
> Agree. Thanks for pointing this out. I recommended the usage of
> generic_32bits table without actually looking at the feature
> definitions.
> 
> Anshuman,
> 
> Sorry about this.

Not a problem, will add an explicit definition for ftr_id_isar6 with
all features except SPECRES as Mark had pointed put.

> 
> Cheers
> Suzuki
