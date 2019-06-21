Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D30CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170472089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IckKuSoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfFUP1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:27:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38557 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUP1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:27:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so6692863oth.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/y2umFI+hLi0gqB/rGAubbWLUwkck+57yGiyeuQgSY=;
        b=IckKuSoiNlAN+R3Z7KagwwSqiMULpfnyYjhGFqV3B10qOS3tAz5qWzbravJhLfm7Nn
         MBM47QBtmecN/B9H/8yM571Y8ymLkyQDWRh8HrG5CiN4gKyxfKwjuhVrpgLPKjtkGOwl
         Qu3S509r9QsAZGUnh9qhM/im3oxrR62oXDIJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/y2umFI+hLi0gqB/rGAubbWLUwkck+57yGiyeuQgSY=;
        b=qEZbO2s82hCdpXFtotZnetCB0Sj141uio17DvioXJZpYf7aR3U4baprtMXyD0OJ/tQ
         AVM3gnJ0YeVZcBD8+Yydi34SEQQCMFKDfngn6Za14JJI4g3m0ewF02I1K0a0yrrL1hiD
         doeS9ibOzRAsHdW/4DlFAsq+XpEv+7r4rXSFQHL5D71HTBZmgGJfBUP97gsAuScwqzgO
         8/LqcB8TSrzI+rUpjI9BetPYnioKJXPvB1slMqdVBnZtzZftKrYcfsZK5XiemlSZmDkr
         H/rQRQTYoxLMumGK617pFQvLxmi9v4gk1SThMejnendEBL3o6QKUHq5WAYtnWhQMcgiy
         V7HA==
X-Gm-Message-State: APjAAAWZI6dVta2TYkXNl3k+6YROK91aBsYHozwIcLOuyGbP4XnDyqax
        2NaAczwgiQXPW43HdOF047c89ciH0xgMI0ClUmj9HaoF
X-Google-Smtp-Source: APXvYqwgOEf24UbMQB0qb7e97wfqsZUAngBWilMHIaq7tVmIYhrhEDo0c+FZY4p3gcRnoOqR3Rxglb8FloyZTHfS6Uo=
X-Received: by 2002:a9d:4b95:: with SMTP id k21mr6328797otf.281.1561130835867;
 Fri, 21 Jun 2019 08:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <1561112433-5308-1-git-send-email-raymond.smith@arm.com>
In-Reply-To: <1561112433-5308-1-git-send-email-raymond.smith@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 21 Jun 2019 17:27:00 +0200
Message-ID: <CAKMK7uEjh+GrSy5AgbVLVQd1S5oJ8KFiWEUmxtMMVdcMSBtdCQ@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
To:     Raymond Smith <Raymond.Smith@arm.com>
Cc:     "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuq825@gmail.com" <yuq825@gmail.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 12:21 PM Raymond Smith <Raymond.Smith@arm.com> wrote:
>
> Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
> denote the 16x16 block u-interleaved format used in Arm Utgard and
> Midgard GPUs.
>
> Signed-off-by: Raymond Smith <raymond.smith@arm.com>
> ---
>  include/uapi/drm/drm_fourcc.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 3feeaa3..8ed7ecf 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -743,6 +743,16 @@ extern "C" {
>  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
>
>  /*
> + * Arm 16x16 Block U-Interleaved modifier
> + *
> + * This is used by Arm Mali Utgard and Midgard GPUs. It divides the image
> + * into 16x16 pixel blocks. Blocks are stored linearly in order, but pixels
> + * in the block are reordered.
> + */
> +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> +       fourcc_mod_code(ARM, ((1ULL << 55) | 1))

This seems to be an extremely random pick for a new number. What's the
thinking here? Aside from "doesnt match any of the afbc combos" ofc.
If you're already up to having thrown away 55bits, then it's not going
to last long really :-)

I think a good idea would be to reserve a bunch of the high bits as
some form of index (afbc would get index 0 for backwards compat). And
then the lower bits would be for free use for a given index/mode. And
the first mode is probably an enumeration, where possible modes simple
get enumerated without further flags or anything.

The other bit: Would be real good to define the format a bit more
precisely, including the layout within the tile.

Also ofc needs acks from lima/panfrost people since I assume they'll
be using this, too.

Thanks, Daniel

> +
> +/*
>   * Allwinner tiled modifier
>   *
>   * This tiling mode is implemented by the VPU found on all Allwinner platforms,
> --
> 2.7.4
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
