Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1DFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B862921743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0tA+7nA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbfHVOKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:10:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38848 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733177AbfHVOKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:10:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id w11so3077466plp.5;
        Thu, 22 Aug 2019 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GnvU3JQHw+wR90RQOXRqRxk4bWPRr/n+YnICw4YFpyY=;
        b=S0tA+7nA9U2zwH8rFTNYMVfPx3zxD1MYd7Ufa47H6S8V/d7lofEFnszCH+dkPaOpP/
         ELuG+oAr9pwaPPtkKyCYGRyyREKZvkI3QnH8m+YTVVmcCK8X5DbUK/oKc7CJifsglBs6
         cOfsW/MuZoM4VHilJQlY3Nb4TqQOrCkLxYdixDkLvYuSZ3j0WFmXXlL6GmqdebyBGPND
         0fsLMuOFli4DtBFQduySIQePoF3aghSQcfSeOSQ8QTiYmBqEsMAbt7jhhZI7ltakmCl/
         6Uet50q712p6wAhe3CrEQbiLDIcxiDMFMNQMhHTj9tlhan/IkNYPoZd2gdO89suWT+ni
         El+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GnvU3JQHw+wR90RQOXRqRxk4bWPRr/n+YnICw4YFpyY=;
        b=S6DtyDCziwMOVbqeAGh7sEiriDRAFUUR0pK+xOtRHlBX0Th6Y5DTpJJq1l8yYe3RG4
         VSkSl95gnKBNrz8rw0YATK/RToDZcpflnHyesxYHJnp/WtHdiKWRGNls6u8+5GnSXs4f
         odN9RJmp3raO/WUxqrygS9sUZIDjh+j1M50y9D58AXUd45Ey5QkDTTEI2ewbszDX5PU5
         AiBRWVfF8OSgaUCwXvO1n9Mqlf69yfGjxRHwNT6O1UCiVfE4HJWI54M6b6W59W9J+vrO
         IA1aGCsqW0Xcj9ylXMwEOp0SiOYvobgokPX9F0Y2p5D11PZyJ+vJcsUfuWTU2vDN8pbh
         6jGQ==
X-Gm-Message-State: APjAAAWgWDJ6KREc2eJZtIUKqtrlSPPei+GorkYhuVutMwXqxaX8xPlg
        IaTEIJyQhG2cyUazKyIHvRWi2dsRFuY=
X-Google-Smtp-Source: APXvYqwCOD8NfosHehfRRT3Hee8HHgnTaaHtuG2G5EKa6aCEP7NvElSyZeeS6CUkQhbP/rL4JkD99g==
X-Received: by 2002:a17:902:4381:: with SMTP id j1mr37835715pld.4.1566483041130;
        Thu, 22 Aug 2019 07:10:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d128sm22544247pfa.42.2019.08.22.07.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 07:10:40 -0700 (PDT)
Date:   Thu, 22 Aug 2019 07:10:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: Re: [RFC PATCH] hwmon: (iio_hwmon) Enable power exporting from IIO
Message-ID: <20190822141039.GD8144@roeck-us.net>
References: <71aec0191e0e5f32cc760f95844d8ee215b48c7f.1565616579.git.michal.simek@xilinx.com>
 <906edfa3-9e7d-e8cc-29e3-e428b79ed0c2@roeck-us.net>
 <2bbbc5e9-7f11-1522-b827-0c0614bb9b69@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bbbc5e9-7f11-1522-b827-0c0614bb9b69@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 03:43:39PM +0200, Michal Simek wrote:
> On 20. 08. 19 17:39, Guenter Roeck wrote:
> > On 8/12/19 6:29 AM, Michal Simek wrote:
> >> There is no reason why power channel shouldn't be exported as is done for
> >> voltage, current, temperature and humidity.
> >>
> >> Power channel is available on iio ina226 driver.
> >>
> >> Tested on Xilinx ZCU102 board.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >>
> >> But I don't think values are properly converted. Voltage1 is fine but the
> >> rest is IMHO wrong. But this patch should enable power channel to be
> >> shown
> >> which looks good.
> >>
> > 
> > No idea what is going on there. I don't really know what "scaled" units
> > the iio subsystem reports. power is supposed to be reported to user space
> > in micro-Watt. Is that what the scaled value from iio reports ?
> 
> I have take a look at it again.
> 
> root@zynqmp-debian:~/libiio/examples# sensors ina226_u76-*
> ina226_u76-isa-0000
> Adapter: ISA adapter
> in1:          +0.01 V
> in2:          +0.85 V
> power1:        1.16 mW
> curr1:        +1.60 A
> 
> from iio_monitor
> voltage0          0.007 V
> voltage1          0.848 V
> power2            1.150 W
> current3          1.361 A
> 
> from iio_info
>  IIO context has 18 devices:
> 	iio:device0: ps_pmbus (buffer capable)
> 		9 channels found:
> 			voltage0:  (input, index: 0, format: le:U16/16>>0)
> 			3 channel-specific attributes found:
> 				attr  0: integration_time value: 0.001100
> 				attr  1: raw value: 3152
> 				attr  2: scale value: 0.002500000
> 			voltage1:  (input, index: 1, format: le:U16/16>>0)
> 			3 channel-specific attributes found:
> 				attr  0: integration_time value: 0.001100
> 				attr  1: raw value: 678
> 				attr  2: scale value: 1.250000000
> 			power2:  (input, index: 2, format: le:U16/16>>0)
> 			2 channel-specific attributes found:
> 				attr  0: raw value: 106
> 				attr  1: scale value: 12.500000000
> 			current3:  (input, index: 3, format: le:U16/16>>0)
> 			2 channel-specific attributes found:
> 				attr  0: raw value: 3152
> 				attr  1: scale value: 0.500000000
> 
> 
> And if you look at power2 (in iio_info) then you see that calculation is
> returning mili-Watts not micro-Watts.
> 
> And looking at it back it is also said there.
> 
> What:           /sys/bus/iio/devices/iio:deviceX/in_powerY_raw
> KernelVersion:  4.5
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 Raw (unscaled no bias removal etc.) power measurement from
>                 channel Y. The number must always be specified and
>                 unique to allow association with event codes. Units after
>                 application of scale and offset are milliwatts.
> 
> That means for power channel value needs to be multiply by 1000.
> 
> Are you OK with this solution?
> 
Yes, looks good.

Thanks,
Guenter

> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index aedb95fa24e3..7ea105bd195b 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -44,12 +44,20 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
>         int ret;
>         struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
>         struct iio_hwmon_state *state = dev_get_drvdata(dev);
> +       struct iio_channel *chan = &state->channels[sattr->index];
> +       enum iio_chan_type type;
> 
> -       ret = iio_read_channel_processed(&state->channels[sattr->index],
> -                                       &result);
> +       ret = iio_read_channel_processed(chan, &result);
>         if (ret < 0)
>                 return ret;
> 
> +       ret = iio_get_channel_type(chan, &type);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (type == IIO_POWER)
> +               result *= 1000;
> +
>         return sprintf(buf, "%d\n", result);
>  }
> 
> 
> Thanks,
> Michal
