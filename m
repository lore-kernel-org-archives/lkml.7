Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F344BC04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74DE205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaRMlWlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfEHSdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:33:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34805 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbfEHSdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:33:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so2378844pfa.1;
        Wed, 08 May 2019 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LXVN51kMKLvBL0dLpkFPlbcwdq5OBL6dF2S+lH8NdUo=;
        b=ZaRMlWlOGVEUY3p5rJSP6iKCWgdPtK0sc4DCqjlykzCgXWTRMXxeNhpUyB4ixEHNB6
         gH4XWt6y/GSRy5WCwTplMPe9wbzxFiqU7Jg1/RawWpNcL0QVzvfpo8B/i1g/2lNF2cRQ
         eMfJ/ofhPMCZg7CaMCTZ1UjlwwE4QGmqeENBMgAtcFkBVRfuzkqCkY/q4OlBjxam9n4W
         oCYdSv4u0w1gsOSxi7Yg0VC0zqxIZw8ztnwlmDcBY/ufYQPeamaJkltZd1t7bwA1SPAg
         ABrGfRd1IQJqYkBqaXTUDO+nvXEYqQccAeJ2p7uP7bRU2aWqqS5gKQfuJZie4OpTUUXy
         GzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LXVN51kMKLvBL0dLpkFPlbcwdq5OBL6dF2S+lH8NdUo=;
        b=lfISUm+raNtu9ggU8lrlCQc8K6D8D73mfvBzows623hEDXHeuniu5bsXLyEZiBLg6C
         e4NDo3Ebyifh+TYZoJDMBjc2vw64a98FZbQNxRVX7+5beATUhYlB/ufLXudeQFW5FwQm
         u7GiEdjRs7YCPgt5MJttO6wtaBuDgRbEvY7c5Ph8MtTLqzewz/cUTfDpaf3v4eXQTPE9
         KryKVlbT6gWvOOGfGqFWOA2xGqd2uyiLBHbmxLRD8C65DdC6/UcZ41kLSG6FcyLBkY7O
         ETbw39FoACB9nd23QerJs15VTlbJ0c0Fi4NVXTNhMUnXdGj33mlPRWv5PYxDUB8lLijy
         o8cQ==
X-Gm-Message-State: APjAAAV9hyIbvURtWAbpx8i1FSjpt7Wjhpy5aoRCyxzrX/p+U872cSXE
        FceO39NTCRhjQqif2rfqnx4=
X-Google-Smtp-Source: APXvYqyBXVmlCGWEwfHRd1cbvSu1ihTjoAjh6LF5aQaY9Zid88MQ3NlobG8YJzU+ahGXYu1ABzUIGA==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr49249065pgl.103.1557340412681;
        Wed, 08 May 2019 11:33:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k26sm21005811pfi.136.2019.05.08.11.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:33:32 -0700 (PDT)
Date:   Wed, 8 May 2019 11:33:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] firmware: arm_scmi: Fetch and store sensor scale
Message-ID: <20190508183331.GB25133@roeck-us.net>
References: <20190508170035.19671-1-f.fainelli@gmail.com>
 <20190508170035.19671-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508170035.19671-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 10:00:34AM -0700, Florian Fainelli wrote:
> In preparation for dealing with scales within the SCMI HWMON driver,
> fetch and store the sensor unit scale into the scmi_sensor_info
> structure. In order to simplify computations for upper layer, take care
> of sign extending the scale to a full 8-bit signed value.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/firmware/arm_scmi/sensors.c | 6 ++++++
>  include/linux/scmi_protocol.h       | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index b53d5cc9c9f6..21353470a740 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -34,6 +34,8 @@ struct scmi_msg_resp_sensor_description {
>  		__le32 attributes_high;
>  #define SENSOR_TYPE(x)		((x) & 0xff)
>  #define SENSOR_SCALE(x)		(((x) >> 11) & 0x3f)
> +#define SENSOR_SCALE_SIGN	BIT(5)
> +#define SENSOR_SCALE_EXTEND	GENMASK(7, 6)
>  #define SENSOR_UPDATE_SCALE(x)	(((x) >> 22) & 0x1f)
>  #define SENSOR_UPDATE_BASE(x)	(((x) >> 27) & 0x1f)
>  		    u8 name[SCMI_MAX_STR_SIZE];
> @@ -140,6 +142,10 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
>  			s = &si->sensors[desc_index + cnt];
>  			s->id = le32_to_cpu(buf->desc[cnt].id);
>  			s->type = SENSOR_TYPE(attrh);
> +			s->scale = SENSOR_SCALE(attrh);
> +			/* Sign extend to a full s8 */
> +			if (s->scale & SENSOR_SCALE_SIGN)
> +				s->scale |= SENSOR_SCALE_EXTEND;
>  			strlcpy(s->name, buf->desc[cnt].name, SCMI_MAX_STR_SIZE);
>  		}
>  
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 3105055c00a7..9ff2e9357e9a 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -144,6 +144,7 @@ struct scmi_power_ops {
>  struct scmi_sensor_info {
>  	u32 id;
>  	u8 type;
> +	s8 scale;
>  	char name[SCMI_MAX_STR_SIZE];
>  };
>  
> -- 
> 2.17.1
> 
