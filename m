Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E71C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8003020709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKNLGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:06:47 -0500
Received: from foss.arm.com ([217.140.110.172]:40634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfKNLGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:06:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D6731B;
        Thu, 14 Nov 2019 03:06:46 -0800 (PST)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5C883F6C4;
        Thu, 14 Nov 2019 03:06:45 -0800 (PST)
Subject: Re: [PATCH v3 3/3] arm64: Workaround for Cortex-A55 erratum 1530923
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Julien Thierry <julien.thierry.kdev@gmail.com>,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20191113172252.12610-1-steven.price@arm.com>
 <20191113172252.12610-4-steven.price@arm.com>
 <0b017ec9-5be1-90b9-be30-09462dec9e9d@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <af9c85ba-4926-7a57-8544-e548b953259e@arm.com>
Date:   Thu, 14 Nov 2019 11:06:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0b017ec9-5be1-90b9-be30-09462dec9e9d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2019 10:27, Suzuki Kuruppassery Poulose wrote:
> On 13/11/2019 17:22, Steven Price wrote:
[...]
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index defb68e45387..d2dd72c19560 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -532,6 +532,19 @@ config ARM64_ERRATUM_1165522
>>           If unsure, say Y.
>>   +config ARM64_ERRATUM_1530923
>> +    bool "Cortex-A55: Speculative AT instruction using out-of-context
>> translation regime could cause subsequent request to generate an
>> incorrect translation"
>> +    default y
>> +    select ARM64_WORKAROUND_SPECULATIVE_AT
> 
> ARM64_WORKAROUND_SPECULATIVE_AT_VHE ?

Thanks for spotting - annoyingly I don't even seem to get a warning from
Kconfig for this. I'll spin a v4 with your R-Bs on the other patches too
(thanks for those too).

Steve
