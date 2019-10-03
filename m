Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BDBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C97B21D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SjYfr4ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfJCEYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 00:24:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46570 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfJCEYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 00:24:07 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so2338941ioo.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 21:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXxgss0qRr38ViNhIsY4E48BXxGon0iuPdHcJHwqwhc=;
        b=SjYfr4ci/wu2v5HJdhvG5VWQ0L+nAwZxsH1u0w5kKILfPjaBnSDE0XQZ0s4eJoryIW
         As8fGKd6gSiZcy6eQNhCL56xGXObLVRxQ0ZedLXEOMrpa3zxChhoO6OGH2dnWZOBl6u3
         mQx5xJ9LM+t6NZp1NyL2uHQ16yh56mtV4nZYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXxgss0qRr38ViNhIsY4E48BXxGon0iuPdHcJHwqwhc=;
        b=ZRs1bqu/ZhfU+UHQbQnlatGvM0FXQuS+TD0QzaiMclpPvcU+1tgQL0zVjTcygd2TSv
         uckKbmvtMGncuR4NYyLI6i8N3NyQaKdN7C1+GWDmmMWRKzoDs1aeiugBDzxmONv0r6vE
         7wMjjeItT3TyVx1Us1YnZH8S8UMbFvSgHjNq/oVXdw5Jn3sD4I6Xx8jk6zspSaCZp7FW
         qdT0o34PuLREs2wNTPWxsKzyTTo03dEED2SfT2LsseLgQfjNWLAP7wZ3OQaUNPsCV7hC
         5VlJFsLA0DepkJN+xkw3BbxXILXQXRddRyhwi/TSzWzJRIyPBtpgJDYNWU77oV72R423
         21CA==
X-Gm-Message-State: APjAAAXtEev7zY6hCmXmh2609maNt+TzEovG0sYszePJcgBPPZQPOZ2p
        EWj5CEjL4rFb2D+bzeL6CR1rPjuLVhdckhq1th1X5A==
X-Google-Smtp-Source: APXvYqz7lFdMeYaFOqQuDlV2bgB6TK9bjpGTgkqgd8HQd647X9V9/RgwVucyGUxqcrmBjl6fatT+jMGOcVJrQTxylyU=
X-Received: by 2002:a02:6284:: with SMTP id d126mr7511832jac.51.1570076645543;
 Wed, 02 Oct 2019 21:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191001080253.6135-1-icenowy@aosc.io> <20191001080253.6135-4-icenowy@aosc.io>
In-Reply-To: <20191001080253.6135-4-icenowy@aosc.io>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Oct 2019 09:53:54 +0530
Message-ID: <CAMty3ZDW4XHyW+6XL_RSVHqTSk79-r749pa0n5e6VbUzowAsiw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 3/3] Revert "drm/sun4i: dsi: Rework a bit
 the hblk calculation"
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wens,

On Tue, Oct 1, 2019 at 1:34 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> This reverts commit 62e7511a4f4dcf07f753893d3424decd9466c98b.
>
> This commit, although claimed as a refactor, in fact changed the
> formula.
>
> By expanding the original formula, we can find that the const 10 is not
> substracted, instead it's added to the value (because 10 is negative
> when calculating hsa, and hsa itself is negative when calculating hblk).
> This breaks the similar pattern to other formulas, so restoring the
> original formula is more proper.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 2d3e822a7739..cb5fd19c0d0d 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -577,14 +577,9 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>                           (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
>
>                 /*
> -                * The blanking is set using a sync event (4 bytes)
> -                * and a blanking packet (4 bytes + payload + 2
> -                * bytes). Its minimal size is therefore 10 bytes.
> +                * hblk seems to be the line + porches length.
>                  */
> -#define HBLK_PACKET_OVERHEAD   10
> -               hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
> -                          (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
> -                          HBLK_PACKET_OVERHEAD);
> +               hblk = mode->htotal * Bpp - hsa;

The original formula is correct according to BSP [1] and work with my
panels which I have tested before. May be the horizontal timings on
panels you have leads to negative value.

[1] https://github.com/ayufan-pine64/linux-pine64/blob/my-hacks-1.2-with-drm/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L919
