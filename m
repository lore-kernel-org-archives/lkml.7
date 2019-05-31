Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48A5C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11A621BD5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfEaMFD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:05:03 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50471 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:05:02 -0400
Received: by mail-it1-f194.google.com with SMTP id a186so15286664itg.0;
        Fri, 31 May 2019 05:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tqrmQ2U13+xCmSb38oWvwz7Ya/O77rdp+A5n3MJMo9s=;
        b=krGIpURES88Ty01kUgOACUwryJ9JeQTULTyI7CeFFdvF1WXZ2llOKVDgXatHuc0l2X
         s+RNsWuSjANmENV+lPSKHCvrdulLS8IoA+PLuIY8+LLo4Xg2wZ0PHADENAwROBIzjJ9J
         6ZJw+x0yD0gRzm1hkSe4Q5RlXqGR/+EHbosdWguUSujE5RWLk5oS9BPrJej2d88+rY40
         oFtuOBSPf++lWgj8fPzEhOSAEbc8IO7nj/et3TvgrhoFP28ISLRRmH5cpzncI0fHPUki
         nkDCWBtJQhorsQqFREKD1CSaWO5r+Sy8beT5NmH+sORKopFRY9Qd8TXI5hjS3OO2kP7i
         0ZVQ==
X-Gm-Message-State: APjAAAUuK6gBqIWn/7WdBDNlWVMDuteN3h0B5aaObTIHi9tHvS/IywIC
        816lKK55bor3zWVEFojx1U5OASUufourBgqAKr4=
X-Google-Smtp-Source: APXvYqySiM9LW0NoBLx4rQzzZSpkGZOKNt7EZ4KDgWPh4CJ8HWvRwy6qvhRMJVkCU4IorVkpiTWZW/8PXo9JPFU0TFc=
X-Received: by 2002:a24:5a45:: with SMTP id v66mr6900489ita.140.1559304302034;
 Fri, 31 May 2019 05:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com> <CAAObsKD8bij1ANLqX6y11Y6mDEXiymNjrDkmHmvGWiFLKWu_FA@mail.gmail.com>
 <4ff02295-6c34-791b-49f4-6558a92ad7a3@arm.com>
In-Reply-To: <4ff02295-6c34-791b-49f4-6558a92ad7a3@arm.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Fri, 31 May 2019 14:04:50 +0200
Message-ID: <CAAObsKBt1tPw9RKGi_Xey=1zy9Tu3N+A=1te2R8=NuJ5tDBqVg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Steven Price <steven.price@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 at 19:38, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 29/05/2019 16:09, Tomeu Vizoso wrote:
> > On Tue, 21 May 2019 at 18:11, Clément Péron <peron.clem@gmail.com> wrote:
> >>
> > [snip]
> >> [  345.204813] panfrost 1800000.gpu: mmu irq status=1
> >> [  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> >> 0x0000000002400400
> >
> >  From what I can see here, 0x0000000002400400 points to the first byte
> > of the first submitted job descriptor.
> >
> > So mapping buffers for the GPU doesn't seem to be working at all on
> > 64-bit T-760.
> >
> > Steven, Robin, do you have any idea of why this could be?
>
> I tried rolling back to the old panfrost/nondrm shim, and it works fine
> with kbase, and I also found that T-820 falls over in the exact same
> manner, so the fact that it seemed to be common to the smaller 33-bit
> designs rather than anything to do with the other
> job_descriptor_size/v4/v5 complication turned out to be telling.

Is this complication something you can explain? I don't know what v4
and v5 are meant here.

> [ as an aside, are 64-bit jobs actually known not to work on v4 GPUs, or
> is it just that nobody's yet observed a 64-bit blob driving one? ]

I'm looking right now at getting Panfrost working on T720 with 64-bit
descriptors, with the ultimate goal of making Panfrost
64-bit-descriptor only so we can have a single build of Mesa in
distros.

> Long story short, it appears that 'Mali LPAE' is also lacking the start
> level notion of VMSA, and expects a full 4-level table even for <40 bits
> when level 0 effectively redundant. Thus walking the 3-level table that
> io-pgtable comes back with ends up going wildly wrong. The hack below
> seems to do the job for me; if Clément can confirm (on T-720 you'll
> still need the userspace hack to force 32-bit jobs as well) then I think
> I'll cook up a proper refactoring of the allocator to put things right.

Mmaps seem to work with this patch, thanks.

The main complication I'm facing right now seems to be that the SFBD
descriptor on T720 seems to be different from the one we already had
(tested on T6xx?).

Cheers,

Tomeu

> Robin.
>
>
> ----->8-----
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 546968d8a349..f29da6e8dc08 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -1023,12 +1023,14 @@ arm_mali_lpae_alloc_pgtable(struct
> io_pgtable_cfg *cfg, void *cookie)
>         iop = arm_64_lpae_alloc_pgtable_s1(cfg, cookie);
>         if (iop) {
>                 u64 mair, ttbr;
> +               struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(&iop->ops);
>
> +               data->levels = 4;
>                 /* Copy values as union fields overlap */
>                 mair = cfg->arm_lpae_s1_cfg.mair[0];
>                 ttbr = cfg->arm_lpae_s1_cfg.ttbr[0];
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
