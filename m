Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414F1C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F892053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyO3r8Sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEGNbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:31:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35993 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfEGNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:31:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id v80so8684214pfa.3;
        Tue, 07 May 2019 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pDfPW38KIL1dpHg7F2t1sYsKkAGlXFceYNzNKtg9UBI=;
        b=cyO3r8SjaSPvRgAnIrHKGrO5McmBXE+WgNeJJg+p7LUXjuglPx0pTYyxK9DRLM7qQL
         X+hnR2TsuMoSzC4XtSsRT4AYHD0Ace+teIBTvnvx+CTZp0a5HCsjLsHHLIMko8qMDNGc
         onbOQHHwLlaF7lk76q1lBaV9YtcJ+vr/Sq2Ittup/KNS/N/f8JchuewoPlD0KOyFraRN
         vUaADbkBjER77QoaMv2SazHjGquXwLSynG0QyGmBp14oyb/FwiPW51cXQMpJOOSPnyBs
         63qr5wtgj3PeIe8g14L4uCkqslg94SEQSzNqPxbwsiqCxZe4pjAqeuGtDWaWlvoeZHqr
         5T4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pDfPW38KIL1dpHg7F2t1sYsKkAGlXFceYNzNKtg9UBI=;
        b=HhkDz+/vfWCbOafvFt46PyhPPHDaHIVyq26Zi/Gvf5ls2fo/f8BbBWtKp+Akbjx++P
         KpMtI1uzR61d07kqF2vX2BP2ZLxul8QYjqW5QbH24Ixy4xGE9Z87wDijdZBCM11psUaw
         zn/Ohj5GS3gyG7ynMkVVt860lUa7nSk4wY7LTK24UuW//jkbpT+d8qfpcFjieazp5nra
         EpQVm6fpy2jU4myV8Wu5+phJDsSJQi6kku9EJh7JMJDoP4+xBAMYqZjGbn4qtDg9DlbG
         tHtr8+vCgN7V8UcxijJzipItBGCebQ//csMKPEOXFtC1Y/8k/+xRGOl5jeVVh1NGUo66
         oXcQ==
X-Gm-Message-State: APjAAAUKF/6c5ciO9/J2pL7mSDTGBAFmawm6KrkuULre27po74rZl255
        cpfoKIPAxhVAi5Jot7JNIOPGkfXi
X-Google-Smtp-Source: APXvYqzq+Z/Wj+qUOgwRvo3HHKRynDEDgnsJskGpr7/iplM2VPRNaEbMdqqGJgcNsTpPQurrvC4Eog==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr41241600pff.94.1557235868496;
        Tue, 07 May 2019 06:31:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o5sm34369209pfa.135.2019.05.07.06.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 06:31:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Fetch and store sensor scale
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
References: <20190506224109.9357-1-f.fainelli@gmail.com>
 <20190506224109.9357-2-f.fainelli@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <84470f47-4e65-80c4-d378-9b83b7f487fb@roeck-us.net>
Date:   Tue, 7 May 2019 06:31:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506224109.9357-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 3:41 PM, Florian Fainelli wrote:
> In preparation for dealing with scales within the SCMI HWMON driver,
> fetch and store the sensor unit scale into the scmi_sensor_info
> structure.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/firmware/arm_scmi/sensors.c | 7 ++++++-
>   include/linux/scmi_protocol.h       | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index b53d5cc9c9f6..f324f0a13ebe 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -33,7 +33,8 @@ struct scmi_msg_resp_sensor_description {
>   #define NUM_TRIP_POINTS(x)	(((x) >> 4) & 0xff)
>   		__le32 attributes_high;
>   #define SENSOR_TYPE(x)		((x) & 0xff)
> -#define SENSOR_SCALE(x)		(((x) >> 11) & 0x3f)
> +#define SENSOR_SCALE_MASK	0x3f
> +#define SENSOR_SCALE(x)		(((x) >> 11) & SENSOR_SCALE_MASK)
>   #define SENSOR_UPDATE_SCALE(x)	(((x) >> 22) & 0x1f)
>   #define SENSOR_UPDATE_BASE(x)	(((x) >> 27) & 0x1f)
>   		    u8 name[SCMI_MAX_STR_SIZE];
> @@ -140,6 +141,10 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
>   			s = &si->sensors[desc_index + cnt];
>   			s->id = le32_to_cpu(buf->desc[cnt].id);
>   			s->type = SENSOR_TYPE(attrh);
> +			s->scale = SENSOR_SCALE(attrh);
> +			/* Sign extend to a full u8 */
> +			if (s->scale & ((SENSOR_SCALE_MASK + 1) >> 1))

The logic here is quite confusing. I think it would be better to define,
say, SENSOR_SCALE_SIGN and use it.

> +				s->scale |= GENMASK(7, 6);
>   			strlcpy(s->name, buf->desc[cnt].name, SCMI_MAX_STR_SIZE);
>   		}
>   
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 3105055c00a7..7746f171f108 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -144,6 +144,7 @@ struct scmi_power_ops {
>   struct scmi_sensor_info {
>   	u32 id;
>   	u8 type;
> +	u8 scale;

Why not s8 if this is a signed value ?

Thanks,
Guenter

>   	char name[SCMI_MAX_STR_SIZE];
>   };
>   
> 

