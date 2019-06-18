Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890D8C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4FE2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY/Id4HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfFRQ1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:27:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36559 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfFRQ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:27:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id q26so9799498lfc.3;
        Tue, 18 Jun 2019 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=REVlNnHgsxxtrnRVJcK1dH+P9nh4ar/FfEMg7w0Qpd0=;
        b=IY/Id4HO7ampe58gGhhmNuUi6Lb+7e1swZEK3Mjh55ZXpTAeppucaBOWtMDGv+6/if
         esex+rXKkSwK/ptGmnxnm4pnm90+lSVML7jZ9IqU/MT8SbbdN5EIduZ8exjcxijWVc6g
         rUX9dHQI2kDfNt571LNXW1Slt23WZxMXWuxmmpH9eh1BskCMMGx63sg7D1oagSEUdQQ0
         CLh4Gh+H7mBWVqx9y9Gs6uoXpOW4o1FdcAjWFU/XsMHq2XC8QQPZ2r8vTt8dAMKMpfb1
         QowO7JV2kCwnJhsvmIpGgRrLa9E90hD1QuoPx984H8S0dhrVRJJSddAH1UFOX1wj1VQC
         9/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=REVlNnHgsxxtrnRVJcK1dH+P9nh4ar/FfEMg7w0Qpd0=;
        b=saknnV2NWVhbxNu1oWDzHep3IkOfJWetKtL1ZR3AmGHX8XVlqaV6SfjpQf1IGswMyY
         +/gvCydLQ8N50d++Fm0340qQKO5nXSoSyj13uX6tWah6Zdcx14dJP3YLGRrhDOpJVrHQ
         FJ7ZAfq/GbYftPf3WDWVxBbiFmXnncNtGsQU6QUArttyhVfLPCboaBii/XKQ69Skoo0g
         uj2KLaItB8RQsed4v7ycqMQZ1XxGVMzLa1ZgYbbGFUD36dQzINlsD4S6vXZ1k6B33cgj
         6+Zep8Spo0n8NM/KtNr9n5686dFZMDDLc150KPxIuxAI8FQFlfdmwTgtag5LAOU1Skrp
         npDQ==
X-Gm-Message-State: APjAAAWVNv1DAgSuPIjmxpQqFTm4KP6Ydpl2JrcsRM/zqebjvmRfUQ4P
        uRX0BVVli4hCNla2qdD42lSfnJp1
X-Google-Smtp-Source: APXvYqyDGAL4Pm+/zw3qJcxh6hhA6+zLJOo5w840grHNTulAvDw9l1c/oqnWP4xzeHiAFIY7AhVdyQ==
X-Received: by 2002:ac2:46d5:: with SMTP id p21mr11745258lfo.133.1560875230790;
        Tue, 18 Jun 2019 09:27:10 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id z12sm2287618lfe.2.2019.06.18.09.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:27:10 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] regulator: core: Parse max-spread value per
 regulator couple
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190603235904.19097-1-digetx@gmail.com>
 <20190603235904.19097-3-digetx@gmail.com>
 <20190617152514.GY5316@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a3917cf4-6090-2c47-f8f6-c25db52662e0@gmail.com>
Date:   Tue, 18 Jun 2019 19:27:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617152514.GY5316@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2019 18:25, Mark Brown пишет:
> On Tue, Jun 04, 2019 at 02:58:58AM +0300, Dmitry Osipenko wrote:
> 
>> +#include <linux/regulator/driver.h>
>>  #include <linux/regulator/consumer.h>
>>  #include <linux/suspend.h>
>>  
>> @@ -156,7 +157,7 @@ struct regulation_constraints {
>>  	int system_load;
>>  
>>  	/* used for coupled regulators */
>> -	int max_spread;
>> +	int max_spread[MAX_COUPLED];
> 
> I'd rather move MAX_COUPLED into a separate header than include driver.h
> so we've got a bit more compile time sepration.
> 

I'll address this in the next revision.
