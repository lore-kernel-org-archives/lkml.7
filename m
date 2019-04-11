Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E0AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B48420693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qi1JUTyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDKRSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:18:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52197 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKRSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:18:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so7697661wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YU4pt8v1ib9daIqRADi7BjOhLgd2e+YgnUqd1UEAUao=;
        b=Qi1JUTyJf8xSMMJjZ/Rqc8mykBoujCwm8OyHhkYLaVp4U3nx4hB5KfDAGasZtB2ESH
         PEtmXWeZDK0l3PAKb098WunYQ+2Ha9bl1I8zNNn4dB/VRwiVbdwblfWFGvlQLk8VcCN3
         upmRAEqLbfbXj4fOk0drOnP9SJF/gnnfdyfwraHx9BbESMA3S9939zuVzGHKli95iO5E
         mzJqgDerPSnni7L7MqcLR96tjG1eScME6WGaoWe0QA9hc30D56Evlz84/Gidi2/w/rOX
         P9eFCRGZbCPHQjUTksZa3f/G0LhcEeuF28PY0aOGZmFye62gtfHg0qe9QHOAbR0yXbZc
         H7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YU4pt8v1ib9daIqRADi7BjOhLgd2e+YgnUqd1UEAUao=;
        b=Qd+/rQMzDE0xlHNZH3Xn6Ztiq2hoB+bs6tMvvXvBlVAMBef7vV6ArTa+Av3iuBj5OV
         rpGXLrToAEzdhb6xD0JrfApfv1bFtFjbDB3rG0Z5rWUgV0hDy6m5Jfk7rda6dRSxmmEr
         9Ot2Js3+YrLcLxYyH9LIeTbF5/kTRYVBZPfALYGXv/MQ5zP+UcluznTgdT7DYfXC/pSH
         cKBP8NwwNNUJu9tZJJl/0y6CpSvmSpI+cOS4WuLREq7LxfYpmK3rjfbnDNw+/UO4hQiU
         R2IGXv2ChZXRp0XYAvGAKSQrLPQtWI6gFb/WN4v1VrH/w1H7yAFtpUmyR2odCW1U+y+j
         RaCQ==
X-Gm-Message-State: APjAAAWLtz54exb1o5U4fKpzCSvWG1Ztcn3gaGPVGjgYSzs7nWVqQb5b
        2BaiWsXjZykHe0V+cfAjDqBRuA==
X-Google-Smtp-Source: APXvYqzA0F7UTO+IFvUALqG96IX1CGD0fL49SLxLo5xu9DMG2oFz1Q1b7LkHAZ+NkJwNZOKiJy3r8Q==
X-Received: by 2002:a1c:7a03:: with SMTP id v3mr7983294wmc.58.1555003080775;
        Thu, 11 Apr 2019 10:18:00 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id w9sm11743768wmi.0.2019.04.11.10.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:18:00 -0700 (PDT)
Subject: Re: [PATCH 4/7] clocksource/arm_arch_timer: Direcly assign
 set_next_event workaround
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
 <20190408154907.223536-5-marc.zyngier@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0d051de8-35a9-61bd-5ac0-7180f19f7c01@linaro.org>
Date:   Thu, 11 Apr 2019 19:17:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408154907.223536-5-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 17:49, Marc Zyngier wrote:
> When a given timer is affected by an erratum and requires an
> alternative implementation of set_next_event, we do a rather
> complicated dance to detect and call the workaround on each
> set_next_event call.
> 
> This is clearly idiotic, as we can perfectly detect whether
> this CPU requires a workaround while setting up the clock event
> device.
> 
> This only requires the CPU-specific detection to be done a bit
> earlier, and we can then safely override the set_next_event pointer
> if we have a workaround associated to that CPU.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Do you want me to take the patch ?

Otherwise:

Acked-by; Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

