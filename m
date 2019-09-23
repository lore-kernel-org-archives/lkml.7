Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29582C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011FB206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391349AbfIWBeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 21:34:10 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:41838 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387843AbfIWBeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 21:34:09 -0400
Received: (qmail 27767 invoked by uid 5089); 23 Sep 2019 01:34:07 -0000
Received: by simscan 1.2.0 ppid: 27707, pid: 27708, t: 0.0458s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.128?) (preid@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 23 Sep 2019 01:34:06 -0000
Subject: Re: [PATCH 4.19 32/79] fpga: altera-ps-spi: Fix getting of optional
 confd gpio
To:     Pavel Machek <pavel@denx.de>, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Sasha Levin <sashal@kernel.org>
References: <20190919214807.612593061@linuxfoundation.org>
 <20190919214810.609051121@linuxfoundation.org> <20190921204659.GC14868@amd>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <c7c4864a-f3b7-6875-d229-c13b3808f7b3@electromag.com.au>
Date:   Mon, 23 Sep 2019 09:33:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190921204659.GC14868@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2019 04:46, Pavel Machek wrote:
> Hi!
> 
>> Currently the driver does not handle EPROBE_DEFER for the confd gpio.
>> Use devm_gpiod_get_optional() instead of devm_gpiod_get() and return
>> error codes from altera_ps_probe().
> 
>> @@ -265,10 +265,13 @@ static int altera_ps_probe(struct spi_device *spi)
>>   		return PTR_ERR(conf->status);
>>   	}
>>   
>> -	conf->confd = devm_gpiod_get(&spi->dev, "confd", GPIOD_IN);
>> +	conf->confd = devm_gpiod_get_optional(&spi->dev, "confd", GPIOD_IN);
>>   	if (IS_ERR(conf->confd)) {
>> -		dev_warn(&spi->dev, "Not using confd gpio: %ld\n",
>> -			 PTR_ERR(conf->confd));
>> +		dev_err(&spi->dev, "Failed to get confd gpio: %ld\n",
>> +			PTR_ERR(conf->confd));
>> +		return PTR_ERR(conf->confd);
> 
> Will this result in repeated errors in dmesg in case of EPROBE_DEFER?
> We often avoid printing such messages in EPROBE_DEFER case.

Yes it will. I can submit a patch for that if required.

> 
>> +	} else if (!conf->confd) {
>> +		dev_warn(&spi->dev, "Not using confd gpio");
>>   	}
>>   
>>   	/* Register manager with unique name */
> 
> Best regards,
> 									Pavel
> 


-- 
Regards
Phil Reid
