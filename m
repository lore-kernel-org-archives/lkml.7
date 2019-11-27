Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD71C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ADE2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EUqC/uYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfK0SKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:10:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33092 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0SKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:10:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id y23so935074wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cbv/8/r3sfhd+NMk4eKHS1W+CsksoJnBQ/vFeBDEews=;
        b=EUqC/uYyOQLRXEtsbXGbq5CLVRefhyQ+qJRAcGcsLyvHr6z7hJsxzKw6xqplaCJ7oW
         2vGwh6hRhxvmaeycEjkOAoLO6jgGGXS1+FEW2lE1eHsWd3mxTu694LM41fWeoIpBH7Vg
         YhUg+vlDlYJk9n5tYVNZtLLEKm/64IfgV4D5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=cbv/8/r3sfhd+NMk4eKHS1W+CsksoJnBQ/vFeBDEews=;
        b=FCn9e6o3xAMAW17dKrokMrAu/0F+BXX0TFH0H0ioCx7z3tDO6f2W7lAyMmL2MjNJtE
         MY4benp5ZK2e/iQ1i5WYlOvZws6nrSpdamBpaQq/bEh2R1ydlZQYhsuZ9H3i8bsdxr1/
         lwZMR+lokpJ3ejzT1F+c+ZzBsb3ea4v0QvIwlPkhiRmSSNqi72Ye59qQisSJwu2sVP7c
         RdWEjNh5lL+OTgXpq+jXHszOLjqT3Bo/3iEDwD+C9PgleshtGUvtooEpd8zxVuRaB9I0
         5TkcaimYOuLP8KtLdqgxRigRnXqwxgOClVS1+ywbYqB6ZxfdqLmPeQNlSq9eDCMMBShc
         LJ/g==
X-Gm-Message-State: APjAAAVrJKHKmIqCaYc73GoIediUPNyj2uUe+CVe2+krTvGrzCNLOOTW
        6TMR+Acgmcgki41ZfS/mnRjrag==
X-Google-Smtp-Source: APXvYqzT8jaNqsYVNrsvu4LEeci1CDFvdEtIFSjKTmi0obdbFp5KUyHs9EfQvXEQTmYckN8AwBDGHw==
X-Received: by 2002:a05:600c:2257:: with SMTP id a23mr5940479wmm.143.1574878236283;
        Wed, 27 Nov 2019 10:10:36 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id g11sm7742001wmh.27.2019.11.27.10.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:10:35 -0800 (PST)
Date:   Wed, 27 Nov 2019 19:10:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: Fix build break
Message-ID: <20191127181033.GF406127@phenom.ffwll.local>
Mail-Followup-To: Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191127170513.42251-1-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127170513.42251-1-mihail.atanassov@arm.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 05:05:32PM +0000, Mihail Atanassov wrote:
> Caused by file removal without adjusting the Makefile.
> 
> Fixes: d268f42e6856 ("drm/mediatek: don't open-code drm_gem_fb_create")
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

Drat, kbuild still sucks if you dont do a clean rebuild :-/

Thanks for the patch, I pushed it.
-Daniel
> ---
>  drivers/gpu/drm/mediatek/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
> index 8067a4be8311..5044dfb8e3d6 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -7,7 +7,6 @@ mediatek-drm-y := mtk_disp_color.o \
>  		  mtk_drm_ddp.o \
>  		  mtk_drm_ddp_comp.o \
>  		  mtk_drm_drv.o \
> -		  mtk_drm_fb.o \
>  		  mtk_drm_gem.o \
>  		  mtk_drm_plane.o \
>  		  mtk_dsi.o \
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
