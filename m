Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CACC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4932087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PesW0sD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfEPNPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:15:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37331 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEPNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:15:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so1569693pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AI8JZy9keS1o3wGiqH13yvNioRMPnmitZYzglqzVfaM=;
        b=PesW0sD/ciOLThNvEJ5C/W678/gfkxLY7wHxWDXM4XUpjORA7GFmWmCdTTSvPA3Z/0
         mRU2vzRtPQ8B9koGUI7hKssaUEBT9F4MR0ZH2GvgZy8EmQcnc09vQRlNg/gMzumatICh
         IAX4WvXg1JAaX1ZUyhP7NrI++OVIlOUGFAWHcmIxxNLMrBqJR49DGSbUUaTN3nVIJPic
         /+6NKGSPOtcHaLcBMAUOYaPUul/RGAKyJ/WJJfMUrYdkILEhf8MJvxTqjjvrCO0NFOFf
         3q8zPRViuBCjVBhQ95qbQdcrb6rRjoLbtwsbi5mla3krW5q7Yw9WpaK5QadmNSDB2o2y
         xh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AI8JZy9keS1o3wGiqH13yvNioRMPnmitZYzglqzVfaM=;
        b=NIA8mOQSoaSclay51XSL/QqFhBRdfnXCTADxrTFpQ34fZJey77q5kTKF6vLuxGiRAS
         oREq4PbUKtaSCoRiw6Kt77nI+M02zR/cgxz7civwGcaOhpz5plOEI+YCDjr7t+urj34N
         j1TZ7P7NS2yh3JGxoGA/EAUr1fl2uOD5mZ067VO9TbSIMLd7fuz0FrcHagKq4p8F+H5C
         WY9pRcYrBD2A4+ESh+I2ggwZMQiS6qC/beSQE6f50B+wA/k7ZSe7jLdAHWMTzodDwN8Q
         lE48XAfv+jHEh8WBurHyeK/aGBUiJdJVyvwXXtLv7q2qNC4eHlv7lwr6THfsIF4a+951
         4NBA==
X-Gm-Message-State: APjAAAUX8rZtT5RXPcvGxPzdYgveIdFnTpagDEP3l0VSxCybLkX3d2Bq
        oCMRKZxwFaObaDDE4/eGNzrV9DCfGTJMEYE3ybs=
X-Google-Smtp-Source: APXvYqzudyk1qALYh5US3Qa7TwBBWRQjv2nVATbz+op+71ojr+YahyEVhSZZYFuqUDeefV1vVymRSCmRg0vDR5v/Kjg=
X-Received: by 2002:a63:fd4a:: with SMTP id m10mr51120343pgj.302.1558012515963;
 Thu, 16 May 2019 06:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <5cda6ee2.1c69fb81.2949b.d3e7@mx.google.com> <20190514073542.GA4969@pendragon.ideasonboard.com>
In-Reply-To: <20190514073542.GA4969@pendragon.ideasonboard.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Thu, 16 May 2019 18:45:04 +0530
Message-ID: <CAJr6mf0zy37MTuZQV2YLLQ7dY4a0r6LpSRTKByX0dBBfxuA4_g@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Remove duplicate header
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     architt@codeaurora.org, a.hajda@samsung.com, airlied@linux.ie,
        Souptick Joarder <jrdr.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 1:05 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Sabyasachi,
>
> Thank you for the patch.
>
> On Tue, May 14, 2019 at 01:01:41PM +0530, Sabyasachi Gupta wrote:
> > Remove drm/drm_panel.h which is included more than once
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/panel.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> > index 7cbaba2..402b318 100644
> > --- a/drivers/gpu/drm/bridge/panel.c
> > +++ b/drivers/gpu/drm/bridge/panel.c
> > @@ -15,7 +15,6 @@
> >  #include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_modeset_helper_vtables.h>
> > -#include <drm/drm_panel.h>
>
> Which tree is this against ? The patch applies on neither drm-next nor
> drm-misc-next.
>
It is against linux-next tree
> While at it, could you you reorder the other header alphabetically to
> make this kind of issue easier to notice ?
>
It is already arranged in alphabetical order
> >
> >  struct panel_bridge {
> >       struct drm_bridge bridge;
>
> --
> Regards,
>
> Laurent Pinchart
