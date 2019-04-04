Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE37AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD27A20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/3IuQG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfDDG7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:59:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51334 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfDDG7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:59:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so1664201wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 23:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4OI2X7uNcXKI7Is6dOdjhTMwUYHuLvBfHv+jMTJYdkQ=;
        b=h/3IuQG4lGHS76otSwV/lkkio5En6Ji+z/rXcoXCpStNWRtUSW8yU7Bsd7dARWKtvD
         NO5oGeE/BoFtlroCJto2bxVOSex6A66cBaRRY+VPQp2PB2JCdW2Gl1sCQLnGhI9AWw3C
         voNaS/o7UC0qCgvVCDOBbxb9bXm9PS/mZyAF40bEAadJZWvBHeIlcooD+0RWSfNFR3mz
         ONF25cMtwPzWlltjG33pcDUNMGJcHtJNcPgze8QOO4g2q8uI5qAJH432lXhlt+beB34h
         DoKQfdW7M7IEwTzZJX8KrYFRQ+q3yH0E6iGssj2gjuRHRRmdJFzZ3TnHWjiejBhCRJug
         2r0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4OI2X7uNcXKI7Is6dOdjhTMwUYHuLvBfHv+jMTJYdkQ=;
        b=Pza3xzoVACq3Ji+wDF48eJYLvLv33OhRuk+jXGVJodO4vWb4wN2gvOsQbD5Lew14SF
         zbPT4YuGsA1BIcbeViPMu4DzxXn06AL3o/Q/f1wyHzjlMp8mRJGS83HX1EtWvgnrES66
         bQwm6On2ZNIVm2dooLZkrABHuyDFEmxMoX9Ln3WSBaIcQrRCXMOwob9dhlHytZVkUA3k
         aSjnh2wX9PBS2vSk9upNOIHeJ+Wvo1KEjGcnsXIhcWU3a4AKcyfaYNpaRBW01MSexX2x
         //oGyUAcaKBkOCKmzc/tAlriGDht+6td/XAd4snhf0QrTyWu3KjGxyrbW7t3pYucSjo/
         mtzg==
X-Gm-Message-State: APjAAAUFB+Bl7ynR2U/zlggnjaoWRh8a8qYVU8ma/N6zt0tADPhbGrTO
        5Q8z9sKOqKI040s0jpiPYI8VHnkQFhCN9w==
X-Google-Smtp-Source: APXvYqynUaG6lGjPSQq1d2N+qn+QmofNG5Dxb6XzrSqeGRskCHncU0KCdEkti1BI1N3T4RqV5axAsQ==
X-Received: by 2002:a1c:cf83:: with SMTP id f125mr2727292wmg.96.1554361174680;
        Wed, 03 Apr 2019 23:59:34 -0700 (PDT)
Received: from [192.168.1.2] (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id a11sm19336099wrx.5.2019.04.03.23.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 23:59:34 -0700 (PDT)
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
Message-ID: <184d1953-533d-2484-3e01-380ae871c4ce@linaro.org>
Date:   Thu, 4 Apr 2019 08:59:33 +0200
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

yeah, the SPMI regulator changes are still pending [1]

[1] https://lore.kernel.org/patchwork/patch/1036105/
