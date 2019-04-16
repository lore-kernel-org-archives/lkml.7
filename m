Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F97C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E7020868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnPbT/Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfDPPl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:41:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42574 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfDPPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:41:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id w23so16364225lfc.9;
        Tue, 16 Apr 2019 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NRsLpMbwuJp4j3PEqRJIvc81+LJ00bYDPemiUiGdrig=;
        b=fnPbT/Je37IB+ggMuCUjyR/xdw3wn0Y9VTtE8CLzqioMTB3AjLndqOv6SLXoYc5yt5
         5abHXTA81ncQ5epTIdwBBaRPRjRAi1KI+6bmHza09oe+i9TDDoFvTRRlQLnWp+rjQBa+
         4qKx2aeUAbm/fFG8zLsvxKS1drbKAjpi2Ek+QWDWAgPTPsy2DCdHjEFhfJsoyaASLqtm
         9VirmsDyvV3eEGqypd0RmuHW6XfK8vhNkWWBi/Nx/ryIUxysg0SLgmWb2oKTmsXsLvyt
         cPIGqP46hUcFSJs9dZGMyxztR0YWDaQIV8Vd+xFG+uGplNZiqUmgcqQP6pAXxBkCT15w
         SbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NRsLpMbwuJp4j3PEqRJIvc81+LJ00bYDPemiUiGdrig=;
        b=AK2dCg+44QuWkNTltUTp7vyAMtYtVRPd5+OOtuJ8B3oiwBIj3NAyXKl5ZqZzRyK5md
         sJaImAbSzQFu/A7WFJ71wLQCOqRycMMyKBK8erxqAD+luszVYoty/oivkXQZcjoVKD/+
         whMKJ2jXIBpB+E8CAswwB/FnMtUNLeNEuoRtnHka8D1SZk6LTdqD6N758a9pfWIm8h3E
         MNlNzJ5BFabyEJ2KGYFkFi0vx2VwzFwSyE4eoelUbb6ggwCe/HbDs8FOF2Gr6KwAeHgl
         xBNMZNw+y/ZZIaOf+jKsMLJMCicz17J3ND3f8hsa5cqDJ9l6YN6QKnIYJd2QXpN47umR
         1nhg==
X-Gm-Message-State: APjAAAUrr7MO/KzQChSxHIFnMT7p69i7an1Z7AGfP6fBXx2eGi2gpy7j
        6jjbWvnjBbCP6XWR0tt2k1aAT50Z
X-Google-Smtp-Source: APXvYqzyHNE0RKfjfscJS8q95RmrEZ1Tf8Cw8pYDO8fAz9XWF87O14mKEME3haW3rNsJRc+JFeMTqg==
X-Received: by 2002:ac2:4312:: with SMTP id l18mr34033584lfh.80.1555429316016;
        Tue, 16 Apr 2019 08:41:56 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id x30sm10373610ljd.38.2019.04.16.08.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:41:55 -0700 (PDT)
Subject: Re: [PATCH v2 12/19] PM / devfreq: tegra: Avoid inconsistency of
 current frequency value
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145721epcas1p4936edf8cf61a7d373a6e3f6aba76a029@epcas1p4.samsung.com>
 <20190415145505.18397-13-digetx@gmail.com>
 <375ebaba-1762-2675-3ae3-2ea9ec4cbcb2@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2d2f7c42-2cad-3b49-eaf3-810f94b3dc77@gmail.com>
Date:   Tue, 16 Apr 2019 18:40:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <375ebaba-1762-2675-3ae3-2ea9ec4cbcb2@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.04.2019 10:15, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
>> The frequency value potentially could change in-between. It doesn't
>> cause any real problem at all right now, but that could change in the
>> future. Hence let's avoid the inconsistency.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index a668e4fbc874..f1a6f951813a 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -496,13 +496,15 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  {
>>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>>  	struct tegra_devfreq_device *actmon_dev;
>> +	unsigned long cur_freq;
>>  
>> -	stat->current_frequency = tegra->cur_freq * KHZ;
>> +	cur_freq = READ_ONCE(tegra->cur_freq);
>>  
>>  	/* To be used by the tegra governor */
>>  	stat->private_data = tegra;
>>  
>>  	/* The below are to be used by the other governors */
>> +	stat->current_frequency = cur_freq * KHZ;
>>  
>>  	actmon_dev = &tegra->devices[MCALL];
>>  
>> @@ -513,7 +515,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>>  
>>  	/* Number of cycles in a sampling period */
>> -	stat->total_time = ACTMON_SAMPLING_PERIOD * tegra->cur_freq;
>> +	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
>>  
>>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>>  
>>
> 
> The read/write access of tegra->cur_freq is in the single routine
> of update_devfreq() as following. I think that there are no any
> potential problem about the inconsistency of tegra->cur_freq.

No, that's wrong assumption. The tegra->cur_freq is changed by the clock notifier that runs asynchronously with the devfreq driver when EMC clock rate is changed by something else in the kernel. 

> IMHO, if there are no any problem now, I'm not sure that we need
> to apply this patch.
> 
> update_devfreq()
> {
> 	devfreq->governor->get_target_freq()
> 		devfreq_update_stats(devfreq)
> 			tegra_devfreq_get_dev_status()
> 				stat->current_frequency = tegra->cur_freq * KHZ;
> 
> 	devfreq_set_target()
> 		tegra_devfreq_target()
> 			clk_set_min_rate(emc_rate, )
> 				tegra_actmon_rate_notify_cb()
> 					tegra->cur_freq = data->new_rate / KHZ;
> 		
> 			clk_set_rate(emc_rate, )
> 				tegra_actmon_rate_notify_cb()
> 					tegra->cur_freq = data->new_rate / KHZ;
> }
> 
> 

The cur_freq value is changed by the clock notifier that runs asynchronously with the rest of the devfreq driver. Hence potentially compiler may generate two separate fetches of the cur_freq value, then the clock rate could be changed by other CPU core simultaneously with tegra_devfreq_get_dev_status() or kernel may re-schedule preemptively, changing the clock rate in-between of the two fetches.
