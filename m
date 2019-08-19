Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F930C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AAC20578
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECytkFZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfHSKhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:37:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44864 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfHSKhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:37:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id c81so930537pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yu0f6pMLdxGwnLVNko3j6vcWwTjQCi3n4eQYrPALZaU=;
        b=ECytkFZhImz4MXGf/sT9x2geFg8X1Tr1iuw08aC0w+AL5aqcyDqi9gV9KwAThc75pM
         D/p/TywVv0FEVxA86z67jjJ/fPUV/kBUfgDosdhBiDBH3wpSKMkHoj7Peh7a3LR5gjsc
         h8HTBCMc/V/TaOjr5u/PBCrAtRwkDSztEomvxS+lGipuURG/D1KwdMyqX3enFnusYgXp
         Se7EYcWowLH/vbb8Maj86wR+UkExzRO8Z3jsej8F+HuCWpn5ORgHok37HUdRy874znTX
         Z1jOIv6BklqdpjVZ8SpPDI43p4qTbGElvwuZhX0CulbqGnwEzmvQe7sll3U5E8Xt0ggq
         t89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yu0f6pMLdxGwnLVNko3j6vcWwTjQCi3n4eQYrPALZaU=;
        b=ZjcqYa4OIxJvNT048EDLIDytUjk7XBlJX44JfeWQa8axI+QisrrVOrxfa1IqSkodbp
         hsMtGLaK7EOlazveXbSK5Yg0Ae379EV78i6W2VeJ9SBWHmUBlQVwVNV29z3J8ZHQTV+5
         gpIgc0VG0IcPPVbGGHsTnt0ipp8PVrOu9eSVuj6+K57HoHc1ZPLrFu1TgFqoAJNf8o4l
         +72oe1dEpSioMGoCcJe0UDmswewSwICO33b86yIt8v1u/XFjjliIPwQVehxe7yW71u5z
         wvZgFOOev3dSydoDIVRrqO/L0/WFSulPxtjlXzTjMorGvm4ySV7+enyNUv4Ahd9FK2To
         njlQ==
X-Gm-Message-State: APjAAAUhoTFKqDdA+lkGsEkEtqxXnMq1AeS2imN6uMttupxN+hAavcnG
        TX3POjWxJsRzXfoWyCwVDeq+vvqC1WkZduQijcXZukND
X-Google-Smtp-Source: APXvYqxb/Iau9+O6bfKWVemg2SeUnFdwsf6MLqDzM3ko0ePzm3BH+UUwB2sj3rStLYgHa1wN+z/oiyOypapE/EeG+Z0=
X-Received: by 2002:a63:e54f:: with SMTP id z15mr19191581pgj.4.1566211058159;
 Mon, 19 Aug 2019 03:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190819100724.30051-1-heikki.krogerus@linux.intel.com> <20190819100724.30051-3-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190819100724.30051-3-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Aug 2019 13:37:25 +0300
Message-ID: <CAHp75Vdfw5zwphnT03uunn686U33MjzeVy+sfAttcFt0WgYwaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] usb: roles: intel_xhci: Supplying software node
 for the role mux
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 1:07 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> The primary purpose for this node will be to allow linking
> the users of the switch to it. The users will be for example
> USB Type-C connectors. By supplying a reference to this
> node in the software nodes representing the USB Type-C
> controllers or connectors, the drivers for those devices can
> access the switch.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  .../usb/roles/intel-xhci-usb-role-switch.c    | 27 ++++++++++++++-----
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> index 277de96181f9..7325a84dd1c8 100644
> --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> @@ -39,6 +39,10 @@ struct intel_xhci_usb_data {
>         void __iomem *base;
>  };
>
> +static const struct software_node intel_xhci_usb_node = {
> +       "intel-xhci-usb-sw",
> +};
> +
>  static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
>  {
>         struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
> @@ -122,17 +126,13 @@ static enum usb_role intel_xhci_usb_get_role(struct device *dev)
>         return role;
>  }
>
> -static const struct usb_role_switch_desc sw_desc = {
> -       .set = intel_xhci_usb_set_role,
> -       .get = intel_xhci_usb_get_role,
> -       .allow_userspace_control = true,
> -};
> -
>  static int intel_xhci_usb_probe(struct platform_device *pdev)
>  {
> +       struct usb_role_switch_desc sw_desc = { };
>         struct device *dev = &pdev->dev;
>         struct intel_xhci_usb_data *data;
>         struct resource *res;
> +       int ret;
>
>         data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>         if (!data)
> @@ -147,9 +147,20 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, data);
>
> +       ret = software_node_register(&intel_xhci_usb_node);
> +       if (ret)
> +               return ret;
> +
> +       sw_desc.set = intel_xhci_usb_set_role,
> +       sw_desc.get = intel_xhci_usb_get_role,
> +       sw_desc.allow_userspace_control = true,
> +       sw_desc.fwnode = software_node_fwnode(&intel_xhci_usb_node);
> +
>         data->role_sw = usb_role_switch_register(dev, &sw_desc);
> -       if (IS_ERR(data->role_sw))
> +       if (IS_ERR(data->role_sw)) {
> +               fwnode_handle_put(sw_desc.fwnode);
>                 return PTR_ERR(data->role_sw);
> +       }
>
>         pm_runtime_set_active(dev);
>         pm_runtime_enable(dev);
> @@ -164,6 +175,8 @@ static int intel_xhci_usb_remove(struct platform_device *pdev)
>         pm_runtime_disable(&pdev->dev);
>
>         usb_role_switch_unregister(data->role_sw);
> +       fwnode_handle_put(software_node_fwnode(&intel_xhci_usb_node));
> +
>         return 0;
>  }
>
> --
> 2.23.0.rc1
>


-- 
With Best Regards,
Andy Shevchenko
