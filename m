Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE49C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F4321655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aI8x9BVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfEHLoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:44:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41838 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfEHLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:44:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so14285910lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MVZ8E32dM3IQUQ/4sulzcLWknTbAvmYBrKs0Eer6wKA=;
        b=aI8x9BVUyV0k/e6hHqtFg2VSGsAE8uqW1Ykt9Vt9Gnl3ZLDZJI+xVptz8VOJ0U+Epz
         reiiUaD5e1XXfszgv5IduYrWVDkVT6at8d1kvFGnbetBJijOdC2vEyTzs6U8wT/ezspt
         UDpUgm9iX0D8ixIaEDy8M7y97kMeSpbRcqY62ZwLgI5YxdPUFncrYswcdj413zXXnI3M
         w5BWe7ZbgDWv1fxphhnrqylrPaM8Pmcp2FX1LLC6KO4RAxI3RNF2dbvBxQNwfeU+zeD+
         wvYHu1h+x7sU+hANV+44uVwwK7mt5GGgjdxekZ85f5vFD4W1SBzSOMOSOhoEwgu/BEdV
         D9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MVZ8E32dM3IQUQ/4sulzcLWknTbAvmYBrKs0Eer6wKA=;
        b=Qf3NDefmcfdDwq+SZWjqRPZ8O/8Mn1GwqbfYGBLKDNS+ZqGdVqRIpPa+T30U7WuP3w
         qXzFzCFjHmczU9FICWTmLTnzoOkz1/PXL/ahh3g4YW/HUKRY0qeHRfbpvswbIWllq4kp
         n/WMEKqrTspYl3h2qBiJg5eFbFV930NVdNK7QqCzI7tmvX+wSrjEPPfkFRDjmOKq8ceY
         uifbprqyHuZsYkkPdJz50t1Wc15HoTWymmEf134VaQz1pwpyvZhUORvjWfpX6BRNsU6u
         ckIPUnB8tZAt33QaiYTFbucwIwWefH12jp5Jdg1xM5Og12m8hG4Pwy7sS7v0vK8d9wA7
         NvDA==
X-Gm-Message-State: APjAAAULTwV+dHE+cqvn06/qQL35+5kLofxDwaUVDWk5lT9isWZDB7Vf
        B4SsofjOdr2AjfyHUNZ5m5+mzw==
X-Google-Smtp-Source: APXvYqxjMqVzBoEBMCg0Uqzhpta0oQMJtUFzmS+zyTM2gjOR58JZ7m+Sy9bAf2amhL1sDOv0Q+Dvrw==
X-Received: by 2002:ac2:5222:: with SMTP id i2mr19153297lfl.68.1557315891721;
        Wed, 08 May 2019 04:44:51 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id t20sm4067648lfb.27.2019.05.08.04.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:44:50 -0700 (PDT)
Subject: Re: [PATCH 1/4] media: venus: firmware: fix leaked of_node references
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1557126318-21487-1-git-send-email-wen.yang99@zte.com.cn>
 <1557126318-21487-2-git-send-email-wen.yang99@zte.com.cn>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <3f57c73e-3059-df43-8bc4-6ed8ca906d32@linaro.org>
Date:   Wed, 8 May 2019 14:44:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557126318-21487-2-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

Thanks for the patch!

On 5/6/19 10:05 AM, Wen Yang wrote:
> The call to of_parse_phandle returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> drivers/media/platform/qcom/venus/firmware.c:90:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 82, but without a corresponding object release within this function.
> drivers/media/platform/qcom/venus/firmware.c:94:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 82, but without a corresponding object release within this function.
> drivers/media/platform/qcom/venus/firmware.c:128:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 82, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/media/platform/qcom/venus/firmware.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 6cfa802..f81449b 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -87,11 +87,11 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  
>  	ret = of_address_to_resource(node, 0, &r);
>  	if (ret)
> -		return ret;
> +		goto err_put_node;
>  
>  	ret = request_firmware(&mdt, fwname, dev);
>  	if (ret < 0)
> -		return ret;
> +		goto err_put_node;
>  
>  	fw_size = qcom_mdt_get_size(mdt);
>  	if (fw_size < 0) {
> @@ -125,6 +125,8 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  	memunmap(mem_va);
>  err_release_fw:
>  	release_firmware(mdt);
> +err_put_node:
> +	of_node_put(node);
>  	return ret;
>  }
>  
> 

-- 
regards,
Stan
