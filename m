Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6877BC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4100E2087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEpH+0ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfEPS0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:26:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39081 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfEPS0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:26:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id v2so3275865oie.6;
        Thu, 16 May 2019 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QOmJrz3t+ssW/c0JNL75BVKUs3lWPdi+hPwpLLqj0Y=;
        b=ZEpH+0epLMFSR18nfhuqzs+K3+pk1JK7FHLTbOUTQfU/wEjw2yw/OkaWvsmN+8euDm
         cpxhsPk10kP23ZWlHRbBYyqjuoOHCWxMJYUnlvztrx4pNOws3OHeTj/IEaoU3s72GxOH
         ZcjXTqYUWFIOQDh+ZtpROhV0KGHV+fHYmUSE8TdQHu2i3iO3sFJONBSJSOM6xSXnUWKp
         hZn1rCsMsGLLa2ctsLGmADOdhQ5tfUOZK5wdYIsBayPnaCHAzt7K37ipbtogV3WTG26v
         ctxFxluxhtaiN6LA+jEIcXU5x0lQQF1ok0OOcPaZ0wDldQf1BqXMRGl42fbGcfGQ66Cn
         YqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QOmJrz3t+ssW/c0JNL75BVKUs3lWPdi+hPwpLLqj0Y=;
        b=HxUvmtEREG/UjaYkpBTphgD6pP94xvwZ/LQU4eXyWbfLwbmrvO/0iilgGTRoHPI7Wm
         GaArDklQg55RGf6mBVcGlIgW1tMvKe2GIVBXsFCvWSZTz7q387aYfUQv7pD2I+81Qbxe
         T3y9OwqDfYn6rux4hTqxpKnLTWqVDGlF2gznieGZtpLLj1jAbVu0yUMgjDy1jUfB6m+H
         Oqdkb9C82iC4NIHyqxDR1G3jOK7Se6ikoXSGQaKHHjESIvG+O6EZIU77gMTDraj5jbo3
         J0Wv0nNhDvlZiPiQ4TN85iP+mHk6U5CJpi19SM25Hdr+44Vt07GSZignfyarbr9udb37
         jhdw==
X-Gm-Message-State: APjAAAW0u2kvW3AZixxFTVrH6Hf+8CHpb1P0ootZqO45PP7W4qJsAUiq
        XHih/8lu/QRlt0alQP8AjN4axMUGS4RotWFE7sU=
X-Google-Smtp-Source: APXvYqxtsCkbedLuyoFQPMGbJweEX/2iUWRBGnKBlpw9mcsocW3dkMpvyrQjOnc7DiWR1WpZ0EsRJpTfOtCCQLhwvOE=
X-Received: by 2002:aca:240d:: with SMTP id n13mr11043400oic.145.1558031190251;
 Thu, 16 May 2019 11:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190514155911.6C0AC68B05@newverein.lst.de> <20190514160241.9EAC768C7B@newverein.lst.de>
 <CA+E=qVfuKBzWK7dpM_eabjU8mLdzOw3zCnYk6Tc1oXdavH7CNA@mail.gmail.com>
 <20190515093141.41016b11@blackhole.lan> <CA+E=qVf6K_0T0x2Hsfp6EDqM-ok6xiAzeZPvp6SRg0yt010pKA@mail.gmail.com>
 <20190516154820.GA10431@lst.de> <CA+E=qVe5NkAvHXPvVc7iTbZn5sKeoRm0166zPW_s83c2gk7B+g@mail.gmail.com>
 <20190516164859.GB10431@lst.de>
In-Reply-To: <20190516164859.GB10431@lst.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 16 May 2019 11:26:45 -0700
Message-ID: <CA+E=qVdxvU5t9MB447Zd+-MO7rw+qBxxaZApjp4fgDx=W47r-g@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: DTS: allwinner: a64: enable ANX6345 bridge on Teres-I
To:     Torsten Duwe <duwe@lst.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 9:49 AM Torsten Duwe <duwe@lst.de> wrote:
>
> On Thu, May 16, 2019 at 09:06:41AM -0700, Vasily Khoruzhick wrote:
> >
> > Driver can talk to the panel over AUX channel only after t1+t3, t1 is
> > up to 10ms, t3 is up to 200ms.
>
> This is after power-on. The boot loader needs to deal with this.

Actually panel driver has to deal with it and not bootloader.

> > It works with older version of driver
> > that keeps panel always on because it takes a while between driver
> > probe and pipeline start.
>
> No lid switch, no USB, no WiFi, no MMC. If you disable DCDC1 you'll
> run out of wakeup-sources ;-) IOW: I see no practical way any OS
> driver can switch this panel voltage off and survive...

Ouch, looks like someone made a huge mistake in HW design?

> > All in all - you don't need panel timings since there's EDID but you
> > still need panel delays. Anyway, it's up to you and maintainers.
>
> Let's give it a try.
>
>         Torsten
>
