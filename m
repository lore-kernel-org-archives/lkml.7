Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89424C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5080A20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="d+AoqMuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfEFJux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:50:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42334 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfEFJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:50:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id w23so8662214lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIR8Y8TRD7JDnicAYZXuKYFswk6mChm5W5k3uZy/A8k=;
        b=d+AoqMuQ+gxyQUTlKLM437WV02AuIWPqZZ1yHOnsCKYwHu0AhjGiAuzSJT5RiYJl6B
         Qce06yQsR/XVFG8X7cZyoRD9930ckqJBHB/8sP0tfFs8/hzMGrx2NSSUxhopMiE/PLH+
         aciy+GxGj8EV21P7qMeOXKCclGn861HWkgFXOHLW9xZRbzh6O8lSVyq93cLbcWMzdbSC
         xXIf5FqvX7wSFeKtyGEgENldh4VFOAFHKWx1khPTu3GSXl6uujnpOfDSEIybCvn5n2C9
         r5hfZos5c/011hdQS3RHWVTiCflO9iJqgVmtGKR7maoGkwNAmR0k4VJey1zWt+HbpGy8
         sz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIR8Y8TRD7JDnicAYZXuKYFswk6mChm5W5k3uZy/A8k=;
        b=Syt/yucEWu/IAPeQkrb1UTjvOmg6dBQO3B9J8rpB8+4L+Z63lxRbroXNg/mEueYSC2
         fPoi7JpuVgvCps2IjHtIV9DVFEJPiVVU30GsXKqs/zNKun7ry1c41ldeWm3C6esyEy4T
         z3noJtYOzEEBn9Xr7kKR1etoCl1SR8ZosAayE/j1NINuTB25TG9rMY/6OmIO/NCOCaiy
         c6cGn142Vh0OqrsQviOk0BdyyEeGRN/jiK97vQZP48yurwG7yT4AxkEcQEoNXDhYR7hn
         PxX2FKrJZorJhPFYa844E8eXUa1SrinVa0j6i2q9r+tpniD5WEHB6cP6S5KDU6Ugp/9r
         GHPQ==
X-Gm-Message-State: APjAAAU/vhZudqPg73+tpYz63a2xR9pJF5fcN7t2j9KASnwlPljV6WWC
        RfIehrLUeW0MFfNb5jGgAymQUK60VXmoCWvWbCTeIQ==
X-Google-Smtp-Source: APXvYqxV/hG6zQ32Xe6xOpYrPEyzfvj/VSnJeB1RXBGmX03eV/CXV7dEIw0VnFDK5CIZjeeoNL7naRm+Scii7rPJ9EU=
X-Received: by 2002:a19:4f54:: with SMTP id a20mr12191013lfk.136.1557136249774;
 Mon, 06 May 2019 02:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <1556795761-21630-1-git-send-email-yash.shah@sifive.com>
 <1556795761-21630-2-git-send-email-yash.shah@sifive.com> <4072c812-d3bf-9ad5-2b30-6b2a5060bb55@arm.com>
In-Reply-To: <4072c812-d3bf-9ad5-2b30-6b2a5060bb55@arm.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Mon, 6 May 2019 15:20:13 +0530
Message-ID: <CAJ2_jOFz907Kf5fhQ2a6K3Fyhr_h2PjvGfpQKxN-OQLRrzP=Ng@mail.gmail.com>
Subject: Re: [PATCH] edac: sifive: Add EDAC platform driver for SiFive SoCs
To:     James Morse <james.morse@arm.com>
Cc:     linux-edac@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Borislav Petkov <bp@alien8.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mchehab@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi james,

On Thu, May 2, 2019 at 10:12 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Yash,
>
> Sorry for the delay on the earlier version of this - I was trying to work out what happens
> when multiple edac drivers probe based on DT...
>
>
> On 02/05/2019 12:16, Yash Shah wrote:
> > The initial ver of EDAC driver supports:
> > - ECC event monitoring and reporting through the EDAC framework for SiFive
> >   L2 cache controller.
> >
>
> You probably don't want this bit preserved in the kernel log:
> {
>
> > This patch depends on patch
> > 'RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs'
> > https://lkml.org/lkml/2019/5/2/309
>
> }
>
> > The EDAC driver registers for notifier events from the L2 cache controller
> > driver (arch/riscv/mm/sifive_l2_cache.c) for L2 ECC events
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
>
> (if you put it here, it gets discarded when the patch is applied)

Ok, will move it down here.

>
> Having an separately posted dependency like this is tricky, as this code can't be
> used/tested until the other bits are merged.
>
>
> >  MAINTAINERS                |   6 +++
> >  arch/riscv/Kconfig         |   1 +
> >  drivers/edac/Kconfig       |   6 +++
> >  drivers/edac/Makefile      |   1 +
> >  drivers/edac/sifive_edac.c | 121 +++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 135 insertions(+)
> >  create mode 100644 drivers/edac/sifive_edac.c
>
> > diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
> > new file mode 100644
> > index 0000000..eb7a9b9
> > --- /dev/null
> > +++ b/drivers/edac/sifive_edac.c
> > @@ -0,0 +1,121 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SiFive Platform EDAC Driver
> > + *
> > + * Copyright (C) 2018-2019 SiFive, Inc.
> > + *
> > + * This driver is partially based on octeon_edac-pc.c
> > + *
> > + */
> > +#include <linux/edac.h>
> > +#include <linux/platform_device.h>
> > +#include "edac_module.h"
> > +
> > +#define DRVNAME "sifive_edac"
> > +
> > +extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
> > +extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
>
> Ideally these would live in some header file.

Will move the externs in sifive_l2_cache header file

>
>
> > +struct sifive_edac_priv {
> > +     struct notifier_block notifier;
> > +     struct edac_device_ctl_info *dci;
> > +};
> > +
> > +/**
> > + * EDAC error callback
> > + *
> > + * @event: non-zero if unrecoverable.
> > + */
> > +static
> > +int ecc_err_event(struct notifier_block *this, unsigned long event, void *ptr)
> > +{
> > +     const char *msg = (char *)ptr;
> > +     struct sifive_edac_priv *p;
> > +
> > +     p = container_of(this, struct sifive_edac_priv, notifier);
> > +
> > +     if (event)
> > +             edac_device_handle_ue(p->dci, 0, 0, msg);
> > +     else
> > +             edac_device_handle_ce(p->dci, 0, 0, msg);
>
> This would be easier to read if your SIFIVE_L2_ERR_TYPE_UE were exposed via some header file.

sure.

>
>
> > +
> > +     return NOTIFY_STOP;
>
> Your notifier register calls are EXPORT_SYMBOL()d, but Kconfig forbids building this as a
> module, so its not for this driver. If there is another user of this notifier-chain, won't
> NOTIFY_STOP here break it?
>

Yes, you are right. Will change it to NOTIFY_OK

>
> > +}
> > +
> > +static int ecc_register(struct platform_device *pdev)
> > +{
> > +     struct sifive_edac_priv *p;
> > +
> > +     p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
> > +     if (!p)
> > +             return -ENOMEM;
> > +
> > +     p->notifier.notifier_call = ecc_err_event;
> > +     platform_set_drvdata(pdev, p);
> > +
> > +     p->dci = edac_device_alloc_ctl_info(sizeof(*p), "sifive_ecc", 1,
>
> sizeof(*p) here is how much space in struct edac_device_ctl_info you need for private
> storage... but you never touch p->dci->pvt_info, so you aren't using it.
>
> 0?

Yes, will change it.

>
>
> > +                                         "sifive_ecc", 1, 1, NULL, 0,
> > +                                         edac_device_alloc_index());
> > +     if (IS_ERR(p->dci))
> > +             return PTR_ERR(p->dci);
> > +
> > +     p->dci->dev = &pdev->dev;
> > +     p->dci->mod_name = "Sifive ECC Manager";
> > +     p->dci->ctl_name = dev_name(&pdev->dev);
> > +     p->dci->dev_name = dev_name(&pdev->dev);
> > +
> > +     if (edac_device_add_device(p->dci)) {
> > +             dev_err(p->dci->dev, "failed to register with EDAC core\n");
> > +             goto err;
> > +     }
> > +
> > +     register_sifive_l2_error_notifier(&p->notifier);
> > +
> > +     return 0;
> > +
> > +err:
> > +     edac_device_free_ctl_info(p->dci);
> > +
> > +     return -ENXIO;
> > +}
>
> > +struct platform_device *sifive_pdev;
>
> static?

Yes, will change this too.

>
>
> > +static int __init sifive_edac_init(void)
> > +{
> > +     int ret;
> > +
> > +     sifive_pdev = platform_device_register_simple(DRVNAME, 0, NULL, 0);
> > +     if (IS_ERR(sifive_pdev))
> > +             return PTR_ERR(sifive_pdev);
> > +
> > +     ret = ecc_register(sifive_pdev);
> > +     if (ret)
> > +             platform_device_unregister(sifive_pdev);
> > +
> > +     return ret;
> > +}
> > +
> > +static void __exit sifive_edac_exit(void)
> > +{
> > +     ecc_unregister(sifive_pdev);
> > +     platform_device_unregister(sifive_pdev);
> > +}
>
> Looks good to me. I think this patch should go with its two dependencies, I'm not sure why
> it got split off...
>
> Reviewed-by: James Morse <james.morse@arm.com>
>

Thanks for your review.

- Yash

>
> Thanks,
>
> James
