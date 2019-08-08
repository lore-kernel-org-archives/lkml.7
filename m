Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F3DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111E42086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565304712;
	bh=8Pp17pXv2BsvdUGgrjCA+x6loADEC1HGz0lVc93J0rg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hu5fYYmHqR/cOwM8ekDdJHpvIipxZMYhafFX0iHZ4xdg6U5I64DxLuD5Zhlc9gUmu
	 XZg5OB0qOhv4RWBCuWHaL+GDIXLem3W2rx0FPQJ6MAEmXOY0zkv8gpaGSHbrK9rBn5
	 uRB2XimIKZ9IjmE3luY2Soyxv7mwOGdOzNpHEZXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390492AbfHHWvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733140AbfHHWvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:51:50 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823402184E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 22:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565304709;
        bh=8Pp17pXv2BsvdUGgrjCA+x6loADEC1HGz0lVc93J0rg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=06U/6nvMdcCkxw7UcbHXLjGLUFy4AtCl3ss9jAZ+s8AHXPinmRTOMcTOo59OHykyz
         NDe7Mf3FCFD0xA2VihjqBz2+9Gzh0S2MrDRCKUqGdaDbpNwQI3cKQrcdKw9UKGcfRT
         oJCXkcagX7UsGQTlExLl2pKFLNyApTCSDnYH2gJ0=
Received: by mail-qk1-f169.google.com with SMTP id g18so70230937qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:51:49 -0700 (PDT)
X-Gm-Message-State: APjAAAW5bE0iOx3BMQnQYNDBISXw4tIVhpBvoOeXi3m7WXAxk3Saeel8
        RJnAOyDdq4+q+FyYFolIhhPmQer58qq+Td8uHA==
X-Google-Smtp-Source: APXvYqwbl/3VPMfI5y3PwG2THnJOA+RM7EdEeptDWTFIwfSk57LM3T+Yd81fZ13xvanJ+3+maiecJE8s+uVIpk4y0kM=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr16013485qke.223.1565304708728;
 Thu, 08 Aug 2019 15:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190808134417.10610-1-kraxel@redhat.com> <20190808134417.10610-8-kraxel@redhat.com>
In-Reply-To: <20190808134417.10610-8-kraxel@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 8 Aug 2019 16:51:37 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rqigmySoJg0iknkEJ5hzWeD3w2iSTpWoqoD67fGV3cw@mail.gmail.com>
Message-ID: <CAL_Jsq+rqigmySoJg0iknkEJ5hzWeD3w2iSTpWoqoD67fGV3cw@mail.gmail.com>
Subject: Re: [PATCH v4 07/17] drm/shmem: drop DEFINE_DRM_GEM_SHMEM_FOPS
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 7:44 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> DEFINE_DRM_GEM_SHMEM_FOPS is identical to DEFINE_DRM_GEM_FOPS now,
> drop it.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem_shmem_helper.h      | 26 -------------------------
>  drivers/gpu/drm/cirrus/cirrus.c         |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
>  drivers/gpu/drm/v3d/v3d_drv.c           |  2 +-
>  4 files changed, 3 insertions(+), 29 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
