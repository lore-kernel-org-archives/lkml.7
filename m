Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ADFC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F397F20836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5LEYekO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfCIOYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:24:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33582 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfCIOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:24:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id c13so10770361wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7rIjTkYfaChn3AQWHIf5YKtHs717sQSf2y9a/O/XINI=;
        b=u5LEYekOKK7ofyfnbVGs2s0Q4VKLB8c02GYS0tLXmkA8kc061B0SUSdRzseQv7VstQ
         eutXXU5akGztqPt2ZnK8rNYsQlGlGjBCzVGjvc6sAOgBbN32hFEGECEXOfYjhGpJVliH
         DEyNc3SMpTc9aFyIchWqXfWIIxzneLircl3JO9NzgQx/a5CW9ucIWsClW9eQRLewtVaW
         vRkVDQMhzBEfTqUTHN3IeT8qgO+QmgrbiWPsONnKvx4D6J5k5unCb7r6bfhAvNsah6jO
         1YPRoHaaxt7G1wLd2vRmpm6fOmQ6XWy/YlsAlTM5W599X2aZeZkltrvxazenQNvcd8sY
         Q1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7rIjTkYfaChn3AQWHIf5YKtHs717sQSf2y9a/O/XINI=;
        b=uK0s+I+PwbK/odxeejEV7B+XbG50nUvDTF6E3eLiBaSp0symn64g1JHzpTZcIGI9c3
         EeQPouscSxKsSlNYzyaHHuN181pgJfZ3FOckLIVd5CncypbZoC99o9BSwpT+SE77mSrX
         Z92WsInak8VVUYO3wDXkVohzsSSxt50vUI/JCXJFVQHJ7euB889tXf89INbWG/QXYNCr
         XyVYBBxDj7+Bz693LqoJtlYBmsXKvQb0HROD+Bmytqs8qm+RAjy6G30vrn8WCO1r4fz+
         qvuSvEclxasMkIX0/mkK1J4F9htvckxL5yRmNN765vLiVROds67u0BMBKSBh7PzBoqd9
         oOPg==
X-Gm-Message-State: APjAAAVSWGN1OJA5w62UKJjooHc/uiwlvXGZMUwsXKaqbXy77CYfJwyS
        azGqyxzECEr77G92JfWJu+DDnN4jxTU=
X-Google-Smtp-Source: APXvYqyfOFA7S2SDjsucGTsRJp2AR6H2HGz2w4eRhmIPKYWRKJYJ4RGC0/gD4kqTMTPhkskz5Rvmzw==
X-Received: by 2002:a1c:c60b:: with SMTP id w11mr12165999wmf.39.1552141449441;
        Sat, 09 Mar 2019 06:24:09 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id t9sm1653485wrx.73.2019.03.09.06.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 06:24:08 -0800 (PST)
Subject: Re: [PATCH] clocksource: cadence_ttc: fix memory leak in
 ttc_setup_clockevent
To:     Yue Haibing <yuehaibing@huawei.com>, michal.simek@xilinx.com,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190309131958.17996-1-yuehaibing@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b9831ea9-3230-6f63-8c73-b3b2cd28c59f@linaro.org>
Date:   Sat, 9 Mar 2019 15:24:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190309131958.17996-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yue,

I appreciate the fix but usually we add a rollback for all the
operations done in the init function.

Please, migrate the init function to the timer-of API, so the rollback
will be automatically handled.

Example here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/timer-sprd.c#n197

On 09/03/2019 14:19, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Add the missing kfree() in ttc_setup_clockevent() to free the
> mem before error return.
> 
> Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/clocksource/timer-cadence-ttc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
> index b334029..b664af8 100644
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -432,6 +432,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
>  				    &ttcce->ttc.clk_rate_change_nb);
>  	if (err) {
>  		pr_warn("Unable to register clock notifier.\n");
> +		kfree(ttcce);
>  		return err;
>  	}
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

