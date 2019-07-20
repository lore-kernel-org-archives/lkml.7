Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58FC76196
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 21:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69912082A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 21:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9Y62yCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfGTVMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 17:12:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34074 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGTVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 17:12:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so9686930pgc.1;
        Sat, 20 Jul 2019 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cXlW4t/Cp5gjzf56TxwnsSbtxly4H0blFeXMvCWkAuM=;
        b=q9Y62yCXq8z2QRQSmiJzcQ8bkTVfyhNk0aC1rUsYnjN3pabxBSsTWDnqK6TtxHJKO9
         jS0lfmDFpLELWRKjBICRZhrpe+l/hazGRg4l4vX9V0G0wlds/Xh1RVUyVum0Qb+rdQdv
         FIM+W3fdkPfiLHOgkTnIT9NMnEIEqpsYz0yyfYZZwU3Japngu41RlvPB8KdqDP/I5NLT
         iKqx+kwwHfPFrw42ArLmi5HH9siktwP2Ge/MrQNSLAsfZqmRQt070O+N5QBMATw/gGWw
         N3hQUBKR7RId7ybBu2knnHUwY11Xnk92Q3uzVdAl9kUuBzvic6DoZp3UWnmOIkU0N/nx
         dQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cXlW4t/Cp5gjzf56TxwnsSbtxly4H0blFeXMvCWkAuM=;
        b=SbE0bxdeQi1v9nZhQCJo+WCHw9vHLD5Mi5GdrGGXiJru7Wg6x5dSrJJ0LaDsAynqFH
         FFhy7n7bJ2AdeMB7gotCABr2pSzsNvLRLIPluVWNLKjCsclr72QuTvaB3FkPZhLgzDpk
         fJymmy6+Y+DeivJq+o9qq5Z0098ad06zyw/Sca06T9BeeYhbqghNprrxoyV5HAkX25do
         sxpSEKaTr9hL4Ibxo6uFLpJ+FdJog+ul2dka75jUSLdB/W837oBSsgsB9/FPflcitylV
         30k/AGpSY8wYFygrUdV8s1W2YDqqz9SximKgpoC9HQ2AEojqfq53UeyoD92kR3yyv3Cp
         B6Hw==
X-Gm-Message-State: APjAAAVeNcSX+ZntntJptLHMfOMJRy3xLJaaEInOLeeD4HoYruyWNQya
        ii5IZrutG9mjKs8UxkU1NN/Nqbei
X-Google-Smtp-Source: APXvYqxekYBq3pnGrcyNNJ2vferO0UHU66bxRSIjJpLDq52eafY88xM9L3jIPHGeWukIkcRIil037g==
X-Received: by 2002:a65:5188:: with SMTP id h8mr29495651pgq.294.1563657131128;
        Sat, 20 Jul 2019 14:12:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i9sm33624540pgo.46.2019.07.20.14.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 14:12:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwmon: (k8temp) update to use new hwmon registration
 API
To:     Robert Karszniewicz <avoidr@firemail.cc>,
        Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <BVOE1YNHJDU6.38N6DGWH9KX7H@HP>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <325bcd3e-7795-1b34-587f-38364dd477f4@roeck-us.net>
Date:   Sat, 20 Jul 2019 14:12:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <BVOE1YNHJDU6.38N6DGWH9KX7H@HP>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/19 2:05 PM, Robert Karszniewicz wrote:
> Hello Guenter.
> 
> Thank you for your feedback! I am working on a version 2.
> 
> On Sat Jul 20, 2019 at 7:08 AM Guenter Roeck wrote:
>>> +static umode_t
>>> +k8temp_is_visible(const void *drvdata, enum hwmon_sensor_types type,
>>> +		  u32 attr, int channel)
>>> +{
>>> +	if (type != hwmon_temp)
>>> +		return 0;
>>
>> Not really needed since only temperature sensors are registered in the first place.
>>
>>> +
>>> +	if (attr != hwmon_temp_input)
>>> +		return 0;
>>> +
>>
>> The idea here is to only create sensors if they actually exist, so I would expect
>> something like the following here.
> 
> I realised that in the probe() function I deleted all the code which
> conditionally creates the sysfs files. Is that how it's supposed to be
> done and that's exactly what is_visible() is for, or is the proper way
> to still create the sysfs files conditionally, too?
> 

Yes, that is what the function is for. sysfs files are created in the core,
based on the result from the call to the is_visible function. If the function
returns 0, the respective sysfs file won't be created.

Thanks,
Guenter

>> 	struct k8temp_data *data = drvdata;
>>
>> 	if (attr != hwmon_temp_input)
>> 		return 0;
>>
>> 	if ((channel & 1) && !(data->sensorsp & SEL_PLACE))
>> 		return 0;
>>
>> 	if ((channel & 2) && !(data->sensorsp & SEL_CORE))
>> 		return 0;
>>
>>> +	return 0444;
>>> +}
> 
>>> +	if (data->swap_core_select)
>>> +		core = core ? 0 : 1;
>>
>> 		core = 1 - core;
>>
>> would accomplish the same without conditional.
> 
> How do you like
> 	core ^= 1;
> ?
> 
>>>    static int k8temp_probe(struct pci_dev *pdev,
>>>    				  const struct pci_device_id *id)
>>>    {
>>> -	int err;
>>>    	u8 scfg;
>>>    	u32 temp;
>>>    	u8 model, stepping;
>>>    	struct k8temp_data *data;
>>> +	struct device *hwmon_dev;
>>>    
>>>    	data = devm_kzalloc(&pdev->dev, sizeof(struct k8temp_data), GFP_KERNEL);
>>>    	if (!data)
>>> @@ -233,84 +274,23 @@ static int k8temp_probe(struct pci_dev *pdev,
>>>    
>>>    	data->name = "k8temp";
>>>    	mutex_init(&data->update_lock);
>>> -	pci_set_drvdata(pdev, data);
>>> -
>>> -	/* Register sysfs hooks */
>>> -	err = device_create_file(&pdev->dev,
>>> -			   &sensor_dev_attr_temp1_input.dev_attr);
>>> -	if (err)
>>> -		goto exit_remove;
>>> -
>>> -	/* sensor can be changed and reports something */
>>> -	if (data->sensorsp & SEL_PLACE) {
>>> -		err = device_create_file(&pdev->dev,
>>> -				   &sensor_dev_attr_temp2_input.dev_attr);
>>> -		if (err)
>>> -			goto exit_remove;
>>> -	}
>>> -
>>> -	/* core can be changed and reports something */
>>> -	if (data->sensorsp & SEL_CORE) {
>>> -		err = device_create_file(&pdev->dev,
>>> -				   &sensor_dev_attr_temp3_input.dev_attr);
>>> -		if (err)
>>> -			goto exit_remove;
>>> -		if (data->sensorsp & SEL_PLACE) {
>>> -			err = device_create_file(&pdev->dev,
>>> -					   &sensor_dev_attr_temp4_input.
>>> -					   dev_attr);
>>> -			if (err)
>>> -				goto exit_remove;
>>> -		}
>>> -	}
> 

