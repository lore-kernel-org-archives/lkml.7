Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DDCC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B1320821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1m39HFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbfDRKfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:35:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43741 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388369AbfDRKfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:35:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id f18so1466307lja.10;
        Thu, 18 Apr 2019 03:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3luCZ1XZ+7mybmUjff/eYadVftnDLZObJZCCUXECbRY=;
        b=i1m39HFx3NtHy9C117UWULblp/cWbLmqXLFvG0P6HWCN/6GuBrHyAnbK9sUNBb1XZj
         Kxr9hMc+d4Dgfxz7AocHsnKh4gs7aS8z8zJ8Ppv/a1GWXnRmPzCz4b1DEimsm9MR6i9M
         AtGTp2eofdcn9SerzDnSAoZ0jYp38RDvQrVKpG620agGUdOMVW1OBGhn0R3Rh7c/WJBu
         Y0grVg7ks7SbkBmj38pnzIjH7Gnsm9rWEStz/xdgeYN9LGOhla5FiXxk8sQ18lg0xuQh
         ZEO3n94x5moYdP/SkFxoETwlfxrG8pIikyMr9Xd/Ljodr4oJOsoAptkR/nrpg3IxGtmK
         VINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3luCZ1XZ+7mybmUjff/eYadVftnDLZObJZCCUXECbRY=;
        b=aN7sKzeQG2BhHc1Y0MjC4vsG983B/Hdq/P4I9s5F1kUOdy9AIctPuVEu3kUGDDzUR+
         LXdi0SyOM93hk2dXQXiD2UInGbBY5xyf7w23Sqy+V9ygIN2CnI0wsuU53TJUMmSmFfT7
         jznhAlfiiO9p9idy61qKLidIquxVQDz6zRXyvi5lUXuVKOyoIhKKwuA8ZLCN1DFliBmW
         W3wH/vqM/9WUuS8bghg7nnwwnpfdxo5j2OakajbdNdNqF9z3Yle8uCy8yLeiggrOjTNR
         bBj6yujYkn0NrNa5ANs0sFy8cxD6wm7ld7O1sCnm7Xb3A4E/dM8aiTOLUz0/UNyhJ1CS
         Qt1A==
X-Gm-Message-State: APjAAAXUlJ4jWk1orqpy0FiIGy/S0whoE8mNUFPPgppG28TX5K+kMHI5
        jEgPMkHJCTs9YbRYNZnN/tE=
X-Google-Smtp-Source: APXvYqxFjSeF4xI9PDaJGcX9vaBXvGmlNIwh/RklZIELq11Fa+YgVNPzQPvHKayL00/cm4duSKsuoQ==
X-Received: by 2002:a2e:390c:: with SMTP id g12mr50550230lja.174.1555583716446;
        Thu, 18 Apr 2019 03:35:16 -0700 (PDT)
Received: from [10.17.182.120] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id p14sm369149lfk.6.2019.04.18.03.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 03:35:15 -0700 (PDT)
Subject: Re: [PATCH] ARM: mach-shmobile: Don't configure ARCH timer if PSCI is
 enabled
To:     Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "julien.grall@arm.com" <julien.grall@arm.com>,
        "horms@verge.net.au" <horms@verge.net.au>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <1555521040-16706-1-git-send-email-olekstysh@gmail.com>
 <OSBPR01MB21036296606B40DB2FE22CD2B8260@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <e9ff61e3-620f-b794-824d-39ab70707e63@gmail.com>
Date:   Thu, 18 Apr 2019 13:35:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB21036296606B40DB2FE22CD2B8260@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18.04.19 10:14, Biju Das wrote:
> Hi Oleksandr,

Hi Biju

>
> Thanks for the patch.
>
>> Subject: [PATCH] ARM: mach-shmobile: Don't configure ARCH timer if PSCI is
>> enabled
>>
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> If CONFIG_PSCI is enabled then most likely we are running on PSCI-enabled
>> U-Boot which, we assume, has already taken care of configuring ARCH timer
>> stuff before switching to non-secure mode.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> ---
>> A bit of context here...
>>
>> We are highly interested in Renesas "Stout" board support (r8a7790) in Xen
>> hypervisor. The reason is to have fully supported HW for performing
>> "OSSTEST" (Xen automatic test system) on ARM32.
>>
>> To reach that target we need a "generic way" for the secondary CPU cores
>> bring up and switching them to non-secure hyp mode.
>> So, the PSCI as a generic well-known way to bring up CPUs, was chosen for
>> that purpose.
>>
>> You can find corresponding patches for U-Boot here:
>> http://u-boot.10912.n7.nabble.com/PATCH-0-3-PSCI-support-for-r8a7790-
>> SoC-Lager-Stout-boards-td357352.html
>>
>> You can find corresponding patches for Xen hypervisor here:
>> https://www.mail-archive.com/xen-
>> devel@lists.xenproject.org/msg43332.html
>>
>> To sumarize:
>> Together with enabling CONFIG_PSCI in shmobile_defconfig, current patch is
>> a minimal required change needed to run mainline Linux on top of PSCI-
>> enabled U-Boot.
>> There is no need to modify device tree. U-Boot will take care of inserting
>> proper "enable-method" strings in CPU nodes.
>>
>> ---
>>   arch/arm/mach-shmobile/setup-rcar-gen2.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-
>> shmobile/setup-rcar-gen2.c
>> index eea60b2..bac4490 100644
>> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> @@ -32,7 +32,7 @@ static const struct of_device_id cpg_matches[]
>> __initconst = {
>>   	{ /* sentinel */ }
>>   };
>>
>> -static unsigned int __init get_extal_freq(void)
>> +static unsigned int __init __maybe_unused get_extal_freq(void)
>>   {
>>   	const struct of_device_id *match;
>>   	struct device_node *cpg, *extal;
>> @@ -60,6 +60,12 @@ static unsigned int __init get_extal_freq(void)
>>
>>   void __init rcar_gen2_timer_init(void)
>>   {
>> +/*
>> + * If CONFIG_PSCI is enabled then most likely we are running on
>> +PSCI-enabled
>> + * U-Boot which, we assume, has already taken care of configuring ARCH
>> +timer
>> + * stuff before switching to non-secure mode.
>> + */
>> +#if !defined(CONFIG_ARM_PSCI)
> Is it required?  If you see the below comment, it is already taken care
> by the below code.
>
> Is your code entering into this block, when booting  the kernel in NS mode?

No, the code below seems to do the proper things. If arch timer is 
configured in U-Boot (enabled and programmed with correct freq) then

that code doesn't try to update it.

But "#if !defined(CONFIG_ARM_PSCI)" wraps secure_cntvoff_init() call as 
well, which resets CNTVOFF,

and this is something I tried to avoid the first from being executed on 
a CPU, which is in SVC mode (when running on top of Xen).


I was thinking whether I should wrap arch timer updating procedure as 
well and decided to do so, but probably I shouldn't have.

>
> <snip>
>    /*
>   87          * Update the timer if it is either not running, or is not at the
>   88          * right frequency. The timer is only configurable in secure mode
>   89          * so this avoids an abort if the loader started the timer and
>   90          * entered the kernel in non-secure mode.
>   91          */
>   92
>   93         if ((ioread32(base + CNTCR) & 1) == 0 ||
>   94             ioread32(base + CNTFID0) != freq) {
>   95                 /* Update registers with correct frequency */
>   96                 iowrite32(freq, base + CNTFID0);
>   97                 asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (freq));
>   98
>   99                 /* make sure arch timer is started by setting bit 0 of CNTCR */
> 100                 iowrite32(1, base + CNTCR);
> 101         }
>
>
> Regards,
> Biju
>
>>   	void __iomem *base;
>>   	u32 freq;
>>
>> @@ -101,6 +107,7 @@ void __init rcar_gen2_timer_init(void)
>>   	}
>>
>>   	iounmap(base);
>> +#endif /* #if !defined(CONFIG_ARM_PSCI) */
>>
>>   	of_clk_init(NULL);
>>   	timer_probe();
>> --
>> 2.7.4

-- 
Regards,

Oleksandr Tyshchenko

