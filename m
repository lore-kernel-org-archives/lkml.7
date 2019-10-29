Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7603FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513A1208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfJ2L0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:26:45 -0400
Received: from foss.arm.com ([217.140.110.172]:50680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfJ2L0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:26:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02E131F1;
        Tue, 29 Oct 2019 04:26:44 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B61E3F71E;
        Tue, 29 Oct 2019 04:26:42 -0700 (PDT)
Subject: Re: [PATCH] arm64: cpufeature: Export Armv8.6 Matrix feature to
 userspace
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Dave.Martin@arm.com
References: <20191025171056.30641-1-julien.grall@arm.com>
 <20191029111517.GE11590@willie-the-truck>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <f58cb01f-4543-6041-df2d-7ca7ba887bc9@arm.com>
Date:   Tue, 29 Oct 2019 11:26:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029111517.GE11590@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 29/10/2019 11:15, Will Deacon wrote:
> On Fri, Oct 25, 2019 at 06:10:56PM +0100, Julien Grall wrote:
>> This patch provides support for reporting the presence of Armv8.6
>> Matrix and its optional features to userspace.
> 
> Are you sure this is 8.6 and not earlier?

This was introduced by Armv8.6 see [1] but allowed to be used by Armv8.2 and 
onwards.

> 
>> This based on [1] + commit ec52c7134b1f "arm64: cpufeature: Treat
>> ID_AA64ZFR0_EL1 as RAZ when SVE is not enabled" (taken from v5.4-rc4).
>>
>> [1]  arm64/for-next/elf-hwcap-docs
>> ---
>>   Documentation/arm64/cpu-feature-registers.rst |  8 ++++++++
>>   Documentation/arm64/elf_hwcaps.rst            | 15 +++++++++++++++
>>   arch/arm64/include/asm/hwcap.h                |  4 ++++
>>   arch/arm64/include/asm/sysreg.h               |  7 +++++++
>>   arch/arm64/include/uapi/asm/hwcap.h           |  4 ++++
>>   arch/arm64/kernel/cpufeature.c                | 11 +++++++++++
>>   arch/arm64/kernel/cpuinfo.c                   |  4 ++++
>>   7 files changed, 53 insertions(+)
>>
>> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
>> index ffcf4e2c71ef..d1d6d56a7b08 100644
>> --- a/Documentation/arm64/cpu-feature-registers.rst
>> +++ b/Documentation/arm64/cpu-feature-registers.rst
>> @@ -193,6 +193,8 @@ infrastructure:
>>        +------------------------------+---------+---------+
>>        | Name                         |  bits   | visible |
>>        +------------------------------+---------+---------+
>> +     | I8MM                         | [52-55] |    y    |
>> +     +------------------------------+---------+---------+
> 
> Looking at:
> 
> https://developer.arm.com/docs/ddi0601/latest/aarch64-system-registers/id_aa64isar1_el1
> 
> Then I8MM is advertised as "Armv8.2", alongside other fields that we haven't
> listed here such as BF16 and SPECRES.
> 
> So we probably want a patch bringing all of this up to speed, rather than
> randomly advertising some features and not others.
> 
>>        | SB                           | [36-39] |    y    |
>>        +------------------------------+---------+---------+
>>        | FRINTTS                      | [32-35] |    y    |
>> @@ -227,6 +229,12 @@ infrastructure:
>>        +------------------------------+---------+---------+
>>        | Name                         |  bits   | visible |
>>        +------------------------------+---------+---------+
>> +     | F64MM                        | [56-59] |    y    |
>> +     +------------------------------+---------+---------+
>> +     | F32MM                        | [52-55] |    y    |
>> +     +------------------------------+---------+---------+
>> +     | I8MM                         | [44-47] |    y    |
>> +     +------------------------------+---------+---------+
> 
> Urgh, we're inconsistent in our bitfields. Some are [lo-hi] whilst others
> are [hi-lo]. Please can you fix that in a preparatory patch? I prefer
> [hi-lo] and it matches the arch docs.

Sure.

Cheers,

[1] 
https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/arm-architecture-developments-armv8-6-a

> 
> Will
> 

-- 
Julien Grall
