Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9E2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3969206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DgDNW/rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfHAHM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:12:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36878 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbfHAHM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:12:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id w13so68183096eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 00:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3HgBG8dgms5aeg3KKVbilyEzZjF4gJI3+pzI6ZqB7c=;
        b=DgDNW/rwQ9RQMEgFi3r3eO0bKXwgH3+xgNXhRN9nikI0MID4Y8Q+aITx64bwslu/R6
         CUVtBW5HMK2/yH4JfolC0xoP4qpayTQPDitAKqzlki4L5sdd+3Id9L9a0ytS0LUbJNbf
         c64BC68THi/AmMpHoomg8lsILIyEMdueFVxVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3HgBG8dgms5aeg3KKVbilyEzZjF4gJI3+pzI6ZqB7c=;
        b=eGiTAbpaxkm6VfOzRDzMgNbEMtkxIG61jqn1RmE8dgsItU5SS0VaSzd0qFsiFfN71i
         OOUs/7nHpGByXPVrdYY07WgM7qaZGrkyqhc7hReYs/pdEPPfNql17y/FK+H8JOU4M6i8
         yRd8DQbfudcwmjNgxNO2b+qHQBQYg5ZzN2Fde4UTMCPg0YrCH3OjggF2vgbB22am2aPd
         q6UEroHVno4mz+u+OCL7J3akepcX7eiffEykFofdopYyeWgHt/5h9GwOW5BipBHNy6Xq
         dWj8j37KKsw4tV1v4d5KzRxyFLyIzZcVDEMh+/FUX4nVEZQw4U0kIzpswD3iU+f05OnL
         kCmQ==
X-Gm-Message-State: APjAAAW8fTTH2UipJs3RR2DNvGQ9ja+iWvXoAoYQho2oH3LYbRnT0L+q
        Ky5NpiilIeO+c+YLwOuUD6ij9K/3NAUQvw==
X-Google-Smtp-Source: APXvYqxC+wP2E/jvSkdlJ4HxmYCOfzO4BUPdTq5+KS58Of4LsWSW6Cd8ktFdTTQ62g2ci4FInBmJdA==
X-Received: by 2002:aa7:ca41:: with SMTP id j1mr113706408edt.149.1564643576714;
        Thu, 01 Aug 2019 00:12:56 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id h10sm17908355edh.64.2019.08.01.00.12.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 00:12:56 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id x4so19192540wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 00:12:56 -0700 (PDT)
X-Received: by 2002:a5d:5012:: with SMTP id e18mr18039721wrt.166.1564643575835;
 Thu, 01 Aug 2019 00:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190619121540.29320-1-boris.brezillon@collabora.com>
 <20190619121540.29320-8-boris.brezillon@collabora.com> <CAHD77HksotqFBTE84rRM=DuNFX=YJPs=YnsuFkaN-pWUNCtoxA@mail.gmail.com>
 <20190801070410.GA22382@aptenodytes>
In-Reply-To: <20190801070410.GA22382@aptenodytes>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 1 Aug 2019 16:12:43 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BPFLqu0JvyxTfS9UAfWanFcXzFtuJ9jcPmHV+XSq6cvQ@mail.gmail.com>
Message-ID: <CAAFQd5BPFLqu0JvyxTfS9UAfWanFcXzFtuJ9jcPmHV+XSq6cvQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] media: hantro: Add core bits to support H264 decoding
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hertz Wong <hertz.wong@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 4:04 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Thu 01 Aug 19, 13:06, Tomasz Figa wrote:
> > Hi Boris,
> >
> > On Wed, Jun 19, 2019 at 9:15 PM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > [snip]
> > > @@ -533,10 +535,21 @@ hantro_queue_setup(struct vb2_queue *vq, unsigned int *num_buffers,
> > >                 return -EINVAL;
> > >         }
> > >
> > > +       /* The H264 decoder needs extra size on the output buffer. */
> > > +       if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_H264_SLICE_RAW)
> > > +               extra_size0 = 128 * DIV_ROUND_UP(pixfmt->width, 16) *
> > > +                             DIV_ROUND_UP(pixfmt->height, 16);
> > > +
> >
> > I wonder if this shouldn't be accounted for already in the sizeimage
> > returned by TRY_/S_FMT, so that the application can know the required
> > buffer size if it uses some external allocator and DMABUF memory type.
> > I know we had it like this in our downstream code, but it wasn't the
> > problem because we use minigbm, where we explicitly add the same
> > padding in the rockchip backend. Any thoughts?
>
> Does the extra size have to be allocated along with the buffer?
>
> On cedrus, we have a need for a similar side-buffer but give it a dedicated CMA
> allocation, which should allow dma-buf-imported buffers.

Yes, the decoder stores motion vectors (IIRC) after the image data.

Best regards,
Tomasz
