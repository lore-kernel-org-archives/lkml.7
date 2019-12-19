Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D950C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D37224650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhr1ZjMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLSK6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:58:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39019 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfLSK6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:58:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so5507375wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LOOsEyvuasBLr3yvzRlpYBFKNpQOIsg2Ax8aja0jnrY=;
        b=yhr1ZjMOsQqXqHsILFXcqatMCvF/ZDmFxSvKD1L8H+K8GLS+/5QDFqfRvsc2CXQFe7
         MN9rTxDI7kZaM92BKsGytik2Y7UK5f3AsWw8X/lT24REN4JmS9ZrVaTq6Sr7rRDyeQo9
         1gRCJr20NNQpcxkUYo+hTc7aaGMnuHswv93eeBwusOHhT8j9cLzegTFmaH9A1hLvflb/
         IWAn7+xHWcvTVZWIQJg8U44AEWRsEmMIAY5pjl5xmkA82sLgMqme0acOXG3PTELobbVv
         KHbO/IEHiTmABkV/YUpa22EsG2ta671r+1bkEMvRzXbwK7PoT+l/N/Bf76YOxeJiZyBT
         MQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LOOsEyvuasBLr3yvzRlpYBFKNpQOIsg2Ax8aja0jnrY=;
        b=YD/PimLCUTHWMdfxZWVwgzSPGlQKZj6AV+H6Wydk4H7wHwg5zvdGRsc6JJ/JOG6dvx
         Xc95GNXtedZc5kWZS1cCOTJIUdSqC863hY+yMKwGHhNiHooZyjLXjdudWfguMM/Iz3lv
         pCsEZKWxH6GT3IdKSMLth54o+u0hd9QnR7FcXQxJfN+vvC5ED/aoWy4XqorHCVCBKOMv
         zXqylsSkAaAyVTwjwWRdNhiRAvjy6PpdLk/5yvoo7zc5NcZOcT9R7I9onhB1wageS3LT
         zvyeZ2UDq+fND1pnjx7Fa7Rxchc31DfTPGJx2Xw08WWMPMMn1BydLgN4lPPCLtLy0VbB
         V1kA==
X-Gm-Message-State: APjAAAWhZTSPwDNWwCLdLUBpBAatyJ6Kw5K0nFniQQamTnAx3h9d0g8A
        9p+PszaTI1//QnXWW3mDVc0xjHfpAgM=
X-Google-Smtp-Source: APXvYqwUw4nBzvJG6W7Ot6OE7z+N85JhMh19YIzO5YKGLoeCcKnDhKV5FIeSRUYPB8ceaij4DGeyoQ==
X-Received: by 2002:adf:e683:: with SMTP id r3mr8690894wrm.38.1576753111420;
        Thu, 19 Dec 2019 02:58:31 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id v22sm5504084wml.11.2019.12.19.02.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 02:58:30 -0800 (PST)
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20191217104629.24590-1-peter.ujfalusi@ti.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2a2c444a-178b-b813-d329-49abbf099381@linaro.org>
Date:   Thu, 19 Dec 2019 10:58:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191217104629.24590-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/12/2019 10:46, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)


Applied thanks,
srini
