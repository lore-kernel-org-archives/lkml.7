Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885ACC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB24206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzE9eXUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfJGOYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:24:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40004 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJGOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:24:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so8762079pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 07:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GFF3pHQBdGHM++ZQ9i6RWEmkmg3jX//CqRDHbD8PwJI=;
        b=WzE9eXUbnUohkIhelRRPEUidxMKRXl8k7SmEvphUuhzwnl3uLaLhZ500BA/P6dSODM
         Rjt4clawMSAvb2oP/a78VIvnpgQiT53BkX2QNHiVRSSeA5q6F/BbvyZtpYBkqoPFUA5V
         pYx5KF1PevAGChYuk9A4ASAk1lUVuuYtfRZ1bNJkXP91oxQN13x1EhKjUq99R7NjazXN
         a/t0gidwwbUwHwV0en1yArumViWUkbpi/WHTMLXpP5Z9qf5NKHbMcS6BQSFtwTE143Jm
         O00dukpQ9JeUg5iFL/08C+ALsZRBN2/1+EykxkWyaaO/bjRItEI7pbd9Bpc4PtyPm+fL
         zIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GFF3pHQBdGHM++ZQ9i6RWEmkmg3jX//CqRDHbD8PwJI=;
        b=ipE0WMnZvmhxHRuUs4O3Ecmv3fc2Wd/YgIrJ5y3Y0IqD8/iQV+raqwuS9yh2Ru/cLp
         cdw+DK6No96SMQGcBwVqRIc7Lcmn4Y/KRIjyOmTBU9q3GAMP7VJmL86apDrczEOo0h2X
         Frr0aK68Ow0VGITOqW+5LjZNpiJhQFW9+miyniWeFELW3uMNPY2zJh/7rhCAFfbTN4QA
         kDTpwPNbsO/Zniiy5dUblF7voBuD3Ivsc5TL8jm/a6t+afxlV8QYaDNhUUwlatcJktMX
         +/KLXX9iBTAZlVQ0E4EfhPlx+Tjb8VnDtoROaiYpenl1qnMQ+LKWKARArl1mduB5u/Ae
         qfog==
X-Gm-Message-State: APjAAAVn6DETo2itUN8h70WYG7ofdVQqYu6GIkhDf7Qy+WIWih3ysZlu
        34LMUJpzY/wz5KOS2dAcxQs=
X-Google-Smtp-Source: APXvYqw14OvZyW18c78sMCbrCRBLGRMdY8GcDNiZZOn0eaJnk8WVnP2iNukFL8Q/jfv30pe4Ubmmbg==
X-Received: by 2002:a63:5552:: with SMTP id f18mr20668293pgm.437.1570458260137;
        Mon, 07 Oct 2019 07:24:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4sm12364990pja.29.2019.10.07.07.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 07:24:19 -0700 (PDT)
Date:   Mon, 7 Oct 2019 07:24:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: fixed: Prevent NULL pointer dereference when
 !CONFIG_OF
Message-ID: <20191007142418.GA1732@roeck-us.net>
References: <20190922022928.28355-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190922022928.28355-1-axel.lin@ingics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 10:29:28AM +0800, Axel Lin wrote:
> Use of_device_get_match_data which has NULL test for match before
> dereference match->data. Add NULL test for drvtype so it still works
> for fixed_voltage_ops when !CONFIG_OF.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/regulator/fixed.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> index d90a6fd8cbc7..f81533070058 100644
> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c
> @@ -144,8 +144,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct fixed_voltage_config *config;
>  	struct fixed_voltage_data *drvdata;
> -	const struct fixed_dev_type *drvtype =
> -		of_match_device(dev->driver->of_match_table, dev)->data;
> +	const struct fixed_dev_type *drvtype = of_device_get_match_data(dev);
>  	struct regulator_config cfg = { };
>  	enum gpiod_flags gflags;
>  	int ret;
> @@ -177,7 +176,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
>  	drvdata->desc.type = REGULATOR_VOLTAGE;
>  	drvdata->desc.owner = THIS_MODULE;
>  
> -	if (drvtype->has_enable_clock) {
> +	if (drvtype && drvtype->has_enable_clock) {
>  		drvdata->desc.ops = &fixed_voltage_clkenabled_ops;
>  
>  		drvdata->enable_clock = devm_clk_get(dev, NULL);
