Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C7BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9824F2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXw/bwZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfC1R1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:27:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46315 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfC1R1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:27:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so3188245wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ekOBbjC86Zcco0g5omzaEdFoxVRaGZu37q80cOtp1cA=;
        b=BXw/bwZtOqUmetnYjmKxLv0fGI3mhpqxFjisTPZZnw9sXFHQAfQqBZ6cskWLs4JG+x
         HOf4yjPHXJoWmAUjNJ2j0g0V7JU8AoOZdL5q93JVPW/VpB8eyYupWz1A4sst/j6TEwuE
         FU5WbDtKBaw6SpKg6oXBiuDQuxS+DjhYio/d900KskNXcccJPKWdf+sw7Kpedu5zerQr
         GY+qjbzLG3Qggd5g+X1KMHUB/E7J0WYW2ck8VV2lKqfTlWvP1TCxzwSGuH2GM+ynqxtD
         pAL6r4IRmsphDTqDh04MOkvQ4Wqm4Pdw4V5kZt+jfN6cwEd43c4uSPMYRFS78iqMv8MW
         Bf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ekOBbjC86Zcco0g5omzaEdFoxVRaGZu37q80cOtp1cA=;
        b=no4kl9/B3+uidhNQsEZByW5pm3bZhLc7Bsmmj9+vNbRCd78AyU+NEzSj+qLecpgUEu
         2tydcn+V9EmmzO4jW4AWfiFwENOXs777sxYueK5dHs53rx7/f+5uZODkNLzEbYmme2rb
         4jRdBTk3nAJ7u2mBCyb4JBycrALsguyw8yXfGdkDhMRiZGuGzsxrgGVm5WiMWFmSW7Nj
         NCRxa7jKZ2hqT+CI/SqhoHpwjokcbsNS98tGBmMjOXOn3OxzRXqEPkVAFzCPLJbiSBuX
         q4W2Knq6G6TID5XTk0w86O6SuyRmKMObXhR6wlI7aYrjEhP7vYG8y1Ynqf/D6k42J1gU
         VMCQ==
X-Gm-Message-State: APjAAAVG+YIVe9UOE1/UDkxsM4Jb0/yqwWBcFbyNX1VP4xFqI1d+YZJo
        /uFV1cesnwUkzZe6d2w325nMGg==
X-Google-Smtp-Source: APXvYqytOkb1hzMBpFu5VJIC4GTHnEzKW0fNWYeTqjPZlrvKWTp3anKDNHZJWnbZ9rF0LZazJ2PA3w==
X-Received: by 2002:adf:deca:: with SMTP id i10mr3069947wrn.88.1553794072348;
        Thu, 28 Mar 2019 10:27:52 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id o6sm12857956wrp.41.2019.03.28.10.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:27:51 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
To:     Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-2-quentin.perret@arm.com>
 <20190328102206.doqj5fykqlld7jkd@queper01-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f5c699d6-f8f8-ab53-2835-329ae2bd8202@linaro.org>
Date:   Thu, 28 Mar 2019 18:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328102206.doqj5fykqlld7jkd@queper01-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2019 11:22, Quentin Perret wrote:
> On Thursday 28 Mar 2019 at 10:13:50 (+0000), Quentin Perret wrote:
>> The recently introduced Energy Model (EM) framework manages power cost
>> tables for the CPUs of the system. Its only user right now is the
>> scheduler, in the context of Energy Aware Scheduling (EAS).
>>
>> However, the EM framework also offers a generic infrastructure that
>> could replace subsystem-specific implementations of the same concepts,
>> as this is the case in the thermal framework.
>>
>> So, in order to prepare the migration of the thermal subsystem to use
>> the EM framework, enable it in the default arm64 defconfig, which is the
>> most commonly used architecture for IPA. This will also compile-in all
>> of the EAS code, although it won't be enabled by default -- EAS requires
>> to use the 'schedutil' CPUFreq governor while arm64 defaults to
>> 'performance'.
>>
>> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
>> ---
>>  arch/arm64/configs/defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 2d9c39033c1a..3c09bdaaefd3 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -97,6 +97,7 @@ CONFIG_XEN=y
>>  CONFIG_COMPAT=y
>>  CONFIG_HIBERNATION=y
>>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
>> +CONFIG_ENERGY_MODEL=n
> 
> Hmm, sorry I turned this to '=n' for testing and forgot to update the
> patch. This obviously should be '=y' ...

I did a test without the ENERGY_MODEL config option set, dhrystone and
the power_allocator policy on the hikey. The board did not mitigate well
and ended up rebooting. May be the cpu cooling Kconfig option should add
a SELECT or a DEPENDS on ENERGY_MODEL ?


>>  CONFIG_ARM_CPUIDLE=y
>>  CONFIG_CPU_FREQ=y
>>  CONFIG_CPU_FREQ_STAT=y
>> -- 
>> 2.21.0
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

