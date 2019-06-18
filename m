Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDF2C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F5820B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzC4HxOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfFRRTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:19:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37015 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFRRTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:19:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id d11so9911106lfb.4;
        Tue, 18 Jun 2019 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FtHDj9Tfcen/+u/bZK7GRRsh71fKJ+0OXIcYDtNSl6s=;
        b=gzC4HxOLPhizo5fmOnj3WKbpXxtLUwhx0SLOGzL3XIfIc+Cu0JzMbgpJMAdbbZ7uXP
         beZl2uyuctH6nvT+fRMHx1CxTEmISEyCIxpoKAzvK4iUIXDOlGNTwBVbycdXWFicy1eq
         739hygZNBTEJIg7XMn+yDmnNlnqfWX4cxyA7jz0autdYa/kh50ow2KggJqSqVPUCcFA0
         NpM6702A9WqVJfCsl72iu0VtnB3zWyp32t4R4I4NgAtfe93oMpNVD/JwrQRe+6cIazx/
         Mc0fuTZvwiVL5ynmn1X8CX03Z28wxkVuXpRldpQF+IIE8KtB9nxJyce4B9mLLGT3IBtO
         RP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FtHDj9Tfcen/+u/bZK7GRRsh71fKJ+0OXIcYDtNSl6s=;
        b=PhMBHALYzHGTFRUcVuQMtwoV0HmjFugXN2TAhgG4VvTSEIZSlD8eTaSHCcSZ3PVi7h
         nPyawsukcVKfYPA7YauX7cv1PbcRA4m7gYDVvLuISvH/AWgu1Eo+uFhs3eTYybLM8mea
         tNxFSh2YEmGxADGJNgx+sC8PBHoOvyCQpuH7LQsn9YVTzgnrTB1zJMzkBUfzKxk436m5
         /k9L1m5RHounv+wLwJ3V8KYZccrqx3e3AKaOuOGdJ+9t8KIS8epKfKLxaVKCXRPBAZ8B
         CrD4ZNeCpSLBYhU5t/9aWaG1s/AktaJBEBLxYTwdZZ2Xc3INRFCfG/5asUd5Xb+GTn3U
         Ay1Q==
X-Gm-Message-State: APjAAAX1WZffdjr1c0pyivMnvlFwgnOtL6Kqtc7nAwJy17pn1gTabEqc
        aSgCjnGZbu/xUVckoWJ/eqtdzj8x
X-Google-Smtp-Source: APXvYqwBvTr5CNyY7fy4r40iUI1XUZv1qTlgGyNEdwQU4eqRPLmyGGPIAKeOFd1PtHBbKFmCo35zew==
X-Received: by 2002:ac2:5212:: with SMTP id a18mr52325935lfl.50.1560878346452;
        Tue, 18 Jun 2019 10:19:06 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id e12sm2274715lfb.66.2019.06.18.10.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 10:19:05 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] soc/tegra: regulators: Add regulators coupler for
 Tegra20
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190603235904.19097-1-digetx@gmail.com>
 <20190603235904.19097-8-digetx@gmail.com>
 <20190617154632.GB5316@sirena.org.uk>
 <2308e5da-a8fd-a0e6-f98c-0931a30baf14@gmail.com>
 <20190618171453.GO5316@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bb84db4c-4d11-3199-ce96-3cd7c70ba911@gmail.com>
Date:   Tue, 18 Jun 2019 20:19:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618171453.GO5316@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.06.2019 20:14, Mark Brown пишет:
> On Tue, Jun 18, 2019 at 07:52:06PM +0300, Dmitry Osipenko wrote:
>> 17.06.2019 18:46, Mark Brown пишет:
> 
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Voltage regulators coupling resolver for NVIDIA Tegra20
>>>> + *
>>>> + * Copyright (C) 2019 GRATE-DRIVER project
> 
>>> Please make the entire comment a C++ one so things look more
>>> intentional.
> 
>> This is actually a correct SPDX comment style for the source files, accordingly to
>> checkpatch. While the C++ style should be used for header files only. I'm not
>> following the SPDX effort much, don't know from where these SPDX-style rules are
>> coming from.
> 
> The SPDX bit is fine, what I'm saying is make the rest of the comment
> also be a C++ comment.
> 

Ah, I just realized that the "// " is the C++ comment style and not C. I can turn it
all into the C++, no problems.
