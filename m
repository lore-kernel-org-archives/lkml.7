Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1609C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A614220868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEnW0PE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfDPTkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:40:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43226 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPTkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:40:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so10820295pgu.10;
        Tue, 16 Apr 2019 12:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=20EwNywf3m8P4T0FJ/VzGkdxquhCrRE+pse6Cf24+X0=;
        b=VEnW0PE9d8x1tlqWkq6cgRRoNTY0bo4cNgszRh7h/yJRk6drqwERjev46mEL8mmE48
         E1TmwzBwRuKtqc9Pby1aYBnZl0XDFOXGspNuGYAM2UZU3IHiaxT+tFnbX2tfNDsTZ+TH
         Lk+7A58nrn0XvqTzMpf64vdaUMI1uscSEcSmH8rV3MO5e1yBXg5oFniZI2B91ei1T9bb
         bqIAsFZ/AqG+P9OxpV1rEGwTjmfj69dweD0w1eYUQfxflnXYqj2jwZZB2sgPoOVaeu74
         C65f2UrFNTl+tRtznBShRk+7JG212vqxa+oFUpALzA2iviJ59TaORfyHql/qMaMFPR95
         52rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=20EwNywf3m8P4T0FJ/VzGkdxquhCrRE+pse6Cf24+X0=;
        b=gUUCeF/71Ksz1nnYz2f5jA+TIL1KTaN44i9Xq2S2mwwSA1Ns++7RMXUCgTVGuxtkq1
         skwN1YCtiKV9r8NdWSXTwI90XOUR8L88oqUiNDLtRKKu0oPDxcGCyB/ki4YgMK5NJ55W
         r0qZcERY4WozS3v3M/eISPRUlHmkVTyUeEVTUoeOhItLYmPDuGW0saayMYr9N5JvTbqb
         KVlAU5fJUfXEfSVQZ5rdNd580ekWrTpmkOkiTkC1chMLp6QG3RMdJcFwcnLm5mZ2nwmo
         p+YpyliWvMy6GCDluLtx8yQFFzlmcK55nqpZmYpKobWA6EMeGmtj53p3x1TunIn4naoj
         RzHg==
X-Gm-Message-State: APjAAAWftH03PIK99fFfIb/lYSaQHbm4d4tCquTl7j0eul4sZhm+uHOS
        n4aQGQBHaCYmjlAOSu0vjqf2WKhV
X-Google-Smtp-Source: APXvYqwdRAbbQWSADv2xDu8Xk2Hi11MQ8eg+1GUWnQF0PK63xfLcu/isQuCgtyfsgKQcp+Lpt+7pOw==
X-Received: by 2002:a65:608a:: with SMTP id t10mr66423984pgu.125.1555443634409;
        Tue, 16 Apr 2019 12:40:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n3sm90913990pfa.99.2019.04.16.12.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 12:40:33 -0700 (PDT)
Date:   Tue, 16 Apr 2019 12:40:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ruslan Babayev <ruslan@babayev.com>
Cc:     xe-linux-external@cisco.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] hwmon: (pmbus) mark registers READ_VIN and READ_IIN
 as paged
Message-ID: <20190416194032.GB8093@roeck-us.net>
References: <20190416183620.39950-2-ruslan@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416183620.39950-2-ruslan@babayev.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:36:17AM -0700, Ruslan Babayev wrote:
> On some devices (like IR35215) READ_VIN and READ_IIN registers are
> paged.
> 
> For devices where these registers are not paged the extra check
> ensures we expose only the registers that are actually present.
> 
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index f35b239961e3..fac966967816 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1379,6 +1379,9 @@ static int pmbus_add_sensor_attrs(struct i2c_client *client,
>  		for (page = 0; page < pages; page++) {
>  			if (!(info->func[page] & attrs->func))
>  				continue;
> +			if (!pmbus_check_word_register(client, page,
> +						       attrs->reg))
> +				continue;

This won't work. Most other chips will just report the values from page 0
when trying to read VIN/IIN from other pages.

Guenter

>  			ret = pmbus_add_sensor_attrs_one(client, data, info,
>  							 name, index, page,
>  							 attrs);
> @@ -1498,6 +1501,7 @@ static const struct pmbus_sensor_attr voltage_attributes[] = {
>  		.reg = PMBUS_READ_VIN,
>  		.class = PSC_VOLTAGE_IN,
>  		.label = "vin",
> +		.paged = true,
>  		.func = PMBUS_HAVE_VIN,
>  		.sfunc = PMBUS_HAVE_STATUS_INPUT,
>  		.sbase = PB_STATUS_INPUT_BASE,
> @@ -1602,6 +1606,7 @@ static const struct pmbus_sensor_attr current_attributes[] = {
>  		.reg = PMBUS_READ_IIN,
>  		.class = PSC_CURRENT_IN,
>  		.label = "iin",
> +		.paged = true,
>  		.func = PMBUS_HAVE_IIN,
>  		.sfunc = PMBUS_HAVE_STATUS_INPUT,
>  		.sbase = PB_STATUS_INPUT_BASE,
> -- 
> 2.17.1
> 
