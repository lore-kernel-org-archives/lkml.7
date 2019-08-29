Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF8DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536E72053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvWh8aXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfH2I2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:28:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39999 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfH2I2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:28:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so2472640wrd.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EMCFDUI7F1iRPWNuyA0vZPwvE9bgb/HOPGdiTj2TTzo=;
        b=pvWh8aXLB52cE8NwojVfuKES2r964HyauHY3gdgiWRedNr/hiDr0sAyjEiuz882xBs
         mkghumAcr6Uy5i5ZLOXceaZTHTiZhI9HqW1TkGczjO0WA5j/dEtbE+/yyWitpCXI/8QE
         qwglN8igSgLbqOVkej/CiPaOgJBXGoDGa8RlBZc3ReWCNaz28sn371HStJpOnCecE9u6
         mFPd695iEd1ek0uGPbpFlkI7hOc2Nm5q8q/uNmBvgPxA7tbpCT+FMx6pdvGAPtX4XL0l
         6Tx/h6RZAyf3muqG66IRj3jC3dRm23RJ0bzrBSpH5ajx5LjnHcULb4gH/MZdxC1QiWrM
         /qwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMCFDUI7F1iRPWNuyA0vZPwvE9bgb/HOPGdiTj2TTzo=;
        b=PAzcI1xOi5iahrTjbycQSAuJ0J2FOsqh/FpzE01pldudUo1/SCQ6oO3iSb7MrxO6Zn
         ZeaLVVDs5vHh3xsN4yGVP8HxucvlYHepSFWsUdytKuZaF3VTjkiwOduWyre/L8owvxZM
         7oFtznNTTGPpWuN/tIwcEivLVaVxNL1J3KPen3BD8srCVMzsF95w8DdlPtgQyTCwWXck
         J8J9l3HDmucO2LA3OyXIq6coQmATbhd+HgWyi4Tzv7fasiQGnOGI9W3RvTM/8JT2HhfA
         MiwoAj8ebxc8XHiWuBxZON6YLcXOqudGDqKiFW/h3uPf0Yz6dwzG+qyBtC8qDDRTY8Zo
         9SIQ==
X-Gm-Message-State: APjAAAVx5QGNuUQZvhEbE1EuQaO6XM+KE2AsVEvq7qzK/+fU60lEoAVO
        Jc9AzirJCKb5nbqIiNTozGRCjtQlBCA=
X-Google-Smtp-Source: APXvYqxg9zgNT+p+MIYdHHYYmbI7yDoxMIjvHepDUL7WobZF0pWP6f/YCLjWZCpt3Ad1rhJ2vfaSqg==
X-Received: by 2002:adf:f90e:: with SMTP id b14mr9255809wrr.124.1567067302978;
        Thu, 29 Aug 2019 01:28:22 -0700 (PDT)
Received: from [192.168.1.6] (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id c62sm1085775wme.20.2019.08.29.01.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:28:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] mbox: qcom: add APCS child device for QCS404
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        jassisinghbrar@gmail.com
Cc:     niklas.cassel@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190826164625.6744-1-jorge.ramirez-ortiz@linaro.org>
 <5d6700b4.1c69fb81.24793.0bff@mx.google.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <818ffe57-0b1b-2b7c-c3f8-fe9845908abe@linaro.org>
Date:   Thu, 29 Aug 2019 10:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5d6700b4.1c69fb81.24793.0bff@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/19 00:31, Stephen Boyd wrote:
> Quoting Jorge Ramirez-Ortiz (2019-08-26 09:46:24)
>> There is clock controller functionality in the APCS hardware block of
>> qcs404 devices similar to msm8916.
>>
>> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> index 705e17a5479c..76e1ad433b3f 100644
>> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> @@ -89,7 +89,11 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>>                 return ret;
>>         }
>>  
>> -       if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global")) {
>> +       platform_set_drvdata(pdev, apcs);
> 
> Why did this move? It's required in the child driver or something now?
> Is it a Fixes sort of change?
> 
>> +
>> +       if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global") ||
>> +           of_device_is_compatible(np, "qcom,qcs404-apcs-apps-global")) {
> 
> Maybe this should be a compatible list instead of two calls to
> of_device_is_compatible().
> 
>> +
>>                 apcs->clk = platform_device_register_data(&pdev->dev,
>>                                                           "qcom-apcs-msm8916-clk",
>>                                                           -1, NULL, 0);
>> @@ -97,8 +101,6 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>>                         dev_err(&pdev->dev, "failed to register APCS clk\n");
>>         }
>>  
>> -       platform_set_drvdata(pdev, apcs);
>> -
>>         return 0;
>>  }
>>  
> 

thanks stephen. posted v2
