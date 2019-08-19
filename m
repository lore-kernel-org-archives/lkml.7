Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338A6C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D022082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="USNDYhJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfHSERU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 00:17:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34907 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfHSERT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:17:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id w20so380744edd.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbCA3+sRi1vwFgWGzHijf0NDsTwyWj0F82bl8GeQoNU=;
        b=USNDYhJe3CqyU1LZcyU12zH7sxmglhu2BEaKMXiAvIZQrefa5w3O3Q8q2Fsn4+C2IH
         ghZBxj5+7IGK50lx1569Ey/8qPFUTixmpa2ANwy5fzScNl9aIhN8UPzwaaEcf7McCB3D
         Les7iJtnWTo9FeitxqnGT/OM+twm5a++OaRag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbCA3+sRi1vwFgWGzHijf0NDsTwyWj0F82bl8GeQoNU=;
        b=NEsuuOLq/J1ux6ST+K0JgYaQR/w8ET7A8ZgmQs1V8iq+cOhcqj8G+QDU3u91yh75zB
         tsydYhmN/xwpNVKUGacvAbKcXrhIEuNGdefvldlQ3GCi9XegXg7SK/RMGMo5Ni+jC1kD
         RvEIPu3g93gMQBoLD/tX9MThVnKFRLdp54h6mA83tbpnS5oxnVerCkwsY8PZK1akvlm7
         NdgNIjwwnaKA+FtzAfbfQuzDImn5YBHb5OXo+pRU9s1CrQUy/gtRj/BefB63AcJDZvZC
         CWP4C1jOC2or3cTV+eLiI0gRIp0sTIQffTAvicclW+3ogcOi+oTXdZaAIR6PQIpsU4sr
         /jCw==
X-Gm-Message-State: APjAAAWiDLmnIYotKVdEgryLktU2RhWiyNJU1pM7iR+MT0G+j9VFw30I
        COpAipMu5kTebbfQTIlUNyhhyuvwK4dIug==
X-Google-Smtp-Source: APXvYqwAS+mLump/l4DUu9vcVDeK/kxE9MbGvpIZ5xJKelPYirZHoSYKvJMYIjMKbFPnRz41chYXbw==
X-Received: by 2002:a17:906:7695:: with SMTP id o21mr18868315ejm.175.1566188237246;
        Sun, 18 Aug 2019 21:17:17 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id r27sm2546182edc.17.2019.08.18.21.17.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2019 21:17:16 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id v15so327796wml.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:17:16 -0700 (PDT)
X-Received: by 2002:a1c:cf88:: with SMTP id f130mr8553542wmg.10.1566188235646;
 Sun, 18 Aug 2019 21:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190725030602.GA13200@hari-Inspiron-1545> <20190725135007.33dc2cd3@collabora.com>
In-Reply-To: <20190725135007.33dc2cd3@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 19 Aug 2019 13:17:04 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AOCCoN1F=_WqQaMrttjotpNo7pc8irhkLQNy9C=WjC1A@mail.gmail.com>
Message-ID: <CAAFQd5AOCCoN1F=_WqQaMrttjotpNo7pc8irhkLQNy9C=WjC1A@mail.gmail.com>
Subject: Re: [PATCH] staging: media: hantro: Remove call to memset after dma_alloc_coherent
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        ZhiChao Yu <zhichao.yu@rock-chips.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Thu, Jul 25, 2019 at 8:50 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Thu, 25 Jul 2019 08:36:02 +0530
> Hariprasad Kelam <hariprasad.kelam@gmail.com> wrote:
>
> > fix below issue reported by coccicheck
> > /drivers/staging/media/hantro/hantro_vp8.c:149:16-34: WARNING:
> > dma_alloc_coherent use in aux_buf -> cpu already zeroes out memory,  so
> > memset is not needed
> >
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>
> > ---
> >  drivers/staging/media/hantro/hantro_vp8.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/staging/media/hantro/hantro_vp8.c b/drivers/staging/media/hantro/hantro_vp8.c
> > index 66c4533..363ddda 100644
> > --- a/drivers/staging/media/hantro/hantro_vp8.c
> > +++ b/drivers/staging/media/hantro/hantro_vp8.c
> > @@ -151,8 +151,6 @@ int hantro_vp8_dec_init(struct hantro_ctx *ctx)
> >       if (!aux_buf->cpu)
> >               return -ENOMEM;
> >
> > -     memset(aux_buf->cpu, 0, aux_buf->size);
> > -
> >       /*
> >        * Allocate probability table buffer,
> >        * total 1208 bytes, 4K page is far enough.
>

Is this something you will pick to your tree?

Best regards,
Tomasz
