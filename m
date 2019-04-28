Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C88C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37EC206C1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSrtIXhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfD1Jy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 05:54:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35812 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfD1Jy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 05:54:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so11036703wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 02:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=18eNnxmuie4YUiAn2ktXEOwnJbLtCYELaDk1cHoo7YE=;
        b=TSrtIXhGjfKv/TjlKx/EIEbo44O3DkyUnlzZHIpZHYJif3uSezeAmR1mIUcIZY4WjE
         ftl9ZRYs3ViMuFvUPpdGV8jOgsxv/NvRClKhL8yDWPBh+GVnIbqLZ9FxwC9rp/lTNoD4
         uUI98M9Pd8tDrchv4rWRp9HiaHv2fn9od/dfnf+y87SwkKkqC4bny9jqxMdXBaZuIXSv
         CxN9okiF9t9KcSUwJ5hVINBe/NTY6TL1D+tbGv8Tr/Gy1zzC0obF1LNRXbdyNCYTL2ND
         afxjo5CtNW7GVgiNjUuOFJBjKyQyJSE+eIPDM5YKqKp8OWrRmRhXzUPEFfA758wY5LgS
         OAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=18eNnxmuie4YUiAn2ktXEOwnJbLtCYELaDk1cHoo7YE=;
        b=BanYZF2jGsqxPLzINEfXcXxL3LJnm2ml0TnnzMx5/85vGJjXDcUYxz8ovtc88s0lz6
         ZMzVWYv8zUbT64O4be4a8O9SMUnVzyVWcdlb9w/CTXvTWLQDsoO7E+8szWo1t0GuVbSY
         eKu/0nQflA+53Oii7PspFWrLkBIAxbDC/Trw0AiCEnsrWEl4LmmYz5622buXLt8nzWd6
         tvq2Pdx1LWYt0GxWZMdTJFy1j4zZBWoOHkVGbjfxOZQchz7Ko4yvun4EVU46I1XGadZW
         nI0k0MpohBKjT68TddiQzHfODzPwRvSWRibFjbs+zNsunjbVKVu3pahk3YOwiCUr2fj6
         fN/w==
X-Gm-Message-State: APjAAAV4GiLU1KkYmih34505osVH4rZ/6dHQtyKMHSLo6rCFBN3+LAWI
        N9n7xbGv3kojJAA0p1Ku8VwQq5N2O1Q=
X-Google-Smtp-Source: APXvYqw1dvLF3xdep/0p3slDjbc+0+I/l5cPcDK7PAJx6ANAKR48Aozw+LhJXCW3uvoeUzthKPTxfg==
X-Received: by 2002:a1c:c287:: with SMTP id s129mr14202725wmf.63.1556445265360;
        Sun, 28 Apr 2019 02:54:25 -0700 (PDT)
Received: from [192.168.0.41] (86.204.129.77.rev.sfr.net. [77.129.204.86])
        by smtp.googlemail.com with ESMTPSA id e5sm1577864wrh.79.2019.04.28.02.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 02:54:24 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] clocksource: improve Atmel TCB timer driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Romain Izard <romain.izard.pro@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190426214718.13470-1-alexandre.belloni@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <09e0dadb-41fd-4fa8-c9ab-f7c071ec2128@linaro.org>
Date:   Sun, 28 Apr 2019 11:54:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426214718.13470-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Applied, thanks.

  -- Daniel


On 26/04/2019 23:47, Alexandre Belloni wrote:
> Hi,
> 
> This series immproves the Atmel TCB clocksource driver to address the
> most urgent shortcomings:
>  - the current tcb_clksrc driver is probed too late to be able to be used at
>    boot and we now have SoCs that don't have a PIT. They currently are not able
>    to boot an upstream kernel.
>  - using the PIT doesn't work well with preempt-rt because its interrupt is
>    shared (in particular with the UART) and their interrupt flags are
>    incompatible). This also happen with the threadedirq command line
>    switch.
>  - there is currently no high resolution sched_clock.
> 
> The plan is to get those changes upstream as soon as possible as they are fixing
> real issues that people are facing. There are further changes needed on the
> clocksource driver to try to stop wasting a TCB channel.
> The PWM TCB driver will also be changed to actually use the reviewed binding
> and this will allow to get rid of atmel_tclib.
> 
> Changes in v3:
>  - collected ack from GKH
>  - return -EBUSY instead of 0 when the TCB is already used
> 
> Changes in v2:
>  - collected acks from Thierry and Arnd
>  - dropped most of the atmel_tclib changes that coud be separated.
>  - added a patch from kbuild
>  - dropped the patch removing the PIT from the defconfig
>  - moved the atmel_tcb.h inclusion in drivers/pwm/pwm-atmel-tcb.c as requested
>    by Thierry
>  - stopped using atmel_tcb_config
>  - reworked the irq number parsing to only care for channel 2
> 
> 
> Alexandre Belloni (8):
>   ARM: at91: move SoC specific definitions to SoC folder
>   clocksource/drivers/tcb_clksrc: stop depending on atmel_tclib
>   clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
>   ARM: at91: Implement clocksource selection
>   clocksource/drivers/tcb_clksrc: move Kconfig option
>   clocksource/drivers/timer-atmel-pit: rework Kconfig option
>   clocksource/drivers/tcb_clksrc: Rename the file for consistency
>   misc: atmel_tclib: do not probe already used TCBs
> 
> kbuild test robot (1):
>   clocksource/drivers/timer-atmel-tcb: tc_clksrc_suspend() can be static
> 
>  arch/arm/mach-at91/Kconfig                    |  23 ++++
>  drivers/clocksource/Kconfig                   |  12 +-
>  drivers/clocksource/Makefile                  |   2 +-
>  .../{tcb_clksrc.c => timer-atmel-tcb.c}       | 130 ++++++++++++------
>  drivers/misc/Kconfig                          |  24 ----
>  drivers/misc/atmel_tclib.c                    |   5 +-
>  drivers/pwm/pwm-atmel-tcb.c                   |   2 +-
>  .../atmel_tc.h => soc/at91/atmel_tcb.h}       |   4 +-
>  8 files changed, 129 insertions(+), 73 deletions(-)
>  rename drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} (79%)
>  rename include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} (99%)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

