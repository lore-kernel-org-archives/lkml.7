Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE17BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 04:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8317E2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 04:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="invRPHWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFTEuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 00:50:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40825 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTEun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 00:50:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so1433797otl.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 21:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7KfXwWshFgYCRp/rB3EC7KJ7aO3/YBFcG4HpA2yrRc=;
        b=invRPHWwsG//4HFgg9KwSVpDmW6VW+E3xuRUlv6jjX+XcUyFbQHVG471IpclLNl2VX
         I3AZlwTuDX0/+rRDEabV4QRS/D9gr1ubU0bH9ZKJTFadXBg0m9J5DXEib9hp+IP5zJRn
         1hMMPiE2UdXow03GY4JfUMU6W21H2egfNnhEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7KfXwWshFgYCRp/rB3EC7KJ7aO3/YBFcG4HpA2yrRc=;
        b=Wg4DpOlYQvlh25ZTzPwWIgUrL6ljNunUpF66WSvs67utZ795MUlGLTEBwmHYUKKjRp
         OH+R9tlCLLfVPkmvIVsUlcud0KCXfkn/RMFlt89v/Gi04r36BY9QFq2674kzaAqlh03D
         6s6fllAw0LDKyEDPa1zsmmrG3Htdp8n9pTZENEa62zHlezopJwlK6m7cn43iHvZxU8KS
         f84Xa/WDOgb+0g/ct9BsLf6cKFZNNaCi2/S2U9GKbUlgr3Y8TE2+nBeRdskLTv99VVc5
         XmlRyKlMkZkLyABfTGjipYmFoCFcPrHARR8iPSNp9WGos7M/3UaeFlsuENXFWACd+Q/5
         vSfQ==
X-Gm-Message-State: APjAAAVg496V45s0Wy3BlI2pDcaeCwK6zBW2LiKNb4Ikkmq1zoiIDZJy
        eTxmrtkQ9n/G/aPf7gAiimKYds4Hs9iJEA==
X-Google-Smtp-Source: APXvYqyqEXqLF9EJd1H70SF7cbk0ewlT6nauwHCAiiSTjYyrkHOaBwDjMNBHMAEbA1NY+MCwLBDOFQ==
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr11653201otn.266.1561006242644;
        Wed, 19 Jun 2019 21:50:42 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id m5sm7688701oif.13.2019.06.19.21.50.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 21:50:42 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id b7so1408894otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 21:50:41 -0700 (PDT)
X-Received: by 2002:a9d:711e:: with SMTP id n30mr12204552otj.97.1561006241374;
 Wed, 19 Jun 2019 21:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190612093648.47412-1-tfiga@chromium.org>
In-Reply-To: <20190612093648.47412-1-tfiga@chromium.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 20 Jun 2019 13:50:30 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWaq1W0bCUTmx0ad29vBpH1xOEoe-Q33vQj2b8AvEHoVg@mail.gmail.com>
Message-ID: <CAPBb6MWaq1W0bCUTmx0ad29vBpH1xOEoe-Q33vQj2b8AvEHoVg@mail.gmail.com>
Subject: Re: [PATCH] media: Clarify the meaning of file descriptors in VIDIOC_DQBUF
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hirokazu Honda <hiroh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 6:36 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> When the application calls VIDIOC_DQBUF with the DMABUF memory type, the
> v4l2_buffer structure (or v4l2_plane structures) are filled with DMA-buf
> file descriptors. However, the current documentation does not explain
> whether those are new file descriptors referring to the same DMA-bufs or
> just the same integers as passed to VIDIOC_QBUF back in time. Clarify
> the documentation that it's the latter.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

That's a welcome precision indeed.

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>

> ---
>  Documentation/media/uapi/v4l/vidioc-qbuf.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/media/uapi/v4l/vidioc-qbuf.rst b/Documentation/media/uapi/v4l/vidioc-qbuf.rst
> index dbf7b445a27b..407302d80684 100644
> --- a/Documentation/media/uapi/v4l/vidioc-qbuf.rst
> +++ b/Documentation/media/uapi/v4l/vidioc-qbuf.rst
> @@ -139,6 +139,14 @@ may continue as normal, but should be aware that data in the dequeued
>  buffer might be corrupted. When using the multi-planar API, the planes
>  array must be passed in as well.
>
> +If the application sets the ``memory`` field to ``V4L2_MEMORY_DMABUF`` to
> +dequeue a :ref:`DMABUF <dmabuf>` buffer, the driver fills the ``m.fd`` field
> +with a file descriptor numerically the same as the one given to ``VIDIOC_QBUF``
> +when the buffer was enqueued. No new file descriptor is created at dequeue time
> +and the value is only for the application convenience. When the multi-planar
> +API is used the ``m.fd`` fields of the passed array of struct
> +:c:type:`v4l2_plane` are filled instead.
> +
>  By default ``VIDIOC_DQBUF`` blocks when no buffer is in the outgoing
>  queue. When the ``O_NONBLOCK`` flag was given to the
>  :ref:`open() <func-open>` function, ``VIDIOC_DQBUF`` returns
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
