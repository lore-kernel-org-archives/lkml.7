Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033FEC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38F12075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2Lz/y9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDLQ5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:57:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37244 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfDLQ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:57:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id v13so9512094ljk.4;
        Fri, 12 Apr 2019 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W27zkBxGk8bsEUwQZzMdkMQUeQalzAdHWjgOOXoBwKI=;
        b=a2Lz/y9YRoVZgxSEhVwOSxuPUGEn5CyzvELgusPLAMLLAq+OIishiNsLWuMxBfDt7C
         8Grg7nJDKC26bVrX7Xx4URCHZmOOP5THc5CwgjkTmRpQQhorfRrxUr2F6qbAYUC6CY+w
         bohMB+ffO7OXBZP529AYTGiWShH1ugIQ27QrFAzr6pY9uP0zhP0KT1fOmBGlTQx7yfVy
         QgeprsTtKTBd+qz35+yyJv5wbJru/Ws355Wx6DSsBsgIprYBgaqszP44Xs8xFfDIWgKa
         KLn3/gW1sr0Od8rQ8cY1MR5OR+Ee/zRCasJrOoJWSvgQL/P77bK8mYUoA9l64zgxY73s
         FoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W27zkBxGk8bsEUwQZzMdkMQUeQalzAdHWjgOOXoBwKI=;
        b=aFd8BXakCxSE7S0+OlRBXlb/aSLr+x+WWABvs+pN+ZWM1j7I9zYuA/QfYE3EacZ5wo
         28bOE91NxBTBFjcq0D4t5ZPFudJqgizvvMgf2VlEbFMiTv4VKDa/E5xjhdiRGaRNuV59
         IE5nbbSEZ4bMXXyjifln3p33XuZ7lQUJ69ZQX3INbPAXu5vCvoWvjbgXUMoWuGEDnQMp
         s5tdScWjuLrAoBGAr/JckmuPrBBqe5FHIPAlltZv5Ox9GZpcHd3epS56Bqx3IfwbpEqx
         SZw8xkm3HNrwAZASSx2loBJTlIj5BEb8ZMSDaTAHlLy+CFxH7Sl1LmBPmKHGHyZZfLdk
         vQCQ==
X-Gm-Message-State: APjAAAU9YcefnInk1GK1UddDE4a/CY64KPOK727pJGWQxlPCrLluzL7l
        s48iGHWj1Hkq0BDPfU1d8tXPRcT8
X-Google-Smtp-Source: APXvYqxwPEId8E3gsr04fa6WV1il1zejICVvu/b10lMvBpwU5nULR3kGicbXor7i8igYC9p8VrmvXw==
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr32544415ljc.65.1555088220593;
        Fri, 12 Apr 2019 09:57:00 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id z8sm8358340ljc.50.2019.04.12.09.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 09:56:59 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] PM / devfreq: tegra: Fix kHz to Hz conversion
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190411222914.25539-1-digetx@gmail.com>
 <20190411222914.25539-2-digetx@gmail.com>
Message-ID: <ab8dfa58-5e38-7538-3d82-d762341cd1b9@gmail.com>
Date:   Fri, 12 Apr 2019 19:56:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411222914.25539-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.04.2019 1:29, Dmitry Osipenko пишет:
> The kHz to Hz is incorrectly converted in a few places in the code,
> this results in a wrong frequency being calculated because devfreq core
> uses OPP frequencies that are given in Hz to clamp the rate, while
> tegra-devfreq gives to the core value in kHz and then it also expects to
> receive value in kHz from the core. In a result memory freq is always set
> to a value which is close to ULONG_MAX because of the bug. Hence the EMC
> frequency is always capped to the maximum and the driver doesn't do
> anything useful. Let's provide OPP with rates in kHz since this eliminates
> few multiplies and divisions in the code. This patch was tested on Tegra30
> and Tegra124 SoC's, EMC frequency scaling works properly now.
> 
> Cc: <stable@vger.kernel.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index c89ba7b834ff..ec4ff55f5eea 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -394,7 +394,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  
>  	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
>  
> -	tegra->cur_freq = data->new_rate / KHZ;
> +	tegra->cur_freq = data->new_rate;

This was a last-minute change and it is incorrect. The cur_freq should be kept in kHz, I'll fix it up in v2 and re-test everything properly once again.
