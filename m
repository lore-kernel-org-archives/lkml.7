Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D365EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9784222451
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FJYQZJbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfIRTiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:38:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33974 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbfIRTiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:38:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id r22so556076lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYdtJ7oCFnyBm2ZB4A+7C5h6gT7MMWnprnThe/izcYI=;
        b=FJYQZJbLlwnYy90gnbw5gVV6ZxnBb7ZVOPYNbwk/X+uv7Q2AcvUbaxXr5/I3hc68iC
         o1mnY1UhXLgFzBZgYShNRfik8r1itqOopd6dCzEH/iFUnarQHiflR2MAQp1g87ruIzZa
         GzycbwAQfEs/XaWi9qqDvP4CUHCYoSy9wDLwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYdtJ7oCFnyBm2ZB4A+7C5h6gT7MMWnprnThe/izcYI=;
        b=McrcwDyPdMRKWtROe3sH0Oyf/S4W0e2iDrC5tBVOFJyvGBMY4vWlVfxuksdq+BIG2W
         axUitm1JTTClEMXoboPOQb/NN7dty/9MBzsE2vKcUmzKQjgjYaC3UxJFjVl0MYl7+qF3
         9QYv/dfDrOAwyQybL1f4bcdh/uTAOQkbyGoSb3r/bI4GR+rmjcH3J2fgzs6R/DY4LHCy
         mUzKyK/kp2ZbKPBU+RvSn/SG6tmBc4zCTNQwoCBVoErTZgRa3AS7CS4wqeg/mYQdtp8W
         ZaJDKOuoIO24kO91Xrs6MJ17c8Ee24hvHqi88OptBtWKc5EwayQKIPczLZ9TFKxe3Y+9
         I6gw==
X-Gm-Message-State: APjAAAWsTNJY7otVQ6vIctpL8G1uSTM6c6iDLxGQgcV+sVM5gWQFBywX
        MGjAIcTvqTZVG3frMloWEcLZpq3MIpk=
X-Google-Smtp-Source: APXvYqygfzloI1VoScPM3bimBrsuQEsLQ+H07Mpap9W2ieAIg+9orRTcTfyWvYTN1ECpKQR5Cle09w==
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr3058069lfm.67.1568835492945;
        Wed, 18 Sep 2019 12:38:12 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id a14sm1153634lfg.74.2019.09.18.12.38.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 12:38:11 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id d5so1093579lja.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:38:11 -0700 (PDT)
X-Received: by 2002:a2e:9bcc:: with SMTP id w12mr3122310ljj.181.1568835490845;
 Wed, 18 Sep 2019 12:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190910160903.65694-1-swboyd@chromium.org> <20190910160903.65694-4-swboyd@chromium.org>
In-Reply-To: <20190910160903.65694-4-swboyd@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 18 Sep 2019 12:37:34 -0700
X-Gmail-Original-Message-ID: <CAE=gft6YdNszcJV67CwcY2gOgPHrJ1+SnKMLr63f2bix2aZXXA@mail.gmail.com>
Message-ID: <CAE=gft6YdNszcJV67CwcY2gOgPHrJ1+SnKMLr63f2bix2aZXXA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] memremap: Add support for read-only memory mappings
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 9:09 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Sometimes we have memories that are supposed to be read-only, but when
> we map these regions the best we can do is map them as write-back with
> MEMREMAP_WB. Introduce a read-only memory mapping (MEMREMAP_RO) that
> allows us to map reserved memory regions as read-only. This way, we're
> less likely to see these special memory regions become corrupted by
> stray writes to them.
>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  include/linux/io.h |  1 +
>  kernel/iomem.c     | 20 +++++++++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/io.h b/include/linux/io.h
> index accac822336a..15a63efcd153 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -148,6 +148,7 @@ enum {
>         MEMREMAP_WC = 1 << 2,
>         MEMREMAP_ENC = 1 << 3,
>         MEMREMAP_DEC = 1 << 4,
> +       MEMREMAP_RO = 1 << 5,
>  };
>
>  void *memremap(resource_size_t offset, size_t size, unsigned long flags);
> diff --git a/kernel/iomem.c b/kernel/iomem.c
> index 62c92e43aa0d..6d76b7398714 100644
> --- a/kernel/iomem.c
> +++ b/kernel/iomem.c
> @@ -19,6 +19,13 @@ static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
>  }
>  #endif
>
> +#ifndef arch_memremap_ro
> +static void *arch_memremap_ro(resource_size_t offset, unsigned long size)
> +{
> +       return NULL;
> +}
> +#endif
> +
>  #ifndef arch_memremap_can_ram_remap
>  static bool arch_memremap_can_ram_remap(resource_size_t offset, size_t size,
>                                         unsigned long flags)
> @@ -45,7 +52,7 @@ static void *try_ram_remap(resource_size_t offset, size_t size,
>   * @offset: iomem resource start address
>   * @size: size of remap
>   * @flags: any of MEMREMAP_WB, MEMREMAP_WT, MEMREMAP_WC,
> - *               MEMREMAP_ENC, MEMREMAP_DEC
> + *               MEMREMAP_ENC, MEMREMAP_DEC, MEMREMAP_RO
>   *
>   * memremap() is "ioremap" for cases where it is known that the resource
>   * being mapped does not have i/o side effects and the __iomem
> @@ -53,6 +60,9 @@ static void *try_ram_remap(resource_size_t offset, size_t size,
>   * mapping types will be attempted in the order listed below until one of
>   * them succeeds.
>   *
> + * MEMREMAP_RO - establish a mapping whereby writes are ignored/rejected.
> + * Attempts to map System RAM with this mapping type will fail.

Why should attempts to map RAM with this flag fail? MEMREMAP_WB will
allow RAM and quietly give you back the direct mapping, so it seems
like at least some values in this function allow RAM.

Oh, I see a comment below about "Enforce that this mapping is not
aliasing System RAM". I guess this is worried about cache coloring?
But is that a problem with RO mappings? I guess the RO mappings could
get partially stale, so if the memory were being updated out from
under you, you might see some updates but not others. Was that the
rationale?

> + *
>   * MEMREMAP_WB - matches the default mapping for System RAM on
>   * the architecture.  This is usually a read-allocate write-back cache.
>   * Moreover, if MEMREMAP_WB is specified and the requested remap region is RAM
> @@ -84,7 +94,10 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
>         }
>
>         /* Try all mapping types requested until one returns non-NULL */
> -       if (flags & MEMREMAP_WB) {
> +       if ((flags & MEMREMAP_RO) && is_ram != REGION_INTERSECTS)
> +               addr = arch_memremap_ro(offset, size);
> +
> +       if (!addr && (flags & MEMREMAP_WB)) {
>                 /*
>                  * MEMREMAP_WB is special in that it can be satisfied
>                  * from the direct map.  Some archs depend on the
> @@ -103,7 +116,8 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
>          * address mapping.  Enforce that this mapping is not aliasing
>          * System RAM.
>          */
> -       if (!addr && is_ram == REGION_INTERSECTS && flags != MEMREMAP_WB) {
> +       if (!addr && is_ram == REGION_INTERSECTS &&
> +           (flags != MEMREMAP_WB || flags != MEMREMAP_RO)) {

Isn't this condition always true? Did you mean flags != MEM_REMAP_WB
&& flags != MEMREMAP_RO?

>                 WARN_ONCE(1, "memremap attempted on ram %pa size: %#lx\n",
>                                 &offset, (unsigned long) size);
>                 return NULL;
> --
> Sent by a computer through tubes
>
