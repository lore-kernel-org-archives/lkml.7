Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA03C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82B920645
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="csR2oOnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfDOMQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:16:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41045 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfDOMQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:16:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so21620491wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oZQ9jNFjXa22UEvVc9ReDINqabzL0slMZxy7p+uxC8M=;
        b=csR2oOnGe5LDdDcKwkh5nQgfP+DgSksP/yi/UqY1kG/vgmF17D9M6rGAx1GnDpf6H1
         4U48vL2wPWgdiJMKyy6fXjrTzMT8cptntUe8TxrqQCjIe1IaU6xqhRSVV9reN1QsbkSV
         VlojhnCFi0c/BlM2mR//0a5T+nEpxrQ7OJyyKI4F/mUQUrOeGj4PWPFDh1SRe/EMFKtj
         lhIeNOkcXi3SElL81vU3Y5G2KZzIWYLXRNLmbZn4lHbIotdCahCf5m3EbBfHSgurtB0k
         cfIwfIOWnqwKm3JAJYg3PWZWivfu7EzrQW2PrQGcXZkqxstJ5UjSXMdG9YsPdapDudRi
         sU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oZQ9jNFjXa22UEvVc9ReDINqabzL0slMZxy7p+uxC8M=;
        b=DTf9+Uql/vRPQyAuZDe6BHkWsQoXvX2t39vptMQzajoyvZoKHfnUbZJJ2RQ652iJsb
         euB0FrL2uun81PwWydgLCT0ntJ8GCaHkDpIZ/SkOTb4vc+BCKOz/BztrYJriMliwpFXk
         QhishzHf4B0+PvBOMKrfGzTYtawkykwtW3ynokm/1hVJCTam7YpO4tLM4KOvJUkGSAvv
         vPXf76B7GeOHL8plSQjtJa5ua7a+KUdxftLXap+g7DdmS05mCSQlGYjXOd0gn1kEHLEx
         Zvos9pKj+FoQGe84EZAeMtf5qpsBrcYBhA2RjFWrFsU1dFE3gT2D0dfjIBOR/JBBO3FA
         pUtQ==
X-Gm-Message-State: APjAAAXToSmvb0Mhlidk879DGa6AHR+C15P7qjMeLXKx+QeBbEkl/op4
        DHkuuona4PpVknUgVZ+o1xK2I4Dc04s=
X-Google-Smtp-Source: APXvYqytId0xb31cZs55y29TPkLOmaX8XyST/BTtHnaDwRikTsTlmBTBNH0A4AdmeOBA/944UdYVKg==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr10802190wrp.235.1555330611076;
        Mon, 15 Apr 2019 05:16:51 -0700 (PDT)
Received: from [192.168.0.41] (4.112.130.77.rev.sfr.net. [77.130.112.4])
        by smtp.googlemail.com with ESMTPSA id d6sm12065156wrp.9.2019.04.15.05.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 05:16:50 -0700 (PDT)
Subject: Re: [PATCH 7/7] clocksource/arm_arch_timer: Use
 arch_timer_read_counter to access stable counters
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
 <20190408154907.223536-8-marc.zyngier@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2a60a031-1eab-2d5e-89ff-b5d516545eeb@linaro.org>
Date:   Mon, 15 Apr 2019 14:16:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408154907.223536-8-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 17:49, Marc Zyngier wrote:
> Instead of always going via arch_counter_get_cntvct_stable to
> access the counter workaround, let's have arch_timer_read_counter
> to point to the right method.
> 
> For that, we need to track whether any CPU in the system has a
> workaround for the counter. This is done by having an atomic
> variable tracking this.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

[ ... ]

> +
>  /*
>   * Default to cp15 based access because arm64 uses this function for
>   * sched_clock() before DT is probed and the cp15 method is guaranteed
> @@ -372,6 +392,7 @@ static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
>  DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
>  EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
>  
> +static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);

Wouldn't make sense to READ_ONCE / WRITE_ONCE instead of using an atomic?

>  static void erratum_set_next_event_tval_generic(const int access, unsigned long evt,
>  						struct clock_event_device *clk)
> @@ -550,6 +571,9 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
>  			per_cpu(timer_unstable_counter_workaround, i) = wa;
>  	}
>  
> +	if (wa->read_cntvct_el0 || wa->read_cntpct_el0)
> +		atomic_set(&timer_unstable_counter_workaround_in_use, 1);
> +

[ ... ]

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

