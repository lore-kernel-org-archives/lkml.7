Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A2EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8137C215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dBNkUYtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfJDGHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 02:07:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44507 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388079AbfJDGHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 02:07:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id r16so4714868edq.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rq6DO8bL2JAeSfoJ3DZboj9jM1fNvjsqTcp7VF7+FUY=;
        b=dBNkUYtxZDTR177velDgXD3e5mQdb08i0MF2tfF6Dug1dTDirf/a1ezBB0XdAWfoUS
         FxWpYVdpJA5cYxi0XeoATW0eLF8Qhlnv8t+wG7mA+XlGJDZMX84dd8hizJTd6TslshJE
         k9VB+WQFJNFWpHG7GOr/govPhLNrubPknmmTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rq6DO8bL2JAeSfoJ3DZboj9jM1fNvjsqTcp7VF7+FUY=;
        b=KrJdF6wvInozFHfOpH/FpDOVnXvIW4M8oF/MiiURuh7fXnQRWYRLP1+6MOmI2IgUT0
         gbFrGOuBaLsJhsFotD6lyQrBPFirtOOhUM68NR1kDzwtDxJEEfBp2kBepHkQ3ScHqWJv
         jpXJbZ0ekHhKoplsA9D3fgM/c+KXMNce/hCFx1IDrOYz4oNgNNPs1Z0234C2dAeUbeMd
         nxYFI2UowLKPYTYh7je+vr76KKP+R3R490k9eijYJnVoC9TolPR3lwZ9vacmKVSalVTM
         aPbpVxRfplsOBaHXcPAwfqQBJOcnoU7ByvjOKc4R8oesqrm04IT9+6LNIecb/mHTJXay
         FSMA==
X-Gm-Message-State: APjAAAVIsy+Ft+hIAPA8t+8okzLRW8jPde6hCkeNknQLJoRm2LJnFP7r
        vYHYWGEaSjK3Y4fqTluc1dTNcU4EpFL9vg==
X-Google-Smtp-Source: APXvYqy5Q2xUPbxC2fX7Hplf9m4QBlvoLkYAU3ZI6uxzKZ4EF2j1U4u6IMNOasfF1paK6Q0C1AxCug==
X-Received: by 2002:a17:906:8287:: with SMTP id h7mr11035053ejx.61.1570169248770;
        Thu, 03 Oct 2019 23:07:28 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id ha2sm473704ejb.63.2019.10.03.23.07.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 23:07:27 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id y19so5540660wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 23:07:26 -0700 (PDT)
X-Received: by 2002:adf:dc41:: with SMTP id m1mr9597504wrj.46.1570169245986;
 Thu, 03 Oct 2019 23:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191003190833.29046-1-ezequiel@collabora.com>
In-Reply-To: <20191003190833.29046-1-ezequiel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 4 Oct 2019 15:07:14 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BgwDrc5Jy+EAnC91184aGJiuSkg2jMqOnAEHHfReoLgw@mail.gmail.com>
Message-ID: <CAAFQd5BgwDrc5Jy+EAnC91184aGJiuSkg2jMqOnAEHHfReoLgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Enable Hantro G1 post-processor
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        kernel@collabora.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Fri, Oct 4, 2019 at 4:09 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Hi all,
>
> The Hantro G1 VPU post-processor block can be pipelined with
> the decoder hardware, allowing to perform operations such as
> color conversion, scaling, rotation, cropping, among others.
>
> When the post-processor is enabled, the decoder hardware
> gets its own set of NV12 buffers (the native decoder format),
> and the post-processor is the owner of the CAPTURE buffers.
>
> This allows the application get processed
> (scaled, converted, etc) buffers, completely transparently.
>
> This feature is implemented by exposing the post-processed pixel
> formats on ENUM_FMT. When the application sets a pixel format
> other than NV12, and if the post-processor is MC-linked,
> the driver will make use of it, transparently.
>
> On this v2, the media controller API is now required
> to "enable" (aka link, in topology jargon) the post-processor.
> Therefore, applications now have to explicitly request this feature.
>
> For instance, the post-processor is enabled using the media-ctl
> tool:
>
> media-ctl -l "'decoder':1 -> 'rockchip,rk3288-vpu-dec':0[0]"
> media-ctl -l "'postproc':1 -> 'rockchip,rk3288-vpu-dec':0[1]"
>
> v4l2-ctl -d 1 --list-formats
> ioctl: VIDIOC_ENUM_FMT
>         Type: Video Capture Multiplanar
>
>         [0]: 'NV12' (Y/CbCr 4:2:0)
>         [1]: 'YUYV' (YUYV 4:2:2)
>
> Patches 1 and 2 are simply cleanups needed to easier integrate the
> post-processor. Patch 2 is a bit invasive, but it's a step
> forward towards merging the implementation for RK3399 and RK3288.
>
> Patch 3 re-works the media-topology, making the decoder
> a v4l2_subdevice, instead of a bare entity. This allows
> to introduce a more accurate of the decoder+post-processor complex.
>
> Patch 4 introduces the post-processing support.
>
> This is tested on RK3288 platforms with MPEG-2, VP8 and
> H264 streams, decoding to YUY2 surfaces. For now, this series
> is only adding support for NV12-to-YUY2 conversion.
>
> The design and implementation is quite different from v1:
>
> * The decoder->post-processor topology is now exposed
>   explicitly and applications need to configure the pipeline.
>   By default, the decoder is enabled and the post-processor
>   is disabled.
>

First of all, thanks for working on this. While from Chromium point of
view there isn't any practical use case for this feature, it could
possibly be valuable for some other platforms.

I still see a problem with the current design. Mem-to-mem decoders are
commonly used in a multi-instance fashion, but media topology is
global. That means that when having two applications on the system
decoding their own videos, one might be stepping on the other by
changing the topology.

I believe that if we want this to be really usable, we would need to
make the media topology per instance, but that's a significant change
to the media subsystem. Maybe we could pursue the other options I
suggested in the previous revision instead, like ordering the formats
returned by enum_fmt by native first and adding format flags that
would tell the userspace that the format can have some performance
and/or power penalty?

Best regards,
Tomasz
