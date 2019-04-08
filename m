Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFA5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59C120857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWuvfpEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfDHQnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:43:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42012 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfDHQnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:43:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so7631235pgh.9;
        Mon, 08 Apr 2019 09:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AcJLUK/8Iy4Wan47KQQy9j5Grf/VAPXWacmY5zQc5Y=;
        b=bWuvfpEoh8WiJ2qcx+G0m3DX6GQTrcayjkwoH1DyR+3cNEVdhKPRy5Xliw7skrPhIe
         2RS+ozSYJujZ3ht5TmDzZdxMvWgvW4X0j7auN9zh/X2FJXhRHo7bDMKuvochS5uQjVmv
         pELHNrokWzQeUYbYa1VbvH2WTF1Hg/US73EYkL8IgrXInQJ5WQBmYcoYco2zAh9VQLzt
         Ezaj2HcX8V1QfOvhee5QoP4Qug4S5/pDLesegrqG91zwXwVlzzXvjZpt+Xh4yoRPAYMZ
         2LQU8FmvnHhNaW6zQF4M5tEmq90tFpVKbNyhPPGr0Nt3BoKIYYUkT7ZA5M9YXh9btV9P
         KZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AcJLUK/8Iy4Wan47KQQy9j5Grf/VAPXWacmY5zQc5Y=;
        b=BLLzr0vYNVg9TJprB5sb7qV35NEN4vCXSytlNrQBv05wtpMgKg68J5N2tvzpGdAGBc
         rGZIeql/zFXAIbcYsx1A5hSahtvCMfdfKXohs5vEC9UwNwTAYQNRZSQzpEQYzI86Srwe
         4IN+K1YTrzwyHTRQWrggXJbR+cc+Lq9nRCz3kGK6gjSvOqE2vMlOO8+QSlel/9YAAJ4W
         x1IRavNAVPFLZKJuQsbDEMfEC/BhKmh+yeARH4EcFJ2p/xW0ZonzTFvelOz8NU+V8po1
         2+HIKgTMaiiPuxfFncbAQmWNTdZ8vPMPPpEKBSFg0LAQVQfDPaRxB9qpwGWm530hOFaR
         MyPA==
X-Gm-Message-State: APjAAAUIuUn5OAwpB9+CdtTRXVZGQ1t/W7Yymx/c1Jwhvp6IxHN3er6L
        RwLTgUEIxmHmQLxVk2RywTqQWIAoXPiTucbueWA=
X-Google-Smtp-Source: APXvYqwmlIqlb3Bhp0SOIhraIZIW32mx1aIYrO+OJHcH9obLjmYhXyOv7/a33VB6L83wnK12rDxdNiHCFRI7iMxYe2U=
X-Received: by 2002:a65:4302:: with SMTP id j2mr28025853pgq.291.1554741784310;
 Mon, 08 Apr 2019 09:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190403164537.24643-1-heikki.krogerus@linux.intel.com> <20190403164537.24643-11-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190403164537.24643-11-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Apr 2019 19:42:52 +0300
Message-ID: <CAHp75VeTUCQax01xVNg7N6oAYKoxadX9vL-X9oEQFHHJ6OSrpg@mail.gmail.com>
Subject: Re: [PATCH 10/11] platform/x86: intel_cht_int33fe: Link with external
 dependencies using fwnodes
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
> Supplying also external devices - the DisplayPort connector
> and the USB role switch - software fwnodes. After this the
> driver has access to all the components tied to the USB
> Type-C connector and can start creating software node
> references to actually associate them with the USB Type-C
> connector device.

> +static int role_switch_match(struct device *dev, void *name)
> +{
> +       return !strcmp(dev_name(dev), name);
> +}
> +
> +static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
> +{

> +       /* First let's find xHCI PCI device */
> +       pdev = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
> +       if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
> +               return -ENODEV;
> +

> +       /* Then the child platform device */
> +       p = device_find_child(&pdev->dev, "intel_xhci_usb_sw",
> +                             role_switch_match);

We have already similar code in kernel
(drivers/nvdimm/claim.c::namespace_match), perhaps
you at least can (locally) introduce

static int match_name(...) // or re-use from drivers/base/bus.c
{
...
}

static device_find_child_by_name(...)
{
...
}

which we may move to the driver core now or later on.

> +       pci_dev_put(pdev);
> +       if (!p)
> +               return -EPROBE_DEFER;
> +

> +       /* Finally the mux device */
> +       dev = device_find_child(p, "intel_xhci_usb_sw-role-switch",
> +                               role_switch_match);

Ditto.

> +       put_device(p);
> +       if (!dev)
> +               return -EPROBE_DEFER;

> +       return 0;

> +}

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

Can't generic helper be in charge of doing this, i.e. chaining fwnodes?

///
void fwnode_chain(parent, new)
{
...
}
///

fwnode_chain(data->dp, fwnode);


> +
> +       return 0;
> +}

--
With Best Regards,
Andy Shevchenko
