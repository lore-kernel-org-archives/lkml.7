Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95F4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8810621924
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI2eJW2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfDPNoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:44:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40065 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfDPNob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:44:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id a28so16079074lfo.7;
        Tue, 16 Apr 2019 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDg5pAoctPInS+yZZzsuu25yRfo6XJen0lYd+lN7LkY=;
        b=WI2eJW2HDpZTh3m6SXZW6gi+vNnU5xM/Ui/KWlq4UpSlTz/luTJ4m63N+u0zoDqRgk
         gAXEA6B0dz8MTpCslIatMSKQvA63LwXvQsPiFXLeRQnc6sDwVjRv9G48UPbZxX/MrZl7
         vGDY+0fK5pvC/9LqH6QGFvpNltLlCqo/OyYJIiTqmaP/KuKxdgfDOVjeu8M+B1HyiyWm
         vc+N2zYZNEedu1f3NTEKpiFMzsOB5HDIkT0QCRJGinfhXmYLYS/lo9tIYFQYKWelVPjF
         +JoAvI50bO1MSs5d/NxsWGBvSabuSZ/WtI9UY0PZ4h68ZLXWngXDUGsq0W2l21kIDZIR
         z4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDg5pAoctPInS+yZZzsuu25yRfo6XJen0lYd+lN7LkY=;
        b=HCn38uD5fwDmKbNSkdhW965MeWDmpF1XXoM18VLO/iZT8FYTnO7aokpsqHMs2eV9XE
         5Q+OtfcZ0X26KSE4vlO909BBAJK1EVywVUqxF0rJ1+drqYNRWcDPdE5k3DEDi2H9biLS
         3FsVHfhpk4zXRnVTxVbOsGzxXEKaMSBaSfKnpGihWEW2a8R55+wqD5ftCVbpb/kduDKN
         VmB+LnX9MfC2PRhwVyxQxS4MDsU9HX6oQdBl5x7NSuFM2vpHY2mkrzBUB4KsiCuMi8pV
         r+2JUDZ8JamcnjBTq3sqf5l1Rzp3NTFw+qOXUW0+Yxsb/gA0MrxXW2NiHwJ99+gOHDPA
         wJAw==
X-Gm-Message-State: APjAAAWyJXZd3xPf5H9BLju9sIKhID9wONTXZ+7EZGUQjqjtfCr1YjLi
        LS8BEcUymi96ZqPWZ7TRgDXPac9/
X-Google-Smtp-Source: APXvYqyWbBf94YpEsEuWpmSx3L3IfON84SWTxqqFzoSPcrnZbYcpf5EPNSBT31W98U671pNJeDFoWw==
X-Received: by 2002:ac2:5396:: with SMTP id g22mr41968241lfh.120.1555422267730;
        Tue, 16 Apr 2019 06:44:27 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id m21sm2503591lfj.47.2019.04.16.06.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 06:44:26 -0700 (PDT)
Subject: Re: [PATCH v2 03/19] PM / devfreq: tegra: Don't ignore clk errors
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145811epcas2p45772ac8ae956928341d76b80d3fa5e91@epcas2p4.samsung.com>
 <20190415145505.18397-4-digetx@gmail.com>
 <1e4038d1-0fd3-f6d2-4e01-d34b16aeddbd@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <485c7af3-453a-1c89-a677-3ef622ee2ad3@gmail.com>
Date:   Tue, 16 Apr 2019 16:42:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1e4038d1-0fd3-f6d2-4e01-d34b16aeddbd@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.04.2019 4:52, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
>> The clk_set_min_rate() could fail and in this case clk_set_rate() sets
>> rate to 0, which may drop EMC rate to minimum and make machine very
>> difficult to use.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index 0c0909fba545..69581c9082d4 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -487,6 +487,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>>  	struct dev_pm_opp *opp;
>>  	unsigned long rate;
>> +	int err;
>>  
>>  	opp = devfreq_recommended_opp(dev, freq, flags);
>>  	if (IS_ERR(opp)) {
>> @@ -496,8 +497,13 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>  	rate = dev_pm_opp_get_freq(opp);
>>  	dev_pm_opp_put(opp);
>>  
>> -	clk_set_min_rate(tegra->emc_clock, rate);
>> -	clk_set_rate(tegra->emc_clock, 0);
>> +	err = clk_set_min_rate(tegra->emc_clock, rate);
>> +	if (err)
>> +		return err;
>> +
>> +	err = clk_set_rate(tegra->emc_clock, 0);
>> +	if (err)
> 
> Why don't you restore the previous minimum clock for tegra->emc_clock
> when failed to execute 'clk_set_rate(tegra->emc_clock, 0);'?
> 
> I think that if you control the restoring the previous minimum clock,
> it is more nice to handle the error handling.

I now see that devfreq has the previous_freq field and indeed it is possible to restore the min_rate value using it. Thanks for the suggestion.
