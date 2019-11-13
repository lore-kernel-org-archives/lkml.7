Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81199C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313E2214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GQfp6xnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfKMIFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:05:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42332 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfKMIFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:05:22 -0500
Received: by mail-oi1-f194.google.com with SMTP id i185so962337oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 00:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JslTrYXN6Ewdf+o6St9+Bkuya/XH+kh75GwvMmEbx8Q=;
        b=GQfp6xnVk0n/cJ7bWh6QAh/hrul+TgbrnOke2VK971tmcYMTRG/ZhTQ49Pvfyk016A
         ylabNCbx3K0BvCVI/uHqCGweUuuiX+WBQtSS4cVaKjYrYpwaJ9dCytbYtg80KlqetT7W
         PMIPUhFLjc5UP5p2bL31jKbAzu2cztamyCsB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JslTrYXN6Ewdf+o6St9+Bkuya/XH+kh75GwvMmEbx8Q=;
        b=VBon5i243wABqn4SmN8suEZyPpjJdBa0QfZujPm1r+d1esAkwX6CHSUKBY8a+5uRL4
         lOSnrDswr/cwAsDa3YvBuyOkwwpjOcqggEYACSPMjRQspQ/PAWS/wgepC/M0CYqXGXC4
         NhgCVjvpJUzwHIzNGAQw0U4RHn1dFYqUhLBn0LlSB2GH2KedCEcdj+FbgSn+7FOw45M8
         xXoUldBfRLL/BBGQtt//mndPkkpFDgZ1mXDh6DUgsqDNuAZuikVoua71q8vgcm1k1l2Z
         64sjaBZtnA8VGjW6i72Ro4DKcUA4w5exaNePOFoWqq3mCEC9kWAbvT64+1fOsMR9ojoR
         uu7Q==
X-Gm-Message-State: APjAAAVV6dALz1vQ8ngHTxF2kvT2P9/els/aQngpz+DBLg5npItEWgxF
        +T3uzErKAL8C1rDrqADwiok58AY8oQTn2i6iLStNAA==
X-Google-Smtp-Source: APXvYqyK2sIGqZ4txSEqR+k0kuCZvu3rfV1ujBoMHLyXsmRoDzQyu4AunaSeyE9NqgVBXWEUe2fV4386QmD+Vy8J4xE=
X-Received: by 2002:aca:b805:: with SMTP id i5mr2048306oif.110.1573632320518;
 Wed, 13 Nov 2019 00:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20191113013114.3013-1-james.qian.wang@arm.com>
In-Reply-To: <20191113013114.3013-1-james.qian.wang@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 13 Nov 2019 09:05:08 +0100
Message-ID: <CAKMK7uHPcrCdkF7AJ06NzRR+hiR3O4seCCtRUf-wO1Y0NF2g2g@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: Fix komeda driver build error
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        "sean@poorly.run" <sean@poorly.run>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 2:32 AM james qian wang (Arm Technology China)
<james.qian.wang@arm.com> wrote:
>
> Fix the build errors lead by
>
> 'commit 4039f0293bbd ("drm/komeda: Add option to print WARN- and INFO-level IRQ events")'
>
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Please also re-enable the komde driver (including all options) in all
the defconfigs in drm-rerere. And maybe type some scripts to compile
test before pushing :-)
-Daniel

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index 15f52e304c08..d406a4d83352 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -51,12 +51,12 @@
>
>  #define KOMEDA_WARN_EVENTS     KOMEDA_ERR_CSCE
>
> -#define KOMEDA_INFO_EVENTS ({0 \
> +#define KOMEDA_INFO_EVENTS (0 \
>                             | KOMEDA_EVENT_VSYNC \
>                             | KOMEDA_EVENT_FLIP \
>                             | KOMEDA_EVENT_EOW \
>                             | KOMEDA_EVENT_MODE \
> -                           })
> +                           )
>
>  /* malidp device id */
>  enum {
> --
> 2.20.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
