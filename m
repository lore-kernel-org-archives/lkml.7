Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B4720854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfdPy5h5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfCRQDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:03:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33032 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfCRQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:03:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id i7so8482513pgq.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G25m8+9f1ygSfASWU0CeM8DWXCHa+R6w3/Ew9+fOBT4=;
        b=NfdPy5h5vrXvbG3AasrACo8iuyrXTHLtVT7H6CgVhSF7Xzqn1DZWHQqe3F/V/eN/FV
         tFzUUr20nk1koe0Z2W+MNxvGbsX5CaHeVwx28iXKV5Rzw2zyWNW4cYK4wJX93l1nmZUD
         K515rzXeXGhq5JY7aGrAVjbPxSqdA6Js2/1tshV92OWsk/M2d4UeEW8aGswq0UJ+zVxk
         4bvizxX7oWL1RYnL0yTIDEyWipZkFDjwLoVgeFAlQZOK1C5Fx/syiXdH+HhNaRX6WnVq
         kHNEhZyutcfJD1MZizdxoRVVljTo4y1s+iks+LyQnYrlaJgBrsGNNP66mT9jHuxVzQQK
         do7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G25m8+9f1ygSfASWU0CeM8DWXCHa+R6w3/Ew9+fOBT4=;
        b=seZMcHDUGiT7v/u3O4NosKjXoT4KmPcVDygHR9qICtNHbM0Kozv7zlYZ3BVCd0FEXV
         CJX8sRC0F4Y4RYepyoNp/35ztv4wnriDm3Jx04EN7dTpeKTSkHtQ/ql9KJVvWF+sAzlH
         hj7YQDfMnVz2hw3laTvxPbFxNnK2M97oSYk/6sXWnaRLuQ78v5KRDA5UU3gLmQfVHxEI
         CL6ap+MBAwar5gzCTlfP5s2Rr2x7VdyvT3DqcO8iiaKU3dJd08yVTWE97L5bWa1Rwty/
         NTwTrHmVo5ddtZyUrQdFY1xY2OZCdSRVxTW+81jQJXpTjHySo62DiYU2OWG7Q/Bsci75
         tEyA==
X-Gm-Message-State: APjAAAVMhj4eXV2YwJmmiIbEv/AIE497h3v/ipvVDi1mK1Kdyym/tdov
        zfFLOaATgR/TIXp24fwDNfk=
X-Google-Smtp-Source: APXvYqw8B20zW65+JN52/0GUAGCvHv2qeDsPt7pH8ThbS7n+0XApZsLEIoQW6hyO06SPMZyTHdtXqw==
X-Received: by 2002:a65:6299:: with SMTP id f25mr18449831pgv.376.1552925008812;
        Mon, 18 Mar 2019 09:03:28 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.googlemail.com with ESMTPSA id j14sm16204886pfn.77.2019.03.18.09.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 09:03:28 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: fix error path for
 regulator_set_voltage_unlocked
To:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Maciej Purski <m.purski@samsubg.com>,
        Support Opensource <support.opensource@diasemi.com>
References: <20190318155054.59B483FBD8@swsrvapps-01.diasemi.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <513a7028-b972-a821-7bf1-0e105bf71305@gmail.com>
Date:   Mon, 18 Mar 2019 19:03:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318155054.59B483FBD8@swsrvapps-01.diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.03.2019 18:32, Steve Twiss пишет:
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
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> ---
>  drivers/regulator/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 68473d0..caf8743 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -3326,7 +3326,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
>  		goto out2;
>  
>  out:
> -	return 0;
> +	return ret;
>  out2:
>  	voltage->min_uV = old_min_uV;
>  	voltage->max_uV = old_max_uV;
> 

Looks like a good catch.

Probably will be a bit better to write this as:

        /* for not coupled regulators this will just set the voltage */
        ret = regulator_balance_voltage(rdev, state);
-       if (ret < 0)
-               goto out2;
-
+       if (ret < 0) {
+               voltage->min_uV = old_min_uV;
+               voltage->max_uV = old_max_uV;
+       }
 out:
-       return 0;
-out2:
-       voltage->min_uV = old_min_uV;
-       voltage->max_uV = old_max_uV;
-
        return ret;
 }
