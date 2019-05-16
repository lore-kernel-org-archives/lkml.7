Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9DDC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E862087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iFdbvY1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfEPWpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 18:45:06 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:32907 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfEPWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 18:45:06 -0400
Received: by mail-vs1-f65.google.com with SMTP id y6so3420481vsb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+W9jD9o7YYLYB/v0Ro7pXl+sH8ADQyIbB7T7NXFVEcc=;
        b=iFdbvY1Qgl23eLRHTcbK2KUoW8rVpz0RfgpjJVzvA3c+FlUStxkuV64Wmn8f0D9q+0
         WFM2GPW77EVVaGnoDv7ntLl+FCqJJHHbK/5HI2zpwdwTg2qw1RbSA+tCBCNIKN5g9LuL
         cXJ8bXROlUY7THLAZMkcbiVOe572QpbIYKKjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+W9jD9o7YYLYB/v0Ro7pXl+sH8ADQyIbB7T7NXFVEcc=;
        b=K5X0+DkPM0yoh2GS9y6cQR3prrR3ul3WBF6XguGvp6H4yg0P7wGYMjgwq5oB79D2gu
         JFATl6rP4QG3fqevLw4XaPqhQ+YhvZvaZa+U5dviC/iyqTWBE9BA9+UYcrfd/FYpBgxo
         31bQt9OfvJsPKEnbFj4CXJu1qBFA9wPJOv1UKrmgGsq/4kBMCvdzuJaQzbb6w+J3V2CY
         XxMacafDRX92BVhOBc4FgLRevH+MBaFvgcLMIGmyZoYlqXtRsnD+bJ/M3DTjSXHy7YGI
         D+LRSJ4yjCviYTuLIo6Z2+m5kmacKRl25/0wgPWK3Bvsq5x4hR5iDGeFFMloqz0Yjtz2
         XFDw==
X-Gm-Message-State: APjAAAXdBr+LvrHxD52u7xXlrwkw6IYe+2e5TjlMKjgoQ0zTLw62c/Ph
        oGoRl954SflYw83WzGb1GlRzF5eISMI=
X-Google-Smtp-Source: APXvYqz2vpPvVDhoWSJVuB1Nk1kcRmZ2SQeIyDUp61/yle4vDCqp1BPkm/+SEpgJy14iyhiYvnecOQ==
X-Received: by 2002:a67:7587:: with SMTP id q129mr24197516vsc.40.1558046705122;
        Thu, 16 May 2019 15:45:05 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id d69sm2033698vkd.25.2019.05.16.15.45.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 15:45:03 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id l20so3407160vsp.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 15:45:03 -0700 (PDT)
X-Received: by 2002:a67:b348:: with SMTP id b8mr17879343vsm.144.1558046702869;
 Thu, 16 May 2019 15:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190516214022.65220-1-dianders@chromium.org> <20190516214022.65220-2-dianders@chromium.org>
In-Reply-To: <20190516214022.65220-2-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 May 2019 15:44:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V3U=5KttaqjUvvF=vpKwFNMd6q0=J1ZKUrJ1b-Stz5bQ@mail.gmail.com>
Message-ID: <CAD=FV=V3U=5KttaqjUvvF=vpKwFNMd6q0=J1ZKUrJ1b-Stz5bQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/rockchip: dw_hdmi: Handle suspend/resume
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 16, 2019 at 2:40 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> cycle:
>
> 1. You lose the ability to detect an HDMI device being plugged in.
>
> 2. If you're using the i2c bus built in to dw_hdmi then it stops
> working.
>
> Let's call the core dw-hdmi's suspend/resume functions to restore
> things.
>
> NOTE: in downstream Chrome OS (based on kernel 3.14) we used the
> "late/early" versions of suspend/resume because we found that the VOP
> was sometimes resuming before dw_hdmi and then calling into us before
> we were fully resumed.  For now I have gone back to the normal
> suspend/resume because I can't reproduce the problems.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Add forgotten static (Laurent)
> - No empty stub for suspend (Laurent)
>
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Whoops, forgot that I should have carried forward:

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-Doug
