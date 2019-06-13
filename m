Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E8AC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBAF2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlHWgvdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbfFMPSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:18:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40790 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbfFMNI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:08:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so10055605wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ilL23+X1miOheYnaAN5erQCIhv+4uPnrS9SFwRKjvVQ=;
        b=NlHWgvdQgbXHYzuQEmA7IPUFQ9AgekquMmB+eJgwYVpmj/ZYtKy80qLxjoHNk7G7md
         qfu7J1oy9PG6kvFub0VoYqG4XhbTi14rXhwkW7E/vWP2+61Q04B9ps82zTxAbvj2Jvzh
         QJtkRiVZoCbTtH+7Q7AcDwmPgw0MHXicxIPGxcow74uimJFHBrmhkhK8IR0U1hFU343V
         iPIbE5nM7+QDljtHZVAGv7guWjMq+AfCJzthxvcexo/BMXQEfMlcpgd5L5ERIu4bt49D
         iVCou1Uf+AuPDEiU9msakoywu1WlQTWSj8yjZAqfXNcmmttzPa0jeOSPtt+NLV6XiMo7
         OL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ilL23+X1miOheYnaAN5erQCIhv+4uPnrS9SFwRKjvVQ=;
        b=YnDzv1S7PCpBYpkIBCKqE/cr1cfhKiYOAPgfvyouvO/kRt+3Iyx9eJfdUIa0NiLueh
         QwLywuoYNWUsRVXJGGSuZuXslsY/q+k1m9fy3K0P/SlVLSd9LxuIrahJuV/csM/HYrnk
         /kXzLVJOtSfxJ/leNnfQFMbeJEQACsh27+TotSmzhYBCuG3TuWw89iHvxfs9OQGZEIwX
         9yQhNNBNzl6xX/GjkKxS8wCUp3n1CayDxXn/sh5RXuIyBP7nCnhk9DDxu5Vr3ZExzXtZ
         jO1RxoB01f/W/U+OY+XxzrxoEDlQxRE86Bq4zQCkFLm2QJ8goCSBkMiDQgQWnqHt6Vd3
         Ahbw==
X-Gm-Message-State: APjAAAW+SZE8hQDnJ5mPaExXhqJaWbxfSmwWIyDOYCmj9CIgbNvJLwnm
        MUfIsBd8yph/FFml3GM7769TmpJSk7s=
X-Google-Smtp-Source: APXvYqy/RMacgmrQt9bdf0F/LTItZep9O2zCOwHHp3S5e5p50evgRnuJkDcQjbGgOHmRjj3SWay2nA==
X-Received: by 2002:a1c:2004:: with SMTP id g4mr3467778wmg.173.1560431333062;
        Thu, 13 Jun 2019 06:08:53 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id z14sm5347415wre.96.2019.06.13.06.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:08:52 -0700 (PDT)
Subject: Re: [PATCH v2] clocksource/arm_arch_timer: extract elf_hwcap use to
 arch-helper
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190613125102.23879-1-andrew.murray@arm.com>
 <86imt9bps6.wl-marc.zyngier@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <684f92dc-ab5a-c48b-17f5-6cf91f0081b9@linaro.org>
Date:   Thu, 13 Jun 2019 15:08:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <86imt9bps6.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2019 15:03, Marc Zyngier wrote:
> + Daniel
> 
> On Thu, 13 Jun 2019 13:51:02 +0100,
> Andrew Murray <andrew.murray@arm.com> wrote:
>>
>> Different mechanisms are used to test and set elf_hwcaps between ARM
>> and ARM64, this results in the use of ifdeferry in this file when
>> setting/testing for the EVTSTRM hwcap.
>>
>> Let's improve readability by extracting this to an arch helper.
>>
>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Daniel, can you please take this though the clocksource tree?

Applied, thanks

  -- Daniel

>> ---
>>  arch/arm/include/asm/arch_timer.h    | 10 ++++++++++
>>  arch/arm64/include/asm/arch_timer.h  | 13 +++++++++++++
>>  drivers/clocksource/arm_arch_timer.c | 15 ++-------------
>>  3 files changed, 25 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
>> index 4b66ecd6be99..ae533caec1e9 100644
>> --- a/arch/arm/include/asm/arch_timer.h
>> +++ b/arch/arm/include/asm/arch_timer.h
>> @@ -4,6 +4,7 @@
>>  
>>  #include <asm/barrier.h>
>>  #include <asm/errno.h>
>> +#include <asm/hwcap.h>
>>  #include <linux/clocksource.h>
>>  #include <linux/init.h>
>>  #include <linux/types.h>
>> @@ -124,6 +125,15 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
>>  	isb();
>>  }
>>  
>> +static inline bool arch_timer_set_evtstrm_feature(void)
>> +{
>> +	elf_hwcap |= HWCAP_EVTSTRM;
>> +}
>> +
>> +static inline bool arch_timer_have_evtstrm_feature(void)
>> +{
>> +	return elf_hwcap & HWCAP_EVTSTRM;
>> +}
>>  #endif
>>  
>>  #endif
>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>> index 50b3ab7ded4f..a847a3ee6cab 100644
>> --- a/arch/arm64/include/asm/arch_timer.h
>> +++ b/arch/arm64/include/asm/arch_timer.h
>> @@ -20,6 +20,7 @@
>>  #define __ASM_ARCH_TIMER_H
>>  
>>  #include <asm/barrier.h>
>> +#include <asm/hwcap.h>
>>  #include <asm/sysreg.h>
>>  
>>  #include <linux/bug.h>
>> @@ -240,4 +241,16 @@ static inline int arch_timer_arch_init(void)
>>  	return 0;
>>  }
>>  
>> +static inline void arch_timer_set_evtstrm_feature(void)
>> +{
>> +	cpu_set_named_feature(EVTSTRM);
>> +#ifdef CONFIG_COMPAT
>> +	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
>> +#endif
>> +}
>> +
>> +static inline bool arch_timer_have_evtstrm_feature(void)
>> +{
>> +	return cpu_have_named_feature(EVTSTRM);
>> +}
>>  #endif
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index b2a951a798e2..3583a92ad960 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -804,14 +804,7 @@ static void arch_timer_evtstrm_enable(int divider)
>>  	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
>>  			| ARCH_TIMER_VIRT_EVT_EN;
>>  	arch_timer_set_cntkctl(cntkctl);
>> -#ifdef CONFIG_ARM64
>> -	cpu_set_named_feature(EVTSTRM);
>> -#else
>> -	elf_hwcap |= HWCAP_EVTSTRM;
>> -#endif
>> -#ifdef CONFIG_COMPAT
>> -	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
>> -#endif
>> +	arch_timer_set_evtstrm_feature();
>>  	cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
>>  }
>>  
>> @@ -1040,11 +1033,7 @@ static int arch_timer_cpu_pm_notify(struct notifier_block *self,
>>  	} else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT) {
>>  		arch_timer_set_cntkctl(__this_cpu_read(saved_cntkctl));
>>  
>> -#ifdef CONFIG_ARM64
>> -		if (cpu_have_named_feature(EVTSTRM))
>> -#else
>> -		if (elf_hwcap & HWCAP_EVTSTRM)
>> -#endif
>> +		if (arch_timer_have_evtstrm_feature())
>>  			cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
>>  	}
>>  	return NOTIFY_OK;
>> -- 
>> 2.21.0
>>
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

