Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D401C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9CB20643
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO7m7iEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfDPN0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:26:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37547 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfDPN0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:26:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so19113966ljk.4;
        Tue, 16 Apr 2019 06:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dDF2QDTV0coGOedoBqTKAuHPEauLa3WDKESucRrXWnQ=;
        b=jO7m7iEix6V2COmWv9y6SjXmr6SGZtYwvRs5EXuozgULf90unc2SWpZCV7PFDG3spd
         MVi2k/5g7x7Ce7BPbIe0Shu5cyaQMleOkxkMObgMuP6tKpDk94A3xk4Ygs3J81TVj6Wf
         keF3lsuoJLuk5ptcUm6N2sWwPTwiTR3tDBCildxWD/HVLpODw7rceglKtay1UQRvQu3f
         Oa3AmGQMZMIKYAXkeawVJSW5rygyIibFlIgBdA+pxP83VvkDhg5YBvl2XcqpcdjfDreh
         oe5pPTV518cozrNbewAHbOut60bmCZryg5oodEuPKI7cRvtB9blEekfJvIfCGtLcyjnO
         M/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dDF2QDTV0coGOedoBqTKAuHPEauLa3WDKESucRrXWnQ=;
        b=a0A6ToVegUo4MgofnEMdLDPvV1mjyxRmL3kmD/9+JZEVUd48qXhbK4WArrvCub1Jkc
         5ldSXDWJ8LmBFvV964R6lxyK+rhzSZEBDp+SOP9bUnd+yq9yt2/dqBXAdfMo7E5GHDdw
         8X2SZxtbDEE7K7kdU/M7+RweJjnkjE/0lT5dpyVouyaIEhXYurU7aBQe/gFLJYPvYTs/
         C+wkG60ne3bbpVCY+HK7XYUyVQB2Ettr0iAF92HpbToqmMJqDKBq929nhlfTNAT49+CA
         882ThJ09MX4Ng8D3VUisrkzL53fbZPHoCTt+6+mlgvVjY3jKdMbw2tVMujj87TaaPSBJ
         mc1A==
X-Gm-Message-State: APjAAAUCLKQ1FdAlgkcrVxJp9UaCykmwrVPpzfFDUQQ1rAq8IkcnUAt7
        18hK7fdyXPHJ1LEmxlYf1FDJcsaq
X-Google-Smtp-Source: APXvYqzP2TcLPM9l3VwaCnEQSEJn39GDBAn5ZH+fRnAAflqAVLH18gziGuqrmEDJHHceNwxZ0Aaqsg==
X-Received: by 2002:a2e:5c7:: with SMTP id 190mr42951263ljf.108.1555421158122;
        Tue, 16 Apr 2019 06:25:58 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id y7sm287533lfg.76.2019.04.16.06.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 06:25:57 -0700 (PDT)
Subject: Re: [PATCH v2 01/19] PM / devfreq: tegra: Fix kHz to Hz conversion
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145820epcas2p27ba84badad9cf5cf5b7853af7e908e43@epcas2p2.samsung.com>
 <20190415145505.18397-2-digetx@gmail.com>
 <a7cacb6c-1097-6d16-f6dc-7470f487c5b8@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cd022104-6b31-9b0d-b5d5-32374bdc0e6a@gmail.com>
Date:   Tue, 16 Apr 2019 16:24:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a7cacb6c-1097-6d16-f6dc-7470f487c5b8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.04.2019 4:45, Chanwoo Choi пишет:
> Hi,
> 
> I add one minor comment (KHZ -> hz).

Hello Chanwoo,

Thank you very much for the review!

> On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
>> The kHz to Hz is incorrectly converted in a few places in the code,
>> this results in a wrong frequency being calculated because devfreq core
>> uses OPP frequencies that are given in Hz to clamp the rate, while
>> tegra-devfreq gives to the core value in kHz and then it also expects to
>> receive value in kHz from the core. In a result memory freq is always set
>> to a value which is close to ULONG_MAX because of the bug. Hence the EMC
>> frequency is always capped to the maximum and the driver doesn't do
>> anything useful. This patch was tested on Tegra30 and Tegra124 SoC's, EMC
>> frequency scaling works properly now.
>>
>> Cc: <stable@vger.kernel.org> # 4.14+
>> Tested-by: Steev Klimaszewski <steev@kali.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index c89ba7b834ff..02905978abe1 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -486,9 +486,9 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>  {
>>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>>  	struct dev_pm_opp *opp;
>> -	unsigned long rate = *freq * KHZ;
>> +	unsigned long rate;
>>  
>> -	opp = devfreq_recommended_opp(dev, &rate, flags);
>> +	opp = devfreq_recommended_opp(dev, freq, flags);
>>  	if (IS_ERR(opp)) {
>>  		dev_err(dev, "Failed to find opp for %lu KHz\n", *freq);
> 
> Need to change it as following:
> - KHz -> Hz

Indeed, good catch.

> 
>>  		return PTR_ERR(opp);
>> @@ -499,8 +499,6 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>  	clk_set_min_rate(tegra->emc_clock, rate);
>>  	clk_set_rate(tegra->emc_clock, 0);
>>  
>> -	*freq = rate;
>> -
>>  	return 0;
>>  }
>>  
>> @@ -510,7 +508,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>>  	struct tegra_devfreq_device *actmon_dev;
>>  
>> -	stat->current_frequency = tegra->cur_freq;
>> +	stat->current_frequency = tegra->cur_freq * KHZ;
>>  
>>  	/* To be used by the tegra governor */
>>  	stat->private_data = tegra;
>> @@ -565,7 +563,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>>  		target_freq = max(target_freq, dev->target_freq);
>>  	}
>>  
>> -	*freq = target_freq;
>> +	*freq = target_freq * KHZ;
>>  
>>  	return 0;
>>  }
>>
> 
> It looks good to me if modify it in accordance with my comment.
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Okay, thanks.
