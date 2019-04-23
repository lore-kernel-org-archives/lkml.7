Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B95C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37D4206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c45I7llL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfDWXI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:08:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43338 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfDWXI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:08:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so22294056wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S+jF/L2bbtq/6fO11UF09dE0wRVcaCI68CrkuWT6qPE=;
        b=c45I7llL09uragjf9jGJ3c5nnG+cW9pAA/aHT4Dbu6O3EGrY0LPRDo5ew7j5keyZ1K
         8uR2E/FvS6iRkTz4stZWe0+wJWrxmL9a4AB0XI29wn1PfJ7QoA8gLrzy14vQrlyn1Umk
         blPfdoE2NnW77UdLr/dTpzTENmZW2tgBo1vWFx6MPwUFtaaf/1HDCr1dVGWI8N3q7Cuv
         tTqCwAj5mbShhUeuMRn7nebDOaZuOCslU/bGMlRY+miHfhpujHJpY/fAH7LPCBv19gKR
         uB9r7Ff32oyE0OSK/SQ12JdXNU828VjicyRLnkSqyhejCR+97qvQhwil1Vo2+lWoUIyW
         E8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S+jF/L2bbtq/6fO11UF09dE0wRVcaCI68CrkuWT6qPE=;
        b=OjiXdgyMmjNFSlSTCs0Yv8kFcwYz0eQ2lfaFxdH6f3qi4ktaA9p4Qqe2pw5iq6vzWn
         kX++zc/Be3iWfLnRj3l21wXX8ozJmk63SbBaGbpe0SziNFwXciydAN8TmlDlSgWBx1EW
         BVE3Hu72kLUjxAq6f1/FfuqG14MQu46mbGdj47NyUZXRnz3tZipXTkMXqXkdBndjapEU
         cMe/XwsRot4N9mDbEgeD29/lcBFoYpFFJyeamvAOiTVGbqBXrpvQKxj5PpkFqBL/045N
         vGvtLkYPJUSNquEq2jNnj1C8tXS6Yvg58WDTr7d5a/JXfcqNshCt74KnRvLF+9CUhdzW
         rO1A==
X-Gm-Message-State: APjAAAVqRnaqADsMIfyhhNVeZfsiQjy2j/px0tlzjaEl5qW3jO7FPCLa
        Id0uAhjcWREvhIef2LQrX2DwMA==
X-Google-Smtp-Source: APXvYqwRCdHK00g4EfLjao7DPzMUQwjrwx9lTvXu4HcWJLNUl+ktRJD6EsLs4P6B15KrkqcdHnH0gQ==
X-Received: by 2002:adf:d081:: with SMTP id y1mr9171169wrh.283.1556060904613;
        Tue, 23 Apr 2019 16:08:24 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id t24sm14885499wmi.10.2019.04.23.16.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 16:08:23 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/of: Add a get_temp_id callback function
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, andrew.smirnov@gmail.com
References: <20190416172203.4679-1-daniel.lezcano@linaro.org>
 <20190423154430.GA16014@localhost.localdomain>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bc10d520-4d15-74d6-0dc2-fd63df8d9a21@linaro.org>
Date:   Wed, 24 Apr 2019 01:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423154430.GA16014@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2019 17:44, Eduardo Valentin wrote:
> Hello,
> 
> On Tue, Apr 16, 2019 at 07:22:03PM +0200, Daniel Lezcano wrote:
>> Currently when we register a sensor, we specify the sensor id and a data
>> pointer to be passed when the get_temp function is called. However the
>> sensor_id is not passed to the get_temp callback forcing the driver to
>> do extra allocation and adding back pointer to find out from the sensor
>> information the driver data and then back to the sensor id.
>>
>> Add a new callback get_temp_id() which will be called if set. It will
>> call the get_temp_id() with the sensor id.
>>
>> That will be more consistent with the registering function.
> 
> I still do not understand why we need to have a get_id callback.
> The use cases I have seen so far, which I have been intentionally rejecting, are
> mainly solvable by creating other compatible entries. And really, if you
> have, say a bandgap, chip that supports multiple sensors, but on
> SoC version A it has 5 sensors, and on SoC version B it has only 4,
> or on SoC version C, it has 5 but they are either logially located
> in different places (gpu vs iva regions), these are all cases in which
> you want a different compatible!
> 
> Do you mind sharing why you need a get sensor id callback?

It is not a get sensor id callback, it is a get_temp callback which pass
the sensor id.

See in the different drivers, it is a common pattern there is a
structure for the driver, then a structure for the sensor. When the
get_temp is called, the callback needs info from the sensor structure
and from the driver structure, so a back pointer to the driver structure
is added in the sensor structure.

Example:

struct hisi_thermal_sensor {
        struct hisi_thermal_data *data;   <-- back pointer
        struct thermal_zone_device *tzd;
        const char *irq_name;
        uint32_t id; 		<-- note this field
        uint32_t thres_temp;
};

struct hisi_thermal_data {
        const struct hisi_thermal_ops *ops;
        struct hisi_thermal_sensor *sensor;
        struct platform_device *pdev;
        struct clk *clk;
        void __iomem *regs;
        int nr_sensors;
};


In the get_temp callback:

static int hisi_thermal_get_temp(void *__data, int *temp)
{
        struct hisi_thermal_sensor *sensor = __data;
        struct hisi_thermal_data *data = sensor->data;

        *temp = data->ops->get_temp(sensor);

        dev_dbg(&data->pdev->dev, "tzd=%p, id=%d, temp=%d, thres=%d\n",
                sensor->tzd, sensor->id, *temp, sensor->thres_temp);

        return 0;
}


Another example:

struct qoriq_sensor {
        struct thermal_zone_device      *tzd;
        struct qoriq_tmu_data           *qdata; <-- back pointer
        int                             id;  	<-- note this field
};

struct qoriq_tmu_data {
        struct qoriq_tmu_regs __iomem *regs;
        bool little_endian;
        struct qoriq_sensor     *sensor[SITES_MAX];
};

static int tmu_get_temp(void *p, int *temp)
{
        struct qoriq_sensor *qsensor = p;
        struct qoriq_tmu_data *qdata = qsensor->qdata;
        u32 val;

        val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
        *temp = (val & 0xff) * 1000;

        return 0;
}

Another example:


struct rockchip_thermal_sensor {
        struct rockchip_thermal_data *thermal;	<-- back pointer
        struct thermal_zone_device *tzd;
        int id;					<-- note this field
};

struct rockchip_thermal_data {
        const struct rockchip_tsadc_chip *chip;
        struct platform_device *pdev;
        struct reset_control *reset;

        struct rockchip_thermal_sensor sensors[SOC_MAX_SENSORS];

	[ ... ]
};


static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
{
        struct rockchip_thermal_sensor *sensor = _sensor;
        struct rockchip_thermal_data *thermal = sensor->thermal;
        const struct rockchip_tsadc_chip *tsadc = sensor->thermal->chip;
        int retval;

        retval = tsadc->get_temp(&tsadc->table,
                                 sensor->id, thermal->regs, out_temp);
        dev_dbg(&thermal->pdev->dev, "sensor %d - temp: %d, retval: %d\n",
                sensor->id, *out_temp, retval);

        return retval;
}

This patch adds an alternate get_temp_id() along with the get_temp()
ops. If the ops field for get_temp_id is filled, it will be invoked and
will pass the sensor id used when registering. It results the driver
structure can be passed and the sensor id gives the index in the sensor
 table in this structure. The back pointer is no longer needed, the id
field neither and I suspect, by domino effect, more structures will
disappear or will be simplified (eg. the above rockchip sensor structure
disappear and the thermal_data structure will contain an array of
thermal zone devices).

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  drivers/thermal/of-thermal.c | 19 +++++++++++++------
>>  include/linux/thermal.h      |  1 +
>>  2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
>> index 2df059cc07e2..787d1cbe13f3 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -78,6 +78,8 @@ struct __thermal_zone {
>>  
>>  	/* sensor interface */
>>  	void *sensor_data;
>> +	int sensor_id;
>> +
>>  	const struct thermal_zone_of_device_ops *ops;
>>  };
>>  
>> @@ -88,10 +90,14 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
>>  {
>>  	struct __thermal_zone *data = tz->devdata;
>>  
>> -	if (!data->ops->get_temp)
>> -		return -EINVAL;
>> +	if (data->ops->get_temp)
>> +		return data->ops->get_temp(data->sensor_data, temp);
>>  
>> -	return data->ops->get_temp(data->sensor_data, temp);
>> +	if (data->ops->get_temp_id)
>> +		return data->ops->get_temp_id(data->sensor_id,
>> +					      data->sensor_data, temp);
>> +
>> +	return -EINVAL;
>>  }
>>  
>>  static int of_thermal_set_trips(struct thermal_zone_device *tz,
>> @@ -407,8 +413,8 @@ static struct thermal_zone_device_ops of_thermal_ops = {
>>  /***   sensor API   ***/
>>  
>>  static struct thermal_zone_device *
>> -thermal_zone_of_add_sensor(struct device_node *zone,
>> -			   struct device_node *sensor, void *data,
>> +thermal_zone_of_add_sensor(struct device_node *zone, struct device_node *sensor,
>> +			   int sensor_id, void *data,
>>  			   const struct thermal_zone_of_device_ops *ops)
>>  {
>>  	struct thermal_zone_device *tzd;
>> @@ -426,6 +432,7 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>>  	mutex_lock(&tzd->lock);
>>  	tz->ops = ops;
>>  	tz->sensor_data = data;
>> +	tz->sensor_id = sensor_id;
>>  
>>  	tzd->ops->get_temp = of_thermal_get_temp;
>>  	tzd->ops->get_trend = of_thermal_get_trend;
>> @@ -516,7 +523,7 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
>>  		}
>>  
>>  		if (sensor_specs.np == sensor_np && id == sensor_id) {
>> -			tzd = thermal_zone_of_add_sensor(child, sensor_np,
>> +			tzd = thermal_zone_of_add_sensor(child, sensor_np, sensor_id,
>>  							 data, ops);
>>  			if (!IS_ERR(tzd))
>>  				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 5f4705f46c2f..2762d7e6dd86 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -351,6 +351,7 @@ struct thermal_genl_event {
>>   *		   hardware.
>>   */
>>  struct thermal_zone_of_device_ops {
>> +	int (*get_temp_id)(int, void *, int *);
>>  	int (*get_temp)(void *, int *);
>>  	int (*get_trend)(void *, int, enum thermal_trend *);
>>  	int (*set_trips)(void *, int, int);
>> -- 
>> 2.17.1
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

