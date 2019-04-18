Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4185BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F9F21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555598092;
	bh=73DTEQDvtlZ/lQfKUKmqK2Q2MLBYdmcVEIsnnAmecgE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xSpCT2FgQ5qg2usUDPK+lA6laWyrNtBwgI9ra1mYrMHXMnJ61ReFLi6hlWQ7gdU8v
	 PktITCLVu3mRL7B44MwsFPFeTnEy9yCAzBZMaX8qvywOJk0AXFLqmlMevPFrQPOjcI
	 b1vDMrt03x6Wj4Oo3CHYdfQF5zI+BgKzHbkzkN0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbfDROev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388343AbfDROeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:34:50 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E302186A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555598090;
        bh=73DTEQDvtlZ/lQfKUKmqK2Q2MLBYdmcVEIsnnAmecgE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yVVmmyK8oyHTkOESlHrnkv3yP37FXkt27A8Ntwia4uTDGm52TN7NKoSjVyGXhY6rY
         p3BThaj2MnXrG/MKlbmQEmxDAIrrw5XlBUiDMTkt0mcVt+LiRUuCJOLNz4UPfvn59g
         mV3jp0OAXU8yOXHQJbdPYZLyMBR3sjDAyg9elNuE=
Received: by mail-qk1-f170.google.com with SMTP id w20so1259750qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:34:49 -0700 (PDT)
X-Gm-Message-State: APjAAAUmi9GpUnQYwVLy65rB9Ij518N5XD0pnMFvaqGFqlpJ6ua1KIhb
        VqvS9C+AEy5pMOFwnNhlDopITjJuSt8Tj7l14g==
X-Google-Smtp-Source: APXvYqyuXzfSREBqLpAMu4YOuxqnmI4NSXt0chQ1+7szm0mVbz3gAAZRV7wSJtD3LX+3Nzj1ApUzWEBzfBzwS/02kI0=
X-Received: by 2002:a37:9186:: with SMTP id t128mr70511602qkd.326.1555598089099;
 Thu, 18 Apr 2019 07:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190417152928.10790-1-steven.price@arm.com>
In-Reply-To: <20190417152928.10790-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Apr 2019 09:34:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJiXvzMrMvLg=bRtms8vk77mQ6jNdpDJzspx3A701gJqw@mail.gmail.com>
Message-ID: <CAL_JsqJiXvzMrMvLg=bRtms8vk77mQ6jNdpDJzspx3A701gJqw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/panfrost: depend on !GENERIC_ATOMIC64 when
 using COMPILE_TEST
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:29 AM Steven Price <steven.price@arm.com> wrote:
>
> Since panfrost has a 'select' on IOMMU_IO_PGTABLE_LPAE we must depend on
> the same set of flags. Otherwise IOMMU_IO_PGTABLE_LPAE will be forced on
> even though it cannot build (no support for cmpxchg64).
>
> This fixes the following warning from kconfig:
>
> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y])
>   Selected by [y]:
>   - DRM_PANFROST [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARM || ARM64 || COMPILE_TEST [=y]) && MMU [=y]
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Humm, I thought I had fixed this. Anyways, applied.

Rob
