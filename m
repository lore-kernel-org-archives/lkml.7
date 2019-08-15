Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AE8C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8C5206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3tDi1tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfHOMyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:54:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35658 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbfHOMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:54:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so1311181pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3B9Z8TePpXTNa77soV+Yw4aRHM57h5fDNR35eGyOSk=;
        b=C3tDi1tZvON2ek83YfAj6Kxd+Qu/iur7e/xho3vY5GLc0U8KDGc1m9Ri6SPy/FbS9w
         La/YpFxayS9wUenF264SszoLB3GuanhI88D9ynsH9yrdfhTYn1JTnB4eN6dffEIZ67Ew
         yXDCLbYJnIhPj9wglrCUr7mcnKwk3E0Qkki0WLTy1nGXyvqs1M4FiG1WX1QHOWxZAOxU
         Wf4Xf03Yc0wDU8wxLoeJ3Ic3Bm77zMpWwk97cjxAizHp9mCQZ3UVtBD0WdqxqMraP30N
         /IqXp3O+rE+jq+w5xqUCjMuPZlg9v5sA+tbZfJunbtfjP/ahZieUKPBHMvmmJevtPsSA
         27Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3B9Z8TePpXTNa77soV+Yw4aRHM57h5fDNR35eGyOSk=;
        b=CCQqQq0u8jhcrEaMcqHyniDoqeVrzfm9q7ddnEvjfxTAtOKKptosNtic3pEFCqwH4n
         toyTW0eWsfZm4t+UOUTElDeTR8vYkdUnGJMiH3OXX1YURGQ2kCVmb63Wrl8Shlser7Ia
         PL0HcgvhVHSeCbRjeST7enMD7DQ2op49O0t44gHV47i+S3UtMPXg8+wx+7/Ltjkp4dSC
         Oz8Hculq0NvjmKTQUedAVb8sk/nAL3VAbaO7haZqfv6uEy0WtbuoB+O/uLagoBn0/NlO
         haVAVYCoWckievY+BNaxCr9Gm8mDqXes1H6MRBiuwgs2egEwFFoOmFgSMxMXtcCMB55o
         FTFg==
X-Gm-Message-State: APjAAAU+cWbT1+jwMP62Sn+nVTHFYihQQMfIZ8SMXv6Te1Iw2/PIJ6U3
        9VpwMGz/gCydKqiIjm1W2mUETH4LjzVuD5DyLeE=
X-Google-Smtp-Source: APXvYqzFJk1zO8xcEE8IP248NIhjzuuPvBpWByKcqa1XF+GU7cPijMJwvzOJEIXH2uT/HJPVO2kXwcVErFw8KCb9ITM=
X-Received: by 2002:a63:e54f:: with SMTP id z15mr3403500pgj.4.1565873644063;
 Thu, 15 Aug 2019 05:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190815112826.81785-1-heikki.krogerus@linux.intel.com> <20190815112826.81785-4-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190815112826.81785-4-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Aug 2019 15:53:52 +0300
Message-ID: <CAHp75VeEKczQ5sX01QqeyiQnuMKdcWQkdqMqLksVB3rDTHL_hw@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/x86: intel_cht_int33fe: Use new API to gain
 access to the role switch
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 2:28 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> The driver for the Intel USB role mux now always supplies
> software node for the role switch, so no longer checking
> that, and never creating separate node for the role switch.
> From now on using software_node_find_by_name() function to
> get the handle to the USB role switch.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 57 +++++-------------------
>  1 file changed, 10 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 4fbdff48a4b5..1d5d877b9582 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -34,7 +34,6 @@ enum {
>         INT33FE_NODE_MAX17047,
>         INT33FE_NODE_PI3USB30532,
>         INT33FE_NODE_DISPLAYPORT,
> -       INT33FE_NODE_ROLE_SWITCH,
>         INT33FE_NODE_USB_CONNECTOR,
>         INT33FE_NODE_MAX,
>  };
> @@ -45,7 +44,6 @@ struct cht_int33fe_data {
>         struct i2c_client *pi3usb30532;
>
>         struct fwnode_handle *dp;
> -       struct fwnode_handle *mux;
>  };
>
>  static const struct software_node nodes[];
> @@ -139,46 +137,10 @@ static const struct software_node nodes[] = {
>         { "max17047", NULL, max17047_props },
>         { "pi3usb30532" },
>         { "displayport" },
> -       { "usb-role-switch" },
>         { "connector", &nodes[0], usb_connector_props, usb_connector_refs },
>         { }
>  };
>
> -static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
> -{
> -       struct fwnode_handle *fwnode;
> -       struct device *dev;
> -       struct device *p;
> -
> -       fwnode = software_node_fwnode(&nodes[INT33FE_NODE_ROLE_SWITCH]);
> -       if (!fwnode)
> -               return -ENODEV;
> -
> -       /* First finding the platform device */
> -       p = bus_find_device_by_name(&platform_bus_type, NULL,
> -                                   "intel_xhci_usb_sw");
> -       if (!p)
> -               return -EPROBE_DEFER;
> -
> -       /* Then the mux child device */
> -       dev = device_find_child_by_name(p, "intel_xhci_usb_sw-role-switch");
> -       put_device(p);
> -       if (!dev)
> -               return -EPROBE_DEFER;
> -
> -       /* If there already is a node for the mux, using that one. */
> -       if (dev->fwnode)
> -               fwnode_remove_software_node(fwnode);
> -       else
> -               dev->fwnode = fwnode;
> -
> -       data->mux = fwnode_handle_get(dev->fwnode);
> -       put_device(dev);
> -       mux_ref.node = to_software_node(data->mux);
> -
> -       return 0;
> -}
> -
>  static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
>  {
>         struct fwnode_handle *fwnode;
> @@ -211,10 +173,9 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
>  {
>         software_node_unregister_nodes(nodes);
>
> -       if (data->mux) {
> -               fwnode_handle_put(data->mux);
> +       if (mux_ref.node) {
> +               fwnode_handle_put(software_node_fwnode(mux_ref.node));
>                 mux_ref.node = NULL;
> -               data->mux = NULL;
>         }
>
>         if (data->dp) {
> @@ -235,14 +196,16 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
>         /* The devices that are not created in this driver need extra steps. */
>
>         /*
> -        * There is no ACPI device node for the USB role mux, so we need to find
> -        * the mux device and assign our node directly to it. That means we
> -        * depend on the mux driver. This function will return -PROBE_DEFER
> -        * until the mux device is registered.
> +        * There is no ACPI device node for the USB role mux, so we need to wait
> +        * until the mux driver has created software node for the mux device.
> +        * It means we depend on the mux driver. This function will return
> +        * -EPROBE_DEFER until the mux device is registered.
>          */
> -       ret = cht_int33fe_setup_mux(data);
> -       if (ret)
> +       mux_ref.node = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
> +       if (!mux_ref.node) {
> +               ret = -EPROBE_DEFER;
>                 goto err_remove_nodes;
> +       }
>
>         /*
>          * The DP connector does have ACPI device node. In this case we can just
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
