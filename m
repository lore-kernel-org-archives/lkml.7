Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E580C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C893820821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC2hllZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfDPVsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:48:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44335 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPVsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:48:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so11031967pfm.11;
        Tue, 16 Apr 2019 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rjNkcZaJDRWMsDaeMv3CLw2qwaRAI5yEn/lOszydD+E=;
        b=HC2hllZHl1ASNpjSCw89mvnBjZY2/mvXkRzmHqeNaFhYHoe7oRvOAOWFSIQZg9tKjx
         V5tI6OqTPT+Z7wzQ2rq6TbbQ9ZH3PgzD0nF1rW46DT2cyRBgcSrxm9eFABCVlya985eu
         hrqV7aVihgZos7qCRtcrOm0iiBPvGQ/5TpJW6vdbyzPm+l/x2Go+p4PJ451S82KMfRdg
         4QTWrSD8b31eswCRVF8XJJjjbxhx4lxXhrFM4ZbTZ4PMBMSTjWWC/hvEKSdga6rXzm4g
         wjPcdBUq5FGiR3+soNvpqDqyZO7vAcdNRpz0GgRe4j+P/WSeYyijHj0qaPxcm/LX01G/
         /Thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rjNkcZaJDRWMsDaeMv3CLw2qwaRAI5yEn/lOszydD+E=;
        b=NimWDrcPkv3R21kZcgalIWZmNllu6V/5XaTYaycPfxroBrDnacJd1b6J/pr5nD5F2T
         vzcFG71OQhjPtxIVac8yZWMCZcFyCsl61mUPos5VUyAXdL41vtOt6X5AdclmwL9TRkSi
         smo99CO5AUbVwg/b98icVqmXhKT8xoLT8KrKhyFntJdPwacysv2/Rnn6sA0gULFSyqrl
         cAwcjft0RsGB02r6KxBSG83Sm3xPvz6QjoDDGAVCScE4v9Wr070qxZxfLivV4hr6x9xg
         w6iITKEnmco/BcqIM0knyxM1tNuKI8ETLdKe/iXVDYSZLeo5HVsAjT7mnl3B6XKDUmNW
         LiMA==
X-Gm-Message-State: APjAAAWH4PM2wCiwBs61TOkXUWNfDnLWVC0FSCD5qyE6DiaXVH0kHTk2
        1HDz7cMpJcX5vdIKbqRgggY=
X-Google-Smtp-Source: APXvYqxwf3UCuP8hZEfPrvXoQaT6keUNytCd+Mbxudx3csijWCnczPdzclvLf7tg3dPz4zjm8onySw==
X-Received: by 2002:a63:6a43:: with SMTP id f64mr46327527pgc.366.1555451320916;
        Tue, 16 Apr 2019 14:48:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p14sm71952254pfa.26.2019.04.16.14.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 14:48:40 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:48:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ruslan Babayev <ruslan@babayev.com>
Cc:     xe-linux-external@cisco.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] hwmon: (pmbus/tps40422) add support for output
 voltage margining
Message-ID: <20190416214838.GA30022@roeck-us.net>
References: <20190416183620.39950-4-ruslan@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416183620.39950-4-ruslan@babayev.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:36:19AM -0700, Ruslan Babayev wrote:
> TPS40422 has MFR_SPECIFIC registers STEP_VREF_MARGIN_HIGH and
> STEP_VREF_MARGIN_LOW, which are signed 16-bit in units of 2mV. This
> value is an offset from the nominal reference voltage of 600mV.
> 
> For instance, the default value of STEP_VREF_MARGIN_LOW is -30
> (decimal), which corresponds to a default margin low voltage of
> 600 - 30 * 2 = 540mV.
> 
> Introduce tps40422_{read/write}_word_data() callbacks to map the
> MFR_SPECIFIC registers to standard PMBUS_VOUT_MARGIN_HIGH and
> PMBUS_VOUT_MARGIN_LOW. For the latter, pmbus_core stores sensor data
> in linear16 format as specified in VOUT_MODE.  Note, that on TPS40422
> the exponent is fixed at (-9). The callbacks will perform the
> necessary conversions.
> 

As mentioned with the other patches, setting actual voltages using the
hwmon subsystem is not appropriate. I can understand the need or desire
to be able to set margin voltages, but the hardware monitoring subsystem
is about monitoring. I would suggest to look at regulator subsystem,
though I don't know if that supports setting margin voltages.
If it doesn't, it might be appropriate to add support there.

The actual support can still be implemented in the pmbus drivers, but not
using hwmon attributes.

Thanks,
Guenter

> Cc: xe-linux-external@cisco.com
> Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
> ---
>  drivers/hwmon/pmbus/tps40422.c | 54 ++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/tps40422.c b/drivers/hwmon/pmbus/tps40422.c
> index 32803825d47e..129d1b0e6b43 100644
> --- a/drivers/hwmon/pmbus/tps40422.c
> +++ b/drivers/hwmon/pmbus/tps40422.c
> @@ -21,16 +21,70 @@
>  #include <linux/i2c.h>
>  #include "pmbus.h"
>  
> +#define TPS40422_STEP_VREF_MARGIN_HIGH	0xd5
> +#define TPS40422_STEP_VREF_MARGIN_LOW	0xd6
> +#define TPS40422_VREF			600
> +
> +static int tps40422_read_word_data(struct i2c_client *client, int page, int reg)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_MARGIN_HIGH:
> +		reg = TPS40422_STEP_VREF_MARGIN_HIGH;
> +		break;
> +	case PMBUS_VOUT_MARGIN_LOW:
> +		reg = TPS40422_STEP_VREF_MARGIN_LOW;
> +		break;
> +	default:
> +		return -ENODATA;
> +	}
> +
> +	ret = pmbus_read_word_data(client, page, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = (TPS40422_VREF + ((s16)ret) * 2) << 9;
> +	ret = DIV_ROUND_CLOSEST(ret, 1000);
> +
> +	return ret;
> +}
> +
> +static int tps40422_write_word_data(struct i2c_client *client, int page,
> +				    int reg, u16 word)
> +{
> +	u16 val;
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_MARGIN_HIGH:
> +		reg = TPS40422_STEP_VREF_MARGIN_HIGH;
> +		break;
> +	case PMBUS_VOUT_MARGIN_LOW:
> +		reg = TPS40422_STEP_VREF_MARGIN_LOW;
> +		break;
> +	default:
> +		return -ENODATA;
> +	}
> +
> +	val = ((((long)word * 1000) >> 9) - TPS40422_VREF + 1) / 2;
> +	return pmbus_write_word_data(client, page, reg, val);
> +}
> +
> +
>  static struct pmbus_driver_info tps40422_info = {
>  	.pages = 2,
> +	.read_word_data = tps40422_read_word_data,
> +	.write_word_data = tps40422_write_word_data,
>  	.format[PSC_VOLTAGE_IN] = linear,
>  	.format[PSC_VOLTAGE_OUT] = linear,
>  	.format[PSC_TEMPERATURE] = linear,
>  	.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_TEMP2
>  		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_TEMP
> +		| PMBUS_HAVE_VOUT_MARGIN_HIGH | PMBUS_HAVE_VOUT_MARGIN_LOW
>  		| PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
>  	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_TEMP2
>  		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_TEMP
> +		| PMBUS_HAVE_VOUT_MARGIN_HIGH | PMBUS_HAVE_VOUT_MARGIN_LOW
>  		| PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
>  };
>  
> -- 
> 2.17.1
> 
