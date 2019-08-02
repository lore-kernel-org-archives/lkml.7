Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6B8C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F38206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWyYMwM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392271AbfHBLDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:03:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40075 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbfHBLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:03:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id m8so38828684lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HL5ANZc7OmpdOHZ2ionlww4aSxrQXJYtiezr9bkrTNM=;
        b=UWyYMwM6+6cdywPrYnOa4onNfoqc3kPU6dOJncvLK+hh3FuKjPGAoJLstXqe5LzSJK
         Opz0J1kGQsQFI0tleEdxhxiDeaQwXxejbiY3WIORSdzjX33te82D6yBYoFxQ0WTmWnde
         5ZvWrsvaMo0svhBwb+1LojGe+1iVDsRVsD9AuA7E+AR73NzRh6l+e5kSdwTlYj6AmODf
         LXzVBOFLH7Nksij+P0GBxuM87d6OrE6M6lRpAhpGOR9jbQMrm2BpavcwtjTbzLyO6nQC
         pb4YuUet/oEg5JbebXQ7XieDP05fgXRYXHjyyCvH5+e/mBcEPAAnuJnBEUxmRsumCbK3
         C/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HL5ANZc7OmpdOHZ2ionlww4aSxrQXJYtiezr9bkrTNM=;
        b=ezYfAdp0oMjYxUWf/O6VDtSnAvxUSmKb9GzM5W3RaqbrrvK26ucm88p6mE2F3YyeDU
         dCFixwmIbCq0ehy8TAQhwKzEYrC2zVKMguTjn4oKL89S+CKBkpgWDbhewi//Jnd9VGkY
         Y3UGDjXnsMgrbmau76tQPCVLeoTY59g9L4ZsNAJoJ8VO+8GpV68E7E/RIBtjn95XMWk4
         YUiSq0eZnhdofQ8CPE7Dp/WbU4GraaqjWHX5XJPcDsPeUsViLJncxoPKL1E6yR5MQZ30
         FhSbEM9ENnj+pbtK9C4g082PhyLq/F9DTF1Xwek1Mo/H/p1CWyrWOnYxnsWnZWEtRUZm
         4MRQ==
X-Gm-Message-State: APjAAAUYWUZJY7bLSqws8G3HwBqrAkZfUWS5EE0wLTs8vzmCtLcGA/bi
        ou2ZEaW3+d6tIHvsmZCxnNEc6R51wEPlNTXfgto=
X-Google-Smtp-Source: APXvYqx5oq7vowqqKfwUYf1UttJH3upuyx969PtPyuX0ERX2LffNrQWKhyKNYV1lXA+tl4HP/Csy3WbhjxRbgRDo4oM=
X-Received: by 2002:a2e:a311:: with SMTP id l17mr7778322lje.214.1564743790013;
 Fri, 02 Aug 2019 04:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <e5484fa33bffec220fd0590b502a962da17c9c72.1564743270.git.agx@sigxcpu.org>
In-Reply-To: <e5484fa33bffec220fd0590b502a962da17c9c72.1564743270.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 2 Aug 2019 08:03:22 -0300
Message-ID: <CAOMZO5BipmSPR1jz3ov8ESSJPsHMViMw42di-WKOdqhyONLK6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: Drop unused imx-ipuv3-crtc.o build
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

Good catch!

On Fri, Aug 2, 2019 at 7:55 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> Since
>
> commit 3d1df96ad468 ("drm/imx: merge imx-drm-core and ipuv3-crtc in one m=
odule")
>
> imx-ipuv3-crtc.o is built via imxdrm-objs. So there's no need to keep an

Actually, it is ipuv3-crtc.o that is built via imxdrm-objs, not
imx-ipuv3-crtc.o.

Apart from that:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
