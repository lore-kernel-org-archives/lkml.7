Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DE8C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C3B20685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfDWPQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:16:22 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44719 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbfDWPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:16:20 -0400
Received: by mail-vs1-f68.google.com with SMTP id j184so8452634vsd.11;
        Tue, 23 Apr 2019 08:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5//6GxCMGJXBkcHJiA/F/s2ofx67rR4WEXlIKHqZL74=;
        b=RAt/BAwFJCrcH9UH9xjNociuNxnvqwYlBDwCc+oEqIupcad5xZbAxFmQQkhgjvJRct
         j4JmlgG5Gj5k15dzFxGMReuoz3jvmAl2GEPf0uI7GLkWqDeJ7sb+do4M6okdFYZnHBFM
         zV1V9IPQrIbbp2IXCVgXwMYxJ0KfNspTN3eoLHcv7KpDtgEwxOkjU7XTRAxZBFLz7Zov
         nF1t5deKE8OrwHqowJuZ0SJQvOVoVLGVocdz5vvr09u0kxcqXDIoai3s9WeZByVHAEzj
         XmTjkHltW+gYpPyGDW2bxA7T/cR5jFHLCf27DwTpKe5iU6KzBoRkOXJ/pgPPYXOqszL8
         0Vog==
X-Gm-Message-State: APjAAAX+l9A+wbWImXBj8+Jx5Twy9Ht0cBNwdEuXOgP65SXSCwOhTJkm
        r96wnMHODxkd8oLDYBAjKXV2U7Xwu5zeNpVWCvU=
X-Google-Smtp-Source: APXvYqzuA6uuoZKLf7AbIB3uGMNyZDKDBdafvUoSNNMldjS+c4YMyifWr3MrDhdZlGLJS6sl4dUIijh7FINKVRNACLs=
X-Received: by 2002:a67:8317:: with SMTP id f23mr13103887vsd.63.1556032579395;
 Tue, 23 Apr 2019 08:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-7-geert+renesas@glider.be> <20190411083905.fpeicn5ia3ghbphe@verge.net.au>
In-Reply-To: <20190411083905.fpeicn5ia3ghbphe@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Apr 2019 17:16:08 +0200
Message-ID: <CAMuHMdVKr=gbMJzvxe-wRbWxWt8TM8TrVauB8eYaGMz45Ko67w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] iommu/ipmmu-vmsa: Add suspend/resume support
To:     Simon Horman <horms@verge.net.au>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Thu, Apr 11, 2019 at 10:39 AM Simon Horman <horms@verge.net.au> wrote:
> On Wed, Apr 03, 2019 at 08:21:48PM +0200, Geert Uytterhoeven wrote:
> > During PSCI system suspend, R-Car Gen3 SoCs are powered down, and all
> > IPMMU state is lost.  Hence after s2ram, devices wired behind an IPMMU,
> > and configured to use it, will see their DMA operations hang.
> >
> > To fix this, restore all IPMMU contexts, and re-enable all active
> > micro-TLBs during system resume.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This patch takes a different approach than the BSP, which implements a
> > bulk save/restore of all registers during system suspend/resume.
> >
> > v2:
> >   - Drop PSCI checks.
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 47 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 46 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 56e84bcc9532e1ce..408ad0b2591925e0 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -36,7 +36,10 @@
> >  #define arm_iommu_detach_device(...) do {} while (0)
> >  #endif
> >
> > -#define IPMMU_CTX_MAX 8U
> > +#define IPMMU_CTX_MAX                8U
> > +#define IPMMU_CTX_INVALID    -1
> > +
> > +#define IPMMU_UTLB_MAX               48U
> >
> >  struct ipmmu_features {
> >       bool use_ns_alias_offset;
> > @@ -58,6 +61,7 @@ struct ipmmu_vmsa_device {
> >       spinlock_t lock;                        /* Protects ctx and domains[] */
> >       DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
> >       struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
>
> It might be possible to save a bit of memory on Gen 2 systems by
> making IPMMU_UTLB_MAX 32 when the driver is compiled for such systems.

This comment applies to the line below, right?

> > +     s8 utlb_ctx[IPMMU_UTLB_MAX];

So it's just 16 bytes, not 16 pointers.

Doing so would reduce struct ipmmu_vmsa_device from 148 to 132 bytes.
Given that structure is allocated by devm_kzalloc(), and devres alignment
was increased in commit a66d972465d15b1d ("devres: Align data[] to
ARCH_KMALLOC_MINALIGN"), I guess it won't make a difference.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
