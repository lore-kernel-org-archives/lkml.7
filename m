Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C91C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B26214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LDDUyvLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfKLGn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:43:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36294 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfKLGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:43:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id f7so14022640edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 22:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gu94hk6ViXZU/1pF57c89Mz0JcKl1j3IzzPZmTPjtQ=;
        b=LDDUyvLAAr/FgJFV0ODv1fscc3tceNs7i1JvEsFi9SbeCOxeMyJWafdRgYIlNqWV49
         ro79eCq++su+3IaTvSt6MwgL4SEwWPUZp7cEzIY5lMEh0+Vi4K+fFmiFNMR56+eI/hDL
         YUlIauWUKVBysNq/DieSbYjanJaQapqZXiAkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gu94hk6ViXZU/1pF57c89Mz0JcKl1j3IzzPZmTPjtQ=;
        b=qlxty6EFibUHNPx2vw7D7zR+Z1Lqs8ya8q1pBjycW1x+ZymhboYvoB0rUrbjv0vY+z
         MuqG4DUJ1dPxQ22Mex6rTka+hF4UJimzaWJgUFOEy4lKPoha+4tk/k0e16SgI+jWUI9S
         anguF3iaRV253FRFQJGc0nGToeHuhlHY9MesquFzjrVKS6ubwemukrrRS6vyVt14Ep1M
         hJyRPTUih3WLdPbISmNG3+mJSmRbDAip07yTo5+e38Xkhhd9gVV88RKCC1QX/4PyvQUw
         n0V3NybxCQWfnBrmBAiviBJusCGdFI4dhX4Tv2nXRceFKkzv1AN6AlNJKHSmwwZEFrew
         Po2Q==
X-Gm-Message-State: APjAAAXcXoA0wEyWZfQiF3fb0Mifa5PcpRbk6JX0C+k3sHLuXfMM2bY8
        Ho8YVm4O5GrlffwNx7hdepQC6a5tT0/h7iYngKSh8A==
X-Google-Smtp-Source: APXvYqyMbA5YJasNK6lBrgNGRtM92Nacpnn0WpqptPvJ7NjQkzN/92o6yJP/Cb/7QkIhQbV5cTyTR309VkTgVeCpFuI=
X-Received: by 2002:a17:906:1d19:: with SMTP id n25mr25947734ejh.151.1573541003705;
 Mon, 11 Nov 2019 22:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20191014075812.181942-1-pihsun@chromium.org> <20191014075812.181942-4-pihsun@chromium.org>
 <20191111231023.GD3108315@builder>
In-Reply-To: <20191111231023.GD3108315@builder>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Tue, 12 Nov 2019 14:42:47 +0800
Message-ID: <CANdKZ0frU9+dRYeMaJjjKm6emxj41c_jBk_RX3G7bXn_oXKp4g@mail.gmail.com>
Subject: Re: [PATCH v20 3/4] rpmsg: add rpmsg support for mt8183 SCP.
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
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

On Tue, Nov 12, 2019 at 7:10 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 14 Oct 00:58 PDT 2019, Pi-Hsun Shih wrote:
>
> > Add a simple rpmsg support for mt8183 SCP, that use IPI / IPC directly.
> >
>
> Hi Pi-Hsun,
>
> Sorry for not reviewing this in a timely manner! This looks good, just
> some very minor comments below.
>
> > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> [..]
> > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> > index f2e5e70a58f2..7896cefb2dc0 100644
> > --- a/drivers/remoteproc/mtk_scp.c
> > +++ b/drivers/remoteproc/mtk_scp.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/remoteproc.h>
> >  #include <linux/remoteproc/mtk_scp.h>
> > +#include <linux/rpmsg/mtk_rpmsg.h>
> >
> >  #include "mtk_common.h"
> >  #include "remoteproc_internal.h"
> > @@ -407,6 +408,31 @@ static void scp_unmap_memory_region(struct mtk_scp *scp)
> >       of_reserved_mem_device_release(scp->dev);
> >  }
> >
> > +static struct mtk_rpmsg_info mtk_scp_rpmsg_info = {
> > +     .send_ipi = scp_ipi_send,
> > +     .register_ipi = scp_ipi_register,
> > +     .unregister_ipi = scp_ipi_unregister,
>
> These are exported symbols, so unless you see a need to support
> alternative implementations in the near future just skip the function
> pointers and call them directly.
>

Yes there is request from MTK that they do want to reuse the mtk_rpmsg
driver for things other than mtk_scp, so there's a need to support
alternative implementations for this.

> > +                struct rpmsg_device *rpdev, rpmsg_rx_cb_t cb, void *priv,
> > +                u32 id)
> > +{
>
> Regards,
> Bjorn

Regards,
Pi-Hsun
