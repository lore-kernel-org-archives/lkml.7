Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E66C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B909B21871
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="myAjYl3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389032AbfGPX7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:59:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33217 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfGPX7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:59:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id r6so17312607qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfE+1oH2ev9A7CB6B7OCM0HfuvGIKPETwgwy1wYPeZk=;
        b=myAjYl3qrrjUdybw3rfkkqgxLpxX2EWxa6gWin7tovqVhvuC1kAEj0YUMz0a+INMKn
         k34dHtcAcHsWoDetwCiVgDi03O2ZbX6tn7T6FBnKsTPf2BLewHVVFqVnoOY7p/UiUCEe
         +2TMI/XehWPm3bOXRcM82WCBDwbCShBjLtw7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfE+1oH2ev9A7CB6B7OCM0HfuvGIKPETwgwy1wYPeZk=;
        b=eACoLFdxRxg2EVAT2uAymkkmjACDD8l8B9jLMrAyh7peB4Z35V5PidAMHuAqXaC0fK
         7CB6Aw9TKALuiHory185xpRfgpszLI9v/clq6ybVLNx+XY0JDK56CaTaoY42yTDdat0q
         uIxeT/5ejkf3MBxYm4611kvVgUmB9SqOITY6lSC3xheyYeeOWyYdAyNT/eGrgGWTQGMt
         xIulyiThiOBcDw5NgTLFBQF9aJqQRi8vpzRk/io8bdPGbydzzAvaIxvQzhLwGcor83fC
         vwgOH91aAfF/7T0cmELqMjU9BBMM2mO81uDCq+z9Nbc2P4+B9Ph4l7J9u7yq+bYMGSdY
         2Vkg==
X-Gm-Message-State: APjAAAWOvRImS21L7hBgfzoQSvkQvCf5cqU4SA00ttF5QiUgsUOMlmhG
        STs7x1X1ZnAXot4D5NDgOBwDca7djlo20vc24z0Rjw==
X-Google-Smtp-Source: APXvYqyCn5WDabT9u/P+OGBvnjMb2lK0frfpzoQz2UZeeBoGFN9gytFn4nfFqeUwNxxQx3qvg3WhGoAnUFfps5oKIQ4=
X-Received: by 2002:aed:3b1c:: with SMTP id p28mr24024945qte.312.1563321575377;
 Tue, 16 Jul 2019 16:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com> <1562625253-29254-7-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1562625253-29254-7-git-send-email-yongqiang.niu@mediatek.com>
From:   Ryan Case <ryandcase@chromium.org>
Date:   Tue, 16 Jul 2019 16:59:23 -0700
Message-ID: <CACjz--k0wVpxWTBXQeUHqm50RgvaCNkNb3DO+KviCOtq-e9gTQ@mail.gmail.com>
Subject: Re: [PATCH v4, 06/33] dt-bindings: mediatek: add mutex description
 for mt8183 display
To:     yongqiang.niu@mediatek.com
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 3:37 PM <yongqiang.niu@mediatek.com> wrote:
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> This patch add mutex description for mt8183 display
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index bb9274a..4a22d49 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -53,6 +53,7 @@ Required properties (all function blocks):
>    For most function blocks this is just a single clock input. Only the DSI and
>    DPI controller nodes have multiple clock inputs. These are documented in
>    mediatek,dsi.txt and mediatek,dpi.txt, respectively.
> +  for MT8183 mutex, this hardware is always free run, has no clocks control

This should have capitalization, punctuation, and drop the trailing space.

It also reads a little strangely. You may want something like "An
exception is that the mt8183 mutex is always free running with no
clocks property."

>
>  Required properties (DMA function blocks):
>  - compatible: Should be one of
> --
> 1.8.1.1.dirty
>
