Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890B7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BA620868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1SDSdgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfDPPoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:44:23 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33518 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPPoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:44:21 -0400
Received: by mail-lf1-f45.google.com with SMTP id j11so16419038lfm.0;
        Tue, 16 Apr 2019 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WfHo21DF+jn0okKDJZD1fn8wNZCD/IRppI1k6ApPUDc=;
        b=k1SDSdgH6zAEa5jw7ZkaybxBiuXonWhN1Sh1RwNhTkg7VvmCeZ6q3a/KEkL2eUMscU
         wPAycmr2bUeKZTgWR2A0ohsYwFB0pzdhXYlRfGJF3v9JqU17Ch0x8EY2zaIcMvf0QEyr
         wouQVmJWzOpc/Dk+diACn35ADzB15IqrFVgI+LKMq1B8tGID2YByKg4MwVc2tI+ZF76y
         3iSwLUp9EGHoy76hZ7/ax/1NKUbOa/Kg5YmpZ5hIeawHdhfSTN9UfxBLhIE+UyqyxHGv
         caloATz94A8tLSm2J/fD7teBV8/cCug9PAWo72Rwom07jFLhwlYXvDvR3leWZskfqLJd
         eYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WfHo21DF+jn0okKDJZD1fn8wNZCD/IRppI1k6ApPUDc=;
        b=swF8Ns1FhKnoW4PP11vTR70/rqHhYmolHaiEA7soYDncdwgxJyiOhCF7SS+FJAx2gO
         e/6rBeiopOQw5Vmt5ne3df6U+4NSKzbATx+iUBD8+QCZGuC6aVZJkiUOdt9cbu0Tdz+F
         uLRcw+C8lyvplABNEY5HHZIL3yvmcAL0I0fScmxYdUOU3HO+kdo+pI4fKI9VoZCgT1ki
         psvip3Ae5PJLa94aD/b1+BN4EVHXfcjqVSRbjENcUja1nsqda4cSF//l+DDN1iZeJhw8
         aFYQnqRnFfrK0xQaExV/PV8LFD6OiRm3wNXSZ57LPOM6B0GSu3TwJTj5mEyDHAQhSiPJ
         Rz4g==
X-Gm-Message-State: APjAAAWyx3RAJ7lfTIqV05U2hzp4kbbY8YiVlTG5Y+FpwmnAWWTo3mdE
        kP546ApnAiNnpVSQLt2IOsACAE50
X-Google-Smtp-Source: APXvYqwMl8KC6q1Z8Nvs1gkRv9954wWaSmHhU+wrYFXsSVTfcTU8mjRmoI6YD/CN7oT+Q1LFqpe2HA==
X-Received: by 2002:ac2:43a9:: with SMTP id t9mr22157001lfl.6.1555429459817;
        Tue, 16 Apr 2019 08:44:19 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id v141sm3099025lfa.52.2019.04.16.08.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:44:18 -0700 (PDT)
Subject: Re: [PATCH v2 15/19] PM / devfreq: tegra: Synchronize IRQ after
 masking it in hardware
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145717epcas4p1647551d3a4c7bb2a0d9698707fa03f43@epcas4p1.samsung.com>
 <20190415145505.18397-16-digetx@gmail.com>
 <81db3a75-2d17-5268-fea5-8b6ed650056f@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a9e02e2e-ec93-53fd-5b50-b8566b7d3abb@gmail.com>
Date:   Tue, 16 Apr 2019 18:42:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <81db3a75-2d17-5268-fea5-8b6ed650056f@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.04.2019 10:41, Chanwoo Choi пишет:
> Hi,
> 
> In this patchset,
> the patch11 adds new 'disable_interrupt' goto statement
> and then patch15 removes 'disable_interrupt' goto statement again.
> Actually, it is inefficient.
> 
> If you change the order of patches,
> you could remove this stuff.

Okay, I'll change that in v3. Thanks.
