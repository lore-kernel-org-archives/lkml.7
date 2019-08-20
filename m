Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664F3C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F5722CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr2mleZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfHTPj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:39:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36270 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbfHTPj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:39:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so3619233pfi.3;
        Tue, 20 Aug 2019 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1j7H+vhoqJHC4PUQJny3VV4YSdCvAEuiAV/gmPHS1VM=;
        b=gr2mleZJ9dxVGMuvaPTQCcUBUl//PAfqvwWFfxsVa0PJkB37oeMzidGuiqFHHxwwCO
         sKe1VLWEF4OugJsqUH66Q/SMlppeRaJZ/SYplA4lezSX2c/D7+tM97atRk6/Qms8gC2h
         71Ft49he37dOSMEIOFyNPs4Tyx17VqYeoAgm17QIq/pb5iXk+qHwcw8S6epDOOYOjSXj
         /ZuhZbRhX/AGYyb2k/IGttCikdiAeOO83/An5q7NjGtzs5PxoUV+2nGwSmiu5q98vd0s
         RiIVw3RrVIbae8dTfY1Tf4LorjtpZe7Ld+RTIvFjb9Zo9UqhcKUcPVj8vcsZVUT0DmwK
         4SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1j7H+vhoqJHC4PUQJny3VV4YSdCvAEuiAV/gmPHS1VM=;
        b=WqazG427Xa1jeWpHxRA9qyUSmtxsbi64Nn+IyajJs64jj5997PP177ndnhVnGhkjUR
         lS0nV6qdD3QTyPNYdI+kMM0+f61N0U5vkdf59Z7nhdZbmr3FQuRrgOH1FvyB8Z1mk81v
         Da/uKj6VVXAQteidsW/NOqSjGiEGckkBlyiwKA2yD5nXb7u7oHk3nQd/cndQzV+yS/wA
         qq8BDY5z+MINnqtsGe+PvmFbq1C9Q3YoczFOoenbrFV4+c4UGh41oy0goaW8YVvDwcxG
         K82k3CzyrLCkmK9EwBCgENNKC9QYP0L/aOugflDpK9R0YCDLR/GuP5UaesTnOQxDg5m/
         WlFQ==
X-Gm-Message-State: APjAAAVaB9yM2IQwWKvJJEbs01H8nBxlyIVCq0rqqEnz1+VyykoXngUM
        jWrW98yeVJJ3ajUERWpDSyk=
X-Google-Smtp-Source: APXvYqyykvp12dfCZS5mTvPsORZ/C+RGO2y6TtmoGJxnglxBRKn3wLFio47kQZwmemnqcRV4KE0biw==
X-Received: by 2002:aa7:8108:: with SMTP id b8mr31256897pfi.197.1566315596703;
        Tue, 20 Aug 2019 08:39:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b24sm19013454pfd.91.2019.08.20.08.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:39:56 -0700 (PDT)
Subject: Re: [RFC PATCH] hwmon: (iio_hwmon) Enable power exporting from IIO
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
References: <71aec0191e0e5f32cc760f95844d8ee215b48c7f.1565616579.git.michal.simek@xilinx.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <906edfa3-9e7d-e8cc-29e3-e428b79ed0c2@roeck-us.net>
Date:   Tue, 20 Aug 2019 08:39:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <71aec0191e0e5f32cc760f95844d8ee215b48c7f.1565616579.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/19 6:29 AM, Michal Simek wrote:
> There is no reason why power channel shouldn't be exported as is done for
> voltage, current, temperature and humidity.
> 
> Power channel is available on iio ina226 driver.
> 
> Tested on Xilinx ZCU102 board.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> But I don't think values are properly converted. Voltage1 is fine but the
> rest is IMHO wrong. But this patch should enable power channel to be shown
> which looks good.
> 

No idea what is going on there. I don't really know what "scaled" units
the iio subsystem reports. power is supposed to be reported to user space
in micro-Watt. Is that what the scaled value from iio reports ?

Thanks,
Guenter

> root@zynqmp-debian:~# iio_info -a && sensors -u
> Library version: 0.16 (git tag: v0.16)
> Compiled with backends: local xml ip usb serial
> Using auto-detected IIO context at URI "local:"
> IIO context created with local backend.
> Backend version: 0.16 (git tag: v0.16)
> Backend description string: Linux zynqmp-debian 5.3.0-rc4-00004-ga7ca33daed22-dirty #41 SMP PREEMPT Mon Aug 12 15:06:58 CEST 2019 aarch64
> IIO context has 1 attributes:
> 	local,kernel: 5.3.0-rc4-00004-ga7ca33daed22-dirty
> IIO context has 1 devices:
> 	iio:device0: ina226 (buffer capable)
> 		9 channels found:
> 			voltage0:  (input, index: 0, format: le:U16/16>>0)
> 			3 channel-specific attributes found:
> 				attr  0: integration_time value: 0.001100
> 				attr  1: raw value: 70
> 				attr  2: scale value: 0.002500000
> 			voltage1:  (input, index: 1, format: le:U16/16>>0)
> 			3 channel-specific attributes found:
> 				attr  0: integration_time value: 0.001100
> 				attr  1: raw value: 958
> 				attr  2: scale value: 1.250000000
> 			power2:  (input, index: 2, format: le:U16/16>>0)
> 			2 channel-specific attributes found:
> 				attr  0: raw value: 3
> 				attr  1: scale value: 0.006250000
> 			current3:  (input, index: 3, format: le:U16/16>>0)
> 			2 channel-specific attributes found:
> 				attr  0: raw value: 70
> 				attr  1: scale value: 0.000250000
> 			timestamp:  (input, index: 4, format: le:S64/64>>0)
> 			allow:  (input)
> 			1 channel-specific attributes found:
> 				attr  0: async_readout value: 0
> 			oversampling:  (input)
> 			1 channel-specific attributes found:
> 				attr  0: ratio value: 4
> 			sampling:  (input)
> 			1 channel-specific attributes found:
> 				attr  0: frequency value: 114
> 			shunt:  (input)
> 			1 channel-specific attributes found:
> 				attr  0: resistor value: 10.000000000
> 		2 device-specific attributes found:
> 				attr  0: current_timestamp_clock value: realtime
> 
> 				attr  1: integration_time_available value: 0.000140 0.000204 0.000332 0.000588 0.001100 0.002116 0.004156 0.008244
> 		2 buffer-specific attributes found:
> 				attr  0: data_available value: 0
> 				attr  1: watermark value: 1
> 		1 debug attributes found:
> 				debug attr  0: direct_reg_access value: 0x4327
> ina226_fourth-isa-0000
> Adapter: ISA adapter
> in1:
>    in1_input: 0.000
> in2:
>    in2_input: 1.198
> power1:
>    power1_input: 0.000
> curr1:
>    curr1_input: 0.000
> ---
>   drivers/hwmon/iio_hwmon.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index f1c2d5faedf0..aedb95fa24e3 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -59,7 +59,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>   	struct iio_hwmon_state *st;
>   	struct sensor_device_attribute *a;
>   	int ret, i;
> -	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1;
> +	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1, power_i = 1;
>   	enum iio_chan_type type;
>   	struct iio_channel *channels;
>   	struct device *hwmon_dev;
> @@ -114,6 +114,10 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>   			n = curr_i++;
>   			prefix = "curr";
>   			break;
> +		case IIO_POWER:
> +			n = power_i++;
> +			prefix = "power";
> +			break;
>   		case IIO_HUMIDITYRELATIVE:
>   			n = humidity_i++;
>   			prefix = "humidity";
> 

