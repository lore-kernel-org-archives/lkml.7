Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A086C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248DC20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcXR66lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfFFNCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:02:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36112 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:02:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id u22so1481747pfm.3;
        Thu, 06 Jun 2019 06:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gJDaE/9aWNqi/p+iU5+nQDsd9sq5Dk3XWXtLMHSqFQU=;
        b=qcXR66lDHA4Jn9Znzb4kxBbzrl/hUYKOZ38PU0qD4AHM4JCHLpGM5mDuuX4uJuVWgB
         CFzkA+cASdMERV8pNxvSFa367SvHndvwso5X1GczAPYkf0QhAAcdOJW3S+FGBnv6tVv+
         3wyOzfpgQCssVnCVgnQ9Q4I+AzOLxz40x7ySvRr3dbgmfM5xtK3fH1ZlwM1oF9zJQ7jL
         7TCwKWa4CspP6kQffvpAlE9zuWekZrvrdzrKNBsa/WoLfy/+qblMbXlScmPRqhq7Hny8
         3/W4QDFvuXQjRfkOltaEpsmVx5J27UnBNPfyRHbKX3Pp8sg2PHJWM1qnbJWlbACDgGX9
         Rk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gJDaE/9aWNqi/p+iU5+nQDsd9sq5Dk3XWXtLMHSqFQU=;
        b=J9H/KH+p8peIVgRWs8goPdLPFz67RMH19tsS+u92mKjwU1Hd+CQ1R58ythF4MDnhzb
         YaxzyEyd5bFJYbtKZiSk2QJlSwgyN7ls47ZCWUDFc7nq2RWrUovO91JxIwLHQ9lzhh0I
         CRCfYLLZGnm5YFQH7j5MIunU2Ah5ywuQ4bN/h40AITFQXnnqHIuXvKfKnwM8BaOdgNi6
         PaxcRPeoXiqiAN6IwokvQ3QL6ChjVdkX8al0u21hhi/Rfx89WbGwXdFMe5NNVSPRciUj
         JDc7IGTJH5ovFvCfGqfcL5km//pwnkysI332G7E+2ETu9LFyrH4/X31Cs6F2v1/P8p6l
         O/Hg==
X-Gm-Message-State: APjAAAUXHZpXL3s7e+azvIlmVUdMeUg3jRfldzmUkDqPz/Jb30DUTsWD
        SPWvGlS6wQQhB4epPhvVVgRPwkrs
X-Google-Smtp-Source: APXvYqzQki2Do+LimfG95UuAeEFtzpFWlZVN4/GwwE9XErPDZFtahI30tmHO71BzPRGMXH/B0HWTXA==
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr8674490pjh.61.1559826130087;
        Thu, 06 Jun 2019 06:02:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ds13sm1779702pjb.5.2019.06.06.06.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 06:02:08 -0700 (PDT)
Subject: Re: [PATCH] hwmon: nct7904: fix error check on register read
To:     Colin King <colin.king@canonical.com>,
        "amy . shih" <amy.shih@advantech.com.tw>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190606122707.16107-1-colin.king@canonical.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <52b996c1-a52e-8cd6-e570-53b873768bc4@roeck-us.net>
Date:   Thu, 6 Jun 2019 06:02:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606122707.16107-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On 6/6/19 5:27 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the return from the call to nct7904_read is being masked
> and so and negative error returns are being stripped off and the
> error check is always false.  Fix this by checking on err first and
> then masking the return value in ret.
> 
> Addresses-Coverity: ("Logically dead code")
> Fixes: af55ab0b0792 ("hwmon: (nct7904) Add extra sysfs support for fan, voltage and temperature.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks a lot for the patch. The offending patch had several additional
problems (shame on me for sloppy review), so I pulled it from the branch
and asked the author to fix all problems and resubmit.

Guenter

> ---
>   drivers/hwmon/nct7904.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index dd450dd29ac7..5fa69898674c 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -928,10 +928,10 @@ static int nct7904_probe(struct i2c_client *client,
>   
>   	/* Check DTS enable status */
>   	if (data->enable_dts) {
> -		ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG) & 0xF;
> +		ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG);
>   		if (ret < 0)
>   			return ret;
> -		data->has_dts = ret;
> +		data->has_dts = ret & 0xF;
>   		if (data->enable_dts & ENABLE_TSI) {
>   			ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG);
>   			if (ret < 0)
> 

