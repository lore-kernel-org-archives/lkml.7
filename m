Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6960BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A35A217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj7uOvhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfDKNai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:30:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37620 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDKNai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:30:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so3429897ply.4;
        Thu, 11 Apr 2019 06:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlwbzU2RBKO9Nn8+4r6gh/M3eH3CzEshhtHVomqF3KQ=;
        b=Qj7uOvhguLviyZQ97IZwU7MSaVUpOPNfaEa87bz3vyZIUoU4JICV3zvDF4Dm9SRgOA
         EqtYrhHfZqprg/nqVGX0JHYXz6cesbHhCEylAbBO72ysgDKbBjXqp4H+auAwY5gvdCXc
         sEJHi5Sjw0tSquGLynDuMEAgY0TNbRIZHpujXCFesjgFzZO2ckMA4CEcyRW/gXpG2ppM
         Jc4IZRnBYN5BiesTNFuz9cCayS52OlP66WXqV1txQ1v+Mtfed30V1qFPcGS9lSnu8m84
         pln3eC3GMGCsjvdpOeOawbfcY4iD+jkPmxBot2Bq2EXIRV1nQi6So8uy6EPLX1HIl3kw
         Q3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlwbzU2RBKO9Nn8+4r6gh/M3eH3CzEshhtHVomqF3KQ=;
        b=jAosOAn06eXrbo2nPxe7O17As6sfe/tAmcXFjObG14Ih6uS7zXgG9Syg55ndz/gV9v
         lqyY8xLnI1NaxYtGopFqnGpfh0xUzKd2poY/ZUYU751t4rhT9OF/mtMAuRn+qxUpqRt0
         4xdjO/DUfWM2Du7BVZ7svKXweF/9fUP4DfnRfXKJDnxxGl4wA4fryf2NRKOX5GGXlEOk
         8/tp0qs1ewRqc0Pl1Kg3H9TJ2s8oEvPA41Yj6qgPE/OCXkrMeiMk/221p6uSsOIMoLI3
         WWQYsvM9XECqVklTNYW4yBy99/SWkx0U06AigxRE85e6gBQsUSGQd8uK+d5eHOJgsvdW
         EptA==
X-Gm-Message-State: APjAAAU2ztoGFzGFpWhLlYdZ6+fFBBEUWmFqDVN20d0l5CcfJaY7prvS
        DzxRLAZvUp7OcxytOG82q6CcZbxF98iBxvm/aig=
X-Google-Smtp-Source: APXvYqw5aApG1kOM7K1rRJvvsa7YiDjOtgK36/Xhkg45zY7r52Rl6njtGJqvZIaG1iq9L3bSIva4Is5xDbrVnP+cJ5g=
X-Received: by 2002:a17:902:9686:: with SMTP id n6mr8294568plp.282.1554989437133;
 Thu, 11 Apr 2019 06:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com> <20190410152505.87041-13-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190410152505.87041-13-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Apr 2019 16:30:26 +0300
Message-ID: <CAHp75VdtNAAHPSPji6h1hQU+Yehu5pqaD3RCEfqLud12NvtTfA@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] platform/x86: intel_cht_int33fe: Replacing the
 old connections with references
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 6:25 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Now that the software nodes support references, and the
> device connection API support parsing fwnode references,
> replacing the old connection descriptions with software node
> references. Relying on device names when matching the
> connection would not have been possible to link the USB
> Type-C connector and the DisplayPort connector together, but
> with real references it's not problem.
>
> The DisplayPort ACPI node is dag up, and the drivers own
> software node for the DisplayPort is set as the secondary
> node for it. The USB Type-C connector refers the software
> node, but it is now tied to the ACPI node, and therefore any
> device entry (struct drm_connector in practice) that the
> node combo is assigned to.
>
> The USB role switch device does not have ACPI node, so we
> have to wait for the device to appear. Then we can simply
> assign our software node for the to the device.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 94 +++++++++++++++++++-----
>  1 file changed, 77 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 0687aa23fcfe..8d9f890ec000 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -39,15 +39,22 @@ enum {
>         INT33FE_NODE_MAX,
>  };
>
> +enum {
> +       INT33FE_REF_ORIENTATION,
> +       INT33FE_REF_MODE_MUX,
> +       INT33FE_REF_DISPLAYPORT,
> +       INT33FE_REF_ROLE_SWITCH,
> +       INT33FE_REF_MAX,
> +};
> +
>  struct cht_int33fe_data {
>         struct i2c_client *max17047;
>         struct i2c_client *fusb302;
>         struct i2c_client *pi3usb30532;
> -       /* Contain a list-head must be per device */
> -       struct device_connection connections[4];
>
>         struct fwnode_handle *dp;
>         struct fwnode_handle *node[INT33FE_NODE_MAX];
> +       struct software_node_reference *ref[INT33FE_REF_MAX];
>  };
>
>  /*
> @@ -280,6 +287,65 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
>         return ret;
>  }
>
> +static void cht_int33fe_remove_references(struct cht_int33fe_data *data)
> +{
> +       int i;
> +
> +       for (i = 0; i < INT33FE_REF_MAX; i++)
> +               fwnode_remove_software_node_reference(data->ref[i]);
> +}
> +
> +static int cht_int33fe_add_references(struct cht_int33fe_data *data)
> +{
> +       struct fwnode_reference_args args[2] = { };
> +       struct software_node_reference *ref;
> +       struct fwnode_handle *con;
> +
> +       con = data->node[INT33FE_NODE_USB_CONNECTOR];
> +
> +       /* USB Type-C muxes */
> +       args[0].fwnode = data->node[INT33FE_NODE_PI3USB30532];
> +       args[1].fwnode = NULL;
> +
> +       ref = fwnode_create_software_node_reference(con, "orientation-switch",
> +                                                   args);
> +       if (IS_ERR(ref))
> +               return PTR_ERR(ref);
> +       data->ref[INT33FE_REF_ORIENTATION] = ref;
> +
> +       ref = fwnode_create_software_node_reference(con, "mode-switch", args);
> +       if (IS_ERR(ref)) {
> +               cht_int33fe_remove_references(data);
> +               return PTR_ERR(ref);
> +       }
> +       data->ref[INT33FE_REF_MODE_MUX] = ref;
> +
> +       /* USB role switch */
> +       args[0].fwnode = data->node[INT33FE_NODE_ROLE_SWITCH];
> +       args[1].fwnode = NULL;
> +
> +       ref = fwnode_create_software_node_reference(con, "usb-role-switch",
> +                                                   args);
> +       if (IS_ERR(ref)) {
> +               cht_int33fe_remove_references(data);
> +               return PTR_ERR(ref);
> +       }
> +       data->ref[INT33FE_REF_ROLE_SWITCH] = ref;
> +
> +       /* DisplayPort */
> +       args[0].fwnode = data->node[INT33FE_NODE_DISPLAYPORT];
> +       args[1].fwnode = NULL;
> +
> +       ref = fwnode_create_software_node_reference(con, "displayport", args);
> +       if (IS_ERR(ref)) {
> +               cht_int33fe_remove_references(data);
> +               return PTR_ERR(ref);
> +       }
> +       data->ref[INT33FE_REF_DISPLAYPORT] = ref;
> +
> +       return 0;
> +}
> +
>  static int cht_int33fe_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -348,22 +414,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       /* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
> -       ret = cht_int33fe_find_max17047(dev, data);
> +       ret = cht_int33fe_add_references(data);
>         if (ret)
>                 goto out_remove_nodes;
>
> -       data->connections[0].endpoint[0] = "port0";
> -       data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
> -       data->connections[0].id = "orientation-switch";
> -       data->connections[1].endpoint[0] = "port0";
> -       data->connections[1].endpoint[1] = "i2c-pi3usb30532-mux";
> -       data->connections[1].id = "mode-switch";
> -       data->connections[2].endpoint[0] = "i2c-fusb302";
> -       data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
> -       data->connections[2].id = "usb-role-switch";
> -
> -       device_connections_add(data->connections);
> +       /* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
> +       ret = cht_int33fe_find_max17047(dev, data);
> +       if (ret)
> +               goto out_remove_references;
>
>         memset(&board_info, 0, sizeof(board_info));
>         strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
> @@ -396,9 +454,11 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         i2c_unregister_device(data->fusb302);
>
>  out_unregister_max17047:
> -       device_connections_remove(data->connections);
>         i2c_unregister_device(data->max17047);
>
> +out_remove_references:
> +       cht_int33fe_remove_references(data);
> +
>  out_remove_nodes:
>         cht_int33fe_remove_nodes(data);
>
> @@ -413,7 +473,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
>         i2c_unregister_device(data->fusb302);
>         i2c_unregister_device(data->max17047);
>
> -       device_connections_remove(data->connections);
> +       cht_int33fe_remove_references(data);
>         cht_int33fe_remove_nodes(data);
>
>         return 0;
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
