Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE89EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FF920652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="algH9MDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfCERLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:11:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40984 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfCERLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:11:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id t7so8058639otk.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 09:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8av4wPIysTYdmMTalnZWD47rjObkEkTQ41ECs56Bw1Q=;
        b=algH9MDYsLTxaATTNb9vRZ0p763Y4Qrv186vFTGXeUUNvOX1Lk0qim1qQxaeNaaJ9d
         iHIUirHZXzaoL4uUNBgHQqLjXzyY1ejA32I6S7wamrdq6bJoXUx3Y0sJZI6HPCBHEQK5
         9Ywmz/EGeTn1n76jCWVwKvyoZj7kAnwktqDMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8av4wPIysTYdmMTalnZWD47rjObkEkTQ41ECs56Bw1Q=;
        b=Zx8HUf/EMkgk5H7gzFDuTySWksoNiYKj1wG5W1NG2vqVQ6MNN+m6TqSBr9rxyTqYrs
         5sg6c7lW7G5TYH6DHARyAoacuJgigtIrLD7Tg3t0E0+oR4tpEnw2ksezLlm5Ce0p9CsP
         91ky6NZMQdcQYru0+SKqqymrswyXFM4LPDeH6T9b3iWKzMTwlQD7mWe+ynsFO+qEujFO
         cM3EToaplQ0kYsmD0pKOaoXHKB8m4tmtmvU2Dwq+9Pnd6+rKwnpaLyvCJzdE6kZzYug2
         u7tY6N4ModEzxuG6Tu1bLSr/X2GXHStLGtCnTUSaBXshhr6bDrn/xBv4IzENR7vGVCEt
         Lxxw==
X-Gm-Message-State: APjAAAVjiEPo7GX2hagRlqXOirGOnYIocIE3G9dGbAzvURUw46laJ2A9
        264Oveu+4AVRb7IP2GnG3CBPxbyV0Ug=
X-Google-Smtp-Source: APXvYqxh34hwFMJDuma0kWtl5OnzZTbddVlX+tjjd3eLVrLYDlR56eSnQfi/84WVCRfybA5MlMAr7w==
X-Received: by 2002:a9d:7596:: with SMTP id s22mr1602176otk.359.1551805909723;
        Tue, 05 Mar 2019 09:11:49 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id 60sm4014194otw.50.2019.03.05.09.11.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 09:11:48 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id i5so8057059oto.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 09:11:47 -0800 (PST)
X-Received: by 2002:a9d:714c:: with SMTP id y12mr1569353otj.114.1551805907202;
 Tue, 05 Mar 2019 09:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20190222231033.102337-1-ncrews@chromium.org> <20190222231033.102337-2-ncrews@chromium.org>
In-Reply-To: <20190222231033.102337-2-ncrews@chromium.org>
From:   Nick Crews <ncrews@chromium.org>
Date:   Tue, 5 Mar 2019 10:11:35 -0700
X-Gmail-Original-Message-ID: <CAHX4x85B9AbVNJgHeKpuZhDKcQQhrHZLuMXRZ4214YCF5tU68Q@mail.gmail.com>
Message-ID: <CAHX4x85B9AbVNJgHeKpuZhDKcQQhrHZLuMXRZ4214YCF5tU68Q@mail.gmail.com>
Subject: Re: [RFC power_supply 2/2] platform/chrome: Add Peak Shift and Adv
 Batt Charging for Wilco EC
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Oleh Lamzin <lamzin@google.com>,
        Bartosz Fabianowski <bartfab@google.com>,
        Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly bump to make sure this doesn't slip down peoples' inboxes.
Any comments would be appreciated :)

-Nick
On Fri, Feb 22, 2019 at 4:10 PM Nick Crews <ncrews@chromium.org> wrote:
>
> This is an example driver that uses the proposed Peak Shift and
> Adv Batt Charging support in the main power supply subsystem.
>
> At this point, there is no actual communication with the EC,
> the point of this is to show the interface that usespace would see,
> and to show the use case for the added properties to the power
> supply susbsystem. To see the location of where the properties
> would appear in userspace, see the Documentation file.
>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  .../ABI/testing/sysfs-class-power-wilco       |  81 +++++++
>  drivers/platform/chrome/wilco_ec/Kconfig      |  14 ++
>  drivers/platform/chrome/wilco_ec/Makefile     |   2 +
>  .../platform/chrome/wilco_ec/advanced_power.c | 199 ++++++++++++++++++
>  drivers/platform/chrome/wilco_ec/core.c       |  14 ++
>  include/linux/platform_data/wilco-ec.h        |   2 +
>  6 files changed, 312 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-wilco
>  create mode 100644 drivers/platform/chrome/wilco_ec/advanced_power.c
>
> diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Documentation/ABI/testing/sysfs-class-power-wilco
> new file mode 100644
> index 000000000000..5c96b28aa597
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-wilco
> @@ -0,0 +1,81 @@
> +What:          /sys/class/power_supply/wilco_adv_power/peak_shift_sched_<day of week>
> +Date:          January 2019
> +KernelVersion: 4.19
> +Description:
> +               For each weekday a start and end time to run in Peak Shift mode
> +               can be set. During these times the system will run from the
> +               battery even if the AC is attached as long as the battery stays
> +               above the threshold specified. After the end time specified the
> +               system will run from AC if attached but will not charge the
> +               battery. The system will again function normally using AC and
> +               recharging the battery after the specified Charge Start time.
> +
> +               The input buffer must have the format "start_hr start_min end_hr
> +               end_min charge_start_hr charge_start_min" The hour fields must
> +               be in the range [0-23], and the minutes must be one of (0, 15,
> +               30, 45). The string must be parseable by sscanf() using the
> +               format string "%d %d %d %d %d %d". An example valid input is
> +               "6 15   009 45 23 0", which corresponds to 6:15, 9:45, and 23:00
> +
> +               The output buffer will be filled with the format "start_hr
> +               start_min end_hr end_min charge_start_hr charge_start_min" The
> +               hour fields will be in the range [0-23], and the minutes will be
> +               one of (0, 15, 30, 45). Each number will be zero padded to two
> +               characters. An example output is "06 15 09 45 23 00", which
> +               corresponds to 6:15, 9:45, and 23:00
> +
> +What:          /sys/class/power_supply/wilco_adv_power/peak_shift_enable
> +Date:          January 2019
> +KernelVersion: 4.19
> +Description:
> +               Enable/disable the peakshift power management policy.
> +
> +               Input should be parseable by kstrtou8().
> +               Output will be either "0\n" or "1\n".
> +
> +What:          /sys/class/power_supply/wilco_adv_power/peak_shift_batt_threshold
> +Date:          January 2019
> +KernelVersion: 4.19
> +Description:
> +               Read/write the battery percentage threshold for which the
> +               peakshift policy is used. The valid range is [15, 50].
> +
> +               Input should be parseable to range [15,50] by kstrtou8().
> +               Output will be two-digit ascii number in range [15, 50].
> +
> +What:          /sys/class/power_supply/wilco_adv_power/adv_batt_charging_sched_<day of week>
> +Date:          January 2019
> +KernelVersion: 4.19
> +Description:
> +               Advanced Charging Mode allows the user to maximize the battery
> +               health. In Advanced Charging Mode the system will use standard
> +               charging algorithm and other techniques during non-work hours to
> +               maximize battery health. During work hours, an express charge is
> +               used. This express charge allows the battery to be charged
> +               faster; therefore, the battery is at full charge sooner. For
> +               each day the time in which the system will be most heavily used
> +               is specified by the start time and the duration.
> +
> +               The input buffer must have the format "start_hr start_min
> +               duration_hr duration_min" The hour fields must be in the range
> +               [0-23], and the minutes must be one of (0, 15, 30, 45). The
> +               string must be parseable by sscanf() using the format string
> +               "%d %d %d %d %d %d". An example valid input is "0006 15  23 45",
> +               which corresponds to a start time of 6:15 and a duration of
> +               23:45.
> +
> +               The output buffer will be filled with the format "start_hr
> +               start_min duration_hr duration_min" The hour fields will be in
> +               the range [0-23], and the minutes will be one of (0, 15, 30,
> +               45). Each number will be zero padded to two characters. An
> +               example output is "06 15 23 45", which corresponds to a start
> +               time of 6:15 and a duration of 23:45
> +
> +What:          /sys/class/power_supply/wilco_adv_power/adv_batt_charging_enable
> ++Date:          January 2019
> ++KernelVersion: 4.19
> ++Description:
> +               Enable/disable the Advanced Battery Charging policy.
> +
> +               Input should be parseable by kstrtou8().
> +               Output will be either "0\n" or "1\n".
> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> index 4a119ced4d0c..0e172076b14e 100644
> --- a/drivers/platform/chrome/wilco_ec/Kconfig
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -18,3 +18,17 @@ config WILCO_EC_DEBUGFS
>           manipulation and allow for testing arbitrary commands.  This
>           interface is intended for debug only and will not be present
>           on production devices.
> +
> +config WILCO_EC_ADV_POWER
> +       tristate "Enable Peak Shift and Adv Batt Charging power policies"
> +       depends on WILCO_EC
> +       help
> +         If you say Y here, you get support to control two power policies
> +         managed by the EC:
> +
> +         Peak Shift is power saving policy that minimizes AC usage during
> +         the peak usage times during the day.
> +
> +         In Advanced Charging Mode the system will use standard
> +         charging algorithms and other techniques during non-work
> +         hours to maximize battery health.
> diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
> index 063e7fb4ea17..b7e8df5d3806 100644
> --- a/drivers/platform/chrome/wilco_ec/Makefile
> +++ b/drivers/platform/chrome/wilco_ec/Makefile
> @@ -4,3 +4,5 @@ wilco_ec-objs                           := core.o mailbox.o
>  obj-$(CONFIG_WILCO_EC)                 += wilco_ec.o
>  wilco_ec_debugfs-objs                  := debugfs.o
>  obj-$(CONFIG_WILCO_EC_DEBUGFS)         += wilco_ec_debugfs.o
> +wilco_ec_adv_power-objs                        := advanced_power.o
> +obj-$(CONFIG_WILCO_EC_ADV_POWER)       += wilco_ec_adv_power.o
> diff --git a/drivers/platform/chrome/wilco_ec/advanced_power.c b/drivers/platform/chrome/wilco_ec/advanced_power.c
> new file mode 100644
> index 000000000000..d53c8d60f523
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/advanced_power.c
> @@ -0,0 +1,199 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Peak Shift and Advanced Battery Charging Power Policies
> + *
> + * Copyright 2018 Google LLC
> + *
> + * Peak Shift is power saving policy that minimizes AC usage during the
> + * peak usage times during the day. For each weekday a start and end time
> + * to run in Peak Shift mode can be set. During these times the system will
> + * run from the battery even if the AC is attached as long as the battery
> + * stays above the threshold specified. After the end time specified the
> + * system will run from AC if attached but will not charge the battery. The
> + * system will again function normally using AC and recharging the battery
> + * after the specified Charge Start time.
> + *
> + * Advanced Charging Mode allows the user to maximize the battery health.
> + * In Advanced Charging Mode the system will use standard charging
> + * algorithm and other techniques during non-work hours to maximize battery
> + * health. During work hours, an express charge is used. This express
> + * charge allows the battery to be charged faster; therefore, the battery
> + * is at full charge sooner. For each day the time in which the system will
> + * be most heavily used is specified by the start time and the duration.
> +
> + */
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/wilco-ec.h>
> +
> +#define DRV_NAME "wilco_adv_power"
> +
> +static enum power_supply_property wilco_adv_power_props[] = {
> +       POWER_SUPPLY_PROP_PEAK_SHIFT_ENABLE,
> +       POWER_SUPPLY_PROP_PEAK_SHIFT_BATT_THRESHOLD,
> +       POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SUNDAY,
> +       POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_MONDAY,
> +       POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_TUESDAY,
> +       POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_WEDNESDAY,
> +       POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_THURSDAY,
> +       POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_FRIDAY,
> +       POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SATURDAY,
> +
> +       POWER_SUPPLY_PROP_ADV_BATT_CHARGING_ENABLE,
> +       POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SUNDAY,
> +       POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_MONDAY,
> +       POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_TUESDAY,
> +       POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_WEDNESDAY,
> +       POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_THURSDAY,
> +       POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_FRIDAY,
> +       POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SATURDAY,
> +};
> +
> +struct wilco_adv_power_data {
> +       struct wilco_ec_device *ec;
> +       struct power_supply *psy;
> +};
> +
> +static int wilco_adv_power_get_property(struct power_supply *psy,
> +                                        enum power_supply_property psp,
> +                                        union power_supply_propval *val)
> +{
> +       // struct wilco_adv_power_data *data = power_supply_get_drvdata(psy);
> +       // This is a stub, really will use mailbox() on data->ec...
> +       int ret = 0;
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_PEAK_SHIFT_ENABLE:
> +               val->intval = 1;
> +               break;
> +       case POWER_SUPPLY_PROP_PEAK_SHIFT_BATT_THRESHOLD:
> +               val->intval = 42;
> +               break;
> +       case POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SUNDAY ...
> +            POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SATURDAY:
> +               val->psval.start_hours = 23;
> +               val->psval.start_minutes = 0;
> +               val->psval.end_hours = 75;
> +               val->psval.end_minutes = 1;
> +               val->psval.charge_start_hours = 0;
> +               val->psval.charge_start_minutes = 59;
> +               break;
> +       case POWER_SUPPLY_PROP_ADV_BATT_CHARGING_ENABLE:
> +               val->intval = 0;
> +               break;
> +       case POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SUNDAY ...
> +            POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SATURDAY:
> +               val->abcval.start_hours = 67;
> +               val->abcval.start_minutes = 13;
> +               val->abcval.duration_hours = 0;
> +               val->abcval.duration_minutes = 88;
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int wilco_adv_power_set_property(struct power_supply *psy,
> +                                       enum power_supply_property psp,
> +                                       const union power_supply_propval *val)
> +{
> +       // struct wilco_adv_power_data *data = power_supply_get_drvdata(psy);
> +       // This is a stub, really will use mailbox() on data->ec...
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_PEAK_SHIFT_ENABLE:
> +               dev_err(&psy->dev, "peak_shift_enable=%d", val->intval);
> +               break;
> +       case POWER_SUPPLY_PROP_PEAK_SHIFT_BATT_THRESHOLD:
> +               dev_err(&psy->dev, "peak_shift_batt_thresh=%d", val->intval);
> +               break;
> +       case POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SUNDAY ...
> +            POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SATURDAY:
> +               dev_err(&psy->dev, "peak_shift_sched_%d=%d %d %d %d %d %d", psp,
> +                       val->psval.start_hours,
> +                       val->psval.start_minutes,
> +                       val->psval.end_hours,
> +                       val->psval.end_minutes,
> +                       val->psval.charge_start_hours,
> +                       val->psval.charge_start_minutes);
> +               break;
> +       case POWER_SUPPLY_PROP_ADV_BATT_CHARGING_ENABLE:
> +               dev_err(&psy->dev, "adv_batt_charging_enable=%d", val->intval);
> +               break;
> +       case POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SUNDAY ...
> +            POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SATURDAY:
> +               dev_err(&psy->dev, "adv_batt_charging_sched_%d=%d %d %d %d", psp,
> +                       val->abcval.start_hours,
> +                       val->abcval.start_minutes,
> +                       val->abcval.duration_hours,
> +                       val->abcval.duration_minutes);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static inline int wilco_adv_power_property_is_writeable(struct power_supply *psy,
> +                                       enum power_supply_property psp)
> +{
> +       return 1;
> +}
> +
> +static const struct power_supply_desc wps_desc = {
> +       .properties     = wilco_adv_power_props,
> +       .num_properties = ARRAY_SIZE(wilco_adv_power_props),
> +       .get_property   = wilco_adv_power_get_property,
> +       .set_property   = wilco_adv_power_set_property,
> +       .property_is_writeable = wilco_adv_power_property_is_writeable,
> +       .name           = DRV_NAME,
> +       .type           = POWER_SUPPLY_TYPE_MAINS,
> +};
> +
> +static int wilco_adv_power_probe(struct platform_device *pdev)
> +{
> +       struct wilco_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
> +       struct power_supply_config psy_cfg = {};
> +       struct wilco_adv_power_data *data;
> +
> +       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (data == NULL)
> +               return -ENOMEM;
> +
> +       data->ec = ec;
> +       psy_cfg.drv_data = data;
> +       platform_set_drvdata(pdev, data);
> +
> +       data->psy = power_supply_register(&pdev->dev, &wps_desc, &psy_cfg);
> +       if (IS_ERR(data->psy))
> +               return PTR_ERR(data->psy);
> +
> +       return 0;
> +}
> +
> +static int wilco_adv_power_remove(struct platform_device *pdev)
> +{
> +       struct wilco_adv_power_data *data = platform_get_drvdata(pdev);
> +
> +       power_supply_unregister(data->psy);
> +       return 0;
> +}
> +
> +static struct platform_driver wilco_adv_power_driver = {
> +       .probe          = wilco_adv_power_probe,
> +       .remove         = wilco_adv_power_remove,
> +       .driver = {
> +               .name = DRV_NAME
> +       }
> +};
> +module_platform_driver(wilco_adv_power_driver);
> +
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Wilco Peak Shift and Advanced Battery Charging driver");
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> index 05e1e2be1c91..8f53214cbb1e 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -89,8 +89,21 @@ static int wilco_ec_probe(struct platform_device *pdev)
>                 goto unregister_debugfs;
>         }
>
> +       /* Register child device that will be found by the peak shift driver. */
> +       ec->adv_power_pdev = platform_device_register_data(dev,
> +                                                          "wilco_adv_power",
> +                                                          PLATFORM_DEVID_AUTO,
> +                                                          NULL, 0);
> +       if (IS_ERR(ec->adv_power_pdev)) {
> +               dev_err(dev, "Failed to create adv power platform device\n");
> +               ret = PTR_ERR(ec->adv_power_pdev);
> +               goto unregister_rtc;
> +       }
> +
>         return 0;
>
> +unregister_rtc:
> +       platform_device_unregister(ec->rtc_pdev);
>  unregister_debugfs:
>         if (ec->debugfs_pdev)
>                 platform_device_unregister(ec->debugfs_pdev);
> @@ -102,6 +115,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
>  {
>         struct wilco_ec_device *ec = platform_get_drvdata(pdev);
>
> +       platform_device_unregister(ec->adv_power_pdev);
>         platform_device_unregister(ec->rtc_pdev);
>         if (ec->debugfs_pdev)
>                 platform_device_unregister(ec->debugfs_pdev);
> diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
> index 446473a46b88..84e9aacd3759 100644
> --- a/include/linux/platform_data/wilco-ec.h
> +++ b/include/linux/platform_data/wilco-ec.h
> @@ -36,6 +36,7 @@
>   * @data_size: Size of the data buffer used for EC communication.
>   * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
>   * @rtc_pdev: The child platform_device used by the RTC sub-driver.
> + * @adv_power_pdev: Child platform_device used by the advanced power sub-driver.
>   */
>  struct wilco_ec_device {
>         struct device *dev;
> @@ -47,6 +48,7 @@ struct wilco_ec_device {
>         size_t data_size;
>         struct platform_device *debugfs_pdev;
>         struct platform_device *rtc_pdev;
> +       struct platform_device *adv_power_pdev;
>  };
>
>  /**
> --
> 2.20.1
>
