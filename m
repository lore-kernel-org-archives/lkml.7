Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4078AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BE8206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EojOhlSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404117AbfIEUuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:50:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38596 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404110AbfIEUuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:50:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id l11so4292107wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Avg8QM6aPfWwX5AoBSBFNIlTtI2x7nEGXCQk3lEb/fc=;
        b=EojOhlSjiJk8y6EJeNppFrahboogV9SnwNJf0VVPvj9yW7Vq17+tZV1p3tUjYh/zzn
         eQ9R5aIm8Pqf/LEcARwdoX6n0VD2ghT8SwLkb3axshTZ5X2u1d17r2IMg5ucPfiraQFj
         /I0RSEMx5k/paxbsKQ28uPeRkRjbW+5qDU+2IKnTr0NP71dqHorDFBF04ebs4ogFj5pR
         sa42t8sSaxPjB2pmqKJpUcm6gvM4EDtdwESfWjL/xPyr66Tff8rszZyTJ9R8ia9vWAcl
         9OnLStXajERrE2mIAJut0X5KTQK3F8fyYJP9E6YsREIMWXzF7CyrQtYmToM52YC08TFm
         HIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Avg8QM6aPfWwX5AoBSBFNIlTtI2x7nEGXCQk3lEb/fc=;
        b=LRufIfCZLCY2G7DihVzjiV/YXTy/4R+iHxQYYLD2i77a9FZvgY3oEd6rhqbBYDTaph
         aetftMlkb16GCpOpR5MST4o9Ir1TJl0JpeerRjbFL6Dm1IcMeD2bKZmQXK4nGogFlViZ
         aLOAXT6qFIWF5YIjKeEKlEPFKt9C8gZJkNP1XMXxupxBpHEqQ1C+K+G1cUtJEwXSJweR
         uiF4EeBFHm86WAh55uaEQqzxdVq63qYChR8SddJUdLexF+gOCNGydgHaiy7zTv5V/aiB
         UEuaegTQHNSeJWeexqmlH7+3xbklAQmxr0cCvSpoxjy/4poKlrkmNnsgNJFOAxqI5lAN
         qFBA==
X-Gm-Message-State: APjAAAUMHQp05XVBSWl0uBgcHcvmss9jX2dct6U6/Wvile53miWgbJxo
        lW7aenlfxjyPDFfy3EiK4qjx48qEsFc=
X-Google-Smtp-Source: APXvYqwi/+00SHE3kxRqKt+uOC1fnKiZKCYTRd+lO9y4jlGHsH2+knmmV2EW7SfCJPj5yMwzkXM97g==
X-Received: by 2002:adf:dc0f:: with SMTP id t15mr4596106wri.258.1567716620556;
        Thu, 05 Sep 2019 13:50:20 -0700 (PDT)
Received: from [192.168.1.6] (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id k6sm5932699wrg.0.2019.09.05.13.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 13:50:19 -0700 (PDT)
Subject: Re: [PATCH v3] watchdog: qcom: support pre-timeout when the bark irq
 is available
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        wim@linux-watchdog.org, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190905182419.26539-1-jorge.ramirez-ortiz@linaro.org>
 <20190905183456.GA29500@roeck-us.net>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <97c57a8a-545e-f5de-0756-e8ce054aa036@linaro.org>
Date:   Thu, 5 Sep 2019 22:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905183456.GA29500@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/19 20:34, Guenter Roeck wrote:
> On Thu, Sep 05, 2019 at 08:24:19PM +0200, Jorge Ramirez-Ortiz wrote:
>> Use the bark interrupt as the pre-timeout notifier whenever this
>> interrupt is available.
>>
>> By default, the pretimeout notification shall occur one second earlier
>> than the timeout.
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> 
> Can you please give people time to reply before flooding the mailing list
> with revisions ? This is getting annoying quite rapidly. I am going to
> reply to v2, as I had started on that already (and to the one without
> subject before).

yes, sorry about it. it is not frequent that someone gives a review so
quickly though so I thought I had time to sneak in some reworks - thanks
and apologies again.

I am about to send v4 addressing the issues you raised.

> 
> Guenter
> .
> 

