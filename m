Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84630C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F40D21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WVdrF/Lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKLH4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:56:16 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45049 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLH4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:56:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id a67so14127492edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9CMSdwYc+0bvqNY3bj8MTiXUzC4S4T1DHmbw/hjbNU=;
        b=WVdrF/LbuxNK+RZNB4qelNBp/e4iwRucvZrfay5MYioNfC69yEfkiq3mEKN7+QocMA
         +ngIf7oLH3g4EnilEip1f0heRVINC3xqFE6iutRFJUMUuXRepN6qv6Ogb7eeXtq+437w
         VySjdaJ+YGZ4xajTgloZcmw/30nVqMmAXL1jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9CMSdwYc+0bvqNY3bj8MTiXUzC4S4T1DHmbw/hjbNU=;
        b=IJZW9IaqXtT4BPrgVWkGZ3okA+WlSnCFnewudTJas3jSC99ERIXkDXTUDM7l6D1SkY
         9iXn/rEiODk7JpRrWH85n4ba+/yR36Z/0lOMLImmmVDdVknlKqmc7CsOrP0sGNv4dcVr
         tNa2EHV0sS4coz82XyzLADD7Hn1/WGDZwGLGu07mklH1oGPDWHGZnRKYANi+8BrRxdIN
         vKUmpvLdagdOONxLkLmFErDhJ3fe+9ipwxVZY0LHr38JukZOZvFu7pR1VBSRUYYFA9gm
         NBWFjhwtU8+CeHzbfmLIygSz8UW8Gu5F+31HD2HoAqKlW6aVflUT24DyMvhQ2kiWFavr
         Utuw==
X-Gm-Message-State: APjAAAUjOqFFmlCyZxsMaqcnWO6q1RnksA2aBdOawNkuc9lIsHjkAJq/
        SX/J8iAZ2/LlnTAMy8/Dyxe2lKT82lFdlB7Cj3GNOA==
X-Google-Smtp-Source: APXvYqykVU2DO/Wmg+8yGSGg8XpY3WapNGgB/334lOZGqtD4Ac7vjW8R99gzzSZakZJfvmlK2D1L57s3QPnfDwLf6zI=
X-Received: by 2002:aa7:c694:: with SMTP id n20mr31255461edq.87.1573545374058;
 Mon, 11 Nov 2019 23:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20191014075812.181942-1-pihsun@chromium.org> <20191014075812.181942-3-pihsun@chromium.org>
 <20191111225316.GC3108315@builder>
In-Reply-To: <20191111225316.GC3108315@builder>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Tue, 12 Nov 2019 15:55:38 +0800
Message-ID: <CANdKZ0ecgLjhnL9CawW+pPerTtPhnMkaUSmjxcB10OoMBzQaGQ@mail.gmail.com>
Subject: Re: [PATCH v20 2/4] remoteproc/mediatek: add SCP support for mt8183
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Erin Lo <erin.lo@mediatek.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for the review, I'll address them in the next version. Some
inline comment below.

On Tue, Nov 12, 2019 at 6:53 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 14 Oct 00:58 PDT 2019, Pi-Hsun Shih wrote:
> > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> [..]
> > +struct platform_device *scp_get_pdev(struct platform_device *pdev)
>
> I'm unable to find a patch that calls this, but I assume you're only
> using the returned struct platform_device * in order to call the other
> exported functions in this driver.

Some more information:

Patches for drivers that are using this function includes:
https://patchwork.kernel.org/patch/11126059/
https://patchwork.kernel.org/patch/11134913/
https://patchwork.kernel.org/patch/11135073/
https://patchwork.kernel.org/patch/11138511/
https://patchwork.kernel.org/patch/11140755/

The returned platform_device are used either:
* As a pointer passing back to the scp_ipi_{register,unregister,send} APIs
  # This is the case above.
* Use the ->dev field for either passing to dma_alloc_coherent
(11134913, 11138511), or logging
(https://patchwork.kernel.org/patch/11140755/ mdp_vpu_register).
  # Probably would need to export another function for mtk_scp* ->
device* if going for this change.

A particular problematic patch for this change is
https://patchwork.kernel.org/patch/11135073/, which stores both
platform_device from SCP or VPU in the same field, but it can be
changed to two different fields.

>
> If this is the case I would suggest that you return a struct mtk_scp *
> instead, as this makes your API cleaner and prevents confusion about
> what platform_device could/should be passed in.
>
> Note that you don't need to disclose the struct mtk_scp to your clients,
> just add a "struct mtk_scp;" in include/remoteproc/mtk_scp.h and your
> clients can pass this pointer around.

Ok I'll change to this.

> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* Reserved SCP code size */
> > +     scp->dram_size = MAX_CODE_SIZE;
> > +     scp->cpu_addr = dma_alloc_coherent(scp->dev, scp->dram_size,
> > +                                        &scp->phys_addr, GFP_KERNEL);
>
> Don't you have a problem with that the reserved memory region must be
> 8MB for this allocation to succeed? If so, consider using devm_ioremap
> or similar to map the region.

Yes the reserved memory need to be large enough.
There are other drivers (https://patchwork.kernel.org/patch/11134913/,
https://patchwork.kernel.org/patch/11138511/) that also use
dma_alloc_coherent on the same reserved memory, so we need to use
dma_alloc_coherent here too.

It seems to be problematic if this dma_alloc_coherent is not called
before the other two dma_alloc_coherent, I'll check this.

> [...]
> Regards,
> Bjorn
