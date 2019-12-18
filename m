Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AA6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E7C206D3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ehbk3QqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfLRAy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:54:58 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39026 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLRAy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:54:58 -0500
Received: by mail-il1-f196.google.com with SMTP id x5so190180ila.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cKjTtuJ6Cl3BPkbORmbBVCSJ2Mx93CiWQ5Web+aZoo=;
        b=Ehbk3QqUh5bTHL9JWhwrStjM1T3/LkM1Kqv+zwWwwk6M/oBy9gNn8PJ2yhBeubKtqw
         eA4bTbmTus7J2LmfuinU86pawGesMIrNtGwKCU1jkvSXjjAkSBccuRyP6ktvcVlBET3y
         RsGdJaHIJjTrGFAjMBY6t7gqFXFQbI1WCoBrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cKjTtuJ6Cl3BPkbORmbBVCSJ2Mx93CiWQ5Web+aZoo=;
        b=W8n41Rx9+1HO4xbg/Eyqsb8nttBquitA6McabAyQbmkkYGECjxm1RQLvkY9Pn9R7P5
         yytsdQi8Aekf695OVV0taPh0cbstDDRlMYMNR9wDeU7UgBp8MhjumifRy/HKCmci8BbL
         kZQ9hAbBfL+PEGFHKwAi7p+E0uQs13KNXHAY3935h8L3x77aBlsbVRsde3151ElUbUA5
         mGlndnZxIIAU9Ca1sLuodvW2LnBLHIJfYX7i0KwTJ9SDTifpzluEx3ZWPBuoMOezZ0mV
         tmNi2PHLSPtZQZgXrM56kHHZ/ImdulYyRBuRWUPbEFTFpGt0IP11gJQAyPpM2f9b9CS2
         ALCQ==
X-Gm-Message-State: APjAAAUtR+8ds5CLIZMlmE2VQi2TnodezCMfvhUsU+p/srh1mTL5WKrI
        GL3DenyhzdaXx1BZP9+A1JtFzW6po98=
X-Google-Smtp-Source: APXvYqyx6VQ6j16qfhldQru8X/t0kIHiTlTbXg8o6iSRRUlz4YUldSOIse9hmZAYwEQ+RQa6455EHA==
X-Received: by 2002:a92:51:: with SMTP id 78mr617812ila.121.1576630496640;
        Tue, 17 Dec 2019 16:54:56 -0800 (PST)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id x62sm121876ill.86.2019.12.17.16.54.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 16:54:55 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id a6so176807ili.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:54:55 -0800 (PST)
X-Received: by 2002:a92:cc90:: with SMTP id x16mr224285ilo.269.1576630494768;
 Tue, 17 Dec 2019 16:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20191213154448.9.I1791f91dd22894da04f86699a7507d101d4385bc@changeid>
 <20191215200632.1019065-1-robdclark@gmail.com>
In-Reply-To: <20191215200632.1019065-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Dec 2019 16:54:42 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U7PXe7n3Q+k6ZWvkUeCRA8Esdyc6C39078=N_7D+BCXA@mail.gmail.com>
Message-ID: <CAD=FV=U7PXe7n3Q+k6ZWvkUeCRA8Esdyc6C39078=N_7D+BCXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fixup! drm/bridge: ti-sn65dsi86: Skip non-standard DP rates
To:     Rob Clark <robdclark@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Dec 15, 2019 at 12:06 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> ---
> Note however, the panel I have on the yoga c630 is not eDP 1.4+, so I
> cannot test that path.  But I think it looks correct.
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 110 +++++++++++++++++++++-----
>  1 file changed, 89 insertions(+), 21 deletions(-)

I ended up basing patch #9 in my v2 series slightly more on Jeffrey's
patch.  Hopefully it looks OK.

I don't have any eDP 1.4 panels either, so hopefully it's all good there...

-Doug
