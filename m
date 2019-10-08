Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C57C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680512070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nz5DCDDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfJHKmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:42:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43516 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfJHKmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:42:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id r9so15165405edl.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlbSEHsat/uhnrc6ji92FO04rhx1+BWt+c9sCRWvAxU=;
        b=Nz5DCDDhGBHxplALcQZGaCTG5mV3Z4jpVK314QjWtvnqS7b/x79n6UlR6EKH0pSuUQ
         Ta/sGeucBtoOKc+GGpsFuh0ci0OIaG75nGDsmjab/9c8JpYDC99GMBB80ipOn3+cbiHW
         Dl8tvsmwndue4YZ60xP4Q3cHJpGZlDwOeSr0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlbSEHsat/uhnrc6ji92FO04rhx1+BWt+c9sCRWvAxU=;
        b=WWDHrtIaEQq63e3P4aSFUc87Fm0muk+pfHXS/dSdb90Q2YRleQXuYXl76gdnM+U0J6
         IkElDYEB1WpWg+nVFbMkssirQWxFpwQ5OQ0ZCum2k98TodGqcuYeMjWv3UYKB8XUIUlj
         jBbkGcLZVCr00JkVRNSysKWxYppjdW1reFn4RRTnelmQRUVYUDma6MVN/qCJ5fHO1zxr
         5Wq3G4hC7rAiQRNenuzW3evIuOjGIuJEyV3Bxl8T++GDmcafL4jgexRsTVNKJEnSs0WR
         FaMkDLlrZch2zgfJ90y1uLzcIpEnRNdNX3b/zDNwzCb+VmOryESbjQZPuBsTiPgRn9BE
         hkNg==
X-Gm-Message-State: APjAAAURqhzvK7qVnJT3q7dfrIuHjexMkuLAlyPgGg3qJ8aXkStn0iFU
        l9R/Zmo2XHs5x1A0KCEwr1qobR88RA+jwA==
X-Google-Smtp-Source: APXvYqzMtu7wt3Q46Q6MmxhiQMEVvyLEWtin5oJYF3ZRhxP4TOVR+ZYHUOdQHnL2PmsdjconsSSdXQ==
X-Received: by 2002:a50:cd1a:: with SMTP id z26mr32597649edi.75.1570531343157;
        Tue, 08 Oct 2019 03:42:23 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id 36sm4002246edz.92.2019.10.08.03.42.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 03:42:21 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id n14so18754821wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:42:20 -0700 (PDT)
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr20090970wrs.7.1570531340404;
 Tue, 08 Oct 2019 03:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191007174505.10681-1-ezequiel@collabora.com>
 <20191007174505.10681-3-ezequiel@collabora.com> <CAAFQd5BNu2ea3ei_imHmEwmdna0+iiSbQSv_SBsdHfP4Uh1h4Q@mail.gmail.com>
 <HE1PR06MB4011EC9E93ECBB6773252247AC9A0@HE1PR06MB4011.eurprd06.prod.outlook.com>
In-Reply-To: <HE1PR06MB4011EC9E93ECBB6773252247AC9A0@HE1PR06MB4011.eurprd06.prod.outlook.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 8 Oct 2019 19:42:09 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CWoAP1psrEW6bVMkRmhFeTvFKtDSLjT7nefc2YiFovqQ@mail.gmail.com>
Message-ID: <CAAFQd5CWoAP1psrEW6bVMkRmhFeTvFKtDSLjT7nefc2YiFovqQ@mail.gmail.com>
Subject: Re: [PATCH v2 for 5.4 2/4] media: hantro: Fix H264 max frmsize
 supported on RK3288
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        "fbuergisser@chromium.org" <fbuergisser@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 3:31 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2019-10-08 07:27, Tomasz Figa wrote:
> > Hi Ezequiel, Jonas,
> >
> > On Tue, Oct 8, 2019 at 2:46 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> >> From: Jonas Karlman <jonas@kwiboo.se>
> >>
> >> TRM specify supported image size 48x48 to 4096x2304 at step size 16 pixels,
> >> change frmsize max_width/max_height to match TRM.
> >>
> >> Fixes: 760327930e10 ("media: hantro: Enable H264 decoding on rk3288")
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >> v2:
> >> * No changes.
> >>
> >>  drivers/staging/media/hantro/rk3288_vpu_hw.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/staging/media/hantro/rk3288_vpu_hw.c b/drivers/staging/media/hantro/rk3288_vpu_hw.c
> >> index 6bfcc47d1e58..ebb017b8a334 100644
> >> --- a/drivers/staging/media/hantro/rk3288_vpu_hw.c
> >> +++ b/drivers/staging/media/hantro/rk3288_vpu_hw.c
> >> @@ -67,10 +67,10 @@ static const struct hantro_fmt rk3288_vpu_dec_fmts[] = {
> >>                 .max_depth = 2,
> >>                 .frmsize = {
> >>                         .min_width = 48,
> >> -                       .max_width = 3840,
> >> +                       .max_width = 4096,
> >>                         .step_width = H264_MB_DIM,
> >>                         .min_height = 48,
> >> -                       .max_height = 2160,
> >> +                       .max_height = 2304,
> > This doesn't match the datasheet I have, which is RK3288 Datasheet Rev
> > 1.4 and which has the values as in current code. What's the one you
> > got the values from?
>
> The RK3288 TRM vcodec chapter from [1], unknown revision and date, lists 48x48 to 4096x2304 step size 16 pixels under 25.5.1 H.264 decoder.
>
> I can also confirm that one of my test samples (PUPPIES BATH IN 4K) is 4096x2304 and can be decoded after this patch.
> However the decoding speed is not optimal at 400Mhz, if I recall correctly you need to set the VPU1 clock to 600Mhz for 4K decoding on RK3288.
>
> I am not sure if I should include a v2 of this patch in my v2 series, as-is this patch do not apply on master (H264_MB_DIM has changed to MB_DIM in master).
>
> [1] http://www.t-firefly.com/download/firefly-rk3288/docs/TRM/rk3288-chapter-25-video-encoder-decoder-unit-(vcodec).pdf

I checked the RK3288 TRM V1.1 too and it refers to 3840x2160@24fps as
the maximum.

As for performance, we've actually been getting around 33 fps at 400
MHz with 3840x2160 on our devices (the old RK3288 Asus Chromebook
Flip).

I guess we might want to check that with Hantro.

Best regards,
Tomasz
