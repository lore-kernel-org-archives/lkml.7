Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA5AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B4524676
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN3zEZj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfLPCvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 21:51:45 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42600 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfLPCvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:51:44 -0500
Received: by mail-ua1-f67.google.com with SMTP id d8so1558081uak.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 18:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dt2N4SwdmDzKos7KOOuigco4w8TfoOXTqKozyp0A0x4=;
        b=eN3zEZj0WJFI6jBrvhlDydESyJ54sA6i7pO0dzNumgwquUT3cBMjt1kPXWPgLW3+KC
         O/9cPuh7+SCcZCEVWKiGl4Zs9dGE8yqQ02w1E4WnmdJIooJX5r/HWWSIZx+LYM5Gx8sh
         xZDmQj8fadMEQ0zsMW/4hfBKtzJZPbpfh2uo7OJsFUVjE2IYzjqoSxRffWaas85lHWYs
         FEeNRuQmA3WgSTH4Z+N/uv1NtKIesr1j4ANKbjbW9iGkgLYKCOrL1DwbXDVVlVbLyvEn
         pfLgUfG/9SZl0ixCu+Dk5YzqDa1nfiw3FzWVGQzdDb33P+zB6JVF4Vc2J9YNJw5Xj6yO
         8v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dt2N4SwdmDzKos7KOOuigco4w8TfoOXTqKozyp0A0x4=;
        b=NR0PaJYl0UauuBZKEHZdQJUA+ZnfG0lFxvFoHai4V1nnVlIxq0fQrDOoEFuJR+ElR4
         R47M2az9nfKB2evgfV8z1naSCZwiuq6JD4TVHJp9suT9URZXdWPdxpwWh/QiynqKAZRY
         p2r4hw0vf4ZVYWE5f/AMXpY64z7QaE6kORTQ2Ir8w/1K18FDa41lbNqz21SCV91++cN3
         gSWQ2G9qu6Gp45CFJXswznx3fLPE9ZjgNCtQnN9m32NH/COqJKa0weWMntCbIQiETUDM
         sWMlDIv7gA/2lSN+jVJle8gH6gDlF3hgMT7Ou8HXLmyJyFDuPhY0HoTpHD2H3M1T7D3o
         m4OQ==
X-Gm-Message-State: APjAAAW+4hxI3SyU/AG3s+qfEVpIAUd722zVe6TMItmccKMnrbwp3LC9
        yy7SvQbbAzA5230DDTZmeEFTPbv8zLuRxmrK7W0=
X-Google-Smtp-Source: APXvYqw3MpWIVLjyYNcUhZRmQiQ0xpTyg++SgIZJzbsAahqWonhwopXbf6c/t0aPRJJxhF5A45bTkX9URI3HMonCQGo=
X-Received: by 2002:ab0:7027:: with SMTP id u7mr21346813ual.94.1576464703537;
 Sun, 15 Dec 2019 18:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20191215211223.1451499-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20191215211223.1451499-1-martin.blumenstingl@googlemail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 16 Dec 2019 10:51:32 +0800
Message-ID: <CAKGbVbvj5zK9gVDQ3+0=xmF5pOUOSJzZ6jaGKHoCqwjYz+UiEQ@mail.gmail.com>
Subject: Re: [RFC v1 0/1] drm: lima: devfreq and cooling device support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for adding this.

As the license, it's up to you, I think it's OK for now.

For the code, I think you may need some lock to protect the time records as
there are two kernel threads gp/pp will try to mark GPU busy and several
interrupts try to mark GPU idle.

Regards,
Qiang


On Mon, Dec 16, 2019 at 5:12 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> This is my attempt at adding devfreq (and cooling device) support to
> the lima driver.
> I didn't have much time to do in-depth testing. However, I'm sending
> this out early because there are many SoCs with Mali-400/450 GPU so
> I want to avoid duplicating the work with somebody else.
>
> The code is derived from panfrost_devfreq.c which is why I kept the
> Collabora copyright in lima_devfreq.c. Please let me know if I should
> drop this or how I can make it more clear that I "borrowed" the code
> from panfrost.
>
> I am seeking comments in two general areas:
> - regarding the integration into the existing lima code
> - for the actual devfreq code (I had to adapt the panfrost code
>   slightly, because lima uses a bus and a GPU/core clock)
>
> My own TODO list includes "more" testing on various Amlogic SoCs.
> So far I have tested this on Meson8b and Meson8m2 (which both have a
> GPU OPP table defined). However, I still need to test this on a GXL
> board (which is currently missing the GPU OPP table).
>
>
> Martin Blumenstingl (1):
>   drm/lima: Add optional devfreq support
>
>  drivers/gpu/drm/lima/Kconfig        |   1 +
>  drivers/gpu/drm/lima/Makefile       |   3 +-
>  drivers/gpu/drm/lima/lima_devfreq.c | 162 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/lima/lima_devfreq.h |  15 +++
>  drivers/gpu/drm/lima/lima_device.c  |   4 +
>  drivers/gpu/drm/lima/lima_device.h  |  11 ++
>  drivers/gpu/drm/lima/lima_drv.c     |  14 ++-
>  drivers/gpu/drm/lima/lima_sched.c   |   7 ++
>  drivers/gpu/drm/lima/lima_sched.h   |   3 +
>  9 files changed, 217 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/lima/lima_devfreq.c
>  create mode 100644 drivers/gpu/drm/lima/lima_devfreq.h
>
> --
> 2.24.1
>
