Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5AEC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A4521738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfDWNz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:55:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52088 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfDWNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:55:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 21F53278760
Subject: Re: [PATCH v5 1/3] power_supply: Add Standard, Adaptive, and Custom
 charge types
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org,
        sre@kernel.org, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org
References: <20190417214022.7jk3usygcpnls3pr@earth.universe>
 <20190418164314.161065-1-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e5ec00fc-5075-85f7-4bd3-1745687f9a3e@collabora.com>
Date:   Tue, 23 Apr 2019 15:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418164314.161065-1-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/4/19 18:43, Nick Crews wrote:
> Add "Standard", "Adaptive", and "Custom" modes to the charge_type
> property, to expand the existing "Trickle" and "Fast" modes.
> I am adding them in order to support a new Chrome OS device,
> but these properties should be general enough that they can be
> used on other devices.
> 
> The meaning of "Standard" is obvious, but "Adaptive" and "Custom" are
> more tricky: "Adaptive" means that the charge controller uses some
> custom algorithm to change the charge type automatically, with no
> configuration needed. "Custom" means that the charge controller uses the
> POWER_SUPPLY_PROP_CHARGE_CONTROL_* properties as configuration for some
> other algorithm.
> 
> v5 changes:
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
>  Documentation/ABI/testing/sysfs-class-power | 12 +++++++++---
>  drivers/power/supply/power_supply_sysfs.c   |  2 +-
>  include/linux/power_supply.h                |  8 ++++++--
>  3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 5e23e22dce1b..544c4e0ef8b6 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -119,10 +119,16 @@ Date:		July 2009
>  Contact:	linux-pm@vger.kernel.org
>  Description:
>  		Represents the type of charging currently being applied to the
> -		battery.
> +		battery. "Trickle", "Fast", and "Standard" all mean different
> +		charging speeds. "Adaptive" means that the charger uses some
> +		algorithm to adjust the charge rate dynamically, without
> +		any user configuration required. "Custom" means that the charger
> +		uses the charge_control_* properties as configuration for some
> +		different algorithm.
>  
> -		Access: Read
> -		Valid values: "Unknown", "N/A", "Trickle", "Fast"
> +		Access: Read, Write
> +		Valid values: "Unknown", "N/A", "Trickle", "Fast", "Standard",
> +			      "Adaptive", "Custom"
>  
>  What:		/sys/class/power_supply/<supply_name>/charge_term_current
>  Date:		July 2014
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index dce24f596160..64dff5cfecc3 100644
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
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 2f9c201a54d1..e86e05d8134d 100644
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
>  };
>  
>  enum {
> 
