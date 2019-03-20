Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E5AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1523E2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTllkblO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfCTOrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:47:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52989 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfCTOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:47:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so6923653wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v4IJn+ycTbVwI6/E9/+wYvHk9WE3u6WFB2zavRkC3uU=;
        b=qTllkblOq3u1hfAOuPWqWSIAnVW+m9fgEYyCS12x3BLIWcbrVh0yzQhwpMHH3tMB/2
         9+luiKBcNNcfXDvsG7UBfGSL+ZdTpG2rBOy69MSGgSZ8F88W5srD0/q/kwpuz8n++d8o
         rtWd49RWfE8qOkkaoC5VwIA1JgjbEVWYrf/6Yb8wt9fnYO2VG9No6PhIW/ITbS5YKMv/
         /gGgPznMCLt7cRhAzZsx5LIa4QxoBBgCK6Z7XdSt7pvb9aGxPIzB5PXRDulybvUMa1zw
         3zYkrQZMbYptmCJ9aqoJKQWx+SRNwzvtMb3MzmVVo9SpRxRJMzSKgFQ08K7od1rHmPAB
         TO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v4IJn+ycTbVwI6/E9/+wYvHk9WE3u6WFB2zavRkC3uU=;
        b=kV+4i6e9h39tsC3dw1IVJB6pynVybMXy0S92pDh71ef6rajBx2/pQYHb4VfZTjHJyA
         Hj4dgqcALE57YBEtnSB3GHq1qnbj+mv4oAkuDxBR4LU4UbSw1+M1AHrjmnJQ4d46CrIe
         S/6RpsQuBr8q8JpKhv+jjM9pi2+SDEsyymKcUzbhIepnXwWpCpZNoEP5nPX+Wrfo17VM
         wo0xx4uNT3DQXtAqab8r1GI96nvxibf5807tjiHz7dtW9HR/SAaBk9BALzFKCh3Yoa5w
         ATQ/lZtco07YRhGBVH+vThJvd3x81py/Dp6rqN7hMuvYRosMVmhmPSe+uLYRWMYEdIUK
         zR/A==
X-Gm-Message-State: APjAAAXUlY0fRiv/p1ROGgeTvsbmLZNnI5IROLbxamlmR3lgT6wiflHV
        YswdH3AXmxfxCf+3kjDhXOyGvmuY/XA=
X-Google-Smtp-Source: APXvYqwYnH1OKOQBPICgVJn3QmfaXYwfzJkOMY4KMdINMm2jtcl42FsEDin+J/5tMbGksmMH+UoQBA==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr9130682wmc.30.1553093235715;
        Wed, 20 Mar 2019 07:47:15 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q17sm1986848wrx.38.2019.03.20.07.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 07:47:14 -0700 (PDT)
Subject: Re: [PATCH] slimbus: ngd: Fix to avoid potential NULL pointer
 dereference
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190319012523.14644-1-pakki001@umn.edu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9508fd1e-7083-4bb7-eaa4-6986ef097d0d@linaro.org>
Date:   Wed, 20 Mar 2019 14:47:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319012523.14644-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/03/2019 01:25, Aditya Pakki wrote:
> In of_qcom_slim_ngd_register, of_match_node may fail and return a NULL
> pointer. This patch avoids such a scenario leading to NULL pointer
> dereference.
> 
> Fixes: 458a445deb9c ("slimbus: ngd: Fix build error on x86")
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 71f094c9ec68..9cc7256028c9 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1332,6 +1332,8 @@ static int of_qcom_slim_ngd_register(struct device *parent,
>   	u32 id;
>   
>   	match = of_match_node(qcom_slim_ngd_dt_match, parent->of_node);
> +	if (!match)
> +		return -ENXIO;

We would not even enter this path without matching compatible, so I 
think a check here is not really necessary.

thanks,
srini
