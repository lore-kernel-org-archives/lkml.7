Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D55EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB0A214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQmxEZhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfEHPxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:53:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44124 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfEHPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:53:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so2642241wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/INLHFLoO3fwx8sE75gtH7ePrD+/xqNv4SqcqLzKke8=;
        b=GQmxEZhssi+c6wCO0ryHOulQS9xtfLbea9bWWK3dnWvZa1Mr2LayNbiBL//0MiXoGR
         QvkuGYnR5H06nWZPMiGl/Er6W0EVzKZWGW8lURQRfQUfixDOOy7loSZ5fP1FnPlFzprJ
         8Wsr4/99zcCql7GKJRwPZmXvvVA0MUCG9PBEppYJqoBq5l6O3RX9VJU6XjYTEBC2c4Ul
         771AipqXZZ01pvfx3O8ZdqY0wze0k31qsdzDy6tcHFTSle4CjV4u2fUAavAudvmi6ngA
         WcIgemZm1zxjwXmhB+7e3WNbtaPpcKwa4Obmeo8+5DtqmFg2KstIrkkKiHyB8M1CSrDo
         GQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/INLHFLoO3fwx8sE75gtH7ePrD+/xqNv4SqcqLzKke8=;
        b=JI0RLYw98FsInFg/j72QSAUKPEN3Sk5IN+xNoHpluozkgf5bcgkWrSiicM4TWbdXVY
         qQcml/mx10zbJIieG3bZn2ojlKZzt6YNB5AGTlh/91JiEhYESeYXNEGIGMwufy8jilZS
         2aVr47CaMwe30tgyVsOYsBfDYLLVWg3uOzCv0xXj7Y7RGacWtdWbRtadjJNt5rWm7oRn
         WRbP++i/IxLNvdbPPe7mddBVoTMKEBfWYGS34n/LNPZUKcQTX1TYxWPpp/Pu8grWJuQk
         vvWINfIBfXtavMseLqf2io/VveSOlQn+7Rk+i7bv+A7GyeomRQoTSO71zub/jVoZqpFq
         kZVA==
X-Gm-Message-State: APjAAAXodlFc/BsSZrEnztxewJvvg13+X/vbD5KW7tsoEOcxug0md73I
        peXICoYViVMZ8Cin4dMfoNg=
X-Google-Smtp-Source: APXvYqyuKISPo+x4BFl9nEqc/t4WkE6l5uUP6rQxJIgo0rWfg1qBLWT64oRs+vPdbL/TkD99TG/c6w==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr28669098wro.206.1557330824343;
        Wed, 08 May 2019 08:53:44 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id c10sm36912386wrd.69.2019.05.08.08.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:43 -0700 (PDT)
Date:   Wed, 8 May 2019 17:53:41 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH] gnss: get serial speed from subdrivers
Message-ID: <20190508155341.GA1605@Red>
References: <1557322788-10403-1-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557322788-10403-1-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 03:39:48PM +0200, Loys Ollivier wrote:
> The default serial speed was hardcoded in the code.
> Rename current-speed to default-speed.
> Add a function parameter that lets the subdrivers specify their
> default speed.
> If not specified fallback to the device-tree default-speed.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> Hello,
> 
> This patch moves the currently hardcoded, default serial speed
> to the subdrivers.
> If the default speed is not specified by the subdriver then it is read
> from the device tree.
> 
> Cheers,
> Loys
> 
>  drivers/gnss/mtk.c    |  6 +++++-
>  drivers/gnss/serial.c | 21 +++++++++++++--------
>  drivers/gnss/serial.h |  3 ++-
>  drivers/gnss/ubx.c    |  3 ++-
>  4 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
> index d1fc55560daf..a1a89f0cc75c 100644
> --- a/drivers/gnss/mtk.c
> +++ b/drivers/gnss/mtk.c
> @@ -16,6 +16,10 @@
>  
>  #include "serial.h"
>  
> +static uint serial_speed = 9600; /* Serial speed (baud rate) */
> +module_param(serial_speed, uint, 0644);
> +MODULE_PARM_DESC(serial_speed, "Serial baud rate (bit/s), (default = 9600)");
> +
>  struct mtk_data {
>  	struct regulator *vbackup;
>  	struct regulator *vcc;
> @@ -69,7 +73,7 @@ static int mtk_probe(struct serdev_device *serdev)
>  	struct mtk_data *data;
>  	int ret;
>  
> -	gserial = gnss_serial_allocate(serdev, sizeof(*data));
> +	gserial = gnss_serial_allocate(serdev, sizeof(*data), serial_speed);
>  	if (IS_ERR(gserial)) {
>  		ret = PTR_ERR(gserial);
>  		return ret;
> diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> index def64b36d994..706fc5b46811 100644
> --- a/drivers/gnss/serial.c
> +++ b/drivers/gnss/serial.c
> @@ -103,17 +103,13 @@ static int gnss_serial_set_power(struct gnss_serial *gserial,
>  	return gserial->ops->set_power(gserial, state);
>  }
>  
> -/*
> - * FIXME: need to provide subdriver defaults or separate dt parsing from
> - * allocation.
> - */
>  static int gnss_serial_parse_dt(struct serdev_device *serdev)
>  {
>  	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
>  	struct device_node *node = serdev->dev.of_node;
> -	u32 speed = 4800;
> +	uint speed;
>  
> -	of_property_read_u32(node, "current-speed", &speed);
> +	of_property_read_u32(node, "default-speed", &speed);

Hello

of_property_read_u32 use u32, so no reason to use uint instead.

Regards

