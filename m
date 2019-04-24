Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF3EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75A220811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfDXMb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:31:58 -0400
Received: from foss.arm.com ([217.140.101.70]:42816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDXMb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:31:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FFE9A78;
        Wed, 24 Apr 2019 05:31:57 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E23AF3F238;
        Wed, 24 Apr 2019 05:31:55 -0700 (PDT)
Subject: Re: [PATCH] ARM: mach-shmobile: Don't configure ARCH timer if PSCI is
 enabled
To:     Oleksandr <olekstysh@gmail.com>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     horms@verge.net.au, magnus.damm@gmail.com, linux@armlinux.org.uk,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <1555521040-16706-1-git-send-email-olekstysh@gmail.com>
 <1b33dca4-e3ae-4588-05f2-37b23ac8df78@arm.com>
 <8c9a1480-7956-9265-14c8-3fbb472e097d@gmail.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <c08c0d02-37f9-9f53-62b9-e5012097d94a@arm.com>
Date:   Wed, 24 Apr 2019 13:31:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8c9a1480-7956-9265-14c8-3fbb472e097d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/04/2019 12:15, Oleksandr wrote:
> 
> On 18.04.19 12:32, Julien Grall wrote:
>>> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c 
>>> b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>>> index eea60b2..bac4490 100644
>>> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>>> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>>> @@ -32,7 +32,7 @@ static const struct of_device_id cpg_matches[] __initconst = {
>>>       { /* sentinel */ }
>>>   };
>>>   -static unsigned int __init get_extal_freq(void)
>>> +static unsigned int __init __maybe_unused get_extal_freq(void)
>>>   {
>>>       const struct of_device_id *match;
>>>       struct device_node *cpg, *extal;
>>> @@ -60,6 +60,12 @@ static unsigned int __init get_extal_freq(void)
>>>     void __init rcar_gen2_timer_init(void)
>>>   {
>>> +/*
>>> + * If CONFIG_PSCI is enabled then most likely we are running on PSCI-enabled
>>> + * U-Boot which, we assume, has already taken care of configuring ARCH timer
>>> + * stuff before switching to non-secure mode.
>>> + */
>>
>> I disagree with that statement. CONFIG_ARM_PSCI may be selected in your 
>> .config for multiple reasons:
>>      - CONFIG_XEN will selected it
>>      - you build a .config targeting multiple platforms
>>
>> Yet you may still want to boot the kernel on older U-boot. Such change would 
>> make it impossible.
>>
>> If there are code that should not be called when PSCI is used, then you need 
>> to make sure the function is not called at runtime.
> 
> I got your point.
> 
> 
> As I answered in a previous email:
> 
>  > But "#if !defined(CONFIG_ARM_PSCI)" wraps secure_cntvoff_init() call as
>  > well, which resets CNTVOFF,
> 
>  > and this is something I tried to avoid the first from being executed on
>  > a CPU, which is in SVC mode (when running on top of Xen).
> 
> What would be a proper way to avoid calling secure_cntvoff_init() at runtime?
> 
> Check that we are already in non-secure mode and/or cntvoff is already 0?

CNTVOFF is controlled by the hypervisor, so you cannot access it from Dom0.

If none of this code should be necessary when PSCI is enabled, then you can 
check the presence of PSCI (see psci_smp_available()).

Another solution is to check whether we are running on xen (see xen_domain()).

In any case, I would still surround the two checks because the "armgcnt" should 
really not be touched by Dom0.

Cheers,

-- 
Julien Grall
