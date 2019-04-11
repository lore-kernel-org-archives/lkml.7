Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4ABC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E972083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEb8cyH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfDKN3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:29:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46121 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKN3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:29:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so3509856pgv.13;
        Thu, 11 Apr 2019 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfP06EvcsQ3On/5zQPU72LK3QwG/JvDoL9SymndWhmI=;
        b=aEb8cyH3JmTFiDSBFR9MkEp2uRiaE+NQ30H9XX7rmV3WN8U8RopiryENF0ojIy4QMZ
         WOh7zAH4oDXx3qKPwdJx58Q/oLlrk2X+Np+IkxyToXKTP6WPQ8GRBokHxArztgSyhHaX
         B0On5jABRWJsKKOis6UPlmLcWE6ggzdq+qmCQ/u4aoQRVVhQD5LqWWHyny3Dh1smYWDj
         JmXHWAvvaoo8nn0/wt2y0ugvEnGjFXpiNOOm7IBTYKd4mlKUWKfUz8jDt3lmwneHb9KU
         tltt/BhdhZ/BDLeXQs8N2tE9DqdF+drX4fDriivt731eqHnSBhmAHJCqFVsjA/0AO6I2
         fxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfP06EvcsQ3On/5zQPU72LK3QwG/JvDoL9SymndWhmI=;
        b=l0VV5tVVoOGQEoYxztmXWsTq5H12gzivNw96NDVKKJqO15pMR5yJ3nN9G2aABY1XYq
         UAka2wz46YUH+XmKYyryR+EosubLBcNL4XHhuZXeswGGncdlB3h6dJL0mCwf7/Jkh+E1
         vlTMZhFYe+7GtVvA47pCGDeUCJO17f5A2OvnhmouxafjPeZORxk2Enl0jOg+J56NqxMW
         zddKC1QhC+tjz0e/UXAtybHEgyjHGsno0L1w0gsfnDMarib63gClknVKbDDL3QWuyIR4
         oCKlCv4MuR6jRkjDz10Zg8SRKXcWVKkvd4uN04OTeFiWbpe0/lsDq6apAW3uOFWnm9gc
         yghA==
X-Gm-Message-State: APjAAAXbJW/Anh8yb9WVvQO/wtUTbK6EJFzPy2Ko86i98bjBMG7Sb6WW
        0FQeH5W/4RK5OwGxGCywznpvRirDmEv85frzAh2hIAWsciI=
X-Google-Smtp-Source: APXvYqyEfigOdB9v+oFd0RSoaMES3H3XziyNaQIxzjXqu2/BzTTB8NLCEBwvD/ffqh1Sg+4vv7nSftLt4BxYXk2kCN8=
X-Received: by 2002:a63:530e:: with SMTP id h14mr11464957pgb.136.1554989349740;
 Thu, 11 Apr 2019 06:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com> <20190410152505.87041-12-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190410152505.87041-12-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Apr 2019 16:28:58 +0300
Message-ID: <CAHp75VeM8Ob-Q9FToNxt7Rwrcoodpphc10=PpDw9CB6xd=3eUA@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] platform/x86: intel_cht_int33fe: Link with
 external dependencies using fwnodes
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
> Supplying also external devices - the DisplayPort connector
> and the USB role switch - software fwnodes. After this the
> driver has access to all the components tied to the USB
> Type-C connector and can start creating software node
> references to actually associate them with the USB Type-C
> connector device.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 92 ++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 0707afd39ca5..0687aa23fcfe 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -33,6 +33,8 @@ enum {
>         INT33FE_NODE_FUSB302,
>         INT33FE_NODE_MAX17047,
>         INT33FE_NODE_PI3USB30532,
> +       INT33FE_NODE_DISPLAYPORT,
> +       INT33FE_NODE_ROLE_SWITCH,
>         INT33FE_NODE_USB_CONNECTOR,
>         INT33FE_NODE_MAX,
>  };
> @@ -44,6 +46,7 @@ struct cht_int33fe_data {
>         /* Contain a list-head must be per device */
>         struct device_connection connections[4];
>
> +       struct fwnode_handle *dp;
>         struct fwnode_handle *node[INT33FE_NODE_MAX];
>  };
>
> @@ -144,8 +147,71 @@ static const struct property_entry *props[] = {
>         [INT33FE_NODE_FUSB302]          = fusb302_props,
>         [INT33FE_NODE_MAX17047]         = max17047_props,
>         [INT33FE_NODE_PI3USB30532]      = NULL,
> +       [INT33FE_NODE_DISPLAYPORT]      = NULL,
> +       [INT33FE_NODE_ROLE_SWITCH]      = NULL,
>  };
>
> +static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
> +{
> +       struct fwnode_handle *fwnode = data->node[INT33FE_NODE_ROLE_SWITCH];
> +       struct pci_dev *pdev;
> +       struct device *dev;
> +       struct device *p;
> +
> +       /* First let's find xHCI PCI device */
> +       pdev = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
> +       if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
> +               return -ENODEV;
> +
> +       /* Then the child platform device */
> +       p = device_find_child_by_name(&pdev->dev, "intel_xhci_usb_sw");
> +       pci_dev_put(pdev);
> +       if (!p)
> +               return -EPROBE_DEFER;
> +
> +       /* Finally the mux device */
> +       dev = device_find_child_by_name(p, "intel_xhci_usb_sw-role-switch");
> +       put_device(p);
> +       if (!dev)
> +               return -EPROBE_DEFER;
> +
> +       /* If there already is a node for the mux, using that one. */
> +       if (dev->fwnode) {
> +               fwnode_handle_get(dev->fwnode);
> +               fwnode_remove_software_node(fwnode);
> +               data->node[INT33FE_NODE_ROLE_SWITCH] = dev->fwnode;
> +       } else {
> +               /* The node can be tied to the lifetime of the device. */
> +               dev->fwnode = fwnode_handle_get(dev->fwnode);
> +       }
> +
> +       put_device(dev);
> +
> +       return 0;
> +}
> +
> +static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
> +{
> +       struct fwnode_handle *fwnode = data->node[INT33FE_NODE_DISPLAYPORT];
> +       struct pci_dev *pdev;
> +
> +       /* First let's find the GPU PCI device */
> +       pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
> +       if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
> +               return -ENODEV;
> +
> +       /* Then the DP child device node */
> +       data->dp = device_get_named_child_node(&pdev->dev, "DD02");
> +       pci_dev_put(pdev);
> +       if (!data->dp)
> +               return -ENODEV;
> +
> +       fwnode->secondary = ERR_PTR(-ENODEV);
> +       data->dp->secondary = fwnode;
> +
> +       return 0;
> +}
> +
>  static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
>  {
>         int i;
> @@ -154,6 +220,12 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
>                 fwnode_remove_software_node(data->node[i]);
>                 data->node[i] = NULL;
>         }
> +
> +       if (data->dp) {
> +               data->dp->secondary = NULL;
> +               fwnode_handle_put(data->dp);
> +               data->dp = NULL;
> +       }
>  }
>
>  static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
> @@ -180,6 +252,26 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
>         }
>         data->node[INT33FE_NODE_USB_CONNECTOR] = fwnode;
>
> +       /* The devices that are not created in this driver need extra steps. */
> +
> +       /*
> +        * There is no ACPI device node for the USB role mux, so we need to find
> +        * the mux device and assign our node directly to it. That means we
> +        * depend on the mux driver. This function will return -PROBE_DEFER
> +        * until the mux device is registered.
> +        */
> +       ret = cht_int33fe_setup_mux(data);
> +       if (ret)
> +               goto err_remove_nodes;
> +
> +       /*
> +        * The DP connector does have ACPI device node. In this case we can just
> +        * find that ACPI node and assing our node as the secondary node to it.
> +        */
> +       ret = cht_int33fe_setup_dp(data);
> +       if (ret)
> +               goto err_remove_nodes;
> +
>         return 0;
>
>  err_remove_nodes:
> --
> 2.20.1
>


--
With Best Regards,
Andy Shevchenko
