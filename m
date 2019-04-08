Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43C7C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742D620880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCDRvqKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfDHQpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:45:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40181 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfDHQpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:45:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so7642817plr.7;
        Mon, 08 Apr 2019 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrDKXuW7FC7KqAwEG6aEwq5J5Y/jHqu2dubzMvyEP9g=;
        b=fCDRvqKE3TfSd3fJ0H6i7EAVp6O+5ajuHx2Dtk6AojR7W25eAUT1y/LmsjMtz8VtN3
         LxLZ0ayywNdgMzfhn5gEUlGGnR9WCl5UT563rXyZds/ZHH3o1cNiFFBA+hJw8FmhwB3H
         BKb40nMEYUYKGRas/FVoNJCktYgoVQ78Nr+n1KgH/w/GS9pCWTR4q10yKaT0WXok7cXu
         V+MuY7W7vw+RG/6ySUOTqyTbv+rKx8o4Lk0TD/x0pb9IXvGXRb1XHGLyEC00KA7/Nr8m
         TlrMoMnI5AMBg/V1TUtjMOOiafHK2mgGyIU7UrcYohSMGO47bXNFCy21prpeFI0khr8Y
         fv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrDKXuW7FC7KqAwEG6aEwq5J5Y/jHqu2dubzMvyEP9g=;
        b=Wb65XXORiGx0Ujg3R86oBrh6kFZ897tRoKoGUCr1cjUYfyajUtoeeBIUDF23HU7u4B
         rgFBsushQ1dZuhKphThkCL1ICd2lv8twmX4rUeGqBOep+PGTk2qDD1mlomntCSvdevO4
         EvEyl7eiuE4kBUzGRAVi4MuBy7dcqxxU2T6t7U9musyS9cf5BhUJrb2ckkUclbZ4bxMB
         rEuR0XJXgR58wT9D6lSY3uCv0hs5FosBjOLdBzWX4YfiMCl8BtndncxJ75ApZtdclWXe
         Ib355tvWb/Y4+Pxq0ZT83YdieUHHIV5OCalqyj0lMKqfj2a5bLtFiakx+799e4Xsxpse
         7Ycg==
X-Gm-Message-State: APjAAAVrGRlOx/GqZHhXyeSHGwaKDkcL6Rbu3zBXRW0wn7MPryv32ulL
        Ts341++MvQHDMP508YzaoL5g/N/1lPNuJ6joYRg=
X-Google-Smtp-Source: APXvYqzPZ4yyIjf62XXzVUThw/zEpnh/fWJ5UaX2KgOSTYw9g6wDQsoOw03VIB5pzrMrDZ8r3FuJTMmlNzd6lTuMcnE=
X-Received: by 2002:a17:902:2c83:: with SMTP id n3mr30304931plb.281.1554741924069;
 Mon, 08 Apr 2019 09:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190403164537.24643-1-heikki.krogerus@linux.intel.com> <20190403164537.24643-12-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190403164537.24643-12-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Apr 2019 19:45:13 +0300
Message-ID: <CAHp75VfKJWXM0=ycdOvn0c1BOS+LevwYbq=6iaCOiQUwk--a-Q@mail.gmail.com>
Subject: Re: [PATCH 11/11] platform/x86: intel_cht_int33fe: Replacing the old
 connections with references
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

On Wed, Apr 3, 2019 at 7:46 PM Heikki Krogerus
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

Though one minor comment below.

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 94 +++++++++++++++++++-----
>  1 file changed, 77 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index ed21aeacec24..f0844a04299b 100644
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
> @@ -287,6 +294,65 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
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

Here I really don't care about 80 character limit.
Ditto for below cases.

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
> @@ -355,22 +421,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       /* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
> -       ret = cht_int33fe_max17047(dev, data);
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
> +       /* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
> +       ret = cht_int33fe_max17047(dev, data);
> +       if (ret)
> +               goto out_remove_references;
>
>         memset(&board_info, 0, sizeof(board_info));
>         strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
> @@ -403,9 +461,11 @@ static int cht_int33fe_probe(struct platform_device *pdev)
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
> @@ -420,7 +480,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
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
