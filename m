Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816DFC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551EC20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="Yxb2DtgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgABQcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:32:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37703 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbgABQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 11:32:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id cy15so39554885edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 08:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Tko8occFlhTAmLh+pmq5km+IinxZOdXNCIFDK4BrgI=;
        b=Yxb2DtgByNnm2fvJC5grlaYIWQcduaEV1xN7bE+1BWv/5kIsEJGJzn9NPu60o6gEGk
         glSFoj0DxpmRKQ3KN+2OW667MMbrcOpFVILpvUMgzz25kWv5AmCq76nosJLB38Qy5t9/
         BaeF0w5f11a83pMJHTlEO8TUuLJSgrOKMAb2L6HMcgquZoDgGnW8O9Q2vMtV8OJrHB/X
         cRHSKwZKg1BAaOmUbpunrXdAFZOL17dgxP4hYHB95aM1oBz9s9BVJFfNU4Zjjy5JDmJ5
         n5917hecOxtC2Ntp4XqcebffaigCfGTiha5Qu2ErrHP+ZeTx+RWp8D4YFOJu7BpcnsGg
         ILFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Tko8occFlhTAmLh+pmq5km+IinxZOdXNCIFDK4BrgI=;
        b=tGtu31ZUlIjmDtsntMvH1qZmCnpPhe4KfcuUHjrTyxTQLBr4q5jdReLUTq/3evxArr
         DkVJrmLfeflrnRGEnEZwpth7o2tN1YOTC1my6RB0xzyXJ5P61ki+NamEkBRY+J7dGLO4
         1ZEw/IEffj5MF/P2gBTOX1/JSrC+4vAiIiiekbxpNyoYdwPqrvyTiVf9SZooinJPaz1J
         6L9VKCKFXqJpC9AEksZLG6VIv8a3Iyu62T9mekCJJ7FvJH+Sy09gDGKPn3S1QS4Tw0Vy
         Qd4dG/dqPc9IgxsJHfYYBSyoRZUEZnDtxWfMrGYAPg147ZGp1x+v5Y8713rgCmDJaVvZ
         5XDw==
X-Gm-Message-State: APjAAAVrbug6LsF5fnf5SKQ0ruNbZXamkhr6sMvZohfAmY4tbIO8JP2H
        FVYuVpdVucEZe06+rjCuMfoLN1oz2tIzC2STmZDZXsBm
X-Google-Smtp-Source: APXvYqwOVsilnsl9v7DZx9xZbGwuN9vKn2FxzE+O5mvOq1IVT7wX95EXQ3BZUT6bjQZc4po8c435XGCjM9jRP1YMO2s=
X-Received: by 2002:a50:9f65:: with SMTP id b92mr87854876edf.275.1577982739378;
 Thu, 02 Jan 2020 08:32:19 -0800 (PST)
MIME-Version: 1.0
References: <20200101204750.50541-1-roman.stratiienko@globallogic.com>
 <20200101204750.50541-2-roman.stratiienko@globallogic.com> <20200102100832.c5fc4imjdmr7otam@gilmour.lan>
In-Reply-To: <20200102100832.c5fc4imjdmr7otam@gilmour.lan>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Thu, 2 Jan 2020 18:32:07 +0200
Message-ID: <CAODwZ7uqf4v8XjOLCn=SoUQchst_b96VCNdaunzn9Q21zPcQ7w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/sun4i: Use CRTC size instead of PRIMARY plane
 size as mixer frame.
To:     Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=87=D1=82, 2 =D1=8F=D0=BD=D0=B2. 2020 =D0=B3., 12:08 Maxime Ripard <mrip=
ard@kernel.org>:
>
> Hi,
>
> On Wed, Jan 01, 2020 at 10:47:50PM +0200, roman.stratiienko@globallogic.c=
om wrote:
> > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> >
> > According to DRM documentation the only difference between PRIMARY
> > and OVERLAY plane is that each CRTC must have PRIMARY plane and
> > OVERLAY are optional.
> >
> > Allow PRIMARY plane to have dimension different from full-screen.
> >
> > Fixes: 5bb5f5dafa1a ("drm/sun4i: Reorganize UI layer code in DE2")
> > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
>
> So it applies to all the 4 patches you've sent, but this lacks some
> context.
>
> There's a few questions that should be answered here:
>   - Which situation is it fixing?

Setting primary plane size less than crtc breaks composition. Also
shifting top left corner also breaks it.

>   - What tool / userspace stack is it fixing?

I am using Android userspace and drm_hwcomposer HAL.

@Jernej, you've said that you observed similar issue. Could you share
what userspace have you used?

>   - What happens with your fix? Do you set the plane at coordinates
>     0,0 (meaning you'll crop the top-lef corner), do you center it? If
>     the plane is smaller than the CTRC size, what is set on the edges?

You can put primary plane to any part of the screen and make it as
small as 8x8 (according to the datasheet) . Background would be filled
with black color, that is default, but it also could be overridden by
setting corresponding registers.

>
>
> Thanks!
> Maxime
