Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92B3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2D420881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="czft9FTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfEOQ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:28:30 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40380 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEOQ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:28:25 -0400
Received: by mail-ua1-f65.google.com with SMTP id d4so82500uaj.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XibrizVK+x4gwJRznLKLxYNtzx6v60+igfS3HoIEayQ=;
        b=czft9FTmE5tMVE8dOINVb8LBbsa35P48tLVdr892dOMLRa4VB1coebG0BKnTxX5Cka
         6m1J4wFkHSi7VzolqLIgckMP6rlJbSJD+yfgb6Cih4Pe7Mqr04yeQhzIn8xXjqs0SOoI
         ZmDyr6hSfcx3TYTP7yv3gAaimFJ6Y3azQMq+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XibrizVK+x4gwJRznLKLxYNtzx6v60+igfS3HoIEayQ=;
        b=Uv/Kp31v7SLhP4NQtmOGiCR9t84p5FOr8p1yLxfa+k6JdB80DHmdf6stobNaUcVve9
         DeK80UhO4XOsKmpDCqSFLBT/hByj79GNugxOwPJ8uzh+87BrLQe3irHxzXDd6yVluWKc
         rVVCXeDsA9LhcLcMwvOZP1OyJSrMIG+zVNpZ6FKs+jWV4r099EV3ZSjR0hrZRbE7gu0Y
         ozYPVMFrT8qCLX/3FburqbR0tKD4H6qeqxtks9WqVAifxivmFkxEMvalvIhFhCtEC/Xd
         +SJxcTkSda3jyv527+fzhKaa9q9MtyangK2TB8/RLLGH5o5t14Kmxh09qnA2e9uzxGN8
         LcpQ==
X-Gm-Message-State: APjAAAVhmK91lIl6eIiVpbiOP0Tc8uhteslOyXKPsg2dWlah7iklSFCx
        UWsZEqM/KE6ZGjRXznfE9io/NxjsfBk=
X-Google-Smtp-Source: APXvYqxY5xQ7WFC2q/iEXL9ynFOq2gUPaKeyqK648fu1UQKui393tdHjBGEYpqB7yB7GWyqNHQQWcg==
X-Received: by 2002:ab0:7019:: with SMTP id k25mr4230500ual.49.1557937704301;
        Wed, 15 May 2019 09:28:24 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id c39sm8864393uac.3.2019.05.15.09.28.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 09:28:24 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id o5so342983vsq.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:28:24 -0700 (PDT)
X-Received: by 2002:a67:f60b:: with SMTP id k11mr13708286vso.111.1557937389222;
 Wed, 15 May 2019 09:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190502223808.185180-1-dianders@chromium.org>
In-Reply-To: <20190502223808.185180-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 May 2019 09:22:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W2BvvEx+sYji5pGAEwagD6uA20nCMKwiU=kD6FqkSLiw@mail.gmail.com>
Message-ID: <CAD=FV=W2BvvEx+sYji5pGAEwagD6uA20nCMKwiU=kD6FqkSLiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: bridge: dw-hdmi: Add hooks for suspend/resume
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

From: Douglas Anderson <dianders@chromium.org>
Date: Thu, May 2, 2019 at 3:38 PM
To: Heiko Stuebner, Sandy Huang, Andrzej Hajda, Laurent Pinchart
Cc: <linux-rockchip@lists.infradead.org>, Neil Armstrong,
<mka@chromium.org>, Sean Paul, Douglas Anderson, Zheng Yang, Sam
Ravnborg, <dri-devel@lists.freedesktop.org>,
<linux-kernel@vger.kernel.org>, Ville Syrj=C3=A4l=C3=A4, David Airlie, Jern=
ej
Skrabec, Daniel Vetter

> On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> cycle:
>
> 1. You lose the ability to detect an HDMI device being plugged in.
>
> 2. If you're using the i2c bus built in to dw_hdmi then it stops
> working.
>
> Let's add a hook to the core dw-hdmi driver so that we can call it in
> dw_hdmi-rockchip in the next commit.
>
> NOTE: the exact set of steps I've done here in resume come from
> looking at the normal dw_hdmi init sequence in upstream Linux plus the
> sequence that we did in downstream Chrome OS 3.14.  Testing show that
> it seems to work, but if an extra step is needed or something here is
> not needed we could improve it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 21 +++++++++++++++++++++
>  include/drm/bridge/dw_hdmi.h              |  3 +++
>  2 files changed, 24 insertions(+)

Did anyone have any thoughts on this patch series?  Thanks!  :-)

-Doug
