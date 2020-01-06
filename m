Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A15BC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CEB2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXwsf8wO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAFMfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 07:35:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35951 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:35:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so49438858wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 04:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=etHpp/b+tlLKLxjZ6TvTwVRA6Mmf6McMbwfMAQQfH4k=;
        b=BXwsf8wOueR/7Su482SHlTV1NZOq9Sek0uktcbPx49LyYUqGYpdX1/KKBGw4c1qhOP
         3VeMM6AJ295vWqtr1HogZQL2jggx/d7H9l8aTCGvsp8NO5J/KlVynSX7f+KmAcTjEnh8
         ATDQnjZWp2xFqMUBCl1ZbIAeKap/QiobXrF3B+Jx8fgjg3Ccw9Nk+1ra6iBGNbeVGKy9
         lZv4pqSa3IJOh3G++W23H4qvyeQL0ZJ8py2UFrWPHHrCllgLTkG8lcC95LD71Nh52b0A
         1rQsgNiCVL5VdStupvzTG9JiWOnObcDVFW1sWWWdg6TjTs1dk4Gfpmxp4UqCABomegcq
         i83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=etHpp/b+tlLKLxjZ6TvTwVRA6Mmf6McMbwfMAQQfH4k=;
        b=VqUBHuNcWRuIRJluNSoZxk3rb7cfSgDPRr6WdvYyGa4/FV/AJ18pQuE9jHKeaH59O1
         hawfC5vfbdMhS5FSCT0m2GAFB7N/sd9ZM8q1OrPkNYCazenX6ShfG/h2fwypruZE9lpR
         4jX8EP0/RPF693M4Kv3s1h6Q0mkxB2L2vnaV0x1+xm/2U9nHxQCjVYoGDU0l2YLj0fU7
         AX1UHou3f2jf0EnJUC5RHpAs+HmmpUcUeZ3zO85ChZ2dn3nJwYFaI4wiir9lfuocXb+T
         xxaKiDAT3TDbTeojZcTyJeO3rnc8QLcemNQzc/6HaE47LnRK06t4VAB1ERIG/rN4loI5
         UtnQ==
X-Gm-Message-State: APjAAAWdZtGMP5essZFY1qLv5dO4z1IItFMmXQShp0G8Qr+iHbobFPOv
        iMzymWENtSO21E3wYoi972xCYkKQsj0=
X-Google-Smtp-Source: APXvYqy3oBNdsjFPXDVHPqhQuVUEc+K3UjrdOr8x429sFlMq1oz4I+8J9YqRlNLlkhJ3y728gc9Z5Q==
X-Received: by 2002:a5d:4045:: with SMTP id w5mr96791354wrp.59.1578314118603;
        Mon, 06 Jan 2020 04:35:18 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id w22sm21853573wmk.34.2020.01.06.04.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 04:35:17 -0800 (PST)
Subject: Re: [PATCH] nvmem: core: Fix a potential use after free
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org
References: <1577438434-9945-1-git-send-email-vulab@iscas.ac.cn>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a5734013-f80b-772a-7fed-b548ff98ec4b@linaro.org>
Date:   Mon, 6 Jan 2020 12:35:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1577438434-9945-1-git-send-email-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the patch.

On 27/12/2019 09:20, Xu Wang wrote:
> Free the nvmem structure only after we are done using it.
> This patch just moves the put_device() down a bit to avoid the
> use after free.

Could you explain the issue bit more here on what exactly could go wrong 
with the exiting order?
may be the stack trace of the use-after-free case? Or steps to reproduce 
the issue?

nvmem device is protected with kref.

--srini

> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>   drivers/nvmem/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 9f1ee9c..7051d34 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -535,8 +535,8 @@ static struct nvmem_device *__nvmem_device_get(void *data,
>   
>   static void __nvmem_device_put(struct nvmem_device *nvmem)
>   {
> -	put_device(&nvmem->dev);
>   	module_put(nvmem->owner);
> +	put_device(&nvmem->dev);
>   	kref_put(&nvmem->refcnt, nvmem_device_release);
>   }
>   
> 
