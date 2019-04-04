Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED311C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61DD206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmiz87Qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfDDG7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:59:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40924 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfDDG7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:59:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so1881428wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 23:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+3wjU3uvExA5IXPLoDVMM4+Gggu1C+1lNvJn8QURTIc=;
        b=xmiz87QuQy/lYC8qBIMH8ygVf+eHXqXWtRpZsNQbklUK6uaI9I1vgm3XOkx9jm1ATY
         1UtvUXgO0tjVxvqqgZEgsnkqaGPOjmR64PlDfylV3tl2gOKn56qsOfTttKVvrBPArtSI
         EQvMYe5YDPZoN0i5SeY0G5MQ247xiL+8TApugEMQNCUYgqFI4wahZa8t1rc7ivAxa2mm
         OkiSrkKpnNE9OFHYebcauXiCzmE+/eX5JuNsB3ojuV2ycgAOIu/8nEXStdcDYVGkU/tP
         L8zbhtajmGC57y6G5Aeg00BvUst9usz9C8MwSsq4E3big/i9cY03jXwieix059MPdsW7
         Z/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3wjU3uvExA5IXPLoDVMM4+Gggu1C+1lNvJn8QURTIc=;
        b=t39D9HdCbpiWP5NkrkGZwF+cfcj5ukNL5YkZkgJZ6/VatIr5q117zf0UI6ecs49YqE
         jKSVZJY3ncrO/8kjpc0dxo/QARH2g/9i71byv7hP0wc+pL6P7lJgtPexXiodvk472K1Q
         aH5WqBXwZXS4IRWr8haqzeTxCO3qTUN/tZoNUfdKSem8vJpaYNN1gtKyKc22mEtmQhta
         gVdVOQU5hG0zKnLZ88TZFH73z3eEHC+fHVGr9uCfMYmM9knzjLarzBo9FwYF5BUjsByL
         rY2qgQY+1to7lJnrO3iryQflNweTk+YcNCnvPRi7y+GXemrDu/wXIP2ttS5ZTw5jELEg
         TLPQ==
X-Gm-Message-State: APjAAAXfB2bn0VAsbfavPzPYa26Guxb3lhAl+SuVsJntwmfyc/le+sty
        9KC63mEKdY4qvTDXw7VdUbH329icbuTKkw==
X-Google-Smtp-Source: APXvYqxdduiV9X6ZMiGtXAA+SEAKNjGRZ7+j6G3AHh0iGqpZenZMhMXT0b96/DiFcsjpWeiWKBFcZA==
X-Received: by 2002:a1c:23cc:: with SMTP id j195mr2550887wmj.74.1554361152483;
        Wed, 03 Apr 2019 23:59:12 -0700 (PDT)
Received: from [192.168.1.2] (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id o4sm37768193wmo.20.2019.04.03.23.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 23:59:11 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] drivers: regulator: qcom_spmi: enable linear
 range info
To:     Mark Brown <broonie@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-2-niklas.cassel@linaro.org>
 <20190404055502.GA5683@sirena.org.uk>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <28e31d46-7df1-cb93-835a-f5eec603baec@linaro.org>
Date:   Thu, 4 Apr 2019 08:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190404055502.GA5683@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 07:55, Mark Brown wrote:
> On Thu, Apr 04, 2019 at 07:09:22AM +0200, Niklas Cassel wrote:
>> From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> ---
>>  drivers/regulator/qcom_spmi-regulator.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
> 
> This doesn't build:
> 
>   CC      drivers/regulator/qcom_spmi-regulator.o
> drivers/regulator/qcom_spmi-regulator.c: In function ‘qcom_spmi_regulator_probe’:
> drivers/regulator/qcom_spmi-regulator.c:1837:29: error: ‘SPMI_REGULATOR_LOGICAL_TYPE_HFS430’ undeclared (first use in this function); did you mean ‘SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS’?
>    if (vreg->logical_type == SPMI_REGULATOR_LOGICAL_TYPE_HFS430) {
>                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                              SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS
> drivers/regulator/qcom_spmi-regulator.c:1837:29: note: each undeclared identifier is reported only once for each function it appears in
> 

yeah, the SPMI regulator changes are still pending
