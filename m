Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BE5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0D720863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5y/fWrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCRQKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:10:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44059 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfCRQKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:10:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id h34so11686801pgh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YIhFIKs9el8j4hsLgwZPPQzsqFgxi9CCkwroXgIH/9M=;
        b=H5y/fWrhJ8CUuu3ZQwAI2HU4xEuhAC+4HrZUlSOvBKFSTZkUnylfiXszr7uJhr0FDK
         DMaw8/oALs88yoM8a63/MpI6bVM46oIs7iwdKG0AohB0l/RB6VSEF8Im5waolXk7wB8r
         Ya17B2Ndyg/9tvs4+oJtd69z3GTE5nJzNNwz4r7zOGpfq00u5Or+zndAZUHKGO1gn8ws
         39XIUyeRBXo7KFvjLFXIqax6waEHcwwFY/TNvf+sB4EjmpwhctvyrDFtYNoP6RSsIvg0
         VRbCEvrGdkicz3ovf/StnTCYTPlwygehzfoU3AfXaZ15p245VmINWF8DpCE7VfEt0aja
         m55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YIhFIKs9el8j4hsLgwZPPQzsqFgxi9CCkwroXgIH/9M=;
        b=LZdgsfvJnKnLvmS3c3gqiduhXk2rokQ+5AypXnx2qbUCVsDtSefp3/zFvh1hXLVnPi
         nrrkSCKWaOEGsC0aDEWjubhBMeNeJB83+JiAgb0b8wC0nAPZQpcy1bztlCqGwVey18K0
         DANmOgArg7Px5bRjCj+urc7DZ1x3piZG5pcwMPJBuMFGHZRhG/4lOWVIuXxMYA57v2xP
         Wj7Oxw0Xt9GgwQ0rrPtBsGIfPOWxdss2bH5rP6isgMsG+2FwJLWYECTZFAGgfy6RmNHp
         31hfUGbKkZ3EiHHemfiwgYJxigx/8UxHHf0aRel7f11S3OvoZioBGT4I9URokwHlxDxm
         6prw==
X-Gm-Message-State: APjAAAU+IDFWqVOa3AlAIUzq762bglcApD0rk7IrPMbz7eQK3DGIWFIG
        +1s+gxcUD/k5twVWsY+MaFU=
X-Google-Smtp-Source: APXvYqzHKasaXjHYtTYAzojmBjVom9G6nX6MM/FzU2QbX/ktmgVNDCNbgvJfEMwW9eBfPoOLiv4FUw==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr20691370plf.242.1552925432769;
        Mon, 18 Mar 2019 09:10:32 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.googlemail.com with ESMTPSA id m8sm22805463pgr.82.2019.03.18.09.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 09:10:31 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: fix error path for
 regulator_set_voltage_unlocked
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Maciej Purski <m.purski@samsubg.com>,
        Support Opensource <support.opensource@diasemi.com>
References: <20190318155054.59B483FBD8@swsrvapps-01.diasemi.com>
 <513a7028-b972-a821-7bf1-0e105bf71305@gmail.com>
Message-ID: <e8cc2027-2705-6175-f88b-cc630978a520@gmail.com>
Date:   Mon, 18 Mar 2019 19:10:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <513a7028-b972-a821-7bf1-0e105bf71305@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.03.2019 19:03, Dmitry Osipenko пишет:
> 18.03.2019 18:32, Steve Twiss пишет:
>> During several error paths in the function
>> regulator_set_voltage_unlocked() the value of 'ret' can take on negative
>> error values. However, in calls that go through the 'goto out' statement,
>> this return value is lost and return 0 is used instead, indicating a
>> 'pass'.
>>
>> There are several cases where this function should legitimately return a
>> fail instead of a pass: one such case includes constraints check during
>> voltage selection in the call to regulator_check_voltage(), which can
>> have -EINVAL for the case when an unsupported voltage is incorrectly
>> requested. In that case, -22 is expected as the return value, not 0.
>>
>> Fixes: 9243a195be7a ("regulator: core: Change voltage setting path")
>> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>> ---
>>  drivers/regulator/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
>> index 68473d0..caf8743 100644
>> --- a/drivers/regulator/core.c
>> +++ b/drivers/regulator/core.c
>> @@ -3326,7 +3326,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
>>  		goto out2;
>>  
>>  out:
>> -	return 0;
>> +	return ret;
>>  out2:
>>  	voltage->min_uV = old_min_uV;
>>  	voltage->max_uV = old_max_uV;
>>
> 
> Looks like a good catch.
> 
> Probably will be a bit better to write this as:
> 
>         /* for not coupled regulators this will just set the voltage */
>         ret = regulator_balance_voltage(rdev, state);
> -       if (ret < 0)
> -               goto out2;
> -
> +       if (ret < 0) {
> +               voltage->min_uV = old_min_uV;
> +               voltage->max_uV = old_max_uV;
> +       }
>  out:
> -       return 0;
> -out2:
> -       voltage->min_uV = old_min_uV;
> -       voltage->max_uV = old_max_uV;
> -
>         return ret;
>  }
> 

Also, probably won't hurt to add a stable tag "Cc: stable <stable@vger.kernel.org>" to get the fix backported.
