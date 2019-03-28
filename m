Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C290C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E332082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfBoewYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfC1LQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:16:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44953 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfC1LQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:16:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id w5so22467814qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1diYEBof8NlvFSF0kfyWcihK2OgV9jT9U+ajdzMqwL0=;
        b=hfBoewYP6p/8WqFNyRJPGWFqnuYuTg5DsRYdpbRCEod4oPVBlOPhPCDy7AF+Hq80vz
         03FcRG0ahbkh2s7Tgqj3+A2nOj1atLQ3XX3xuJQp6GHBjm8GpiBgg5o+6e0DcJtXTJ9e
         /lPvG1DMFjzG1g5c45+AWlE7wg+RxHo+UIvK1wA3f6Z0ro2+CR5o104n0gnO9OQMidGu
         6iYUtRsqlXhYDkexRy+fbvunsgRqjT774DMn6Abejl0TkkWxaxdhwzN9L4DqGF6xV/3Q
         Z2G++oBT3E/+xX/Sc9prT+bVAW8pYBzZHPdmcbeBjZI47lw4R75lPeIZ7zLPBX4i/AUn
         wDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1diYEBof8NlvFSF0kfyWcihK2OgV9jT9U+ajdzMqwL0=;
        b=iPgNlWfSXScVS72J89sI77UHbafh5nnkgF88vyEP46sBeVimplgjHJyQiCq4nqS9O5
         5ugoj6QVTTcrQLLsn7mOzZLuC4Dg8EQvkjcLEXYpRor8T7k4pzGe/MhIuasOl6FcsNmX
         9pCChjXGVZHgdOshtiYx2pEY8V1wn9NFsTsJeFSJpqmT7BMyG7RHBEGMVfvKJpKjUhHS
         /jRTUBB0UWglcZN41JuNPLrIdNh6sSy/sdr5SLQCknU8aUfnP8yQGyn62i1MncAkyl1i
         xX6Pw7fp4hiDfXZAh+PLkaQmvoEjpqk4sIV5IIhDOQILmFK1k/326Y8S98Pihlvl0av9
         Bfjg==
X-Gm-Message-State: APjAAAVbsVYt29m+O9zg/Nq2vQJRf4RcNksm6gvdWbQ2LY51Zjo0ACVj
        rwWAa7pN611bCcBOzvE4J/iK+NgNPaHroKX3vj4=
X-Google-Smtp-Source: APXvYqz/Y8mLZ2yJcG7PZ1riC5D0+PRo+xIx0Xt7+Emr/zqxqAQFjqqDV3XBxRZhJyF53iJhBuOrNSzISZhHZet5AK8=
X-Received: by 2002:ac8:3782:: with SMTP id d2mr35579373qtc.170.1553771767840;
 Thu, 28 Mar 2019 04:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190327051450.16222-1-pihsun@chromium.org> <20190327051450.16222-7-pihsun@chromium.org>
In-Reply-To: <20190327051450.16222-7-pihsun@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 28 Mar 2019 12:15:56 +0100
Message-ID: <CAFqH_51BYkGW_jma-WpE5tsJs=daXDZB1dD6RYCErZ64RNuyTQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] platform/chrome: cros_ec: add EC host command
 support using rpmsg.
To:     Peter Shih <pihsun@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Thanks for sending this upstream, Some few comments and questions
below. Apart from these LGTM.

Missatge de Peter Shih <pihsun@chromium.org> del dia dc., 27 de mar=C3=A7
2019 a les 6:17:
>
> From: Pi-Hsun Shih <pihsun@chromium.org>
>
> Add EC host command support through rpmsg.
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
> Changes from v6:
>  - Make data for response aligned to 4 bytes.
>
> Changes from v5:
>  - Change commit title.
>  - Add documents for some structs, and fix all warning from
>    scripts/kernel-doc.
>  - Miscellaneous fixes based on feedback.
>
> Changes from v4:
>  - Change from work queue to completion.
>  - Change from matching using rpmsg id to device tree compatible, to
>    support EC subdevices.
>
> Changes from v3:
>  - Add host event support by adding an extra bytes at the start of IPC
>    message to indicate the type of the message (host event or host
>    command), since there's no additional irq that can be used for host
>    event.
>
> Changes from v2:
>  - Wait for ipi ack instead of depends on the behavior in mtk-rpmsg.
>
> Changes from v1:
>  - Code format fix based on feedback for cros_ec_rpmsg.c.
>  - Extract feature detection for SCP into separate patch (Patch 6).
> ---
>  drivers/platform/chrome/Kconfig         |   9 +
>  drivers/platform/chrome/Makefile        |   1 +
>  drivers/platform/chrome/cros_ec_rpmsg.c | 265 ++++++++++++++++++++++++
>  3 files changed, 275 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c
>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kc=
onfig
> index 9186d81a51cc..5c48aa6da2f8 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -59,6 +59,15 @@ config CROS_EC_I2C
>           a checksum. Failing accesses will be retried three times to
>           improve reliability.
>
> +config CROS_EC_RPMSG
> +       tristate "ChromeOS Embedded Controller (rpmsg)"
> +       depends on MFD_CROS_EC && RPMSG && OF
> +       help
> +         If you say Y here, you get support for talking to the ChromeOS =
EC
> +         through rpmsg. This uses a simple byte-level protocol with a
> +         checksum. Also since there's no addition EC-to-host interrupt, =
this
> +         use a byte in message to distinguish host event from host comma=
nd.
> +
>  config CROS_EC_SPI
>         tristate "ChromeOS Embedded Controller (SPI)"
>         depends on MFD_CROS_EC && SPI
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/M=
akefile
> index 1e2f0029b597..4b69d795720d 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_CHROMEOS_LAPTOP)           +=3D chromeos_lap=
top.o
>  obj-$(CONFIG_CHROMEOS_PSTORE)          +=3D chromeos_pstore.o
>  obj-$(CONFIG_CHROMEOS_TBMC)            +=3D chromeos_tbmc.o
>  obj-$(CONFIG_CROS_EC_I2C)              +=3D cros_ec_i2c.o
> +obj-$(CONFIG_CROS_EC_RPMSG)            +=3D cros_ec_rpmsg.o
>  obj-$(CONFIG_CROS_EC_SPI)              +=3D cros_ec_spi.o
>  cros_ec_lpcs-objs                      :=3D cros_ec_lpc.o cros_ec_lpc_re=
g.o
>  cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC) +=3D cros_ec_lpc_mec.o
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/c=
hrome/cros_ec_rpmsg.c
> new file mode 100644
> index 000000000000..2ecae806cfc5
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright 2018 Google LLC.
> +
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/rpmsg.h>
> +#include <linux/slab.h>
> +
> +#define EC_MSG_TIMEOUT_MS 200
> +#define HOST_COMMAND_MARK 1
> +#define HOST_EVENT_MARK 2
> +
> +/**
> + * struct cros_ec_rpmsg_response - rpmsg message format from from EC.
> + *
> + * @type:      The type of message, should be either HOST_COMMAND_MARK o=
r
> + *             HOST_EVENT_MARK, representing that the message is a respo=
nse to
> + *             host command, or a host event.
> + * @data:      ec_host_response for host command.
> + */
> +struct cros_ec_rpmsg_response {
> +       u8 type;
> +       u8 data[] __aligned(4);
> +};
> +
> +/**
> + * struct cros_ec_rpmsg - information about a EC over rpmsg.
> + *
> + * @rpdev:     rpmsg device we are connected to
> + * @xfer_ack:  completion for host command transfer.
> + * @host_event_work:   Work struct for pending host event.
> + */
> +struct cros_ec_rpmsg {
> +       struct rpmsg_device *rpdev;
> +       struct completion xfer_ack;
> +       struct work_struct host_event_work;
> +};
> +
> +/**
> + * cros_ec_cmd_xfer_rpmsg - Transfer a message over rpmsg and receive th=
e reply
> + *
> + * @ec_dev: ChromeOS EC device
> + * @ec_msg: Message to transfer
> + *
> + * This is only used for old EC proto version, and is not supported for =
this
> + * driver.
> + *
> + * Return: number of bytes of the reply on success or negative error cod=
e.
> + */
> +static int cros_ec_cmd_xfer_rpmsg(struct cros_ec_device *ec_dev,
> +                                 struct cros_ec_command *ec_msg)
> +{
> +       return -EINVAL;
> +}
> +
> +/**
> + * cros_ec_pkt_xfer_rpmsg - Transfer a packet over rpmsg and receive the=
 reply
> + *
> + * @ec_dev: ChromeOS EC device
> + * @ec_msg: Message to transfer
> + *
> + * Return: number of bytes of the reply on success or negative error cod=
e.
> + */
> +static int cros_ec_pkt_xfer_rpmsg(struct cros_ec_device *ec_dev,
> +                                 struct cros_ec_command *ec_msg)
> +{
> +       struct ec_host_response *response;
> +       struct cros_ec_rpmsg *ec_rpmsg =3D ec_dev->priv;
> +       struct rpmsg_device *rpdev =3D ec_rpmsg->rpdev;
> +       int len;
> +       u8 sum;
> +       int ret;
> +       int i;
> +       unsigned long timeout;
> +
> +       ec_msg->result =3D 0;
> +       len =3D cros_ec_prepare_tx(ec_dev, ec_msg);
> +       dev_dbg(ec_dev->dev, "prepared, len=3D%d\n", len);
> +
> +       reinit_completion(&ec_rpmsg->xfer_ack);
> +       ret =3D rpmsg_send(rpdev->ept, ec_dev->dout, len);
> +       if (ret) {
> +               dev_err(ec_dev->dev, "rpmsg send failed\n");
> +               return ret;
> +       }
> +
> +       timeout =3D msecs_to_jiffies(EC_MSG_TIMEOUT_MS);
> +       ret =3D wait_for_completion_timeout(&ec_rpmsg->xfer_ack, timeout)=
;
> +       if (!ret) {
> +               dev_err(ec_dev->dev, "rpmsg send timeout\n");
> +               return -EIO;
> +       }
> +
> +       /* check response error code */
> +       response =3D (struct ec_host_response *)ec_dev->din;
> +       ec_msg->result =3D response->result;
> +
> +       ret =3D cros_ec_check_result(ec_dev, ec_msg);
> +       if (ret)
> +               goto exit;
> +
> +       if (response->data_len > ec_msg->insize) {
> +               dev_err(ec_dev->dev, "packet too long (%d bytes, expected=
 %d)",
> +                       response->data_len, ec_msg->insize);
> +               ret =3D -EMSGSIZE;
> +               goto exit;
> +       }
> +
> +       /* copy response packet payload and compute checksum */
> +       memcpy(ec_msg->data, ec_dev->din + sizeof(*response),
> +              response->data_len);
> +
> +       sum =3D 0;
> +       for (i =3D 0; i < sizeof(*response) + response->data_len; i++)
> +               sum +=3D ec_dev->din[i];
> +
> +       if (sum) {
> +               dev_err(ec_dev->dev, "bad packet checksum, calculated %x\=
n",
> +                       sum);
> +               ret =3D -EBADMSG;
> +               goto exit;
> +       }
> +
> +       ret =3D response->data_len;
> +exit:
> +       if (ec_msg->command =3D=3D EC_CMD_REBOOT_EC)
> +               msleep(EC_REBOOT_DELAY_MS);
> +
> +       return ret;
> +}
> +
> +static void
> +cros_ec_rpmsg_host_event_function(struct work_struct *host_event_work)
> +{
> +       struct cros_ec_rpmsg *ec_rpmsg =3D container_of(
> +               host_event_work, struct cros_ec_rpmsg, host_event_work);
> +       struct cros_ec_device *ec_dev =3D dev_get_drvdata(&ec_rpmsg->rpde=
v->dev);
> +       bool wake_event =3D true;
> +       int ret;
> +
> +       ret =3D cros_ec_get_next_event(ec_dev, &wake_event);
> +
> +       /*
> +        * Signal only if wake host events or any interrupt if
> +        * cros_ec_get_next_event() returned an error (default value for
> +        * wake_event is true)
> +        */
> +       if (wake_event && device_may_wakeup(ec_dev->dev))
> +               pm_wakeup_event(ec_dev->dev, 0);
> +
> +       if (ret > 0)
> +               blocking_notifier_call_chain(&ec_dev->event_notifier,
> +                                            0, ec_dev);
> +}
> +
> +static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data=
,
> +                                 int len, void *priv, u32 src)
> +{
> +       struct cros_ec_device *ec_dev =3D dev_get_drvdata(&rpdev->dev);
> +       struct cros_ec_rpmsg *ec_rpmsg =3D ec_dev->priv;
> +       struct cros_ec_rpmsg_response *resp;
> +
> +       if (!len) {
> +               dev_warn(ec_dev->dev, "rpmsg received empty response");

Is this is unlikely to happen?

> +               return -EINVAL;
> +       }
> +
> +       resp =3D data;
> +       len -=3D offsetof(struct cros_ec_rpmsg_response, data);
> +       if (resp->type =3D=3D HOST_COMMAND_MARK) {
> +               if (len > ec_dev->din_size) {
> +                       dev_warn(
> +                               ec_dev->dev,
> +                               "received length %d > din_size %d, trunca=
ting",
> +                               len, ec_dev->din_size);

How often this warning appears? Should be this a dev_dbg?

> +                       len =3D ec_dev->din_size;
> +               }
> +
> +               memcpy(ec_dev->din, resp->data, len);
> +               complete(&ec_rpmsg->xfer_ack);
> +       } else if (resp->type =3D=3D HOST_EVENT_MARK) {
> +               schedule_work(&ec_rpmsg->host_event_work);
> +       } else {
> +               dev_warn(ec_dev->dev, "rpmsg received invalid type =3D %d=
",
> +                        resp->type);

Is this is unlikely to happen?

> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
> +{
> +       struct device *dev =3D &rpdev->dev;
> +       struct cros_ec_device *ec_dev;
> +       struct cros_ec_rpmsg *ec_rpmsg;
> +       int ret;
> +
> +       ec_dev =3D devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
> +       if (!ec_dev)
> +               return -ENOMEM;
> +
> +       ec_rpmsg =3D devm_kzalloc(dev, sizeof(*ec_rpmsg), GFP_KERNEL);
> +       if (!ec_rpmsg)
> +               return -ENOMEM;
> +
> +       ec_dev->dev =3D dev;
> +       ec_dev->priv =3D ec_rpmsg;
> +       ec_dev->cmd_xfer =3D cros_ec_cmd_xfer_rpmsg;
> +       ec_dev->pkt_xfer =3D cros_ec_pkt_xfer_rpmsg;
> +       ec_dev->phys_name =3D dev_name(&rpdev->dev);
> +       ec_dev->din_size =3D sizeof(struct ec_host_response) +
> +                          sizeof(struct ec_response_get_protocol_info);
> +       ec_dev->dout_size =3D sizeof(struct ec_host_request);
> +       dev_set_drvdata(dev, ec_dev);
> +
> +       ec_rpmsg->rpdev =3D rpdev;
> +       init_completion(&ec_rpmsg->xfer_ack);
> +       INIT_WORK(&ec_rpmsg->host_event_work,
> +                 cros_ec_rpmsg_host_event_function);
> +
> +       ret =3D cros_ec_register(ec_dev);
> +       if (ret) {
> +               dev_err(dev, "cannot register EC\n");
> +               return ret;
> +       }
> +
> +       return 0;

cros_ec_register returns 0 on success and prints an error message if
something went wrong. Remove the above and just do:

return cros_ec_register(ec_dev);


> +}
> +
> +static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
> +{
> +       struct cros_ec_device *ec_dev =3D dev_get_drvdata(&rpdev->dev);
> +       struct cros_ec_rpmsg *ec_rpmsg =3D ec_dev->priv;
> +
> +       cancel_work_sync(&ec_rpmsg->host_event_work);
> +}
> +
> +static const struct of_device_id cros_ec_rpmsg_of_match[] =3D {
> +       { .compatible =3D "google,cros-ec-rpmsg", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, cros_ec_rpmsg_of_match);
> +
> +static struct rpmsg_driver cros_ec_driver_rpmsg =3D {
> +       .drv =3D {
> +               .name   =3D KBUILD_MODNAME,
> +               .of_match_table =3D cros_ec_rpmsg_of_match,
> +       },
> +       .probe          =3D cros_ec_rpmsg_probe,
> +       .remove         =3D cros_ec_rpmsg_remove,
> +       .callback       =3D cros_ec_rpmsg_callback,
> +};
> +
> +module_rpmsg_driver(cros_ec_driver_rpmsg);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS EC multi function device (rpmsg)");
> --
> 2.21.0.392.gf8f6787159e-goog
>
