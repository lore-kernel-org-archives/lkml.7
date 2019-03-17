Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA974C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D66D2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ45cfy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfCQUgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:36:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44302 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 16:36:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id h34so9879146pgh.11;
        Sun, 17 Mar 2019 13:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpQ0A4nzKDx5EWaTKJ+/9yNVUDj+zXtKZgItn3OkNg4=;
        b=hQ45cfy8NtVQqkuWp2WnLefPUlFlONMzbEdSfUMQaic96g1/XRgbpyOgSFkmrLUKVR
         cDySd8Qy0xVUpnM1JLjVB+ZrORcAtuAKm/P7J3rB8GnO8454dNeCS+IpZjxL3k26X5SF
         vE0js8gISD7nwzeyGbdSm3PK+Az2QzPUEN9nniVpY3HL0xjKUoMO27yEQUPp+x3NSZQY
         otDSJ1Pc/M9QthRnLehBICeXp87nVd3Wj4QPkCgvA98649e/07vNJUapABsF6J/DmBDL
         JrDTwxB0PRVd11Jb7GKb7lPHuhlLZVoczXMnP7CAcqdJaAKtr1w4JJChy1j7CC4romZH
         WXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpQ0A4nzKDx5EWaTKJ+/9yNVUDj+zXtKZgItn3OkNg4=;
        b=asrnykXaTFwrYIYmVTYE1OuwE6Ga2lFJFmRxVWiUjr4Fh0XCXhJAgdx+c/4MVbGryv
         FA1Sup2SfdCW1RBeL+aZZsUQ9lvv0xeh2NHrVEPDg/bjaL8oTcduU3ZJ10aS0aoIt45k
         GWj97ocF+Yif++Oet9Y1HwjzrBKPRRU2WSLm2KC3ZL8zeWbAzVRnySBw4Cwounm6zX8v
         j5uXmGt1r61VcfqpE1NymcbRDHt5f+jCHjoVCQ86l4jrwa4Hzqs3OO6I1VLj9jhk9beF
         aguK/v/85eKxLXkJ1rSl0dOh1twxhsog4+0rxEHs35WlOhBqla/YOA57guwt9cSxbkh1
         U2yA==
X-Gm-Message-State: APjAAAUvMcWvUTKYy/LgbTfkHrxAUkCkr8pjODPH8s8MjzPcitQAGLEe
        0k4JW8vXjXzotzmotF0E1S7MBfoloWFJ0IrOd2dTsD8F
X-Google-Smtp-Source: APXvYqxmx7ln/22xBoLk+bl9Lnnr9ZFRIeHCilmZGu8oUKTlAJESCxccu0YRWp/fn35aE+eBmLr3xCOijEdqSZizW40=
X-Received: by 2002:a17:902:a9c8:: with SMTP id b8mr16323486plr.12.1552854975327;
 Sun, 17 Mar 2019 13:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190315165800.5058-1-heikki.krogerus@linux.intel.com> <20190315165800.5058-8-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190315165800.5058-8-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 17 Mar 2019 22:36:03 +0200
Message-ID: <CAHp75VfMyyPEPg8VkmrbF6CeL0_+pPw+KrT5e+aGLsx0rwm=5g@mail.gmail.com>
Subject: Re: [PATCH 07/12] platform/x86: intel_cht_int33fe: Provide software
 node for all components
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 6:58 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Software nodes provide two features that we will need later.
> 1) Software nodes can have references to other software nodes.
> 2) Software nodes can exist before a device entry is created.
>

I don't see any problems with code (*), though I hope Hans will have
chance to test this.
One nit below.

(*) Means all patches touching PDx86 in this series

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 122 +++++++++++++++++------
>  1 file changed, 92 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 6fa3cced6f8e..26444d31945b 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -24,15 +24,25 @@
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>

> +#include <linux/pci.h>

Preserve the ordering, please.

>
>  #define EXPECTED_PTYPE         4
>
> +enum {
> +       INT33FE_NODE_FUSB302,
> +       INT33FE_NODE_MAX17047,
> +       INT33FE_NODE_PI3USB30532,
> +       INT33FE_NODE_MAX,
> +};
> +
>  struct cht_int33fe_data {
>         struct i2c_client *max17047;
>         struct i2c_client *fusb302;
>         struct i2c_client *pi3usb30532;
>         /* Contain a list-head must be per device */
>         struct device_connection connections[4];
> +
> +       struct fwnode_handle *node[INT33FE_NODE_MAX];
>  };
>
>  /*
> @@ -63,14 +73,6 @@ static int cht_int33fe_check_for_max17047(struct device *dev, void *data)
>         return 1;
>  }
>
> -static struct i2c_client *cht_int33fe_find_max17047(void)
> -{
> -       struct i2c_client *max17047 = NULL;
> -
> -       i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
> -       return max17047;
> -}
> -
>  static const char * const max17047_suppliers[] = { "bq24190-charger" };
>
>  static const struct property_entry max17047_props[] = {
> @@ -78,6 +80,36 @@ static const struct property_entry max17047_props[] = {
>         { }
>  };
>
> +static int
> +cht_int33fe_max17047(struct device *dev, struct cht_int33fe_data *data)
> +{
> +       struct fwnode_handle *fwnode = data->node[INT33FE_NODE_MAX17047];
> +       struct i2c_client *max17047 = NULL;
> +       struct i2c_board_info board_info;
> +       int ret;
> +
> +       i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
> +       if (max17047) {
> +               /* Pre-existing i2c-client for the max17047, add device-props */
> +               max17047->dev.fwnode->secondary = fwnode;
> +               /* And re-probe to get the new device-props applied. */
> +               ret = device_reprobe(&max17047->dev);
> +               if (ret)
> +                       dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
> +               return 0;
> +       }
> +
> +       memset(&board_info, 0, sizeof(board_info));
> +       strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
> +       board_info.dev_name = "max17047";
> +       board_info.fwnode = fwnode;
> +       data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
> +       if (IS_ERR(data->max17047))
> +               return PTR_ERR(data->max17047);
> +
> +       return 0;
> +}
> +
>  static const struct property_entry fusb302_props[] = {
>         PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
>         PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
> @@ -86,12 +118,50 @@ static const struct property_entry fusb302_props[] = {
>         { }
>  };
>
> +static const struct property_entry *props[] = {
> +       [INT33FE_NODE_FUSB302]          = fusb302_props,
> +       [INT33FE_NODE_MAX17047]         = NULL,
> +       [INT33FE_NODE_PI3USB30532]      = NULL,
> +};
> +
> +static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
> +{
> +       int i;
> +
> +       for (i = 0; i < INT33FE_NODE_MAX; i++) {
> +               fwnode_remove_software_node(data->node[i]);
> +               data->node[i] = NULL;
> +       }
> +}
> +
> +static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
> +{
> +       struct fwnode_handle *fwnode;
> +       int ret;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(props); i++) {
> +               fwnode = fwnode_create_software_node(props[i], NULL);
> +               if (IS_ERR(fwnode)) {
> +                       ret = PTR_ERR(fwnode);
> +                       goto err_remove_nodes;
> +               }
> +               data->node[i] = fwnode;
> +       }
> +
> +       return 0;
> +
> +err_remove_nodes:
> +       cht_int33fe_remove_nodes(data);
> +
> +       return ret;
> +}
> +
>  static int cht_int33fe_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct i2c_board_info board_info;
>         struct cht_int33fe_data *data;
> -       struct i2c_client *max17047;
>         struct regulator *regulator;
>         unsigned long long ptyp;
>         acpi_status status;
> @@ -151,26 +221,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         if (!data)
>                 return -ENOMEM;
>
> +       ret = cht_int33fe_add_nodes(data);
> +       if (ret)
> +               return ret;
> +
>         /* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
> -       max17047 = cht_int33fe_find_max17047();
> -       if (max17047) {
> -               /* Pre-existing i2c-client for the max17047, add device-props */
> -               ret = device_add_properties(&max17047->dev, max17047_props);
> -               if (ret)
> -                       return ret;
> -               /* And re-probe to get the new device-props applied. */
> -               ret = device_reprobe(&max17047->dev);
> -               if (ret)
> -                       dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
> -       } else {
> -               memset(&board_info, 0, sizeof(board_info));
> -               strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
> -               board_info.dev_name = "max17047";
> -               board_info.properties = max17047_props;
> -               data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
> -               if (IS_ERR(data->max17047))
> -                       return PTR_ERR(data->max17047);
> -       }
> +       ret = cht_int33fe_max17047(dev, data);
> +       if (ret)
> +               goto out_remove_nodes;
>
>         data->connections[0].endpoint[0] = "port0";
>         data->connections[0].endpoint[1] = "i2c-pi3usb30532";
> @@ -187,7 +245,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         memset(&board_info, 0, sizeof(board_info));
>         strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
>         board_info.dev_name = "fusb302";
> -       board_info.properties = fusb302_props;
> +       board_info.fwnode = data->node[INT33FE_NODE_FUSB302];
>         board_info.irq = fusb302_irq;
>
>         data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
> @@ -198,6 +256,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>
>         memset(&board_info, 0, sizeof(board_info));
>         board_info.dev_name = "pi3usb30532";
> +       board_info.fwnode = data->node[INT33FE_NODE_PI3USB30532];
>         strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
>
>         data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
> @@ -214,9 +273,11 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         i2c_unregister_device(data->fusb302);
>
>  out_unregister_max17047:
> +       device_connections_remove(data->connections);
>         i2c_unregister_device(data->max17047);
>
> -       device_connections_remove(data->connections);
> +out_remove_nodes:
> +       cht_int33fe_remove_nodes(data);
>
>         return ret;
>  }
> @@ -230,6 +291,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
>         i2c_unregister_device(data->max17047);
>
>         device_connections_remove(data->connections);
> +       cht_int33fe_remove_nodes(data);
>
>         return 0;
>  }
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
