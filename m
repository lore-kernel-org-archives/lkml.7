Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278B6C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0066F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfIZURv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:17:51 -0400
Received: from foss.arm.com ([217.140.110.172]:59030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfIZURu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:17:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 405EF142F;
        Thu, 26 Sep 2019 13:17:50 -0700 (PDT)
Received: from [172.23.27.158] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E485D3F67D;
        Thu, 26 Sep 2019 13:17:45 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] arm64: vdso32: Detect binutils support for dmb
 ishld
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190926133805.52348-1-vincenzo.frascino@arm.com>
 <20190926133805.52348-3-vincenzo.frascino@arm.com>
 <20190926142642.GF9689@arrakis.emea.arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <88d1b318-5c20-b3f4-6c24-60917c673f91@arm.com>
Date:   Thu, 26 Sep 2019 21:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926142642.GF9689@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 3:26 PM, Catalin Marinas wrote:
> On Thu, Sep 26, 2019 at 02:38:03PM +0100, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
>> index d6465823b281..75cf8c796d0e 100644
>> --- a/arch/arm64/Kbuild
>> +++ b/arch/arm64/Kbuild
>> @@ -4,3 +4,9 @@ obj-$(CONFIG_NET)	+= net/
>>  obj-$(CONFIG_KVM)	+= kvm/
>>  obj-$(CONFIG_XEN)	+= xen/
>>  obj-$(CONFIG_CRYPTO)	+= crypto/
>> +
>> +# as-instr-compat
>> +# Usage: cflags-y += $(call as-instr-compat,instr,option1,option2)
>> +
>> +as-instr-compat = $(call try-run,\
>> +	printf "%b\n" "$(1)" | $(COMPATCC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
> 
> This doesn't seem to be used anywhere. Was it meant to be replaced by
> cc32-as-instr?
> 

Forgot to squash a stash here. Will fix in v3. This is not used anymore was just
an experiment.

-- 
Regards,
Vincenzo
