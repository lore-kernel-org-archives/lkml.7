Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9318C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9723A2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbfEWVnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:43:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35584 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388219AbfEWVnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:43:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id n14so6879183otk.2;
        Thu, 23 May 2019 14:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Hbgz3hxp/a58+ErXmRrOWz2gL6UQg1j+v6ltJTHI20=;
        b=g+AeDYejN8Cqvo7XGZ0tA4GyxBbiPJD/0MJJeI8oHDK+l11vr2TyG50riYCROQ3Xmo
         bpasr2eo39pbR+8yQZdNbqvnwAQV/aC106UKDNi9DnsiI+bhVK7E2Kl4+nbB9LA60yzP
         Zv8SVpev/ZlJpncbBI+Y9jcnr8kSWSKA3/otIkfhN/7VWe4rzoxwqXT0+DoQxOQ8rPjt
         Vc/Nf4ePwlkY9G1I4SjZ9/N/+SuwoAOppe5wGqlGmLYHrqKjYwRz8iukQeePc04KeYv+
         lWwxUczabx4sY9TfUHR/hA8JeKVy8iphhHD6x0azrzBfYSwg2xZLl+5+oIOf5GYyWQQ9
         mwZg==
X-Gm-Message-State: APjAAAWhqU6K3l5xOlSgmKJQE3u0JfJZWwgcevAbPDbdC19qp5vi8W1m
        fWQcc+yeSh0UOY1TPL6jLEwuzhRLRZw=
X-Google-Smtp-Source: APXvYqyBQe0jIYg3Olqc4vtTXDpQjou0tLjVoPVwklion2GyfaA+cAVbLG9kyUt5KfbBAzI5r+2WmQ==
X-Received: by 2002:a05:6830:1d5:: with SMTP id r21mr5182368ota.155.1558647830206;
        Thu, 23 May 2019 14:43:50 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id j189sm241147oia.2.2019.05.23.14.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 14:43:49 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id y124so5552389oiy.3;
        Thu, 23 May 2019 14:43:49 -0700 (PDT)
X-Received: by 2002:aca:ed57:: with SMTP id l84mr366380oih.13.1558647828917;
 Thu, 23 May 2019 14:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180105094009.22599-1-ran.wang_1@nxp.com> <20180105094009.22599-4-ran.wang_1@nxp.com>
In-Reply-To: <20180105094009.22599-4-ran.wang_1@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 23 May 2019 16:43:36 -0500
X-Gmail-Original-Message-ID: <CADRPPNS7iai2DwBjV0XTmxJKJ-diGzYMDg9Bfavjmai5Q=EW+g@mail.gmail.com>
Message-ID: <CADRPPNS7iai2DwBjV0XTmxJKJ-diGzYMDg9Bfavjmai5Q=EW+g@mail.gmail.com>
Subject: Re: [PATCH 4/4] xHCI: Handle dwc3 erratum on USB3 HW LPM feature.
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 5, 2018 at 4:00 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Synopsys STARS ticket: 90000969472(A-010131)
>
> Description: This erratum is applicable for the USB 3.0 Super
> Speed host mode operation. When the U2 timer expires while in
> U1 mode, the USB 3.0 controller completes a U1->U2 entry operation
> lasting three mac3_clk (24 ns). If the xHCI driver issues a
> U3 request during this operation, thecontroller drops this request.
>
> Impact: The controller ignores the request when the xHCI driver
> programs the U3 entry (PORTSC.PLS = U3).
>
> Workaround:
> 1. Before initiating U3 entry, save PORTPMSC.
> 2. Disable U2 entry by programming PORTPMSC[U2 Timeout] = h'FF.
> 3. After U3 entry, re-enable the U2 timer by programming PORTPMSC
> with the value saved in Step 1.

Hi Mathias,

Could you help to review this patch?

Hi Ran,

Since this is an dwc3 related hardware issue, can it be addressed in
the dwc3 layer instead of in the common xhci layer?

>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/usb/host/xhci-hub.c  |   22 ++++++++++++++++++++++
>  drivers/usb/host/xhci-plat.c |    6 +++++-
>  drivers/usb/host/xhci.h      |    1 +
>  3 files changed, 28 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index f070f94..a61185e 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -676,12 +676,34 @@ void xhci_set_link_state(struct xhci_hcd *xhci, __le32 __iomem **port_array,
>                                 int port_id, u32 link_state)
>  {
>         u32 temp;
> +       u32 portpmsc_u2_backup = 0;
> +
> +       /* Backup U2 timeout info before initiating U3 entry erratum A-010131 */
> +       if (xhci->shared_hcd->speed >= HCD_USB3 &&
> +                       link_state == USB_SS_PORT_LS_U3 &&
> +                       (xhci->quirks & XHCI_DIS_U1U2_WHEN_U3)) {
> +               portpmsc_u2_backup = readl(port_array[port_id] + PORTPMSC);
> +               portpmsc_u2_backup &= PORT_U2_TIMEOUT_MASK;
> +               temp = readl(port_array[port_id] + PORTPMSC);
> +               temp |= PORT_U2_TIMEOUT_MASK;
> +               writel(temp, port_array[port_id] + PORTPMSC);
> +       }
>
>         temp = readl(port_array[port_id]);
>         temp = xhci_port_state_to_neutral(temp);
>         temp &= ~PORT_PLS_MASK;
>         temp |= PORT_LINK_STROBE | link_state;
>         writel(temp, port_array[port_id]);
> +
> +       /* Restore U2 timeout info after U3 entry complete */
> +       if (xhci->shared_hcd->speed >= HCD_USB3 &&
> +                       link_state == USB_SS_PORT_LS_U3 &&
> +                       (xhci->quirks & XHCI_DIS_U1U2_WHEN_U3)) {
> +               temp = readl(port_array[port_id] + PORTPMSC);
> +               temp &= ~PORT_U2_TIMEOUT_MASK;
> +               temp |= portpmsc_u2_backup;
> +               writel(temp, port_array[port_id] + PORTPMSC);
> +       }
>  }
>
>  static void xhci_set_remote_wake_mask(struct xhci_hcd *xhci,
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 1969e56..616c56e 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -266,8 +266,12 @@ static int xhci_plat_probe(struct platform_device *pdev)
>         if (device_property_read_bool(sysdev, "usb2-lpm-disable"))
>                 xhci->quirks |= XHCI_HW_LPM_DISABLE;
>
> -       if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
> +       if (device_property_read_bool(sysdev, "usb3-lpm-capable")) {
>                 xhci->quirks |= XHCI_LPM_SUPPORT;
> +               if (device_property_read_bool(sysdev,
> +                                       "snps,dis-u1u2-when-u3-quirk"))
> +                       xhci->quirks |= XHCI_DIS_U1U2_WHEN_U3;
> +       }
>
>         if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
>                 xhci->quirks |= XHCI_BROKEN_PORT_PED;
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index b966cd8..9704779 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1835,6 +1835,7 @@ struct xhci_hcd {
>  /* Reserved. It was XHCI_U2_DISABLE_WAKE */
>  #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL        (1 << 28)
>  #define XHCI_HW_LPM_DISABLE    (1 << 29)
> +#define XHCI_DIS_U1U2_WHEN_U3 (1 << 30)
>
>         unsigned int            num_active_eps;
>         unsigned int            limit_active_eps;
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
