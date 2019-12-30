Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5859BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2129A2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2/p99Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfL3Tjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:39:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34303 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3Tjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:39:49 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so17599109lfc.1;
        Mon, 30 Dec 2019 11:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b7jcdnKGpQoMXB5jym9bcA+uOYxnISOQKzOGlO5x77I=;
        b=j2/p99JeknWrOKp0xFKGM5yAu6FCdh6LPVVY18jsceUWp2xjMVWCOZ9BXmJLKaZ2aO
         D+2dBOrhOA8k/cDLGqBdrSTFdPQhqTnJf5u5MJbTeBzh8gBa1z14gTFmH2UsVe7+37Go
         Wh2KrO2s9ZCsM3VNkF/5i41UOuLA1o1HhMXp63D+ZDQJ5RUweW93/D0bAHlj6M6oMmsi
         spwS9Tpu8IU4C/lGzRmePbBUYmRLdylcTqsoP2FagQ3os4Jn40GQy0VW3BVabQUclnf+
         eWMSHuVw3kL4kwewunhDwM2iDI/dCQfjFVT83hYWIpC2DXmhrZ6PMI5hd3Z3QBoMki2H
         FmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b7jcdnKGpQoMXB5jym9bcA+uOYxnISOQKzOGlO5x77I=;
        b=js5gpYHbJfNIFlIQQwD/zBmuNv3ZXIrWasHuAaFr95RfFN+GQ6toc2IcIdFyuyINpT
         5Tlhp/w+HUqY/PVsQGkaRzkcKr25+tkXid3Gxn+ebkgnh1VPjy1lBjVTkQiUcglfyr9q
         /OmdK9iko9plk3L6WCP+U0SPPdQXi/am1iSYq8bOi2Ei02qxrIsVxTvcyOUu97lamTkO
         cymBQi3ayF0sM+exdAfBqvpBrriaMcW58X7d5elram0jrGaSKoKSmf2TQ37/VIwm+x4b
         R7NYrK0kxL38GbKG/9QcGAk16leUK+uEgM4ccLidKnxjiENiP9jEfkCcq9nPkFIzBecG
         p46A==
X-Gm-Message-State: APjAAAUePvOmJslMb0tjzHJeGV14hFrOhMsM4Ug1+yqvsctO+rRFULqr
        2YP0YGnFmZqoDy1sdNQKAsl6hiFD
X-Google-Smtp-Source: APXvYqzlfvKm1U/MKTD9szzVYuXGUuy6aB9vEsrtzpBlRfH4SyGZKISZkKGCnHF6cM6KhnrzvsB6Pw==
X-Received: by 2002:a19:2486:: with SMTP id k128mr39078871lfk.16.1577734786557;
        Mon, 30 Dec 2019 11:39:46 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u9sm18079594lji.49.2019.12.30.11.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 11:39:46 -0800 (PST)
Subject: Re: [PATCH v5 07/19] dt-bindings: soc: tegra-pmc: Add id for Tegra
 PMC 32KHz blink clock
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-8-git-send-email-skomatineni@nvidia.com>
 <c8a847fb-3d23-6e1e-59e2-a2d15b63ce02@gmail.com>
 <b46c21ca-855e-cd81-ab8d-aa96b61ebb56@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9a4a125c-7a39-31c9-4670-4f4a29e18c56@gmail.com>
Date:   Mon, 30 Dec 2019 22:39:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b46c21ca-855e-cd81-ab8d-aa96b61ebb56@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.12.2019 00:30, Sowjanya Komatineni пишет:
> 
> On 12/22/19 1:55 PM, Dmitry Osipenko wrote:
>> 21.12.2019 01:26, Sowjanya Komatineni пишет:
>>> Tegra PMC has blink functionality that allows 32KHz clock out to
>>> blink pin of the Tegra.
>>>
>>> This patch adds id for this blink clock to use for enabling or
>>> disabling blink output through device tree.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>   include/dt-bindings/soc/tegra-pmc.h | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/dt-bindings/soc/tegra-pmc.h
>>> b/include/dt-bindings/soc/tegra-pmc.h
>>> index f7c866404456..a99a457471ee 100644
>>> --- a/include/dt-bindings/soc/tegra-pmc.h
>>> +++ b/include/dt-bindings/soc/tegra-pmc.h
>>> @@ -9,7 +9,8 @@
>>>   #define TEGRA_PMC_CLK_OUT_1        0
>>>   #define TEGRA_PMC_CLK_OUT_2        1
>>>   #define TEGRA_PMC_CLK_OUT_3        2
>>> +#define TEGRA_PMC_CLK_BLINK        3
>>>   -#define TEGRA_PMC_CLK_MAX        3
>>> +#define TEGRA_PMC_CLK_MAX        4
>>>     #endif    /* _DT_BINDINGS_SOC_TEGRA_PMC_H */
>>>
>> Could you please explain the reason of separating CLK_OUT and BLINK PMC
>> patches?
> No specific reason just thought to have BLINK as separate patch as its
> different register configuration to have fixed 32Khz clock out.
>>
>> Also, you only documented CLK_OUT clocks in the DT binding and no BLINK.
> missed to add BLINK to dt-binding doc. Will add in v6.

Ok
