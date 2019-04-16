Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03EEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A3E20872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxF2yz3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbfDPRcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:32:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38926 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfDPRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:32:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so28215539wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DTHrgt8Q+9MU0rLcib5jpVeSzaccN60qGcicKE132EA=;
        b=bxF2yz3UnKAH0igd6dt8GCIqUo4UJm1RPrhOfMPJxK2wXaRXnfUMYtyo2r97u80YTS
         Qjfgmi4CeAKn8v9IuOVO/Ocqk3eQCCc5i9ZeU4SKWTktSvfcSW59/K10XkkiJzbBz2CQ
         L4LTRnPJ0WZMeLgmID6uZKMWUcN1WPWJ8MgYQT4tDnF7XyoiV+1kZv1BiXVYyKYfHmn0
         XNWKrZhR/kPwiw5Q27vSuT6vWMQRxVHHpE5FjpR0pzwd3cminBRDOqHGhV86k4ksp6yG
         nun+eU6MyDe/JSd371tP3ASldosjw+fI5bed5/OboxfeRN5wrrjPMkLoJDi/9RAVbQ7u
         Cqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DTHrgt8Q+9MU0rLcib5jpVeSzaccN60qGcicKE132EA=;
        b=iv+BuD1J256YDzKZLWELX+aCAPTmEg2K+qgqz7InuLaezJFOKZTh5yFML+C+u+4U7U
         VIp3jSB2fCnWHcLFS5vMTvPuGTJmdKs9iOKJ++q8OUbOn+rtW78B5W80TYD2A2+A66yt
         XPXbTBlcB7qvRM0sdKaNaCtB4lN5JD84Vja17/cnULPgFpkrbugHKzyKNTI0cCcKkDFU
         6AI4G7oG+9FXcgpy0l0au1D7vhGRTuEABJzh8Kbj5tBJx3VYmppoDRF+WUSIjS2wxnlG
         OhZpvS3JUCoNV1i5Q2TMnb00BnmbR3vg8V3cwG9xXQ3NzERo28wBGEpIRuqPlG/roeHM
         vkdw==
X-Gm-Message-State: APjAAAVwY41BeLx37n03rdEN6qNkqPNuIHMM9GIrvpH20VDToeWFHkZr
        G9N5GNLGup2LAiDxCj/GLRT+Ob6lDms=
X-Google-Smtp-Source: APXvYqw8iedU2LFSngp6kBV3Vi75K40IfE2rQR9LqST1fDh7/gGmWLR0eNtSuQM7Mtz9X9BSSxJMnA==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr49238309wrs.256.1555435956286;
        Tue, 16 Apr 2019 10:32:36 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id 7sm182441944wrc.81.2019.04.16.10.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:32:35 -0700 (PDT)
Subject: Re: [PATCH] clocksource: timer-probe: change log level to warn
To:     Moses Christopher <moseschristopherb@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20190416172309.7428-1-moseschristopherb@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <63ead988-cb06-ca14-6995-9d5405f3e562@linaro.org>
Date:   Tue, 16 Apr 2019 19:32:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416172309.7428-1-moseschristopherb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 19:23, Moses Christopher wrote:
>   - In drivers/clocksource/timer-probe.c, the log level for the message
>     stating "no matching timers found" should be of warning(4) rather
>     than critical(2)
>   - Reference:
>      - https://e2e.ti.com/support/processors/f/791/t/726024
>      - As per the feedback received from Daniel Lezcano
> 
> Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>

Applied for 5.2 but massaged a bit the change log to comply with the
kernel submitting patches rules.

> ---
>  drivers/clocksource/timer-probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
> index 028075720334..246b45d22d08 100644
> --- a/drivers/clocksource/timer-probe.c
> +++ b/drivers/clocksource/timer-probe.c
> @@ -50,5 +50,5 @@ void __init timer_probe(void)
>  	timers += acpi_probe_device_table(timer);
>  
>  	if (!timers)
> -		pr_crit("%s: no matching timers found\n", __func__);
> +		pr_warn("%s: no matching timers found\n", __func__);
>  }
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

