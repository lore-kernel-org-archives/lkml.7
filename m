Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB7DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAD724679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0dWNacy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLTIzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:55:39 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37884 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfLTIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:55:39 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so8634687ioc.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 00:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFyk6wfDM3uJNZM3XmVJRb6zXEf3/dZ+tc8Bv4YB2yY=;
        b=W0dWNacy+Z08VU2VNyW6cLKarj2vQSvC7GwIrBrk5kAeHpY8LUCugVbH17i6+PQmyA
         lzshmpaK75tqkDiY8MXYJFy40HtHbIraPO0UNF/SdTr1T0MrZjg9bMNdnlBgv7STNqf6
         AcP0G+MibU3+k6+ra+ZS/fYB+z7mO6Z7OA5uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFyk6wfDM3uJNZM3XmVJRb6zXEf3/dZ+tc8Bv4YB2yY=;
        b=CIHmSMdopNSlowMAQjBsY7ZJ1jk2hrJn17CUvHB3QR0m4JD+QjYkiGQCXdG9kIHp4Z
         uPAqFK67B9N7KHHBIpmFKGGc6WSZ4uX8HqT+qR4Kgj4TevG4ym4LOCf84aqKYrTxEHHH
         wlc5dKq4wju9gCuR+teTolhFQg8ApjGqfcjCurghMJ6RvMQ7MqOOkI2JktkGHtg0R0Um
         zy5q2p22LQQHP3JAxwNFgmgK04PJ7vO/zXEfhLIGQ8uyaEyk2kFrTCLJ/YG3eHpQ/hft
         zruoI1Kon7XxiSzAVb5x2VaJ2zqmaEPcPUyXk3dkgx6Hkp86JjIcAesYi8APP2hFL50L
         Ra5Q==
X-Gm-Message-State: APjAAAVF+j5HRa42CF5OHwGxZH6ZB7GmP6niVN8O8lMBRjGEEnm+0sgq
        s7d1iLrx3OK/Yh/Yacafdsk26jfBzSgzbL4QA1gPyg==
X-Google-Smtp-Source: APXvYqx6jNS3ruJSqRukqpBfv5nCziRlHY3HFBeibFf5MWoadOk37sDVbGh863vc8QU+b1jTv0rGaDTo6tv6CoaEyJc=
X-Received: by 2002:a6b:3845:: with SMTP id f66mr9807832ioa.102.1576832138346;
 Fri, 20 Dec 2019 00:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20191220081738.1895-1-enric.balletbo@collabora.com> <20191220081738.1895-3-enric.balletbo@collabora.com>
In-Reply-To: <20191220081738.1895-3-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 20 Dec 2019 16:55:12 +0800
Message-ID: <CAJMQK-h9w5a1CKyTqdBsmz6TYbcGMzhPLNwU7kYBYp56EV0PZA@mail.gmail.com>
Subject: Re: [PATCH v22 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Ulrich Hecht <uli@fpond.eu>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 4:17 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> From: Jitao Shi <jitao.shi@mediatek.com>
>
> This patch adds drm_bridge driver for parade DSI to eDP bridge chip.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> [uli: followed API changes, removed FW update feature]
> Signed-off-by: Ulrich Hecht <uli@fpond.eu>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
tested on mt8173 chromebook
