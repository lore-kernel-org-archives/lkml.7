Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BE5C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040EB20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfEPSCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:02:09 -0400
Received: from foss.arm.com ([217.140.101.70]:53688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfEPSCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:02:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 340FA19BF;
        Thu, 16 May 2019 11:02:09 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 692343F5AF;
        Thu, 16 May 2019 11:02:07 -0700 (PDT)
Subject: Re: [PATCH v2] gnss: get serial speed from subdrivers
To:     Loys Ollivier <lollivier@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Colin Ian King <colin.king@canonical.com>,
        linux-arm-kernel@lists.infradead.org
References: <1558024626-19395-1-git-send-email-lollivier@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <69b5e90c-c1c3-9f2e-57a8-64741182a96e@arm.com>
Date:   Thu, 16 May 2019 19:02:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558024626-19395-1-git-send-email-lollivier@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2019 17:37, Loys Ollivier wrote:
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
> Changes since v1[0]
> - Use u32 data types instead of uint
> 
> [0]: https://lore.kernel.org/lkml/1557322788-10403-1-git-send-email-lollivier@baylibre.com/
> 
> Cheers,
> Loys
> 
>   drivers/gnss/mtk.c    |  7 ++++++-
>   drivers/gnss/serial.c | 21 +++++++++++++--------
>   drivers/gnss/serial.h |  3 ++-
>   drivers/gnss/ubx.c    |  3 ++-
>   4 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
> index d1fc55560daf..1d35bcb52072 100644
> --- a/drivers/gnss/mtk.c
> +++ b/drivers/gnss/mtk.c
> @@ -16,6 +16,10 @@
>   
>   #include "serial.h"
>   
> +static uint serial_speed = 9600; /* Serial speed (baud rate) */
> +module_param(serial_speed, uint, 0644);
> +MODULE_PARM_DESC(serial_speed, "Serial baud rate (bit/s), (default = 9600)");
> +
>   struct mtk_data {
>   	struct regulator *vbackup;
>   	struct regulator *vcc;
> @@ -69,7 +73,8 @@ static int mtk_probe(struct serdev_device *serdev)
>   	struct mtk_data *data;
>   	int ret;
>   
> -	gserial = gnss_serial_allocate(serdev, sizeof(*data));
> +	gserial = gnss_serial_allocate(serdev, sizeof(*data),
> +				       (u32)serial_speed);
>   	if (IS_ERR(gserial)) {
>   		ret = PTR_ERR(gserial);
>   		return ret;
> diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> index def64b36d994..3be799702291 100644
> --- a/drivers/gnss/serial.c
> +++ b/drivers/gnss/serial.c
> @@ -103,17 +103,13 @@ static int gnss_serial_set_power(struct gnss_serial *gserial,
>   	return gserial->ops->set_power(gserial, state);
>   }
>   
> -/*
> - * FIXME: need to provide subdriver defaults or separate dt parsing from
> - * allocation.
> - */
>   static int gnss_serial_parse_dt(struct serdev_device *serdev)
>   {
>   	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
>   	struct device_node *node = serdev->dev.of_node;
> -	u32 speed = 4800;
> +	u32 speed;
>   
> -	of_property_read_u32(node, "current-speed", &speed);
> +	of_property_read_u32(node, "default-speed", &speed);
>   
>   	gserial->speed = speed;

Hmm, maybe it's a bit too convoluted for the compiler to warn about, but 
if a "default-speed" property is not present, gserial->speed will now be 
assigned an uninitialised value. I don't know what the intent is neither 
the driver nor the DT provides a value, but you'll either need to bring 
back the fallback initialisation above or propagate errors from 
of_property_read_u32().

Robin.

>   
> @@ -121,7 +117,8 @@ static int gnss_serial_parse_dt(struct serdev_device *serdev)
>   }
>   
>   struct gnss_serial *gnss_serial_allocate(struct serdev_device *serdev,
> -						size_t data_size)
> +					 size_t data_size,
> +					 u32 serial_speed)
>   {
>   	struct gnss_serial *gserial;
>   	struct gnss_device *gdev;
> @@ -146,10 +143,18 @@ struct gnss_serial *gnss_serial_allocate(struct serdev_device *serdev,
>   	serdev_device_set_drvdata(serdev, gserial);
>   	serdev_device_set_client_ops(serdev, &gnss_serial_serdev_ops);
>   
> -	ret = gnss_serial_parse_dt(serdev);
> +	/* Serial speed provided by subdriver takes precedence over dt*/
> +	if (!serial_speed)
> +		ret = gnss_serial_parse_dt(serdev);
> +	else
> +		gserial->speed = serial_speed;
> +
>   	if (ret)
>   		goto err_put_device;
>   
> +	if (!gserial->speed)
> +		return -EINVAL;
> +
>   	return gserial;
>   
>   err_put_device:
> diff --git a/drivers/gnss/serial.h b/drivers/gnss/serial.h
> index 980ffdc86c2a..17df61e399e6 100644
> --- a/drivers/gnss/serial.h
> +++ b/drivers/gnss/serial.h
> @@ -33,7 +33,8 @@ struct gnss_serial_ops {
>   extern const struct dev_pm_ops gnss_serial_pm_ops;
>   
>   struct gnss_serial *gnss_serial_allocate(struct serdev_device *gserial,
> -						size_t data_size);
> +					 size_t data_size,
> +					 u32 serial_speed);
>   void gnss_serial_free(struct gnss_serial *gserial);
>   
>   int gnss_serial_register(struct gnss_serial *gserial);
> diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
> index 7b05bc40532e..52ae6e4987e0 100644
> --- a/drivers/gnss/ubx.c
> +++ b/drivers/gnss/ubx.c
> @@ -68,8 +68,9 @@ static int ubx_probe(struct serdev_device *serdev)
>   	struct gnss_serial *gserial;
>   	struct ubx_data *data;
>   	int ret;
> +	u32 speed = 4800;
>   
> -	gserial = gnss_serial_allocate(serdev, sizeof(*data));
> +	gserial = gnss_serial_allocate(serdev, sizeof(*data), speed);
>   	if (IS_ERR(gserial)) {
>   		ret = PTR_ERR(gserial);
>   		return ret;
> 
