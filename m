Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F329C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583D520880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563318736;
	bh=ZrMVMjZfiyo7aCNZthaYAClwMGeLU4tWWQ3/FztZONQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZnYiyrdq4qnQABco0m3CH2kz12c3ka+32V7hkjdMIuYNPWVB5IGdaO50YOnymo3ta
	 QRexBuOycHP8vz6dqvhLJrDM8OvrjE9W7dn4225DsjIr+hNd8HIl6Gq0y6fxinwS1m
	 oGXA+BRd/ub1nEI6nvuhIf1LEdGKeNUL0fIadKR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbfGPXMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfGPXMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:12:15 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 911CB20880;
        Tue, 16 Jul 2019 23:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563318733;
        bh=ZrMVMjZfiyo7aCNZthaYAClwMGeLU4tWWQ3/FztZONQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L2wK49fqvZrOCA2UmMLJVRunNbS9bYwSsZWU7KO7RSPW/HF9FQoBgLuXl0sqbhV+p
         /DPg+rCflLYYK+nUaItC88VE574wDb5bf/Q9qVyJY9TUtmajBwtHM8I+NmiCknHUUe
         2IfOWacl96/EsvMd9z6LAKHSgOv6n0Oi032NWtjs=
Received: by mail-qt1-f181.google.com with SMTP id 44so21356696qtg.11;
        Tue, 16 Jul 2019 16:12:13 -0700 (PDT)
X-Gm-Message-State: APjAAAUBDJU8wsH6G4bMr7ITSb3VvEPDryuRgdQjEHWmBngV30c0IP6P
        PjkoHqtHrhcT9w2iqMKKjAr0345Wi4YcwOlVtQ==
X-Google-Smtp-Source: APXvYqwuS/Dg8B+UFbtaAI3HpuroiCW8Ay+TBupg3TpQ4YyL58i2wfKjd7YT1BdI2CBnIuzGMm9qYpo0lGu4l9NncY0=
X-Received: by 2002:a0c:b627:: with SMTP id f39mr26683553qve.72.1563318732830;
 Tue, 16 Jul 2019 16:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190703050827.173284-1-drinkcat@chromium.org> <815a8414-bfbe-c693-3208-1580779815ec@gmail.com>
In-Reply-To: <815a8414-bfbe-c693-3208-1580779815ec@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 16 Jul 2019 17:12:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLETdazfnz5EU0Qw4TVVBhWmzk12Z5zYMo5Hm2ACPXh1w@mail.gmail.com>
Message-ID: <CAL_JsqLETdazfnz5EU0Qw4TVVBhWmzk12Z5zYMo5Hm2ACPXh1w@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Make sure no-map does not remove already reserved regions
To:     Florian Fainelli <f.fainelli@gmail.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ian Campbell <ian.campbell@citrix.com>,
        Grant Likely <grant.likely@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 4:46 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 7/2/19 10:08 PM, Nicolas Boichat wrote:
> > If the device tree is incorrectly configured, and attempts to
> > define a "no-map" reserved memory that overlaps with the kernel
> > data/code, the kernel would crash quickly after boot, with no
> > obvious clue about the nature of the issue.
> >
> > For example, this would happen if we have the kernel mapped at
> > these addresses (from /proc/iomem):
> > 40000000-41ffffff : System RAM
> >   40080000-40dfffff : Kernel code
> >   40e00000-411fffff : reserved
> >   41200000-413e0fff : Kernel data
> >
> > And we declare a no-map shared-dma-pool region at a fixed address
> > within that range:
> > mem_reserved: mem_region {
> >       compatible = "shared-dma-pool";
> >       reg = <0 0x40000000 0 0x01A00000>;
> >       no-map;
> > };
> >
> > To fix this, when removing memory regions at early boot (which is
> > what "no-map" regions do), we need to make sure that the memory
> > is not already reserved. If we do, __reserved_mem_reserve_reg
> > will throw an error:
> > [    0.000000] OF: fdt: Reserved memory: failed to reserve memory
> >    for node 'mem_region': base 0x0000000040000000, size 26 MiB
> > and the code that will try to use the region should also fail,
> > later on.
> >
> > We do not do anything for non-"no-map" regions, as memblock
> > explicitly allows reserved regions to overlap, and the commit
> > that this fixes removed the check for that precise reason.
> >
> > Fixes: 094cb98179f19b7 ("of/fdt: memblock_reserve /memreserve/ regions in the case of partial overlap")
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >  drivers/of/fdt.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index cd17dc62a71980a..a1ded43fc332d0c 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -1138,8 +1138,16 @@ int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
> >  int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
> >                                       phys_addr_t size, bool nomap)
> >  {
> > -     if (nomap)
> > +     if (nomap) {
> > +             /*
> > +              * If the memory is already reserved (by another region), we
> > +              * should not allow it to be removed altogether.
> > +              */
> > +             if (memblock_is_region_reserved(base, size))
> > +                     return -EBUSY;
> > +
> >               return memblock_remove(base, size);
>
> While you are it, the nomap argument (introduced with
> e8d9d1f5485b52ec3c4d7af839e6914438f6c285) predates the introduction of
> memblock_is_nomap() (bf3d3cc580f9960883ebf9ea05868f336d9491c2), so
> should just remove memblock_remove() and use memblock_mark_nomap()
> instead here.

Perhaps like this patch[1]? Though the reasoning is different and the
commit message here is more thorough, so can I get a combined patch.
However, I don't under how handling a misconfigured DT and aligned
with EFI are the same patch. What's considered valid for EFI is not
for DT regions?

Rob

[1] https://patchwork.ozlabs.org/patch/1131232/
