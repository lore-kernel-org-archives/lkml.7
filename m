Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E99C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5722075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfDOOjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:39:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45720 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOOjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:39:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 879CD2817D4
Subject: Re: [PATCH v3 1/2] power_supply: Add more charge types and
 CHARGE_CONTROL_* properties
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org,
        sre@kernel.org, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        groeck@google.com, dtor@google.com, sjg@chromium.org,
        jchwong@chromium.org
References: <20190412002055.92529-1-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <81dc9f50-b485-9a4c-d972-2652f6c24cd8@collabora.com>
Date:   Mon, 15 Apr 2019 16:39:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412002055.92529-1-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,


On 12/4/19 2:20, Nick Crews wrote:
> Add "Standard", "Adaptive", and "Custom" modes to the charge_type
> property, to expand the existing "Trickle" and "Fast" modes.
> In addition, add POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
> and POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD properties, to expand
> the existing CHARGE_CONTROL_* properties. I am adding them in order
> to support a new Chrome OS device, but these properties should be
> general enough that they can be used on other devices.
> 
> The meaning of "Standard" is obvious, but "Adaptive" and "Custom" are
> more tricky: "Adaptive" means that the charge controller uses some
> custom algorithm to change the charge type automatically, with no
> configuration needed. "Custom" means that the charge controller uses the
> POWER_SUPPLY_PROP_CHARGE_CONTROL_* properties as configuration for some
> other algorithm. For example, in the use case that I am supporting,
> this means the battery begins charging when the percentage
> level drops below POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD and
> charging ceases when the percentage level goes above
> POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD.
> 
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  drivers/power/supply/power_supply_sysfs.c |  4 +++-
>  include/linux/power_supply.h              | 10 ++++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index dce24f596160..6104a3f03d46 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -56,7 +56,7 @@ static const char * const power_supply_status_text[] = {
>  };
>  
>  static const char * const power_supply_charge_type_text[] = {
> -	"Unknown", "N/A", "Trickle", "Fast"
> +	"Unknown", "N/A", "Trickle", "Fast", "Standard", "Adaptive", "Custom"
>  };
>  
>  static const char * const power_supply_health_text[] = {
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
> index 2f9c201a54d1..d59205170232 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -40,11 +40,15 @@ enum {
>  	POWER_SUPPLY_STATUS_FULL,
>  };
>  
> +/* What algorithm is the charger using? */
>  enum {
>  	POWER_SUPPLY_CHARGE_TYPE_UNKNOWN = 0,
>  	POWER_SUPPLY_CHARGE_TYPE_NONE,
> -	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,
> -	POWER_SUPPLY_CHARGE_TYPE_FAST,
> +	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,	/* slow speed */
> +	POWER_SUPPLY_CHARGE_TYPE_FAST,		/* fast speed */
> +	POWER_SUPPLY_CHARGE_TYPE_STANDARD,	/* normal speed */
> +	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted speed */
> +	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* props */

You should probably add the info in Documentation/ABI/testing/sysfs-class-power
and add the new values in /sys/class/power_supply/<supply_name>/charge_type
propriety

>  };
>  
>  enum {
> @@ -121,6 +125,8 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */

This also needs to be documented in Documentation/ABI/testing/sysfs-class-power

>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
> 

Thanks,
 Enric
