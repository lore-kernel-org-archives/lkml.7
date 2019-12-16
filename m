Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1904C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0412467B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLPDDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 22:03:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41479 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfLPDDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 22:03:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so3774307eds.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 19:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FENccwgG3uhDFjFer/TFmu057ClxmW4CVGbxtoIFMB4=;
        b=H1C3libRsRqhaXFyRUnPXRTmb9MKlJ1Z5tvCGf1U1JaDQK/tTdVo8oL+LuG/ORiytt
         wIyeqr8Amlq1vBTwizpYoV8LSiGEIi0AQOPCfEBCOJTavr8ZDWOhl9wkeaAeZO+0OHiG
         +jrG7USZTN5lgBAy6JEPkzjeQasfKy/ZwyJHwj2E43AMUAQYEWLay169NCwRs+lgpRwI
         giWf+zhMTzVbFWzUnAyRqEBzRY+vbMECC1Mksc7v3fO3rYZNNZWJhL26uw49GVV9g+ln
         0DesPCvXIm3dxgu1pzqRuIypkeMFMuBlCe+RiXA+ic7fjzWTDtLKvcvvn7PSQduJhZP2
         w6pw==
X-Gm-Message-State: APjAAAVm/6YkQ//ACWhgQc+QjiNzE4jRhxR0n6cKyDZX20FGMZ7kmdg3
        MClEFFHnoQqegQPXpWXEd3xG0OZtvhg=
X-Google-Smtp-Source: APXvYqzeyp8KubcRi2rZvK13ws8DDU09Kv5daBELJdyCuLyVDEvfcKAHXTYD7acDrSVvrIcWQOaCwg==
X-Received: by 2002:a17:906:4815:: with SMTP id w21mr18706132ejq.259.1576465418097;
        Sun, 15 Dec 2019 19:03:38 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id f10sm674090edl.90.2019.12.15.19.03.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2019 19:03:37 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id u2so5081274wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 19:03:37 -0800 (PST)
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr29527605wmg.66.1576465416941;
 Sun, 15 Dec 2019 19:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20191215211223.1451499-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20191215211223.1451499-1-martin.blumenstingl@googlemail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 16 Dec 2019 11:03:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v6528SUOyefhsnjEwG7vfud3+Ce+_=CM3cM4vKiRcmNXAA@mail.gmail.com>
Message-ID: <CAGb2v6528SUOyefhsnjEwG7vfud3+Ce+_=CM3cM4vKiRcmNXAA@mail.gmail.com>
Subject: Re: [RFC v1 0/1] drm: lima: devfreq and cooling device support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     yuq825@gmail.com, dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

I think it's more common to have separate copyright notices. First you
have yours, then a second paragraph stating the code is derived from
foo, and then attach the copyright statements for foo.

ChenYu

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
