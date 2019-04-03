Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9627C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678BC2148E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554267437;
	bh=O2dWtnHMvIucSN9og0FGKl2+3z34XXj7gTmGiID9qk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Tcwu1xmcZMmVDmrkCTB+hfhmXGEiz3TvKlSgjs7J8IX1B3XmPIZPNXgw002LBQUGY
	 WS/0j7bDgXgXiTwVXIXMzOoaiKZuz5oGf2f80jb2gSvLbQYfaYD/KEQH9RTkhjubgt
	 WXigh/AZMH2fHhq6qbXtTdE/7wq6J2zxkUNzHwaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfDCE5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbfDCE5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:57:15 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073F82148E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2019 04:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554267434;
        bh=O2dWtnHMvIucSN9og0FGKl2+3z34XXj7gTmGiID9qk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YXO6WTzWL5SQ2sNq/Uvg9t/vqXg5D+gTAc4DnbIgIYxipxC1WAIueJuJO8bV91EA4
         O0sCx/l9Z8dZw+3vlVzHPefkGnda6u9jx+5uBMkvtLmJ/wuqAcPKlDNcqwYcv2aJ3Y
         6MkIf4kA5fgBLRR0tr0lYjueq+7yRhpcU2YE7jvg=
Received: by mail-qt1-f175.google.com with SMTP id v20so17792682qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:57:13 -0700 (PDT)
X-Gm-Message-State: APjAAAX14sT2o4JEVaM4M+60ILqatVBqF1rJPG9TeNpchraxaQFN9ORD
        0rIlXq7L+JHEdqhSxCB++94FLnC0CX0l+f/huw==
X-Google-Smtp-Source: APXvYqwCpRpvs326uXX4jy7Nr4Dj8f+XYoaLcsF2rUa9OJATlj/OinpZAjqtW2thoDpU/6hw5NBn/iHQ9kXqQybAxJY=
X-Received: by 2002:aed:3e3d:: with SMTP id l58mr62864866qtf.77.1554267433206;
 Tue, 02 Apr 2019 21:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-4-robh@kernel.org>
 <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
In-Reply-To: <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 2 Apr 2019 23:57:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKbqNDMx26Tkyrem-NXF_0iApcWaaEDphtfy6kX050Upg@mail.gmail.com>
Message-ID: <CAL_JsqKbqNDMx26Tkyrem-NXF_0iApcWaaEDphtfy6kX050Upg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 2:12 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 01/04/2019 08:47, Rob Herring wrote:
> > This adds the initial driver for panfrost which supports Arm Mali
> > Midgard and Bifrost family of GPUs. Currently, only the T860 and
> > T760 Midgard GPUs have been tested.
>
> FWIW, on an antique T624 (Juno) it seems to work no worse than the kbase
> driver plus panfrost-nondrm, which is to say it gets far enough to prove
> that the userspace definitely doesn't support T624 (kmscube manages to
> show a grey background, but the GPU is constantly falling over with page
> faults trying to dereference address 0 - for obvious reasons I'm not
> going to get any further involved in debugging that).
>
> A couple of discoveries and general observations below.
>
> > v2:
> > - Add GPU reset on job hangs (Tomeu)
> > - Add RuntimePM and devfreq support (Tomeu)
> > - Fix T760 support (Tomeu)
> > - Add a TODO file (Rob, Tomeu)
> > - Support multiple in fences (Tomeu)
> > - Drop support for shared fences (Tomeu)
> > - Fill in MMU de-init (Rob)
> > - Move register definitions back to single header (Rob)
> > - Clean-up hardcoded job submit todos (Rob)
> > - Implement feature setup based on features/issues (Rob)
> > - Add remaining Midgard DT compatible strings (Rob)
> >
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Eric Anholt <eric@anholt.net>
> > Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> [...]
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > new file mode 100644
> > index 000000000000..227ba5202a6f
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -0,0 +1,227 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
> > +/* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include "panfrost_device.h"
> > +#include "panfrost_devfreq.h"
> > +#include "panfrost_features.h"
> > +#include "panfrost_gpu.h"
> > +#include "panfrost_job.h"
> > +#include "panfrost_mmu.h"
> > +
> > +static int panfrost_clk_init(struct panfrost_device *pfdev)
> > +{
> > +     int err;
> > +     unsigned long rate;
> > +
> > +     pfdev->clock = devm_clk_get(pfdev->dev, NULL);
> > +     if (IS_ERR(pfdev->clock)) {
>
> The DT binding says clocks are optional, but this doesn't treat them as
> such.

Hum, I would think effectively clocks are always there and necessary
for thermal reasons.


> > +     spin_lock_init(&pfdev->mm_lock);
> > +
> > +     /* 4G enough for now. can be 48-bit */
> > +     drm_mm_init(&pfdev->mm, SZ_32M >> PAGE_SHIFT, SZ_4G);
>
> You probably want a dma_set_mask_and_coherent() call for your 'real'
> output address size somewhere - the default 32-bit mask works out OK for
> RK3399, but on systems with RAM above 4GB io-pgtable will get very
> unhappy about DMA bounce-buffering.

Yes, I have a todo for figuring out the # of physaddr bits in the mmu
setup (as this call is just relevant to the input address side).
Though maybe just calling dma_set_mask_and_coherent() is enough and I
don't need to know the exact number of output bits for the io-pgtable
setup?

> > +     return err;
> > +}
> > +
> > +static int panfrost_remove(struct platform_device *pdev)
> > +{
> > +     struct panfrost_device *pfdev = platform_get_drvdata(pdev);
> > +     struct drm_device *ddev = pfdev->ddev;
> > +
> > +     drm_dev_unregister(ddev);
> > +     pm_runtime_get_sync(pfdev->dev);
> > +     pm_runtime_put_sync_autosuspend(pfdev->dev);
> > +     pm_runtime_disable(pfdev->dev);
> > +     panfrost_device_fini(pfdev);
> > +     drm_dev_put(ddev);
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id dt_match[] = {
> > +     { .compatible = "arm,mali-t604" },
> > +     { .compatible = "arm,mali-t624" },
> > +     { .compatible = "arm,mali-t628" },
> > +     { .compatible = "arm,mali-t720" },
> > +     { .compatible = "arm,mali-t760" },
> > +     { .compatible = "arm,mali-t820" },
> > +     { .compatible = "arm,mali-t830" },
> > +     { .compatible = "arm,mali-t860" },
> > +     { .compatible = "arm,mali-t880" },
>
> Any chance of resurrecting the generic "arm,mali-midgard" compatible? :P

I wouldn't mind, but we still need all these and I don't think we'd be
adding more. For bifrost, we're adding 'arm,mali-bifrost' from the
start.

> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> > new file mode 100644
> > index 000000000000..867e2ba3a761
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> [...]

> > +     /* Limit read & write ID width for AXI */
> > +     if (panfrost_has_hw_feature(pfdev, HW_FEATURE_3BIT_EXT_RW_L2_MMU_CONFIG))
> > +             quirks &= ~(L2_MMU_CONFIG_3BIT_LIMIT_EXTERNAL_READS |
> > +                         L2_MMU_CONFIG_3BIT_LIMIT_EXTERNAL_WRITES);
> > +     else
> > +             quirks &= ~(L2_MMU_CONFIG_LIMIT_EXTERNAL_READS |
> > +                         L2_MMU_CONFIG_LIMIT_EXTERNAL_WRITES);
> > +
> > +#if 0
> > +     if (kbdev->system_coherency == COHERENCY_ACE) {
> > +             /* Allow memory configuration disparity to be ignored, we
> > +              * optimize the use of shared memory and thus we expect
> > +              * some disparity in the memory configuration */
> > +             quirks |= L2_MMU_CONFIG_ALLOW_SNOOP_DISPARITY;
>
> Well that sounds terrifying; I rather wish my brain had preprocessed
> that #if already.

What can I say, copied from Arm's driver. I'm just going to drop for now.

>
> > +     }
> > +#endif
> > +     gpu_write(pfdev, GPU_L2_MMU_CONFIG, quirks);
> > +
> > +     quirks = 0;
> > +     if ((panfrost_model_eq(pfdev, 0x860) || panfrost_model_eq(pfdev, 0x880)) &&
> > +         pfdev->features.revision >= 0x2000)
> > +             quirks |= JM_MAX_JOB_THROTTLE_LIMIT << JM_JOB_THROTTLE_LIMIT_SHIFT;
> > +     else if (panfrost_model_eq(pfdev, 0x6000) &&
> > +              pfdev->features.coherency_features == COHERENCY_ACE)
> > +             quirks |= (COHERENCY_ACE_LITE | COHERENCY_ACE) <<
> > +                        JM_FORCE_COHERENCY_FEATURES_SHIFT;
>
> Experience says you can never really trust what ID registers claim about
> system integration stuff like coherency, because eventually someone will
> get a tieoff wrong and make it all fall apart. If even the vendor driver
> has a DT override for it you know you're on thin ice ;)

Unlike the vendor driver, we only have to care about cases seen upstream...

> Ultimately, most of your I/O coherency behaviour will be governed by
> what the DMA API thinks (based on "dma-coherent"), so if you end up with
> mismatched expectations at the point coherency_features gets set up then
> you're liable to have a bad time. See the arm-smmu drivers for prior
> examples of handling the equivalent thing.

None of this matters til bifrost and a platform implementing this, so
I'll worry about it then.

Thanks for the review.

Rob
