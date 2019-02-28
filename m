Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72709C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E24218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjxZHr1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbfB1OfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:35:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37411 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbfB1OfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:35:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so9093645wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Kkz1gWU2j+/sHbYzvIHb2P6bABHf6o9u82gvARVFKc=;
        b=PjxZHr1w5Qq/YYxOmsC/j3YKaZdoyAHiUOzwi+8eDPLi+aD3lSu+pYB8t2Zi3MAiH/
         Si+5PfcT7ptC/btn8S6mPjvLBegNyeVuyXDo3Cwz+wBQ03jEFn5xjVgALt2EUZyN9r80
         sR3AukmeRAdL5BKJZcXicmkqFcZCkI51eRtjPKvViiaRWRargjfmMHRFUkKlR40dtmk4
         9deV34Uinirg3W9PgVczgDDZePTyc1M/ofLU9RLZ4EsRmn6J46BYN5zOM6z3Qyy5DwOe
         kWrHQBEWKir8jcP2oR4r2DBGb8tHj0kDBEQTYVHqZg7MxBbuOuRsZO1RcSb6PY9dthIh
         yBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Kkz1gWU2j+/sHbYzvIHb2P6bABHf6o9u82gvARVFKc=;
        b=LZyG3ZMkEtaDrMiCT2xVNrHRtdkeVPFnOmiZZ96ViphhuFgIaOPewV2UMEYSW+wD2F
         hnO4kyl6yxPhDkGEVes+Q+Fgb2ZfBsYP2knAhlV2ytApOEx/BUSUV0+PPQZxt0fs9plk
         z6HVgvPIUQsrs3NnDzvdFsY3dOwDOl0Xj6DknyJI5S8b46M4vqduGOcgoWljPYXkaGgc
         LHFZo5hoK2NevgEBDmUG/BL9H0opelElthj+ATCg+TWN03ah2kJfPasqwT2cmyK3bEuo
         /8e1VMnkcugHin3bB8U/JIj/C/xTfY95aLG0Ks7xudleJIiucKzE7rpmKqHysKaOS/iI
         vMPQ==
X-Gm-Message-State: APjAAAUTBX203td01naN0EOBBpzj//fhPGf1DV4vEdKdFEYlirLBkZ2H
        MNt/JmsB9T85quNbuMB+79i2h0n5beo=
X-Google-Smtp-Source: AHgI3IZ2eBGs1Ks43dL/3i8l3bwoFMwvoVJxUpuVS2R09ezK1n5k7Abr2/8M3cUrS1a0DtyGatwsfQ==
X-Received: by 2002:a7b:c352:: with SMTP id l18mr3021596wmj.127.1551364507763;
        Thu, 28 Feb 2019 06:35:07 -0800 (PST)
Received: from [192.168.0.41] (244.150.136.77.rev.sfr.net. [77.136.150.244])
        by smtp.googlemail.com with ESMTPSA id k203sm4657415wmf.44.2019.02.28.06.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:35:07 -0800 (PST)
Subject: Re: [PATCH 2/7] MAINTAINERS: Update files for PSCI
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-3-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cc5bd1b9-1aa1-496a-9e16-3e6a8e321067@linaro.org>
Date:   Thu, 28 Feb 2019 15:35:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228135919.3747-3-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 14:59, Ulf Hansson wrote:
> The files for the PSCI firmware driver were moved to a sub-directory, let's
> update MAINTAINERS to reflect that.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32b76cb95f57..ff998605b773 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12182,7 +12182,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
>  M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
> -F:	drivers/firmware/psci*.c
> +F:	drivers/firmware/psci/
>  F:	include/linux/psci.h
>  F:	include/uapi/linux/psci.h
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

