Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA7AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758D620850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qhnpv2qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDKUIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:08:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43496 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKUIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:08:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so4300822wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=66pJRrVMg8kq0VWEWmjYW7Ug7Cw4i2vMYlb6B7iK0q0=;
        b=Qhnpv2qyo8zYX6zg1PN7YifcHAi/Rd7VQZVO/GrUv7dM5EKxGzV9pM+3NXqzfb28RA
         jdHwKaC4HPBJSkOwQImJvMjqDLliIn9vhJLSiepUnoQWY2veWY2yOfdrnmCCT7W+nxON
         mqDRQixRBbbtN+Q+HWZnVzyVdLRhO05067qVccguRYGQFsbeF0KEHgPnmSG03boyErcE
         FmbT8IcHYp96oZUlJgCuIZXsi4by6U9tvRh3Re16Km1/LqH62U/OprX9Dhr0QXg3W4UY
         dfgTnkK0ZVOmnKLeyNo7o2k2ESi6JmY3oX77S4c8zUg1JvIqfX9A8VH43z2BRFoVJmkb
         CywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=66pJRrVMg8kq0VWEWmjYW7Ug7Cw4i2vMYlb6B7iK0q0=;
        b=Q2qOO0R1beljLloz5vTr69jYi7ZhJ1Hzh0xeoxXmykXWGk9yzO77WkslABSKXgltuX
         AXjtJCZZkX7lRE0ENtKqAU0TtGir5Cqwg/4qvP9o+HVUbz5m5xtG55FeZfLGVpQaq4tc
         ruwj5rLg6QbSSg0UA9EWS4end/AALH/hYqrUe4ujpIh2uhIFFrVgPUBk1Mjj2spiYeS2
         o+2HD5DbXyPqgdztF5JELorGZ8tRi6/6J8k3P9SDp8XOWOkm7kHExyJJnMoxFC5QJDCW
         DznIZ/esHjypxJ9BLr8SapAGtQJmzajd8U1w6lSmz5Y5JIyPrVJ/REpdc0+N3Rxwq9TH
         ME+Q==
X-Gm-Message-State: APjAAAVdXNZ3fAsPojRCuiiOPg5stmx4TmQ7sYPNag3/dCuHv01o32ny
        d/nijOW/YJBfv6hy1shxNwFbYkykhQQ=
X-Google-Smtp-Source: APXvYqyBf0z7VOUGabtwvXB6Xcu3cQmsNGorUEUn+ly8PmapTwAtJm1N/viMSeFyn8Kij4DxZIba5A==
X-Received: by 2002:adf:f050:: with SMTP id t16mr28112589wro.198.1555013320003;
        Thu, 11 Apr 2019 13:08:40 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id x205sm8931576wmg.9.2019.04.11.13.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:08:39 -0700 (PDT)
Subject: Re: [PATCH 1/3] clocksource/drivers/timer-milbeaut: Fix to enable
 one-shot timer
To:     Sugaya Taichi <sugaya.taichi@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
 <1553483149-8922-2-git-send-email-sugaya.taichi@socionext.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0488b22d-6e47-768a-6bde-eb2d7196f7e9@linaro.org>
Date:   Thu, 11 Apr 2019 22:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553483149-8922-2-git-send-email-sugaya.taichi@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 04:05, Sugaya Taichi wrote:
> Fix mlb_set_oneshot_state() to enable one-shot timer.
> The function should stop and start a timer, but "start" statement was
> dropped. Kick the register to start one-shot timer.

Can you add the "Fixes" tag please.



> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  drivers/clocksource/timer-milbeaut.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
> index f2019a8..9fd5d08 100644
> --- a/drivers/clocksource/timer-milbeaut.c
> +++ b/drivers/clocksource/timer-milbeaut.c
> @@ -80,6 +80,8 @@ static int mlb_set_state_oneshot(struct clock_event_device *clk)
>  	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
>  
>  	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
> +	val |= MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
> +	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
>  	return 0;
>  }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

