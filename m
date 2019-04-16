Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D14BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC1621852
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5uPVRRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfDPPyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:54:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37101 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDPPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:54:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so19602485ljk.4;
        Tue, 16 Apr 2019 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f9FY1sBshfobGtdtolgZbeCXIDcnPODfPdgmcUPML64=;
        b=D5uPVRRO7ckpJhWyrahBStGAu/QBGOdbSISaT2q3olx2BGJJFjKRLOJFzrk0qidOQ4
         gD4+ZwPuRfYZaTfy3FH3Bkf5j6KCuU83xnDmJcemaLFweCXnCE9mSBQis9GG+YLPk8Lk
         Pt2brcUmdgrpSPJRnxMGrkUz2abpivYF8Tr1eni9Tp764kXEvu5YZxZS9ssK5eestGAx
         L521soww3t67dFSOzzqqc637Edw929FeCji4X2hDZ367EEOyIzHd27qONRJAaBRk57nA
         7R8Hzuh/h1gE0s4RVB86TBAjdUxHuhBU/ri7bzGDfpOZs1/tyfSqdd/jDwUW7fTr6Yjk
         kuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f9FY1sBshfobGtdtolgZbeCXIDcnPODfPdgmcUPML64=;
        b=jfh4eBBAdBYAngv1IJFftgx0wWbbibvWDb9JqZtWNxJINOyCoyuBsNMFcoWXtnEWug
         mInLe0/X9EVKiaLEPVtbEB40sFbnHNw797mowQDgfqUJIPpro0H1u+vJRcA7pBbQGTeE
         ycIyqFDe5uXn3+NZWwMkCIQ6u0OI0jSfA0b+ljH29/65S9kPLZCUdITF4bJLfr1WMX5P
         PexIh2cOUAFBoaXh8z/zsTUYXSnvRmOf79MXSouTbIzs1URFP/e4xHagsAkx3TngxDHY
         /JtOFJGBVyS42YIDInl7pZD/Tp+VM90xuLviqmZZlBve30/qcpbfDCSyWfW4ZzC+oFkn
         kYNA==
X-Gm-Message-State: APjAAAVDKU7oZ2DqrtmNlKbqVlrRMaYHKTnuUbk39uxJN1hNTs7RT8T3
        OzkAZWH3jnJszXZ+BTMR4N9gqhxJ
X-Google-Smtp-Source: APXvYqyp78Bj6fwwhuWx0YuNL475YFrPoDxZTGWiF/aZjcWSULXb8m556YKv/DWVjEhr4kfaGrIeXg==
X-Received: by 2002:a2e:4ca:: with SMTP id a71mr44450009ljf.39.1555430078023;
        Tue, 16 Apr 2019 08:54:38 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id j14sm11338871lfb.18.2019.04.16.08.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:54:37 -0700 (PDT)
Subject: Re: [PATCH v2 18/19] PM / devfreq: tegra: Enable COMPILE_TEST for the
 driver
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145614epcas4p494a515b20cd351e220ac4eb37c05b7fb@epcas4p4.samsung.com>
 <20190415145505.18397-19-digetx@gmail.com>
 <8d8c55b8-b4aa-e072-7c5f-0b1e5e883031@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <77653f79-45ef-1557-c940-0140bcb69311@gmail.com>
Date:   Tue, 16 Apr 2019 18:52:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8d8c55b8-b4aa-e072-7c5f-0b1e5e883031@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.04.2019 10:43, Chanwoo Choi пишет:
> On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
>> The driver's compilation doesn't have any specific dependencies, hence
>> the COMPILE_TEST option can be supported in Kconfig.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 78c33ddd4eea..bd6652863e7d 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>  
>>  config ARM_TEGRA_DEVFREQ
>>  	tristate "NVIDIA Tegra30+ DEVFREQ Driver"
>> -	depends on ARCH_TEGRA
>> +	depends on ARCH_TEGRA || COMPILE_TEST
>>  	select PM_OPP
>>  	help
>>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
>>
> 
> I think that it doesn't need to make it a separate patch.
> You can merge this patch to patch17 and then drop this patch.
> 

I'd prefer to have this change as a separate patch because this is a logically distinct change from the patch 17.
