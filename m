Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A38FC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A17207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g44SEnrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfJCNaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:30:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32923 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbfJCNaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:30:01 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so5576747ior.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HKr4/cJ7iq9izM911rBXPiwq2ApQcWOC8a/94M//WE=;
        b=g44SEnrzA2qar8s97gk4B/ztcRe7nTTl5c5ZcAd2Fs/CLz8539Me0WXGCkws3eYC44
         nYJ856R6/Ctbz9ZanNHCEx5MgYTxSy8BWyormOEux3XHMKOt+15xHMfbJ1h7MTk5yTDg
         7o2TeE6YzevPbPGeqmrVXTUwiqZVEZZUtsDb2ZmpuFkFongRBKYVHWAdfpGS+zcYv+qV
         7yvEPlPL6GlBY/P1+kKaPrJip7yCaf8zsQpUiNm+BwBO5NVhLopDZ8H7xCjsXcVCPkyJ
         RBf4dLgTtliQZzlKAZ0S2mhxym+ilnXZSfYPXNrat0TpShqSk0/h7lOGAjzqikTXqCHH
         Q5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HKr4/cJ7iq9izM911rBXPiwq2ApQcWOC8a/94M//WE=;
        b=SuM2V+Fl6A/UvNJBk+Q6oUfD3hlwGGWCbxgxtLmLTUOKlzkRrmyKZy7OlZ7Oou9C00
         Yg73rcHtmMBMaHLqZK2K99JGNOYhWsRy7hOuyK6UwEfEDpbAgsWSHwpP3zwLeKva23AB
         b7xkir8839meaLbJBMBGX2aH9h73jcg8eUy04E1EVawYYs6iAVZawdKPQmy0WAuoR59t
         aFbWWmXsGcdXLuKkCoCDDEHjAnk+8/BdhxmzfkAYP9DKkFC6c7sHk4OJE00OYKq/o2GR
         RpC1W3k+oYJGf/VCXpe4U2keAGXeYioBZGjv/wIW4Hbi8PIo2Ebb47hSHE+cyDW74xo5
         iJQQ==
X-Gm-Message-State: APjAAAUyRwBObSCMxd6SG5OZquuDoG+mo9iLST5kuBsFzBHn3higowQ9
        yTNWGQ9b6qru4AjuhHLfXB/2q+NBQKIFkK/RhCrfdKDj
X-Google-Smtp-Source: APXvYqxreQxx29k2JK11Fj0++YZu+xr0zRqfLfbEWCnbZtmcqopH8qTn+g4tqQ0Hc8UkcTQPywevs2q4vO1zSd9l1Aw=
X-Received: by 2002:a92:aa87:: with SMTP id p7mr9947589ill.7.1570109400135;
 Thu, 03 Oct 2019 06:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190930164425.20282-1-ayan.halder@arm.com>
In-Reply-To: <20190930164425.20282-1-ayan.halder@arm.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Thu, 3 Oct 2019 21:29:48 +0800
Message-ID: <CAKGbVbuM9riESVq+ZZgEho3R9dymVvYaZXBUD9_-0LQmxsMZpg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/fourcc: Add Arm 16x16 block modifier
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Raymond Smith <Raymond.Smith@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayan,

Thanks for the patch. I'm OK with either the static reserved type way or
the previous dynamic way. So this patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

PS. for anyone would like to know the usage of this modifier, lima mesa
driver need this modifier to denote some tiled texture format and shared
between client and display server.

Regards,
Qiang

On Tue, Oct 1, 2019 at 12:45 AM Ayan Halder <Ayan.Halder@arm.com> wrote:
>
> Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
> denote the 16x16 block u-interleaved format used in Arm Utgard and
> Midgard GPUs.
>
> Changes from v1:-
> 1. Reserved the upper four bits (out of the 56 bits assigned to each vendor)
> to denote the category of Arm specific modifiers. Currently, we have two
> categories ie AFBC and MISC.
>
> Signed-off-by: Raymond Smith <raymond.smith@arm.com>
> Signed-off-by: Ayan kumar halder <ayan.halder@arm.com>
> ---
>  include/uapi/drm/drm_fourcc.h | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 3feeaa3f987a..b1d3de961109 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -648,7 +648,21 @@ extern "C" {
>   * Further information on the use of AFBC modifiers can be found in
>   * Documentation/gpu/afbc.rst
>   */
> -#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)   fourcc_mod_code(ARM, __afbc_mode)
> +
> +/*
> + * The top 4 bits (out of the 56 bits alloted for specifying vendor specific
> + * modifiers) denote the category for modifiers. Currently we have only two
> + * categories of modifiers ie AFBC and MISC. We can have a maximum of sixteen
> + * different categories.
> + */
> +#define DRM_FORMAT_MOD_ARM_CODE(type, val) \
> +       fourcc_mod_code(ARM, ((__u64)type << 52) | ((val) & 0x000fffffffffffffULL))
> +
> +#define DRM_FORMAT_MOD_ARM_TYPE_AFBC 0x00
> +#define DRM_FORMAT_MOD_ARM_TYPE_MISC 0x01
> +
> +#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode) \
> +       DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_AFBC, __afbc_mode)
>
>  /*
>   * AFBC superblock size
> @@ -742,6 +756,17 @@ extern "C" {
>   */
>  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
>
> +/*
> + * Arm 16x16 Block U-Interleaved modifier
> + *
> + * This is used by Arm Mali Utgard and Midgard GPUs. It divides the image
> + * into 16x16 pixel blocks. Blocks are stored linearly in order, but pixels
> + * in the block are reordered.
> + */
> +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> +       DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_MISC, 1ULL)
> +
> +
>  /*
>   * Allwinner tiled modifier
>   *
> --
> 2.23.0
>
