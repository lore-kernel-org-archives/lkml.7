Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6888FC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352A720643
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDmzKIhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDKQe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:34:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34972 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfDKQe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:34:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so8223955wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TQOe65o2IadhbVE9tWUiz1K2F/QKC/DM3r1AT+nkV0o=;
        b=uDmzKIhs7Txo3Jgk+h11zpBn8rPeQ7jauF8c6k95isdKlnuFplP63TEcnj4WzBZHTd
         6dXwscSWvsxqnBJE70y/pbYea3aX25aklhcY/mH0alBxSj3WAoSYFRDy9eJ8JjXmENqs
         4GuYMkueBOoSq9b4g+1p03D/iKUV3L4YB7yk9rYz0aoq7PzoZGzE1LYAyvglYvbO/Ozb
         UY5RZwfWRNOjQrkMrOJlV85gFrVthW7AFwHyibjSMDoXeynbDGLDG0rxDM+316uz6qQW
         c7yOujTWEfXLfzRkRqr3lUrXbGKL2eI57n2J9tm6evrcrLOr63x9pdp+OIDT75WXwaJV
         PJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TQOe65o2IadhbVE9tWUiz1K2F/QKC/DM3r1AT+nkV0o=;
        b=aOqBqO1H4sQngXWf3niYnwFwwuDfeAgHwImaMsfEYN7z8RJJMP7RuL1Xr7xAxl43EB
         LqYCfNVUl7vPLyjnfHTanCQKJ3YjRSLBuwGjiNw+XqSw79J+syIbH8E5ntbtf3Rdb3Es
         3i6gDSUWxM3VnLO4YonWqlFSamvyNu7QvDb5zkN1Ft+dFXWW1+UaAeZlsCMVCiKAeOIA
         sWUFWPH4jU+PLoKwivC5hhvdpGzEs0EMrXj4DJ4ndf7V2omSIDB5qvVqdYLcEVr+p0Ov
         kcpTRsAFt+/+4nHFz2cNhmWGhR+8FsF/IkKDUT9hzhDl6qMmDQFzucbxB9WK5b93cGLq
         SrCA==
X-Gm-Message-State: APjAAAXyuPd6KK1AILtvU2wqTPckJKNf8Bk/Kvi7dWRVRj3yMEzmkAQM
        xNwDhWejAZFk/AFPRjaPDj2FXA==
X-Google-Smtp-Source: APXvYqx/Um95xHSe2Fl93bDPu1mwY+PiLIRNXVYYJnwr7v3npoOt611zjDssFQDggEmCo/GezWKcyA==
X-Received: by 2002:adf:f050:: with SMTP id t16mr27520805wro.198.1555000467041;
        Thu, 11 Apr 2019 09:34:27 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id b9sm9513137wmc.9.2019.04.11.09.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:34:26 -0700 (PDT)
Subject: Re: [PATCH 00/12] clocksource: improve Atmel TCB timer driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <580bf140-1e00-517d-628a-952128ebe4fe@linaro.org>
Date:   Thu, 11 Apr 2019 18:34:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexandre,

except the comment for 3/12, the series looks good to me.



On 03/04/2019 16:11, Alexandre Belloni wrote:
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
> The plan is to get those changes upstream as soon as possible as they
> arre fixing real issues that people are facing. There are further
> changes needed on the clocksource driver to try to stop wasting a TCB
> channel.
> the PWM TCB driver will also be changed to actually used the reviewed
> binding and this will allow to get rif of atmel_tclib.
> 
> Alexandre Belloni (12):
>   ARM: at91: move SoC specific definitions to SoC folder
>   misc: atmel_tclib: drop AVR32 support
>   misc: atmel_tclib: move definitions to header file
>   clocksource/drivers/tcb_clksrc: stop depending on atmel_tclib
>   clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
>   ARM: at91: Implement clocksource selection
>   clocksource/drivers/tcb_clksrc: move Kconfig option
>   clocksource/drivers/timer-atmel-pit: rework Kconfig option
>   clocksource/drivers/tcb_clksrc: Rename the file for consistency
>   ARM: configs: at91: unselect PIT
>   misc: atmel_tclib: do not probe already used TCBs
>   clocksource/drivers/timer-atmel-tcb: Use ARRAY_SIZE instead of  
>     hardcoded size
> 
>  arch/arm/configs/at91_dt_defconfig            |   1 +
>  arch/arm/configs/sama5_defconfig              |   1 +
>  arch/arm/mach-at91/Kconfig                    |  23 ++++
>  drivers/clocksource/Kconfig                   |  12 +-
>  drivers/clocksource/Makefile                  |   2 +-
>  .../{tcb_clksrc.c => timer-atmel-tcb.c}       | 123 ++++++++++++------
>  drivers/misc/Kconfig                          |  24 ----
>  drivers/misc/atmel_tclib.c                    |  37 +-----
>  drivers/pwm/pwm-atmel-tcb.c                   |   2 +-
>  .../atmel_tc.h => soc/at91/atmel_tcb.h}       |  25 +++-
>  10 files changed, 146 insertions(+), 104 deletions(-)
>  rename drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} (81%)
>  rename include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} (95%)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

