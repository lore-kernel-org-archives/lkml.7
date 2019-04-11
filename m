Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFE3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E612146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8Bd6cQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfDKUZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:25:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38044 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfDKUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:25:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so9038389wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OTg+YucJbC88+/MvrejQnacV5f7NWqAfb85l4/kbNV4=;
        b=I8Bd6cQR/3+3IE8gc5TKIeYmshHktD54mN9mnwIBeNwPFvuv5A7ASdmJrFP/lAbjos
         zGU2mnLvmJ+M/gVv9LyrIhq0f0A3c0FYDFngdZAeAgMr6dZtLiBQFU2YyDST9qbSAdU+
         7TxUd1d0mA8WJLZ2wvo44Gn5ySzjFMtEEFe1osjrnd4U5SyoXtupirkgDoxyg/jFfGd/
         qgn5qBtENXp3Xyv/mQd0DihqWqWUNPlFG74VIsNL2Bf1LpylqlzoBWpbNy7EgNZbVE0G
         /aGR/VFHTBMPKcA5BaFqAH72Cn4mliZMGLBdhMysllg7r2fPdn6YyszIZiluRsfR1iVJ
         yyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OTg+YucJbC88+/MvrejQnacV5f7NWqAfb85l4/kbNV4=;
        b=jI3VD8GezqIzNJZRUcuBG1LP0YMRNrXvd5ZBKqOmhEKb+opleDMK4jg9ZcNwbDf8PT
         4Bbaxf601q9GkS4Gh6Fd9X0mo1ZIYTIRCPN9Ln2ghwV+gqCUdckp7C9aNWRq3dst3x9V
         0rTUetpifS2QNzL/7I4UY0hiHOt6V6H9xSPujw9OkEKSFML//6z3sj29NYHELO1HNPEm
         qoD716XDWm+0X5UXPzstLY7uUTDzn4mVsiNBxztaHe3gpXdupBAZz++bl76EtglNfHzR
         HIcStLrbRJO5VyPJIgDwi5hnBe1OcvcvYbE9TTg0hGCl2caT+upQ/fMfTrRAHK/6DGc6
         CCaA==
X-Gm-Message-State: APjAAAVItPbgLAoqNwmXqykERPNRGHC51A2WMLBFzqWlwfMhzihi6hUc
        +wL6fc4BF9erqCjEaoD7kDlp7g==
X-Google-Smtp-Source: APXvYqx1DJfb/uhQrT1rFvxgrWAe4WNJa72gJkva9Qr/pVknOckSqspOTdUW6gRIjdfu8V1yrC6rfw==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr27485970wre.246.1555014308026;
        Thu, 11 Apr 2019 13:25:08 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id z140sm15891905wmc.27.2019.04.11.13.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:25:07 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Remove
 omap_dm_timer_set_load_start
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Keerthy <j-keerthy@ti.com>
References: <20190327050126.12064-1-natechancellor@gmail.com>
 <20190327081142.GA11034@lenoch> <20190404141730.GE49658@atomide.com>
 <6defcea8-1e94-14ac-f9c5-e14c61ea4d99@linaro.org>
 <20190410200748.GN2839@atomide.com>
 <b8a177ee-0058-2730-4c95-56834f6bafd4@linaro.org>
 <20190411193614.GA8469@archlinux-i9>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a65245e7-8c08-227a-a24a-7736468a2f4d@linaro.org>
Date:   Thu, 11 Apr 2019 22:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411193614.GA8469@archlinux-i9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 21:36, Nathan Chancellor wrote:
> On Thu, Apr 11, 2019 at 09:20:56PM +0200, Daniel Lezcano wrote:
>> On 10/04/2019 22:07, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Daniel Lezcano <daniel.lezcano@linaro.org> [190410 17:02]:
>>>> can you ask for an acked-by before pulling a patch in your tree?
>>>
>>> I certainly do ask and wait for acks where possible :)
>>
>> Ok, I may have missed them.
>>
>>> Note that I have not applied this patch. I just added
>>> Keerthy to Cc on this thread so maybe you misread the
>>> message earlier. My comment "seems like no other
>>> takers" was for Ladislav regarding somebody picking up
>>> his earlier work, not for picking up this patch :)
>>
>> Actually I was referring to the commit 592ea6bd1fad. Anyway as stated
>> above I could have miss your call.
>>
>>> In any case, I've been waiting for you guys to pick up
>>> the patch, here's my ack if you're waiting for it:
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>
>> The patch does not apply. Is it aligned with tip/timers/core ?
>>
> 
> The commit this fixes is in timers/urgent and it doesn't look like that
> has been backmerged into timers/core.

Anyway, probably simple to apply it directly to timers/urgent then.
That's good I have other patches for the branch.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

