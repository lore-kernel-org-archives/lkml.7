Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D407AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0AE21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfDWN4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:56:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52092 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfDWN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:56:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8BAD4278760
Subject: Re: [PATCH v5 2/3] power_supply: Add
 CHARGE_CONTROL_{START_THRESHOLD,END_THRESHOLD} properties
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org,
        sre@kernel.org, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org
References: <20190417214022.7jk3usygcpnls3pr@earth.universe>
 <20190418164314.161065-1-ncrews@chromium.org>
 <20190418164314.161065-2-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <7dd9a992-6542-5615-8b7d-ff110935d808@collabora.com>
Date:   Tue, 23 Apr 2019 15:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418164314.161065-2-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/4/19 18:43, Nick Crews wrote:
> Add POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
> and POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD properties, to expand
> the existing CHARGE_CONTROL_* properties. I am adding them in order
> to support a new Chrome OS device, but these properties should be
> general enough that they can be used on other devices.
> 
> When the charge_type is "Custom", the charge controller uses the
> POWER_SUPPLY_PROP_CHARGE_CONTROL_* properties as configuration for some
> other algorithm. For example, in the use case that I am supporting,
> this means the battery begins charging when the percentage
> level drops below POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD and
> charging ceases when the percentage level goes above
> POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD.
> 
> v5 changes:
> - Add the other missing CHARGE_CONTROL_* properties documentation in
>   a separate commit
> - Split up adding the charge types and adding the
>   POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD and
>   POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD properties into
>   two different commits.
> v4 changes:
> - Add documentation for the new properties, and add documentation for
>   the the previously missing charge_control_limit and
>   charge_control_limit_max properties.
> 
> Signed-off-by: Nick Crews <ncrews@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  Documentation/ABI/testing/sysfs-class-power | 20 ++++++++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  2 ++
>  include/linux/power_supply.h                |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 544c4e0ef8b6..a5b144f61de8 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -114,6 +114,26 @@ Description:
>  		Access: Read
>  		Valid values: Represented in microamps
>  
> +What:		/sys/class/power_supply/<supply_name>/charge_control_start_threshold
> +Date:		April 2019
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Represents a battery percentage level, below which charging will
> +		begin.
> +
> +		Access: Read, Write
> +		Valid values: 0 - 100 (percent)
> +
> +What:		/sys/class/power_supply/<supply_name>/charge_control_end_threshold
> +Date:		April 2019
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Represents a battery percentage level, above which charging will
> +		stop.
> +
> +		Access: Read, Write
> +		Valid values: 0 - 100 (percent)
> +
>  What:		/sys/class/power_supply/<supply_name>/charge_type
>  Date:		July 2009
>  Contact:	linux-pm@vger.kernel.org
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 64dff5cfecc3..6104a3f03d46 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -274,6 +274,8 @@ static struct device_attribute power_supply_attrs[] = {
>  	POWER_SUPPLY_ATTR(constant_charge_voltage_max),
>  	POWER_SUPPLY_ATTR(charge_control_limit),
>  	POWER_SUPPLY_ATTR(charge_control_limit_max),
> +	POWER_SUPPLY_ATTR(charge_control_start_threshold),
> +	POWER_SUPPLY_ATTR(charge_control_end_threshold),
>  	POWER_SUPPLY_ATTR(input_current_limit),
>  	POWER_SUPPLY_ATTR(energy_full_design),
>  	POWER_SUPPLY_ATTR(energy_empty_design),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index e86e05d8134d..d59205170232 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -125,6 +125,8 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
> 
