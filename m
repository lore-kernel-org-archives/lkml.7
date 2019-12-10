Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4C2C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3342077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUlhrTXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfLJSGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:06:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45878 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfLJSGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:06:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so205164pfg.12;
        Tue, 10 Dec 2019 10:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x7cIa0Gzn0+ggjSlshOSNWW2DeHmjBusnX3y5xYnnNA=;
        b=mUlhrTXes8jVFg4L6+rLWVW26Lh2269clAptABJVM2oyEg8udRfNi2y73zs4hHISPb
         7Bb/SguG1CqWrG3WJLs6q+xjK4+RIfHiuofgTGhDCvukpoGMmA5eumAtAum/4gibEjyg
         aA0oocBZNx1VzdngLJaVlOzUErI65h1c999OMuHxGdyawbnxg972nEmf4XzSkSB1w4bU
         Gn/gfU00vo0/z98UGEaaCYLFovqPk0vTPX0akm4m11RbNiB8eW+AZ+HdhJtHOJxyfHfz
         THJQ9THOAYmU5lz1BhVweTfx1hV4q8aWQFu/YTs1DdV+XzWeVVKihofX5mwAytXS0BEW
         cSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=x7cIa0Gzn0+ggjSlshOSNWW2DeHmjBusnX3y5xYnnNA=;
        b=ucFRgMP8yacLpG1iOC09ZMOPRga19OHyb6xvc61bp8Y178zYAReBlm3lFahvKcFp+v
         ozunIs21gWZSRB9Tmo1Am+foJKpEAaiDzr3CX4GlxXuH2eEKUJpIiZmTylUzcC2CEU/L
         4EHNW+7CRFGjWakSlvQzsZVxpaRoY2GtDq9e4nIzkRBGExA55yOIznz9WEqjUbfj4xJF
         lg+SMO7AZenyXkM/6pMM91JyaSBjK4vXBmjYkMv0TuODQ5TNAiuhCVAHNJsrrSTTx4sI
         Mv33LrLnEJgE0+U/uFvQP4G8EiDnhjbX91qqJ5o1LtO6GdNxl6JzONdEoE1zmRuQFncZ
         mmZA==
X-Gm-Message-State: APjAAAUQER4xxCnytNXTUrEcyxghx9wGhmIWbm8aaSXNBhpqZfTEazjl
        7hiRgB0jcIJfv9L0m0Rjvfsqa2/y
X-Google-Smtp-Source: APXvYqxzzdfr2oH3/kuV7D4wmhCdZY4HFSokyE6BHuOFh2/Njgmy1jZsyEVBEBDBISMut4upwDfKrQ==
X-Received: by 2002:a63:f814:: with SMTP id n20mr25713115pgh.318.1576001205971;
        Tue, 10 Dec 2019 10:06:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p16sm4068546pgm.8.2019.12.10.10.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 10:06:44 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:06:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 14/15] hwmon: (scmi-hwmon) Match scmi device by both name
 and protocol id
Message-ID: <20191210180643.GA10944@roeck-us.net>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-15-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210145345.11616-15-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 02:53:44PM +0000, Sudeep Holla wrote:
> The scmi bus now has support to match the driver with devices not only
> based on their protocol id but also based on their device name if one is
> available. This was added to cater the need to support multiple devices
> and drivers for the same protocol.
> 
> Let us add the name "hwmon" to scmi_device_id table in the driver so
> that in matches only with device with the same name and protocol id
> SCMI_PROTOCOL_SENSOR. This will help to add IIO support in parallel if
> needed.

If you are planning to re-implement the driver as iio driver, it would
make more sense to drop the hwmon driver entirely and use the iio->hwmon
bridge to access the sensors as hwmon devices if needed.

Guenter

> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/hwmon/scmi-hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 8a7732c0bef3..286d3cfda7de 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -259,7 +259,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>  }
> 
>  static const struct scmi_device_id scmi_id_table[] = {
> -	{ SCMI_PROTOCOL_SENSOR },
> +	{ SCMI_PROTOCOL_SENSOR, "hwmon" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> --
> 2.17.1
> 
