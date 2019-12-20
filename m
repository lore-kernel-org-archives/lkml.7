Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981D4C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A0B2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCGsuxyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLTAON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:14:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38027 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLTAON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:14:13 -0500
Received: by mail-io1-f67.google.com with SMTP id v3so7657607ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 16:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSBzbWB7QqhpPeTI1Nu3CdSKSF5DFJ1xy+2l/2BwbzI=;
        b=TCGsuxyN57BiemwmY4L0TI6RbOFu/6NkPfJZhjiD1hszmXXVHzuglib54KMoo1cm6c
         IqJ8GX4xvmwU9uDTh2uZQ5JqrEU5nQPG7A3m6CocVr3rTBosFPQ7hyXRLG5y0cuZQFAP
         p9aTUQkl8Knj7CQxm0l+3K5N0rw/oA8ewX/3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSBzbWB7QqhpPeTI1Nu3CdSKSF5DFJ1xy+2l/2BwbzI=;
        b=MEW41e8xIztbouHl0UMhxQsj+lxt+E16caDXiJd0JFcXpTeKcxnEwH9VGH4TEV8PO+
         WsiH3j4B12DbefOsHFE0w8B87EJ9vftwwLGBOP9V3f2IVVxHG6dmuxZUXTPDv+HMYH48
         OKjgTw1QkG3NCYEgIk6OBIItC/+FWsPPwSuTc+19HFPcyfswFg96sWqkiYfOG7mrBGz4
         vRaXylbEVPacOlJobtkQhwmA4EWfd/MuIN7ALOenggIfM8M8FwFX+iy7ahA9ef7jeQBE
         nXWaGLAH5QM49kAcrprVocRs7F6FmlXPKDvJESq7nJ7x/EYA/HZQhK8QX8SOlg1QcRzh
         GI1A==
X-Gm-Message-State: APjAAAVtqK/AexlCeOBhTt2NF8Sc4jBIljHRCPX0LlH50cKPlYC2r3rL
        hheoLlLhTBZF8Y7H3dMg6ZwqETvO4XdoZRJmIpqERg==
X-Google-Smtp-Source: APXvYqzKI77IzPWHmf6MLacA03+yp3D4IujBehG9GJ1A7DXEy0QkZWv8M5GBrSKsp+eOPeLiRwRHUss3MtNpuWX7V6s=
X-Received: by 2002:a5d:89c8:: with SMTP id a8mr7781523iot.186.1576800851978;
 Thu, 19 Dec 2019 16:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20191219201340.196259-1-pmalani@chromium.org> <20191219201340.196259-2-pmalani@chromium.org>
In-Reply-To: <20191219201340.196259-2-pmalani@chromium.org>
From:   Benson Leung <bleung@chromium.org>
Date:   Thu, 19 Dec 2019 16:13:59 -0800
Message-ID: <CANLzEktdkZvdpJusvC67xjyxw5+botWH+TLBmfT8hg6u6P+yPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: cros_ec: Add usbpd-notify to usbpd_charger
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Prashant,

On Thu, Dec 19, 2019 at 12:14 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Add the cros-usbpd-notify driver as a cell for the cros_usbpd_charger
> subdevice on non-ACPI platforms.
>
> This driver allows other cros-ec devices to receive PD event
> notifications from the Chrome OS Embedded Controller (EC) via a
> notification chain.
>
> Change-Id: I4c062d261fa1a504b43b0a0c0a98a661829593b9

Make sure to strip Gerrit's Change-Ids before sending upstream. They
don't have any meaning outside of chromiumos.

> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index c4b977a5dd966..1dde480f35b93 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
>  static const struct mfd_cell cros_usbpd_charger_cells[] = {
>         { .name = "cros-usbpd-charger", },
>         { .name = "cros-usbpd-logger", },
> +#ifndef CONFIG_ACPI
> +       { .name = "cros-usbpd-notify", },
> +#endif
>  };
>
>  static const struct cros_feature_to_cells cros_subdevices[] = {
> --
> 2.24.1.735.g03f4e72817-goog
>


-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
