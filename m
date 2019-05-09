Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C682BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B6E217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXi6j9tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfEIVbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:31:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42013 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIVba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:31:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id j53so4283451qta.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j0iReheYpHHCRxnkxZOPwzvTFoigU7ITAfw7X6CL/3w=;
        b=CXi6j9tShfzXD6wv6ImtnIYmeKgjrNPftCgUXy5b1aml3EGktm/g9eH+BthOssDDRX
         WTyZA7CEDUaLol8xnCQtlVtOWopB2DqMOoQcG+DpBq4/qB0se7fO33hLux9XTmkb7gCN
         4hlSsL0gHOJ2unyrT5m1V5wxO4B4RMZITlgADDfwMaZjakyXAecTMxWmuORRiCRzGpi3
         pyI/sNMeiK/rFuKiIjidiD+vjDNVo8ONJs5uP4o75j9IOr7o8g+abIvTBkjXTBQXI2ki
         f5OCSNuZVNhmOlb2qzACTO9X0rzrQe4v1JYFkwwJytVwSihVxxdDSbuD8s4oJX4kin9S
         xqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j0iReheYpHHCRxnkxZOPwzvTFoigU7ITAfw7X6CL/3w=;
        b=oK2FDFG0cL+wzzKZJdR0fMvBb83TPf2/VjvjjHicgmMfzXwPVS24X9nhR3/K09+dII
         Ag5WwrfNVOi6hvWDuKHdZK0lvbygQDTbf92nMmEboVIF/n5A9ZVEvJ4nKoF9A+LISbcF
         iOx2UOeWpRI+BM8S1cSduRwKf1UacMSW2dAdMB+s1FWYZDVGCmguB/hbRclfEKliNSfo
         FLJVV1geCzH9kGNjwT1gZXUIi5pksATtLAfFlDU2KtlcV9O1tPMtLOj93RAIQudvdnc/
         2JwJ+ow9H41iaVHI1GbdXuVK+EniZ49sxETx8SCZ3G0UTt1uYJMPcN6q/6bjrMyFmVu6
         UtCw==
X-Gm-Message-State: APjAAAVW4Yra+B8JrLJvp/RboFjxEyE4mhRsS6won2FGoU8LbVQQLITv
        FIeFKisPKICtE+m/7GhY4+KGSYri9sCUkIit2q8=
X-Google-Smtp-Source: APXvYqwwwxtE+fGKB4F85rbjwZ3t7BHHHyHKV5MkZNYdP1QdiAV27bcY7B4/vmKzsSnWpeCxLoE9jJieVjDpHvBjmME=
X-Received: by 2002:ac8:fa9:: with SMTP id b38mr1496162qtk.22.1557437489161;
 Thu, 09 May 2019 14:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190417012048.87977-1-ncrews@chromium.org>
In-Reply-To: <20190417012048.87977-1-ncrews@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 9 May 2019 23:31:17 +0200
Message-ID: <CAFqH_53L-rq3pGny90eAS1ho__vAxnLt5i_F1pvo+=PA1fO-HQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/chrome: wilco_ec: Add Boot on AC support
To:     Nick Crews <ncrews@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dlaurie@chromium.org, Daniel Erat <derat@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, bartfab@chromium.org,
        lamzin@google.com, jchwong@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Thanks for the patch, some few comments below...

Missatge de Nick Crews <ncrews@chromium.org> del dia dc., 17 d=E2=80=99abr.
2019 a les 3:22:
>
> Boot on AC is a policy which makes the device boot from S5 when AC
> power is connected. This is useful for users who want to run their
> device headless or with a dock.
>
> v3 changes:
> - Add docstring to wilco_ec_add_sysfs()
> - Tweak a comment
> - Use val > 1 instead of val !=3D 0 && val !=3D 1
> v2 changes:
> - Move documentation to Documentation/ABI/testing/sysfs-platform-wilco-ec
>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  .../ABI/testing/sysfs-platform-wilco-ec       | 11 +++
>  drivers/platform/chrome/wilco_ec/Makefile     |  2 +-
>  drivers/platform/chrome/wilco_ec/core.c       |  9 +++
>  drivers/platform/chrome/wilco_ec/sysfs.c      | 77 +++++++++++++++++++
>  include/linux/platform_data/wilco-ec.h        | 12 +++
>  5 files changed, 110 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-wilco-ec
>  create mode 100644 drivers/platform/chrome/wilco_ec/sysfs.c
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Document=
ation/ABI/testing/sysfs-platform-wilco-ec
> new file mode 100644
> index 000000000000..e074c203cd32
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
> @@ -0,0 +1,11 @@
> +What:          /sys/bus/platform/devices/GOOG000C\:00/boot_on_ac
> +Date:          April 2019
> +KernelVersion: 5.2
> +Description:
> +               Boot on AC is a policy which makes the device boot from S=
5
> +               when AC power is connected. This is useful for users who
> +               want to run their device headless or with a dock.
> +
> +               Input should be parseable by kstrtou8() to 0 or 1.
> +               Output will be either "0\n" or "1\n".
> +
> diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform=
/chrome/wilco_ec/Makefile
> index 063e7fb4ea17..1281dd7737c4 100644
> --- a/drivers/platform/chrome/wilco_ec/Makefile
> +++ b/drivers/platform/chrome/wilco_ec/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -wilco_ec-objs                          :=3D core.o mailbox.o
> +wilco_ec-objs                          :=3D core.o mailbox.o sysfs.o
>  obj-$(CONFIG_WILCO_EC)                 +=3D wilco_ec.o
>  wilco_ec_debugfs-objs                  :=3D debugfs.o
>  obj-$(CONFIG_WILCO_EC_DEBUGFS)         +=3D wilco_ec_debugfs.o
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/c=
hrome/wilco_ec/core.c
> index 05e1e2be1c91..abd15d04e57b 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -89,8 +89,16 @@ static int wilco_ec_probe(struct platform_device *pdev=
)
>                 goto unregister_debugfs;
>         }
>
> +       ret =3D wilco_ec_add_sysfs(ec);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to create sysfs entries: %d", ret);
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
> @@ -102,6 +110,7 @@ static int wilco_ec_remove(struct platform_device *pd=
ev)
>  {
>         struct wilco_ec_device *ec =3D platform_get_drvdata(pdev);
>
> +       wilco_ec_remove_sysfs(ec);
>         platform_device_unregister(ec->rtc_pdev);
>         if (ec->debugfs_pdev)
>                 platform_device_unregister(ec->debugfs_pdev);
> diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/=
chrome/wilco_ec/sysfs.c
> new file mode 100644
> index 000000000000..959b5da2eb16
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/sysfs.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Google LLC
> + *
> + * Sysfs properties to view and modify EC-controlled features on Wilco d=
evices.
> + * The entries will appear under /sys/bus/platform/devices/GOOG000C:00/
> + *
> + * See Documentation/ABI/testing/sysfs-platform-wilco-ec for more inform=
ation.
> + */
> +
> +#include <linux/platform_data/wilco-ec.h>
> +#include <linux/sysfs.h>
> +
> +#define CMD_KB_CMOS                    0x7C
> +#define SUB_CMD_KB_CMOS_AUTO_ON                0x03
> +
> +struct boot_on_ac_request {
> +       u8 cmd;                 /* Always CMD_KB_CMOS */
> +       u8 reserved1;
> +       u8 sub_cmd;             /* Always SUB_CMD_KB_CMOS_AUTO_ON */
> +       u8 reserved3to5[3];
> +       u8 val;                 /* Either 0 or 1 */
> +       u8 reserved7;
> +} __packed;
> +
> +static ssize_t boot_on_ac_store(struct device *dev,
> +                               struct device_attribute *attr,
> +                               const char *buf, size_t count)
> +{
> +       struct wilco_ec_device *ec =3D dev_get_drvdata(dev);
> +       struct boot_on_ac_request rq;
> +       struct wilco_ec_message msg;
> +       int ret;
> +       u8 val;
> +
> +       ret =3D kstrtou8(buf, 10, &val);
> +       if (ret < 0)
> +               return ret;
> +       if (val > 1)
> +               return -EINVAL;
> +
> +       memset(&rq, 0, sizeof(rq));
> +       rq.cmd =3D CMD_KB_CMOS;
> +       rq.sub_cmd =3D SUB_CMD_KB_CMOS_AUTO_ON;
> +       rq.val =3D val;
> +
> +       memset(&msg, 0, sizeof(msg));
> +       msg.type =3D WILCO_EC_MSG_LEGACY;
> +       msg.request_data =3D &rq;
> +       msg.request_size =3D sizeof(rq);
> +       ret =3D wilco_ec_mailbox(ec, &msg);
> +       if (ret < 0)
> +               return ret;
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR_WO(boot_on_ac);

Is not possible to read the flag? From the API description seems that it is=
.

> +
> +static struct attribute *wilco_dev_attrs[] =3D {
> +       &dev_attr_boot_on_ac.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group wilco_dev_attr_group =3D {
> +       .attrs =3D wilco_dev_attrs,
> +};
> +
> +int wilco_ec_add_sysfs(struct wilco_ec_device *ec)
> +{
> +       return sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
> +}
> +
> +void wilco_ec_remove_sysfs(struct wilco_ec_device *ec)
> +{
> +       sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);

As Guenter pointed:  sysfs_remove_group()

> +}
> diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platf=
orm_data/wilco-ec.h
> index 1ff224793c99..7809b098ce27 100644
> --- a/include/linux/platform_data/wilco-ec.h
> +++ b/include/linux/platform_data/wilco-ec.h
> @@ -123,4 +123,16 @@ struct wilco_ec_message {
>   */
>  int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message=
 *msg);
>
> +/**
> + * wilco_ec_add_sysfs() - Create sysfs entries
> + * @ec: Wilco EC device
> + *
> + * wilco_ec_remove_sysfs() needs to be called afterwards
> + * to perform the necessary cleanup.
> + *
> + * Return: 0 on success or negative error code on failure.
> + */
> +int wilco_ec_add_sysfs(struct wilco_ec_device *ec);
> +void wilco_ec_remove_sysfs(struct wilco_ec_device *ec);
> +
>  #endif /* WILCO_EC_H */
> --
> 2.20.1
>
