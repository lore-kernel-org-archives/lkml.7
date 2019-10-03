Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AC8C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD13222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="N2K/o9vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfJCEh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 00:37:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39220 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfJCEh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 00:37:26 -0400
Received: by mail-io1-f68.google.com with SMTP id a1so2481002ioc.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 21:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlekqaDeWFJgEd5A1fBRjx/7k1tl63XnhZuTSyHIz4o=;
        b=N2K/o9viZlp1wU82nZeoxpgVml0anhGjTES+V5f7ZmBrN6KXsn0+yIR9qkonlHBcoT
         QTHH63dWxWdeC69Z26P8Len8fBpb+sf26Th2APGZEmm/zT4fcBOA9pShLkEbLizr1o/a
         j6JdKtQ/qw8Yu2WVUJFzygEFLvK0EOs3C2ihQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlekqaDeWFJgEd5A1fBRjx/7k1tl63XnhZuTSyHIz4o=;
        b=rSvDpYD0tvveLZpI/CsdepyciBDMouheoU+1cnR8PFf42W44w6R5af5BGvlLsOjTF4
         Y3VLfolwLWWwCn1vxGTY2tgSBk98SPOeMF95IEcNeTkXbhVipcQUwiuCc8hEmaQ4rpCu
         H4XKVVR1ijIOnYsznZe6ZNNU1k7UhYjPP5Nv/VemHMwLV/1hJ28/ehX6RPkTLroeAtGw
         cecTpgG+atnxVKYKyvVxXC/RH976k19eT0fhFk4MXIZHbBoy26xWyyQAcDOkuoR1Jl08
         bHNGKFT/sZvRyoCxbXM8r8DvJJa5cFCneQrMrNR9inGj+Ybgbcjb7tEczXjx0Pkv8sRm
         chxg==
X-Gm-Message-State: APjAAAWEY171ADSGjp0QQWUi+2oTXYUae9mENxSDRN/zD8VseCG1UFh7
        lhNG0KWoWVpeYQWYQuB9vRgZOJoTAHIvi585DP3oPg==
X-Google-Smtp-Source: APXvYqwIWNbnxgMtuGs8BYHnctnPvSODa9WWOtei664E5I8ipwXWBsAKeY9LVmjih5hknlLYsQ8lj89ZirBa1m/Sfzg=
X-Received: by 2002:a92:c74d:: with SMTP id y13mr8131989ilp.77.1570077444611;
 Wed, 02 Oct 2019 21:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191001080253.6135-1-icenowy@aosc.io> <20191001080253.6135-3-icenowy@aosc.io>
In-Reply-To: <20191001080253.6135-3-icenowy@aosc.io>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Oct 2019 10:07:13 +0530
Message-ID: <CAMty3ZC-5czGhOwtk7pE+JGbMRKxo7GrpUgnX3dpY8Jt5j_Afg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/3] drm/sun4i: dsi: fix DRQ calculation
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

Hi,

On Tue, Oct 1, 2019 at 1:34 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> According to the BSP source code, when calculating the magic DRQ value
> outside burst mode, a formula of "lcd_ht - lcd_x - lcd_hbp", which is
> interpreted as right margin (HFP value). However, currently the
> sun6i_mipi_dsi driver code calculates it wrongly as HFP + sync length,
> which lead to timing error.
>
> Fix the DRQ calculation by change it to use HFP.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index c86e11631ebc..2d3e822a7739 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -436,9 +436,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
>                              SUN6I_DSI_BURST_LINE_SYNC_POINT(SUN6I_DSI_SYNC_POINT));
>
>                 val = SUN6I_DSI_TCON_DRQ_ENABLE_MODE;
> -       } else if ((mode->hsync_end - mode->hdisplay) > 20) {
> +       } else if ((mode->hsync_start - mode->hdisplay) > 20) {
>                 /* Maaaaaagic */
> -               u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
> +               u16 drq = (mode->hsync_start - mode->hdisplay) - 20;

I have similar patch in the ML, which required commit details
commented by Chen-Yu [1]. So, I'm trying to send it accordingly, let
me know if you have issues.

[1] https://patchwork.freedesktop.org/patch/305920/
