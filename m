Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1137AC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4069206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc7mnHZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfFRQwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:52:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38156 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRQwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:52:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so262257ljg.5;
        Tue, 18 Jun 2019 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VvN1RT3YhX4S+tnrDjMeGdATUPZBLzNsT+mQoBS4VYY=;
        b=Kc7mnHZhazC3sk4n4dEK0MJ0sv/29yhN+D7V1aEfzU1F5pSCjcZvTYTWeBTQ9CYsIQ
         PX8RQ+S5gzKEkJ8iHvaexahErw6m5uJ5V4bI+CMCEJs9pTZKsdv2E8CHETAXacQ015fs
         SRp/wc99ikA4F7x8/h9Byl0jO4h1DDn2R5z7XQjltCRo2hbf2dpdKa+9+yDsUCyLtM92
         wtTcV5juvgxsUZKkdh2iTv+TNolvzr6bMF8fsLxXAgxG4F4GKQjMmeBUKY/wYw8DS69G
         eDZBGFg5Rk/b7w/5QDlyfT8XqHfF3ezG91dnS0FekaJvEEsS983YxTVmYPQVwELIrSuj
         LStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VvN1RT3YhX4S+tnrDjMeGdATUPZBLzNsT+mQoBS4VYY=;
        b=i8wFaYwulUCu4LCpRiwXJ+CTb0rglmrZ00Z/jRgEGTwMYFTZzITWZ8ZrH3sH0CToqc
         8q1ECIFwY2ZDEZiKXFElkEiITJNyKhYYuANQWB0JL9ytS2EVSe4aiGG1DiB+ELD0Qg4n
         BDteSP7CgDJPIsPjT2NRBwazDt5V3NqjMdK7poR4SdeHifMsahjX6FPRdz4pzTHRO6vx
         QNIkMT1ZKu63MsWO1pjiCTDybVhvAXHdAzmOeCdIS/G0xwZS+V5wpteiMTMS3pqzJvRG
         nFO4oWq7i6tNEGnXyV34xHlBpCjDHkdx0bhNRC4aRC3/r8JKPlhLo8mHMIPGbs3DbV63
         Fexg==
X-Gm-Message-State: APjAAAWz3c7qbZBGlqZ6d5KDiJbP9Osn/SNIKlH8QSC9SQsf3exS9X5f
        XFhiFWzhzVInH7jcIuN4fzHpvhQ0
X-Google-Smtp-Source: APXvYqxg1b68+3gAdXjI3NkWYRnheR71IOaw8M9NZgr7fdYNWI4NqgJ32iCuL4B4jWwrkj6vHUmrRg==
X-Received: by 2002:a2e:720a:: with SMTP id n10mr16610696ljc.226.1560876728147;
        Tue, 18 Jun 2019 09:52:08 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id s14sm2656632ljd.88.2019.06.18.09.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:52:07 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2308e5da-a8fd-a0e6-f98c-0931a30baf14@gmail.com>
Date:   Tue, 18 Jun 2019 19:52:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617154632.GB5316@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2019 18:46, Mark Brown пишет:
> On Tue, Jun 04, 2019 at 02:59:03AM +0300, Dmitry Osipenko wrote:
> 
>> +config SOC_TEGRA20_VOLTAGE_COUPLER
>> +	bool "Voltage scaling support for Tegra20 SoC's"
> 
> SoCs
> 
>> +	depends on ARCH_TEGRA_2x_SOC
> 
> Can we have an || COMPILE_TEST here please?

Good call!

>> +++ b/drivers/soc/tegra/regulators-tegra20.c
>> @@ -0,0 +1,348 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Voltage regulators coupling resolver for NVIDIA Tegra20
>> + *
>> + * Copyright (C) 2019 GRATE-DRIVER project
> 
> Please make the entire comment a C++ one so things look more
> intentional.
> 

This is actually a correct SPDX comment style for the source files, accordingly to
checkpatch. While the C++ style should be used for header files only. I'm not
following the SPDX effort much, don't know from where these SPDX-style rules are
coming from.
