Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D9DCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5520D20862
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V49twJFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404283AbfJ1SBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:01:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34367 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbfJ1SBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:01:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so10910875wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jduO3+nmeKK9VS1s8WbIrvAU7M7GfnDKYTuy7uL3lUk=;
        b=V49twJFBnv8vhyt1xGKbHgkEMxw/QmzBWMVQxqa8ndFePF1i4p6i1Jfh+Wm51qxxjT
         A2pFiKu4QAZlTUF+VhSBJktYwoKAglOebImWS3d9LIRmEBPxakf600WFrk81zBnmZOfc
         KqpQCGwEBzU/zKPHyTiOP+paHBqhzcfBEkZ2hx82xIxjkRptjQ/KVTGkYRVgLeIy7I2b
         s4ffI+Z9GLwb4Z7RZYYyFvIWqQb4TKbqW7GiXegoH3sNIlBeBNrFVue1zNS4Wrh2HCb4
         ZVcMsMa0bgF/A3EL8TH9XbcmBcm4k2/4rcgSN4cc+0WRDyHJaDkKTGflpHuRMwM2xwip
         xxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jduO3+nmeKK9VS1s8WbIrvAU7M7GfnDKYTuy7uL3lUk=;
        b=PdhKD/bk0u528cBZ0QunzwSj37cQWhOvEuF7cBMUuWKgUnAJKEeMPxZrXi7NxVympG
         nENpyXXa8VqwcKEN767BVOaUiTAJHmEwf4QeyX6n+IuXr/yCMU1j4dbeb+fMzoT31dE8
         oERoqfNdfGOXHQSF2ZGiZYxaHmSSYQSh5CD9+WrRcUzgaLX2PIyy46TC/CXCFtg2jSKE
         7qU/RnpADsKqojPVjb4liKPUWQvubKRVTkD3vRauk5UHuboDb0QpVCAejRXhwETUtMW4
         qKfM2bZiBKzSZ4xRPPRkUlByL3Gre4JVB9/i09IAvf1Q7Bp9bo+I9YFQR5WB3sBPfWh9
         I7Wg==
X-Gm-Message-State: APjAAAUHyfLkl2kulHMAc32tqDY2rgH8TQDBQUjKXV5Z2joFXb4U+XRo
        riBc61A5019EdVHH0MxZ85be+5tIezvAqi3V3H8=
X-Google-Smtp-Source: APXvYqzoAdGTSHSTU9eyo8LQOBqa6heDODvIKG2DLAH+ujy7LtazhawvcWzU5HbRuAOr79Iu1oSlrWXXkm2MzpNIx/A=
X-Received: by 2002:a5d:444b:: with SMTP id x11mr16184711wrr.207.1572285675441;
 Mon, 28 Oct 2019 11:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191028024156.23964-1-linux@roeck-us.net>
In-Reply-To: <20191028024156.23964-1-linux@roeck-us.net>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 28 Oct 2019 11:01:03 -0700
Message-ID: <CAHQ1cqFCraPayphD4WWmGP87adGxxmj2Nyae8imotio0r972rA@mail.gmail.com>
Subject: Re: [PATCH] nvme: Add hardware monitoring support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <kbusch@kernel.org>,
        Chris Healy <Chris.Healy@zii.aero>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 7:04 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> nvme devices report temperature information in the controller information
> (for limits) and in the smart log. Currently, the only means to retrieve
> this information is the nvme command line interface, which requires
> super-user privileges.
>
> At the same time, it would be desirable to use NVME temperature informati=
on
> for thermal control.
>
> This patch adds support to read NVME temperatures from the kernel using t=
he
> hwmon API and adds temperature zones for NVME drives. The thermal subsyst=
em
> can use this information to set thermal policies, and userspace can acces=
s
> it using libsensors and/or the "sensors" command.
>
> Example output from the "sensors" command:
>
> nvme0-pci-0100
> Adapter: PCI adapter
> Composite:    +39.0=C2=B0C  (high =3D +85.0=C2=B0C, crit =3D +85.0=C2=B0C=
)
> Sensor 1:     +39.0=C2=B0C
> Sensor 2:     +41.0=C2=B0C
>

Tried this on ZII i.MX8MQ Ultra Zest Board with NVMe device attached.
Seems to work as advertised, so:

Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/nvme/host/Kconfig      |  10 +++
>  drivers/nvme/host/Makefile     |   1 +
>  drivers/nvme/host/core.c       |   5 ++
>  drivers/nvme/host/nvme-hwmon.c | 160 +++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h       |   8 ++
>  5 files changed, 184 insertions(+)
>  create mode 100644 drivers/nvme/host/nvme-hwmon.c
>
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 2b36f052bfb9..aeb49e16e386 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -23,6 +23,16 @@ config NVME_MULTIPATH
>            /dev/nvmeXnY device will show up for each NVMe namespaces,
>            even if it is accessible through multiple controllers.
>
> +config NVME_HWMON
> +       bool "NVME hardware monitoring"
> +       depends on (NVME_CORE=3Dy && HWMON=3Dy) || (NVME_CORE=3Dm && HWMO=
N)
> +       help
> +         This provides support for NVME hardware monitoring. If enabled,
> +         a hardware monitoring device will be created for each NVME driv=
e
> +         in the system.
> +
> +         If unsure, say N.
> +
>  config NVME_FABRICS
>         tristate
>
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index 8a4b671c5f0c..03de4797a877 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -14,6 +14,7 @@ nvme-core-$(CONFIG_TRACING)           +=3D trace.o
>  nvme-core-$(CONFIG_NVME_MULTIPATH)     +=3D multipath.o
>  nvme-core-$(CONFIG_NVM)                        +=3D lightnvm.o
>  nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)   +=3D fault_inject.o
> +nvme-core-$(CONFIG_NVME_HWMON)         +=3D nvme-hwmon.o
>
>  nvme-y                                 +=3D pci.o
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa7ba09dca77..fc1d4b146717 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2796,6 +2796,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>         ctrl->oncs =3D le16_to_cpu(id->oncs);
>         ctrl->mtfa =3D le16_to_cpu(id->mtfa);
>         ctrl->oaes =3D le32_to_cpu(id->oaes);
> +       ctrl->wctemp =3D le16_to_cpu(id->wctemp);
> +       ctrl->cctemp =3D le16_to_cpu(id->cctemp);
> +
>         atomic_set(&ctrl->abort_limit, id->acl + 1);
>         ctrl->vwc =3D id->vwc;
>         if (id->mdts)
> @@ -2897,6 +2900,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>
>         ctrl->identified =3D true;
>
> +       nvme_hwmon_init(ctrl);
> +
>         return 0;
>
>  out_free:
> diff --git a/drivers/nvme/host/nvme-hwmon.c b/drivers/nvme/host/nvme-hwmo=
n.c
> new file mode 100644
> index 000000000000..f19098bc3228
> --- /dev/null
> +++ b/drivers/nvme/host/nvme-hwmon.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVM Express hardware monitoring support
> + * Copyright (c) 2019, Guenter Roeck
> + */
> +
> +#include <linux/hwmon.h>
> +
> +#include "nvme.h"
> +
> +struct nvme_hwmon_data {
> +       struct nvme_ctrl *ctrl;
> +       struct nvme_smart_log log;
> +};
> +
> +static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
> +{
> +       return nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +                           &data->log, sizeof(data->log), 0);
> +}
> +
> +static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types t=
ype,
> +                          u32 attr, int channel, long *val)
> +{
> +       struct nvme_hwmon_data *data =3D dev_get_drvdata(dev);
> +       struct nvme_smart_log *log =3D &data->log;
> +       int err;
> +       int temp;
> +
> +       err =3D nvme_hwmon_get_smart_log(data);
> +       if (err)
> +               return err < 0 ? err : -EPROTO;
> +
> +       switch (attr) {
> +       case hwmon_temp_max:
> +               *val =3D (data->ctrl->wctemp - 273) * 1000;
> +               break;
> +       case hwmon_temp_crit:
> +               *val =3D (data->ctrl->cctemp - 273) * 1000;
> +               break;
> +       case hwmon_temp_input:
> +               if (!channel)
> +                       temp =3D le16_to_cpup((__le16 *)log->temperature)=
;
> +               else
> +                       temp =3D le16_to_cpu(log->temp_sensor[channel - 1=
]);
> +               *val =3D (temp - 273) * 1000;
> +               break;
> +       case hwmon_temp_crit_alarm:
> +               *val =3D !!(log->critical_warning & NVME_SMART_CRIT_TEMPE=
RATURE);
> +               break;
> +       default:
> +               err =3D -EOPNOTSUPP;
> +               break;
> +       }
> +       return err;
> +}
> +
> +static const char * const nvme_hwmon_sensor_names[] =3D {
> +       "Composite",
> +       "Sensor 1",
> +       "Sensor 2",
> +       "Sensor 3",
> +       "Sensor 4",
> +       "Sensor 5",
> +       "Sensor 6",
> +       "Sensor 7",
> +       "Sensor 8",
> +};
> +
> +static int nvme_hwmon_read_string(struct device *dev,
> +                                 enum hwmon_sensor_types type, u32 attr,
> +                                 int channel, const char **str)
> +{
> +       *str =3D nvme_hwmon_sensor_names[channel];
> +       return 0;
> +}
> +
> +static umode_t nvme_hwmon_is_visible(const void *_data,
> +                                    enum hwmon_sensor_types type,
> +                                    u32 attr, int channel)
> +{
> +       const struct nvme_hwmon_data *data =3D _data;
> +
> +       switch (attr) {
> +       case hwmon_temp_crit:
> +               if (!channel && data->ctrl->cctemp)
> +                       return 0444;
> +               break;
> +       case hwmon_temp_max:
> +               if (!channel && data->ctrl->wctemp)
> +                       return 0444;
> +               break;
> +       case hwmon_temp_crit_alarm:
> +               if (!channel)
> +                       return 0444;
> +               break;
> +       case hwmon_temp_input:
> +       case hwmon_temp_label:
> +               if (!channel || data->log.temp_sensor[channel - 1])
> +                       return 0444;
> +               break;
> +       default:
> +               break;
> +       }
> +       return 0;
> +}
> +
> +static const struct hwmon_channel_info *nvme_hwmon_info[] =3D {
> +       HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +       HWMON_CHANNEL_INFO(temp,
> +                          HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +                               HWMON_T_LABEL | HWMON_T_CRIT_ALARM,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL),
> +       NULL
> +};
> +
> +static const struct hwmon_ops nvme_hwmon_ops =3D {
> +       .is_visible =3D nvme_hwmon_is_visible,
> +       .read =3D nvme_hwmon_read,
> +       .read_string =3D nvme_hwmon_read_string,
> +};
> +
> +static const struct hwmon_chip_info nvme_hwmon_chip_info =3D {
> +       .ops =3D &nvme_hwmon_ops,
> +       .info =3D nvme_hwmon_info,
> +};
> +
> +void nvme_hwmon_init(struct nvme_ctrl *ctrl)
> +{
> +       struct device *dev =3D ctrl->device;
> +       struct nvme_hwmon_data *data;
> +       struct device *hwmon;
> +       int err;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return;
> +
> +       data->ctrl =3D ctrl;
> +
> +       err =3D nvme_hwmon_get_smart_log(data);
> +       if (err) {
> +               dev_warn(dev, "Failed to read smart log (error %d)\n", er=
r);
> +               return;
> +       }
> +
> +       hwmon =3D devm_hwmon_device_register_with_info(dev, dev_name(dev)=
,
> +                                                    data,
> +                                                    &nvme_hwmon_chip_inf=
o,
> +                                                    NULL);
> +       if (IS_ERR(hwmon))
> +               dev_warn(dev, "Failed to instantiate hwmon device\n");
> +}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 22e8401352c2..e6460c1216bc 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -231,6 +231,8 @@ struct nvme_ctrl {
>         u16 kas;
>         u8 npss;
>         u8 apsta;
> +       u16 wctemp;
> +       u16 cctemp;
>         u32 oaes;
>         u32 aen_result;
>         u32 ctratt;
> @@ -652,4 +654,10 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(s=
truct device *dev)
>         return dev_to_disk(dev)->private_data;
>  }
>
> +#if IS_ENABLED(CONFIG_NVME_HWMON)
> +void nvme_hwmon_init(struct nvme_ctrl *ctrl);
> +#else
> +static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
> +#endif
> +
>  #endif /* _NVME_H */
> --
> 2.17.1
>
