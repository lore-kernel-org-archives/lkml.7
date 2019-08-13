Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13603C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE79206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565733012;
	bh=qZlws6v+N8kI1UKOVdpEHH2UF31aMI5gwG/rOfFqHzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tvC3pNpvH9KJTKCz0zR/QA486CZjLCfR/kQZpXq4e+JCDqgb94Gz9PNnBK/gE23T2
	 wBeyMsgTDdPD8R8DGvPqz8UdPvZXssWjQILPzQtjMsY1sgpmToSDs2yNFrT9GNz1Bw
	 NTcJlSF2chW1IlNiSO9iuqrgRxfiRd5D3fB3cxqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfHMVuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfHMVuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:50:11 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A8A20842;
        Tue, 13 Aug 2019 21:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565733010;
        bh=qZlws6v+N8kI1UKOVdpEHH2UF31aMI5gwG/rOfFqHzw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sqrnJ/m/lZjwrQjDTqlrzGi1anuWpCof3q1L4UIhTXIXaYkQySPbMoiC5CnzVwWWc
         9148vWRJwV4fBbIZRDHWDqWS4brABGhBzsHkksdoqSgu5KWedwbYeyOfL7UBBRyoJR
         Bz5WUcSlul2NfHeUcZ1jzK8ApAkBqsJYaJLA/Zfo=
Received: by mail-qk1-f177.google.com with SMTP id s145so80982484qke.7;
        Tue, 13 Aug 2019 14:50:09 -0700 (PDT)
X-Gm-Message-State: APjAAAU5X3DWyr5I4q02Mjg0VEzG1I5wYL4UzGnYxWx3SnylrQ+6hVUW
        BS2B8dVgUTWTDJsdvhL+A7ev9Hy3z6pqQbicnQ==
X-Google-Smtp-Source: APXvYqzMYP4+7zj4XfcIegLbEaqHi41gyoiH8MyCXiN9EIcjrt64BloYhGN0yKxe/9u4lsm4KPn2KKl8nfimpDdfVJk=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr34676994qke.393.1565733009197;
 Tue, 13 Aug 2019 14:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190808140153.9156-1-dinguyen@kernel.org>
In-Reply-To: <20190808140153.9156-1-dinguyen@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Aug 2019 15:49:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLJN3n6A3NWX=pEYSPfnvQFsdBYwqr9iREHWGFwL2wHYQ@mail.gmail.com>
Message-ID: <CAL_JsqLJN3n6A3NWX=pEYSPfnvQFsdBYwqr9iREHWGFwL2wHYQ@mail.gmail.com>
Subject: Re: [PATCHv3] drivers/amba: add reset control to amba bus probe
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Russell

On Thu, Aug 8, 2019 at 8:02 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
> default. Until recently, the DMA controller was brought out of reset by the
> bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals that
> are not used are held in reset and are left to Linux to bring them out of
> reset.
>
> Add a mechanism for getting the reset property and de-assert the primecell
> module from reset if found. This is a not a hard fail if the reset property
> is not present in the device tree node, so the driver will continue to probe.
>
> Because there are different variants of the controller that may have multiple
> reset signals, the code will find all reset(s) specified and de-assert them.
>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v3: add a reset_control_put()
>     add error handling for -EPROBE_DEFER
> v2: move reset control to bus code
>     find all reset properties and de-assert them
> ---
>  drivers/amba/bus.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 100e798a5c82..00e68ea416ca 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -18,6 +18,7 @@
>  #include <linux/limits.h>
>  #include <linux/clk/clk-conf.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>
>  #include <asm/irq.h>
>
> @@ -401,6 +402,28 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>         ret = amba_get_enable_pclk(dev);
>         if (ret == 0) {
>                 u32 pid, cid;
> +               int count;
> +               struct reset_control *rstc;
> +
> +               /*
> +                * Find reset control(s) of the amba bus and de-assert them.
> +                */
> +               count = reset_control_get_count(&dev->dev);
> +               while (count > 0) {
> +                       rstc = of_reset_control_get_shared_by_index(dev->dev.of_node, count - 1);
> +                       if (IS_ERR(rstc)) {
> +                               if (PTR_ERR(rstc) == -EPROBE_DEFER) {
> +                                       ret = -EPROBE_DEFER;
> +                               } else {
> +                                       dev_err(&dev->dev, "Can't get amba reset!\n");
> +                               }
> +                               break;
> +                       } else {

You can remove the else here and save some indentation on the rest.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>


> +                               reset_control_deassert(rstc);
> +                               reset_control_put(rstc);
> +                               count--;
> +                       }
> +               }
>
>                 /*
>                  * Read pid and cid based on size of resource
> --
> 2.20.0
>
