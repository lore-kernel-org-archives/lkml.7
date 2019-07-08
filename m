Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B697C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140C220656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs2Ah93r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbfGHQFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:05:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38524 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfGHQFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:05:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so1051081plb.5;
        Mon, 08 Jul 2019 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zj4h3LPFwWX/eUpF2K+qOBGx59jHvRg14Pyk3N6ZIj8=;
        b=Cs2Ah93rCf/JmPqAEHCi8TaA0qrOFhqaE5hmqN67kLV2wG8IVxSv1FOCkToM6klGMS
         /YaIg8vFcv6FWh8xwVfD2FPUtzykQLsLETpwwG4c9R3BEmTTtAwRaAzGdgtlHlXkImAI
         F1WzTwlRb//4YarU/QOUUEE2M2AK69iu2ItsTGuvNxVRVa3H+URF6XKHKZ7fQ+aWbFaI
         ky91CHbsurW0JSNx0/t2jawrFN/MXPdK/dBRD9asRGleMS2N7pzNupOMnonuoWMHVLbz
         qdjAWbE7b5bexbDBctTCFMFncQsO+0e2GUGsA4xAU7ElAt6IsCr24C4OC0GKUknqGEen
         6PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zj4h3LPFwWX/eUpF2K+qOBGx59jHvRg14Pyk3N6ZIj8=;
        b=OYUuuAX1tcBzBC5NV6fxdDuPrDpKTqGR4PnD2vwMsi4K06RxpafHDFRQBZIZU1WeTf
         0OXqR+wAI9+7HG8B7KLUCMk9zq47M9mSU/Zumnb2E85atoA0HjVyT2bHcvqRuRlP8xTy
         DQaO+8MCKh9u9w42t6+lV4bUV4fIVgZwh9qjyorfogEtUha7CDdY2Q8srn3D+VZT1eXz
         Ht/fOlMdnyqlU7rSUvMcefMpRoRpTvi9N2PWvTddiTurcAGR7jp0sowa3oLIqL8l2PQd
         e/zLT5iKilOx2V1heAU2vdQD1xDaxpz7Vwocbl4x1G9FrZrbENXaGS+tUNIWaYLz09rp
         4qOQ==
X-Gm-Message-State: APjAAAUc9ViP7GktujAP0BeTeYF7lkSpbADNNQGPp9cuiLMGa1F2nh4g
        6bfdWnZ9SSwwmm4O94G/pEI=
X-Google-Smtp-Source: APXvYqyTXYeYdUKJVxZlIQ1sQYegDbAsQ25fSAznBmuferVZ1DpzRqW+HYMbh+MGvB0mQxyasDEQeQ==
X-Received: by 2002:a17:902:5998:: with SMTP id p24mr25814533pli.110.1562601922829;
        Mon, 08 Jul 2019 09:05:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t2sm15708380pgo.61.2019.07.08.09.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 09:05:21 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:05:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 08/11] firmware: arm_scmi: Drop async flag in
 sensor_ops->reading_get
Message-ID: <20190708160520.GA6741@roeck-us.net>
References: <20190708154730.16643-1-sudeep.holla@arm.com>
 <20190708154730.16643-9-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708154730.16643-9-sudeep.holla@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 04:47:27PM +0100, Sudeep Holla wrote:
> SENSOR_DESCRIPTION_GET provides attributes to indicate if the sensor
> supports asynchronous read. Ideally we should be able to read that flag
> and use asynchronous reads for any sensors with that attribute set.
> 
> In order to add that support, let's drop the async flag passed to
> sensor_ops->reading_get and dynamically switch between sync and async
> flags based on the attributes as provided by the firmware.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  drivers/firmware/arm_scmi/sensors.c | 4 ++--
>  drivers/hwmon/scmi-hwmon.c          | 2 +-
>  include/linux/scmi_protocol.h       | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index 17dbabd8a94a..1b5757c77a35 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -211,7 +211,7 @@ scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
>  }
>  
>  static int scmi_sensor_reading_get(const struct scmi_handle *handle,
> -				   u32 sensor_id, bool async, u64 *value)
> +				   u32 sensor_id, u64 *value)
>  {
>  	int ret;
>  	struct scmi_xfer *t;
> @@ -225,7 +225,7 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
>  
>  	sensor = t->tx.buf;
>  	sensor->id = cpu_to_le32(sensor_id);
> -	sensor->flags = cpu_to_le32(async ? SENSOR_READ_ASYNC : 0);
> +	sensor->flags = cpu_to_le32(0);
>  
>  	ret = scmi_do_xfer(handle, t);
>  	if (!ret) {
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 0c93fc5ca762..8a7732c0bef3 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -72,7 +72,7 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  	const struct scmi_handle *h = scmi_sensors->handle;
>  
>  	sensor = *(scmi_sensors->info[type] + channel);
> -	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
> +	ret = h->sensor_ops->reading_get(h, sensor->id, &value);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index ea6b72018752..697e30fb9004 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -182,7 +182,7 @@ struct scmi_sensor_ops {
>  	int (*trip_point_config)(const struct scmi_handle *handle,
>  				 u32 sensor_id, u8 trip_id, u64 trip_value);
>  	int (*reading_get)(const struct scmi_handle *handle, u32 sensor_id,
> -			   bool async, u64 *value);
> +			   u64 *value);
>  };
>  
>  /**
> -- 
> 2.17.1
> 
