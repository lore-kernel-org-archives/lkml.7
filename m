Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C2FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569B621473
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOuKwslX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfCRQlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:41:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43992 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfCRQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:41:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id l11so11752937pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qf8VyBGM6BCT/mmVBZAC1dCuSDdDI/a+rLEIrUdaTPM=;
        b=SOuKwslXC8uTauaIitnuKF3r0OTs6531kBIFlkX6Na6TisnAOtZMny7m5d2L7WMFLn
         Oj91HIheOrrKkwIEfVWdkDLBIr/uzjV9Eyv3q0tl/lkd7KTTmtY+HJwSVfFpPbkA22jJ
         EUIdcTl5+jY8L88orpux7EkS0KlKmCLL3ZzV9INU2XfzWYh9pIcHrhmJy38+ZYzI5izp
         kIT3cst//ARXr5ZZhvOa/78+5/Vf2gnTjCktnzoXDvKeaqXJ9//uBmbbLp9nTjjejo0y
         QnRXZewm/eoyyUdwxcM1vIqCh3mLQztZFoy6+ZgPtUOBHMR7QHqTOER5Y8q4AVDat31D
         rYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qf8VyBGM6BCT/mmVBZAC1dCuSDdDI/a+rLEIrUdaTPM=;
        b=XVbMqNzibT1+AloKPVlRx+oVhKdLiRzdxfU/XbWlxF2Id+zXTgbMV+A+0eEBOFuArw
         rdo1aT0JlTRGHkKjnSH+i7grDu+cDghAkgsgZvgdZpRAcWNeRvBMr54/z1Zha5rZ8Tvk
         AojSVPk0iR5pyyQpZJ/fflhUkrXLU3H1unKnjQPWDnOCd8WyBlJ01919J03lDAC7fuN2
         FtF+HcMAMfadI+VUspT1WbXeh03hd6ytYkliewk4sAdemQV1g/ErvWc3l8sMOcdXjktr
         gA+V9FynIAonV/7LwjsqJf+XUUqHbeMhNEgJEI7tJytFYBx4Jm6se9EbMI1D7lPk1C9d
         okmg==
X-Gm-Message-State: APjAAAWueWCoiMbqbKdCtbxw5c+AWz/D8Ej0QFp9HV3L5siDp4IgztL+
        etaSVgM6R3ItCENkjeUoJCY=
X-Google-Smtp-Source: APXvYqwOvona7fGnvmRbd74cRV5iYvcphTuPWDTjU7Wb260ZA/rDm8tNQFOAv7AG6Y7dH3RummU1VQ==
X-Received: by 2002:a17:902:9a02:: with SMTP id v2mr20818589plp.201.1552927264659;
        Mon, 18 Mar 2019 09:41:04 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.googlemail.com with ESMTPSA id a66sm23028289pfj.153.2019.03.18.09.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 09:41:03 -0700 (PDT)
Subject: Re: [PATCH v2] regulator: core: fix error path for
 regulator_set_voltage_unlocked
To:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Maciej Purski <m.purski@samsubg.com>,
        Support Opensource <support.opensource@diasemi.com>
References: <20190318163132.1BB633FBA2@swsrvapps-01.diasemi.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c3a02cd7-3cd3-b1a5-45fb-278c3391336e@gmail.com>
Date:   Mon, 18 Mar 2019 19:40:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318163132.1BB633FBA2@swsrvapps-01.diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.03.2019 19:17, Steve Twiss пишет:
> During several error paths in the function
> regulator_set_voltage_unlocked() the value of 'ret' can take on negative
> error values. However, in calls that go through the 'goto out' statement,
> this return value is lost and return 0 is used instead, indicating a
> 'pass'.
> 
> There are several cases where this function should legitimately return a
> fail instead of a pass: one such case includes constraints check during
> voltage selection in the call to regulator_check_voltage(), which can
> have -EINVAL for the case when an unsupported voltage is incorrectly
> requested. In that case, -22 is expected as the return value, not 0.
> 
> Fixes: 9243a195be7a ("regulator: core: Change voltage setting path")
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> ---
>  drivers/regulator/core.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 68473d0..968dcd9 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -3322,15 +3322,12 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
>  
>  	/* for not coupled regulators this will just set the voltage */
>  	ret = regulator_balance_voltage(rdev, state);
> -	if (ret < 0)
> -		goto out2;
> +	if (ret < 0) {
> +		voltage->min_uV = old_min_uV;
> +		voltage->max_uV = old_max_uV;
> +	}
>  
>  out:
> -	return 0;
> -out2:
> -	voltage->min_uV = old_min_uV;
> -	voltage->max_uV = old_max_uV;
> -
>  	return ret;
>  }
>  
> 

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
