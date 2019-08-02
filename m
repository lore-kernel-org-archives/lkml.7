Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DD8C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B552087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564759805;
	bh=exi+9OQEtZ7oI8S+4n8aYHHOqvpX9ctCa2KPyOEi70c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F58WxtFWMNnhz+bZv0qcfU1j4q8rwfFU1zEainWptJYtN2t8H7W9tzbswNdIWa1W0
	 hllPxkYzR29nwoWC5sIT3xTwu4HQWciImALhNpNgSUZr4AqeUQcEQYM9/ixFQwIrxV
	 zY3IjK3JK9fJt3miMtMXhg4PtLdjL26VACvhLr5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbfHBPaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732277AbfHBPaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:30:04 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E14021783;
        Fri,  2 Aug 2019 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564759803;
        bh=exi+9OQEtZ7oI8S+4n8aYHHOqvpX9ctCa2KPyOEi70c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AwJ+Y8vA75d/vMycBEhTJYNB+zLZA65/L8ndELebOL1ft/DqAQHcTHqtXoNjI+hyR
         wnANR3KMbhOl9eMeXeGdtg+otBpea3bxFK1TSVs6k6IAs/alHczr0U0oMWEdOm9fCU
         TrwwVTqLcoHrMnL8pt5ifUmEnAxO22zPH+lKfUOg=
Received: by mail-qt1-f182.google.com with SMTP id d23so74320206qto.2;
        Fri, 02 Aug 2019 08:30:03 -0700 (PDT)
X-Gm-Message-State: APjAAAWhEbJgIPOKpRnLV/XmmQ/qExZorShaNg1bOYaRfzZjF3jUsc14
        Vh3Zl45VOIxA9XOuapYzUVmORcXmQSZTEY7L8w==
X-Google-Smtp-Source: APXvYqzityF7o7KUO1Njby8yuDCjj0HJCmvW0poZGiH53DOdLh77y5Ia90Sp+PIkYjkjHRHG/c/ZknfJJgTyRKPgjJw=
X-Received: by 2002:a0c:b627:: with SMTP id f39mr99725316qve.72.1564759802191;
 Fri, 02 Aug 2019 08:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190801184346.7015-1-dinguyen@kernel.org> <CAL_Jsq+PRKGwdozr3VECpk2ugrOuWd4CYnRSR7ChyPOKgheYkw@mail.gmail.com>
 <92009928-3df1-1573-7d67-40e79d77c77e@kernel.org>
In-Reply-To: <92009928-3df1-1573-7d67-40e79d77c77e@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 2 Aug 2019 09:29:50 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+XfAO5BFnmhekUv1gKSOeVn03k7KtWWp2DgomxFL+UMQ@mail.gmail.com>
Message-ID: <CAL_Jsq+XfAO5BFnmhekUv1gKSOeVn03k7KtWWp2DgomxFL+UMQ@mail.gmail.com>
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

On Fri, Aug 2, 2019 at 8:42 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
>
>
> On 8/2/19 9:37 AM, Rob Herring wrote:
> > On Thu, Aug 1, 2019 at 12:44 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
> >>
> >> From: Dinh Nguyen <dinh.nguyen@intel.com>
> >>
> >> The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
> >> default. Until recently, the DMA controller was brought out of reset by the
> >> bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals that
> >> are not used are held in reset and are left to Linux to bring them out of
> >> reset.
> >
> > You can fix this in the kernel, but any versions before this change
> > will remain broken. IMO, the u-boot change should be reverted because
> > it is breaking an ABI (though not a good one).
> >
>
> Right, there exists in U-Boot to support legacy platforms before this
> recent change. This would be for future versions.
>
> >> Add a mechanism for getting the reset property and de-assert the primecell
> >> module from reset if found. This is a not a hard fail if the reset property
> >> is not present in the device tree node, so the driver will continue to probe.
> >
> > I think this belongs in the AMBA bus code, not the DT code, as that is
> > where we already have clock control code for similar reasons.
> >
>
> Ok.
>
> >>
> >> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> >> ---
> >>  drivers/of/platform.c | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> >> index 7801e25e6895..d8945705313d 100644
> >> --- a/drivers/of/platform.c
> >> +++ b/drivers/of/platform.c
> >> @@ -21,6 +21,7 @@
> >>  #include <linux/of_irq.h>
> >>  #include <linux/of_platform.h>
> >>  #include <linux/platform_device.h>
> >> +#include <linux/reset.h>
> >>
> >>  const struct of_device_id of_default_bus_match_table[] = {
> >>         { .compatible = "simple-bus", },
> >> @@ -229,6 +230,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
> >>         struct amba_device *dev;
> >>         const void *prop;
> >>         int i, ret;
> >> +       struct reset_control *rstc;
> >>
> >>         pr_debug("Creating amba device %pOF\n", node);
> >>
> >> @@ -270,6 +272,18 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
> >>                 goto err_free;
> >>         }
> >>
> >> +       /*
> >> +        * reset control of the primecell block is optional
> >> +        * and will not fail if the reset property is not found.
> >> +        */
> >> +       rstc = of_reset_control_get_exclusive(node, "dma");
> >
> > 'dma' doesn't sound very generic.
> >
>
> how about 'primecell' ?

It should be based on what is in the TRMs. Unlike pclk, there doesn't
appear to be a standard name or number of resets:

pl011: PRESETn and nUARTRST
pl330: ARESETn

Can't you just retrieve all of them and deassert them all and ignore the name?

Also, you might need to use the shared variant as the core code has to
work for either dedicated or shared resets.

Rob
