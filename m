Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC606C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC3221924
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVTs4FNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfDPNqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:46:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41418 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfDPNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:46:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id t30so16057038lfd.8;
        Tue, 16 Apr 2019 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1anlsw5jTjhl2brbVUtfoVxAV9CSpLlVcdeyYBX0gUE=;
        b=WVTs4FNzZMjxo73GKoPFd6DAV7xRS7TlFhtQw3jc/2NzYMxAXr/JsV3c+MOKehd5lD
         0aOg3QddzGH4ELLZq2Vjjq7AEbpqg1CIEcn1dKyO6BhACnWBQbtINjPXSfHC3XiGNfwW
         7f7TSih8IeO598soWL18Bfv768j2TZAOFXv66H0XcN/QvLHyCYG24YguC145UOAMk+ML
         aFKklHK/e/t35h6fiIQwmpN2R+SqbiSy+OFG6Ux1IyeuiyokaJJAyE7sVPQMoTPeYpMx
         GiYz87JPhec6g3tqBAAQ0b5uZxzPpqW27v05I7LbftHv24l6S18I0L+Z1HTUql3A2Grn
         0v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1anlsw5jTjhl2brbVUtfoVxAV9CSpLlVcdeyYBX0gUE=;
        b=CyPbXw5tqpLa/UedRWRCm8OM1duH4Sh7HaHfatiLHt7fkCUeYwqRpTOBFjv3p6AdIW
         9J2kAyy96KvAP5irQ6jA/P1HiJbMF9iT5kH8e8Mj+HYJNeAmmUEcSJAyY2lGUXjepGqE
         QjzuW6wbfi88eDl7o6sz1V9Qr3LyhpduMr94Wwe0TqFUz4iiw4Ty84Tb3w/IMyaThwJL
         cWxWDhDKoabJOMBovrBFNkb7MEW8Mqbwg5I8+816TeAMb5295aPtT7TvCOTICwhjjjVm
         XA7AWq2ixzowx0s4FLsoyHWieifZhPwI3gMI/Q8p+Z720k8a+nM72DB+s3+KPt3wZRm/
         7FYA==
X-Gm-Message-State: APjAAAVwpdb1E/tnTqVymPHlXJAM6/TJaJBGeBNBJ/MWwGTyjNlj22U7
        gRINDUlvBp+MsNEDWZ7g+9C4/tRY
X-Google-Smtp-Source: APXvYqyO7iJ7QrAiIHHy0b3zVCfXe8lF83NkazPfn2G8pXneiYv5Yx+mmmzolQTBiSZ3J84w6soUJw==
X-Received: by 2002:ac2:51da:: with SMTP id u26mr9358269lfm.32.1555422393334;
        Tue, 16 Apr 2019 06:46:33 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id f21sm9402281ljk.94.2019.04.16.06.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 06:46:32 -0700 (PDT)
Subject: Re: [PATCH v2 04/19] PM / devfreq: tegra: Don't set EMC clock rate to
 maximum on probe
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145546epcas3p2dd7b6049da59458b165eb54e4cc8162d@epcas3p2.samsung.com>
 <20190415145505.18397-5-digetx@gmail.com>
 <9fa3c0c3-0ef4-2d86-b6a8-7bd0fbc131e6@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4ae5b863-a6db-39bb-7654-6dd9b63c0d34@gmail.com>
Date:   Tue, 16 Apr 2019 16:44:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9fa3c0c3-0ef4-2d86-b6a8-7bd0fbc131e6@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.04.2019 4:59, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
>> There is no real benefit from doing so, hence let's drop that rate setting
>> for consistency.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index 69581c9082d4..d62fb1b0d9bb 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -648,8 +648,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  		return PTR_ERR(tegra->emc_clock);
>>  	}
>>  
>> -	clk_set_rate(tegra->emc_clock, ULONG_MAX);
>> -
> 
> It seems like that initialize the emc_clock as the supported maximum clock.
> But, if the rate for emc_clock initialized by either bootloader or clock driver
> and it's well working until this code, actually, it is not necessary.
> 
> Looks good to me.
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

EMC clock rate is set properly at a boot time on all Tegra's, thanks.
