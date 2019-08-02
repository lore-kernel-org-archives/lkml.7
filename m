Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A75C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7402A2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564756637;
	bh=vd9Dv8dBGevOpOI7ckz0Ps8LNrJ4SV3q4dIJDCwbkTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rptzAFvDi56+EteXsY4NV4CXCZ6H/aKx/1lMaRazW6GdXFge+a4It45b6J6dCdP0A
	 AXrMxhZEqnKt3VSxYxprwo5cSGRPZ6oTLvqWyqPSsmA0oFjJ9CNfI7fLOANTTvlxvw
	 FH1UC17tU4RRi53sJXm53EnLL0CU7FjWUSb7wgUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394993AbfHBOhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392460AbfHBOhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:37:15 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C764D21726;
        Fri,  2 Aug 2019 14:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564756634;
        bh=vd9Dv8dBGevOpOI7ckz0Ps8LNrJ4SV3q4dIJDCwbkTI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pIh3/U350ApivszFbRNnFktXokXBKr+wTTQmTmkTcXIX77COsAo0TgRe92rHIbR0y
         AeUVQCIkxbsvc60rImMt90f9Qfk0s+a1NDKQxNR8zuysR3wVis/STJnYCS/0bQnTmz
         YqAKifhFLFjtFzCsZ+eZ0aQV0tGm9ea1esGFu1Xg=
Received: by mail-qk1-f179.google.com with SMTP id 201so54907997qkm.9;
        Fri, 02 Aug 2019 07:37:14 -0700 (PDT)
X-Gm-Message-State: APjAAAVq7uE1i/XhWmubbBf9vjI07iLLMsLKPO7EtwoVPl6U/O4hvR9a
        ZpvFcuPTb1Z0Mjz1alEINyJhQ4IhcUIyvhST7Q==
X-Google-Smtp-Source: APXvYqy2cwj//e24fge1qT8CDOe9Xb/QmIUI69Wrhfjrl0tNCfhoSm7l0dvzzTg52YBKBW6aTsIA+0MW56bbtCA5ys8=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr25665655qke.393.1564756633987;
 Fri, 02 Aug 2019 07:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190801184346.7015-1-dinguyen@kernel.org>
In-Reply-To: <20190801184346.7015-1-dinguyen@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 2 Aug 2019 08:37:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+PRKGwdozr3VECpk2ugrOuWd4CYnRSR7ChyPOKgheYkw@mail.gmail.com>
Message-ID: <CAL_Jsq+PRKGwdozr3VECpk2ugrOuWd4CYnRSR7ChyPOKgheYkw@mail.gmail.com>
Subject: Re: [PATCH] drivers/amba: add reset control to primecell probe
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Dinh Nguyen <dinh.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 12:44 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> From: Dinh Nguyen <dinh.nguyen@intel.com>
>
> The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
> default. Until recently, the DMA controller was brought out of reset by the
> bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals that
> are not used are held in reset and are left to Linux to bring them out of
> reset.

You can fix this in the kernel, but any versions before this change
will remain broken. IMO, the u-boot change should be reverted because
it is breaking an ABI (though not a good one).

> Add a mechanism for getting the reset property and de-assert the primecell
> module from reset if found. This is a not a hard fail if the reset property
> is not present in the device tree node, so the driver will continue to probe.

I think this belongs in the AMBA bus code, not the DT code, as that is
where we already have clock control code for similar reasons.

>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/of/platform.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 7801e25e6895..d8945705313d 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>
>  const struct of_device_id of_default_bus_match_table[] = {
>         { .compatible = "simple-bus", },
> @@ -229,6 +230,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>         struct amba_device *dev;
>         const void *prop;
>         int i, ret;
> +       struct reset_control *rstc;
>
>         pr_debug("Creating amba device %pOF\n", node);
>
> @@ -270,6 +272,18 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>                 goto err_free;
>         }
>
> +       /*
> +        * reset control of the primecell block is optional
> +        * and will not fail if the reset property is not found.
> +        */
> +       rstc = of_reset_control_get_exclusive(node, "dma");

'dma' doesn't sound very generic.

> +       if (!IS_ERR(rstc)) {
> +               reset_control_deassert(rstc);
> +               reset_control_put(rstc);
> +       } else {
> +               pr_debug("amba: reset control not found\n");
> +       }
> +
>         ret = amba_device_add(dev, &iomem_resource);
>         if (ret) {
>                 pr_err("amba_device_add() failed (%d) for %pOF\n",
> --
> 2.20.0
>
