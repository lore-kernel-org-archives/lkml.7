Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F41DC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBED206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyFmw5X2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfJHSAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:00:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36474 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfJHSAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:00:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so18564846ljj.3;
        Tue, 08 Oct 2019 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4zg1hW8IZ+jl95tWhiTQcQxYxGKBPk85Lp740u8bUZw=;
        b=DyFmw5X28smxQXkuguo4LS3CkLGVQWL1OUeXIiGclJu3huA4X9PoAEiRdUsZq2WMLH
         DeHeKygplHiomAUceqa6ZQ4RNrsYCtYK6EQncn5eCxGO3pXnT6w5C44FMkK2jjQzCbRD
         rYWp7niwA9SkBacKRkNz3RztHAhXNfJMwEi9S/STeBfRqetxGPy9vRGywPckUddWN9QD
         mJMQmlZdEQtywwdqTLNVdkTeJ8bMuV3/ag08mYQo0dOcZT5ah3f7egVGgHI7ERfPRPgT
         u43U/7QHDD6VTiImimqa+yiL/FvcZbSE/QaG2VOkOPKQr5LGd8QFBkcxFMv2Yk7UAP/9
         vesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4zg1hW8IZ+jl95tWhiTQcQxYxGKBPk85Lp740u8bUZw=;
        b=hiSXi4BUpoMiIfuc34RhCvqv5tcdsAnXexEhmTk08N278ckKG2eO+u8v1eQZHI5p70
         PnZvEWLV/TWHm06RHHXIdJJGyz0oy3FDkPHPCnkX9U1cPJhWtT/7LmKoGr1JMVKfFCgc
         F5nMUkvPQKVSDnm9C0KxwVpid9Sxd2dCbrZm+eWdsxxeHqNxPwWQCeeLN/kG6Q5taf8Z
         91zUKMcz1q8EeeiG05OH6z5USFkRUUKhZzpUNhIhvrqE07/PLi5tP5RV6oJPUrwoLuR+
         uoX5g6+Wk0bA4YV1SsAyM/y6kPzvFp2+j0jpP6RFjrCzRbDn/x2jMikFF+TkBXINTNET
         31xg==
X-Gm-Message-State: APjAAAX6mDlXJkrYN7ex6fDjnX2fQELAu84lZ4YdSA2yvOe7h/sKPvTq
        1UaBT8mU4RX21DX6or6IvZY=
X-Google-Smtp-Source: APXvYqw1+8sx4LFfwYdNCxtV7NMZP5/pufaOu2SM5iNgffsxVFalqiN0Ey3o0f319Rmmo6/v8D70UA==
X-Received: by 2002:a2e:9702:: with SMTP id r2mr23355999lji.190.1570557630958;
        Tue, 08 Oct 2019 11:00:30 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.231])
        by smtp.googlemail.com with ESMTPSA id g5sm4203288ljk.22.2019.10.08.11.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 11:00:30 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled regulators
 in regulator_enable()
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
References: <20191008101709.13827-1-m.szyprowski@samsung.com>
 <20191008115025.GF4382@sirena.co.uk>
 <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
 <20191008120611.GG4382@sirena.co.uk>
 <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
 <20191008124736.GJ4382@sirena.co.uk>
 <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
 <be8d3280-9855-ed18-b2ab-d7fb28d80b82@gmail.com>
 <20191008161535.GN4382@sirena.co.uk>
 <4ad890b7-705e-94f9-2e61-1f3a60984c91@gmail.com>
 <20191008171747.GS4382@sirena.co.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <439154a4-1502-40af-7086-d4e3eb24025f@gmail.com>
Date:   Tue, 8 Oct 2019 21:00:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191008171747.GS4382@sirena.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.10.2019 20:17, Mark Brown пишет:
> On Tue, Oct 08, 2019 at 08:05:03PM +0300, Dmitry Osipenko wrote:
>> 08.10.2019 19:15, Mark Brown пишет:
> 
>>> That sounds like it might just postpone the inevitable - if you set the
>>> wrong voltage first it might decide to drop down some voltage that
>>> wasn't expected.  There's a bit of a bootstrapping issue.  I think it
>>> would be safer to just say that anything that is within spec won't get
>>> changed any time we balance, we'd only change things if needed to bring
>>> them back into spec.
> 
>> Yes, the case of changing voltage before regulator is enabled seems
>> won't work as expected.
> 
>> Maybe it won't hurt to disallow a non always-on regulators to be coupled
>> until there will be a real user for that case.
> 
> I thought that coupling with the CPU core and main SoC power regulators
> was one of the main use cases for this feature?
> 

In a case of NVIDIA Tegra SoCs, it's coupling of CPU core *and* SoC core
regulators. I see that Exynos also couples the always-on regulators.

Properly handling case of a disabled coupled regulator certainly will be
useful, but looks like there are no real users for that feature right
now and thus no real testing is done.

Keeping coupled regulators in s valid voltage range is the today's main
feature.
