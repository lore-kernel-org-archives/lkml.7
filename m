Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169F5C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAB821903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552752698;
	bh=pN5/Z/D07eYlj06vWV7BDIBSQmt0wgdaixM69uWgdBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xy7/sYaWRIdlswrc+sjldUscTY/jxUXXNkbryNZZzujLCGehGB/p7VRdye3eQYO2v
	 S3XBubwYLx3NxWHb879wgvlMUEndagBQIptyfK/mMG09/UdGXHMTGxSN3HJFgHLUZq
	 cjLys1T6yVcIEXb1vOMaSHAKQb0lwYHxPbV80MXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCPQLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfCPQLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:11:37 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9950321900;
        Sat, 16 Mar 2019 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552752696;
        bh=pN5/Z/D07eYlj06vWV7BDIBSQmt0wgdaixM69uWgdBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DLZDRLwOxtVvQlMx2vUkjhwcoOUQqcfErdL2M6W7CHlKwI7vGDNXRlrbNJGeSgxzs
         h22XTWFUutwPbUJPaoK+6tEKY+Tdgq38BaR1iFh6KTeaEsQY36HGSDmyqAbTeBIQWO
         0j8m60V9BYONwgRi3brcO8pb8+071kvD3yTs3e2o=
Date:   Sat, 16 Mar 2019 16:11:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] iio: cros_ec: Drop unnecessary include files
Message-ID: <20190316161130.623b6e53@archlinux>
In-Reply-To: <20190313114032.11455-1-enric.balletbo@collabora.com>
References: <20190313114032.11455-1-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 12:40:32 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> From: Guenter Roeck <groeck@chromium.org>
> 
> The cros_ec sensors drivers do not call any sysfs functions
> or use any sysfs defines, and thus do not need to include
> linux/sysfs.h. Also, some cros_ec drivers include linux/delay.h
> and is not used.
> 
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> [remove linux/delay.h]
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c                  | 1 -
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      | 2 --
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 1 -
>  drivers/iio/light/cros_ec_light_prox.c                    | 2 --
>  drivers/iio/pressure/cros_ec_baro.c                       | 1 -
>  5 files changed, 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 021f9f5cd3bb..3be10b121a28 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -29,7 +29,6 @@
>  #include <linux/mfd/cros_ec_commands.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/platform_device.h>
>  
>  #define DRV_NAME	"cros-ec-accel-legacy"
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 8d76afb87d87..7d3950952ae6 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -16,7 +16,6 @@
>   * EC about sensors data. Data access is presented through iio sysfs.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/common/cros_ec_sensors_core.h>
> @@ -30,7 +29,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> -#include <linux/sysfs.h>
>  
>  #define CROS_EC_SENSORS_MAX_CHANNELS 4
>  
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 414cc43c287e..c770a2a809d7 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -25,7 +25,6 @@
>  #include <linux/mfd/cros_ec_commands.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/platform_device.h>
>  
>  static char *cros_ec_loc[] = {
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index fd1609e975ab..7bb3078217b3 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -13,7 +13,6 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/common/cros_ec_sensors_core.h>
> @@ -28,7 +27,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> -#include <linux/sysfs.h>
>  
>  /*
>   * We only represent one entry for light or proximity. EC is merging different
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 87c07af9181f..886690785047 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -13,7 +13,6 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/common/cros_ec_sensors_core.h>

