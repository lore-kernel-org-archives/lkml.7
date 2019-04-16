Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920E9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EA7205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWLgkqHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfDPObC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:31:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35683 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDPObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:31:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id t4so10806962ljc.2;
        Tue, 16 Apr 2019 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bel8cDlRinkQEO4hIw3rS4EYpXIO7LaPV+lIxly/3KM=;
        b=pWLgkqHf4TpcGHIkd9RWrJ6Srkxcx453DIyI2IH4+t7jEWaOCJO95CGtK/FfJ6UkgA
         EuHASh4MJ0JwS6RJeN496vfws9v1jjzRDFpoUUaVzegPpf71nm/ruChKw2AoGx62T+LT
         Bz+6kbht1XKwyj/oHXBz0+fADSIDImb/2TthEWuPX5LDD4v1snA1RuBUUaZYP1Y8umJi
         jUIOI9yuhzRJOMdu24qFfrGXOjp7NGfRqGJJ5kd2O6zeG+hlU6kjhx3QYbnwyUipRy+R
         aSXKpjwRVld/KeNVv2xr6QcOz3Apl3C1vA0sAW2WFgqrnfIre2Rp3k2/d0EmDYolQyMo
         RFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bel8cDlRinkQEO4hIw3rS4EYpXIO7LaPV+lIxly/3KM=;
        b=AdCpMQuWzh+rzDj3F+pRDsw9Kyuf/WQCAnfQgWBTwx+Pms3yu0jpyr2bOOwQtUdcTs
         xh0+LwNq79CBgSuTjBLmuNPDuzTvCcykuiECun+xrJVHP62ySAQx5Wu9nsIL2CazJ5Sb
         vVz5w/I5ke0KV53/YyRkp6DiEu5NHA/oxTi385n7+3MXw8XYZ1A8v7fvqPdVROg7spXX
         gGJQLWtZCJK19uAeYkVPoB1qS2woshOoEwlN9Gh9ESyV440C9bNMjo9OX93uY5HWHWID
         0sg8YlDpf3KkNtQcrtF44LQoBnRwYumHmvOlNYIeYdW2yhrqbLtvuNAhjJW/XIo6JM3Q
         LXkw==
X-Gm-Message-State: APjAAAUlBwJRZoK9vEVTtTPWI7iMswoUtDOhiAHrurEN6dRuEAg3DOf+
        uq+KZW2u6iYV1MgZWyLbTZ8TqT/g
X-Google-Smtp-Source: APXvYqw1AjaZVuIjwDAG3K2/WXmcsoW1frcKzHcwyfoI3D7COne7jb43Dot+qdZ2CEDyv65PG0MXVA==
X-Received: by 2002:a2e:3c0a:: with SMTP id j10mr43104138lja.164.1555425059422;
        Tue, 16 Apr 2019 07:30:59 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id 30sm10326472ljv.79.2019.04.16.07.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 07:30:58 -0700 (PDT)
Subject: Re: [PATCH v2 06/19] PM / devfreq: tegra: Fix missed error checking
 on devfreq initialization failure
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145756epcas3p36a0597ca84dfbe079f9a453d8b28fea0@epcas3p3.samsung.com>
 <20190415145505.18397-7-digetx@gmail.com>
 <b610cdf7-5ca7-0f29-f74d-fb7892796577@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7f187635-a42e-02cf-899f-996702602785@gmail.com>
Date:   Tue, 16 Apr 2019 17:29:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b610cdf7-5ca7-0f29-f74d-fb7892796577@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.04.2019 5:32, Chanwoo Choi пишет:
> Hi,
> 
> patch6/7/8/9 are for handling of exception handling in probe() function.
> Actually, I'm not sure that there are special reason to split out
> the patches. I think that you can squash patch6/7/8/9 to only one patch.

Indeed, I was rebasing and reordering patches multiple times and looks like there is no reason not to squash these patches now.

> Also, even if patch6/7/8/9 handle the exception handling in probe(),
> the tegra_devfreq_probe() doesn't support the restoring sequence
> when fail happen. I think that if you want to fix the fail case of probe(),
> please add the restoring sequence about following function.
> - clk_disable_unprepare()
> - clk_notifier_unregister()
> - dev_pm_opp_remove()

When all of 6/7/8/9 patches are applied, the clk_notifier_register() becomes the last invocation of the probe function and clk_enable() is kept at the first place of the probe order. Hence the sequence you're suggesting is already incorrect because error-unwinding order usually should be opposite to the probe order. It looks to me that the current final result of these patches is already correct.
