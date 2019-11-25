Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF09EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F92020740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfKYQa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:30:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60520 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfKYQa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:30:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D5AEC28A0E9
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec: Pass firmware node to MFD
 device
To:     Raul E Rangel <rrangel@chromium.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Akshu.Agrawal@amd.com, Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
References: <20191121211053.48861-1-rrangel@chromium.org>
 <20191121140830.3.I1fbda3ecf40f4631420cbb75ba830d2d3b3bac1e@changeid>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <86f40fab-3e68-bc1c-425b-94f681c7b6c6@collabora.com>
Date:   Mon, 25 Nov 2019 17:30:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121140830.3.I1fbda3ecf40f4631420cbb75ba830d2d3b3bac1e@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raul,

One comment below.

On 21/11/19 22:10, Raul E Rangel wrote:
> cros_ec_dev needs to have a firmware node associated with it so mfd
> cells can be properly bound to the correct ACPI/DT nodes.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
> Before this patch:
> $ find /sys/bus/platform/devices/cros-ec-* -iname firmware_node -exec ls -l '{}' \;
> <nothing>
> 
> After this patch:
> $ find /sys/bus/platform/devices/cros-ec-dev.0.auto/ -iname firmware_node -exec ls -l '{}' \;
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-accel.1.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-chardev.7.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-debugfs.8.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-gyro.2.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-lid-angle.4.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-lightbar.9.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-pd-sysfs.10.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-ring.3.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-sysfs.11.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-usbpd-charger.5.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-usbpd-logger.6.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/firmware_node -> ../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
> 
>  drivers/platform/chrome/cros_ec.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 51d76037f52a..3c08c9098d29 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -167,9 +167,16 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  	}
>  
>  	/* Register a platform device for the main EC instance */
> -	ec_dev->ec = platform_device_register_data(ec_dev->dev, "cros-ec-dev",
> -					PLATFORM_DEVID_AUTO, &ec_p,
> -					sizeof(struct cros_ec_platform));
> +	ec_dev->ec =
> +		platform_device_register_full(&(struct platform_device_info){
> +			.parent = ec_dev->dev,
> +			.name = "cros-ec-dev",
> +			.id = PLATFORM_DEVID_AUTO,
> +			.data = &ec_p,
> +			.size_data = sizeof(struct cros_ec_platform),
> +			.fwnode = ec_dev->dev->fwnode,
> +			.of_node_reused = 1});

Please create a local `struct platform_device_info`, fill and pass the &pdevinfo
in platform_device_register_full, I think is more clear.

Thanks,
 Enric

> +
>  	if (IS_ERR(ec_dev->ec)) {
>  		dev_err(ec_dev->dev,
>  			"Failed to create CrOS EC platform device\n");
> 
