Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B437C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB65214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkoKe78B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbfDRLP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:15:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38386 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRLPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:15:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so1587584ljg.5;
        Thu, 18 Apr 2019 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X2xsbhd6kxgk9Y+1IAGRIDEB0DQYqj57FakgyMH9E2A=;
        b=TkoKe78B9jcgz29EhttK900ga0eyOZu43cMD2QinQo69OtfgM6/h0ZooRH/7yzIBTp
         gh77g9WL29lBcqKKTDVYh4+1Zuk7T1FPM3HEL6qnadUgoR2sqQKEI8zBiTd0wiK6QCyv
         8JaZ7q3GtFICqhcKsQjDgdUKWXfIU1T9Jx/6DTYdfsG7glmIVP2s0Udi7uUDwSiPq69j
         whw4/J+h+ni1WcgufZhJlZOUGpY3PnXlpQnZbIB/uvn/egngCPgsSrLgiGoZeTOPvd82
         DoGh7alnXbPMelg5USwoCvwsmtfsFDg1fIxBCNVbyHNNicepA5GSb9PLBxPrY0/pHyk9
         L+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X2xsbhd6kxgk9Y+1IAGRIDEB0DQYqj57FakgyMH9E2A=;
        b=tOGfXqWHioJl0UeF8RtG+mOXYg4+0a9rAGKnwLUs1G4IpByPTScE1s2LhHeakf7vtr
         yQ5xlXPKTb2Yb/+uRHkYEFQA1mJyT+5Tzrk1JU5j7BIH8339KLFLz/tnqnKJ1S3FZWIo
         r0iedRcpxbhTc5G4Jg6ckRk5L/rSwJ5c5nFqempCNXxz1fOAUIRUvXif3uuD+Zb+/9xX
         AIqhg8AiN5qTmSzpwj3jp+MygO/kiXMPCDIvNDTaSbSg1re6sX5hH6KGYNOeRXL0jNBa
         WqsR8zEi0erP278cW7TvQSvBh+tP/jGp9k4TR4EyfS2OYhWmICVbPVGkmbAe2mzArZlJ
         LKdQ==
X-Gm-Message-State: APjAAAXXpkgF6KhKF2n3Nk/AHsSZtxkyizp39EwDMw+8giOnW0k/bo9b
        M0/D+qIR9JN+wR3xxCZQaIQ=
X-Google-Smtp-Source: APXvYqw/Jlh6MC+SLHXcSgYI0yuvhCzbm3CgINWZzoJobpDSneEfenes242LlxFZuXWXGfjPau8dFA==
X-Received: by 2002:a2e:94c7:: with SMTP id r7mr50777251ljh.91.1555586153648;
        Thu, 18 Apr 2019 04:15:53 -0700 (PDT)
Received: from [10.17.182.120] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id h123sm91538lfe.96.2019.04.18.04.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 04:15:52 -0700 (PDT)
Subject: Re: [PATCH] ARM: mach-shmobile: Don't configure ARCH timer if PSCI is
 enabled
To:     Julien Grall <julien.grall@arm.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     horms@verge.net.au, magnus.damm@gmail.com, linux@armlinux.org.uk,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <1555521040-16706-1-git-send-email-olekstysh@gmail.com>
 <1b33dca4-e3ae-4588-05f2-37b23ac8df78@arm.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <8c9a1480-7956-9265-14c8-3fbb472e097d@gmail.com>
Date:   Thu, 18 Apr 2019 14:15:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1b33dca4-e3ae-4588-05f2-37b23ac8df78@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18.04.19 12:32, Julien Grall wrote:
> Hi,

Hi Julien


<snip>

>>
>> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c 
>> b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> index eea60b2..bac4490 100644
>> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> @@ -32,7 +32,7 @@ static const struct of_device_id cpg_matches[] 
>> __initconst = {
>>       { /* sentinel */ }
>>   };
>>   -static unsigned int __init get_extal_freq(void)
>> +static unsigned int __init __maybe_unused get_extal_freq(void)
>>   {
>>       const struct of_device_id *match;
>>       struct device_node *cpg, *extal;
>> @@ -60,6 +60,12 @@ static unsigned int __init get_extal_freq(void)
>>     void __init rcar_gen2_timer_init(void)
>>   {
>> +/*
>> + * If CONFIG_PSCI is enabled then most likely we are running on 
>> PSCI-enabled
>> + * U-Boot which, we assume, has already taken care of configuring 
>> ARCH timer
>> + * stuff before switching to non-secure mode.
>> + */
>
> I disagree with that statement. CONFIG_ARM_PSCI may be selected in 
> your .config for multiple reasons:
>      - CONFIG_XEN will selected it
>      - you build a .config targeting multiple platforms
>
> Yet you may still want to boot the kernel on older U-boot. Such change 
> would make it impossible.
>
> If there are code that should not be called when PSCI is used, then 
> you need to make sure the function is not called at runtime.

I got your point.


As I answered in a previous email:

 > But "#if !defined(CONFIG_ARM_PSCI)" wraps secure_cntvoff_init() call as
 > well, which resets CNTVOFF,

 > and this is something I tried to avoid the first from being executed on
 > a CPU, which is in SVC mode (when running on top of Xen).

What would be a proper way to avoid calling secure_cntvoff_init() at 
runtime?

Check that we are already in non-secure mode and/or cntvoff is already 0?


>
> Cheers,
>
-- 
Regards,

Oleksandr Tyshchenko

