Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2666DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA4820857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L2pIgyCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfCTC7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:59:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42718 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCTC7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 22:59:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id w139so628541oie.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 19:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMr1RUBK1VUjq0K0x9zOXPkgJoLdgDs5VbUJMJruWbo=;
        b=L2pIgyCChQcpLOr/swrUbZsmcACIcg4yzS8kckFZQYTxtm8Ghb3VBzU/pbAnRj0+hv
         9d6XymhlDQKXAWaCUzBpi+8FILodW5+sdiozjW+CSXkAoVulczBeKB8kgq0LN4s5iYEk
         ZNH4C/hddgQvW6XWIqqIPyw7TXGsfrue0n3RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMr1RUBK1VUjq0K0x9zOXPkgJoLdgDs5VbUJMJruWbo=;
        b=NolB3WR4b3em9VI4SKxnP/P7HtJw3awlVOn7sLn3VcjnhtrN5oMDC3nhmu55ZjIiXB
         LD2pvlUBQpW/kwpwOHZ54AWFFJX7kuoj6NFci9QcpkfjDHywxaIBu33HsjFyS1tK0vZz
         qDrOsTlpcbgeoUp9A6uASDb6qTY2pkljJPU3RiCYdy/VkEPlrlv0V9wHEnHH4VnUn2zI
         BRw8cGkQl2ppcVOVUfbb94ZCEeCIbVohwW1safOMopFO1ylKruWwT5Gs3I9AkKjiz7gZ
         R4M9X9TDm2/4f1g2aOjmYEkMMV6OZ6FeopOzN8glpb7mW/MzQ7/8osGWyOHamT5r+hC0
         Iuyw==
X-Gm-Message-State: APjAAAU+pgDzPP8AKrD6qqQH/hFVHGU3fDuPm6A3DqXYUWG87jus6s5C
        qbcSGN9gQDfN9UaVsGxAy2UScTZ/ichaCQ==
X-Google-Smtp-Source: APXvYqxNuifXZVztNT/jXaO8UjxV2bb/AmVbXaI7aFVDWR9bB0U6+XRZZWlVKRJT9S9D5f/5QA4jJQ==
X-Received: by 2002:aca:4812:: with SMTP id v18mr3323563oia.36.1553050793075;
        Tue, 19 Mar 2019 19:59:53 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id 92sm342656oti.60.2019.03.19.19.59.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 19:59:51 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id v7so633289oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 19:59:50 -0700 (PDT)
X-Received: by 2002:aca:b7c4:: with SMTP id h187mr3760677oif.112.1553050789996;
 Tue, 19 Mar 2019 19:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.3917a1471bfc8cbdfdde8026566b3857caff5762.1553009355.git-series.maxime.ripard@bootlin.com>
 <9d9fe5c2dc58f9398cb6b1e9bb208640d25ae816.1553009355.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <9d9fe5c2dc58f9398cb6b1e9bb208640d25ae816.1553009355.git-series.maxime.ripard@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 20 Mar 2019 11:59:38 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BH25EEXN1KFsQigJo-K_KCfM0vmwVYJmj1-fkw+189Cg@mail.gmail.com>
Message-ID: <CAAFQd5BH25EEXN1KFsQigJo-K_KCfM0vmwVYJmj1-fkw+189Cg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        jenskuske@gmail.com, Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, Mar 20, 2019 at 12:29 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> From: Pawel Osciak <posciak@chromium.org>
>
> Stateless video codecs will require both the H264 metadata and slices in
> order to be able to decode frames.
>
> This introduces the definitions for a new pixel format for H264 slices that
> have been parsed, as well as the structures used to pass the metadata from
> the userspace to the kernel.
>
> Co-Developped-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Pawel Osciak <posciak@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/media/uapi/v4l/biblio.rst            |   9 +-
>  Documentation/media/uapi/v4l/ext-ctrls-codec.rst   | 569 ++++++++++++++-
>  Documentation/media/uapi/v4l/pixfmt-compressed.rst |  19 +-
>  Documentation/media/uapi/v4l/vidioc-queryctrl.rst  |  30 +-
>  Documentation/media/videodev2.h.rst.exceptions     |   5 +-
>  drivers/media/v4l2-core/v4l2-ctrls.c               |  42 +-
>  drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +-
>  include/media/h264-ctrls.h                         | 192 +++++-
>  include/media/v4l2-ctrls.h                         |  13 +-
>  include/uapi/linux/videodev2.h                     |   1 +-
>  10 files changed, 880 insertions(+), 1 deletion(-)
>  create mode 100644 include/media/h264-ctrls.h
>

Thanks for the patch and addressing my comments patiently!

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
