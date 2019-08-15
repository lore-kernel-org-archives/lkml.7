Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486C8C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC6F2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n917679w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfHOISm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:18:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34871 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbfHOISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:18:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id p197so1136235lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n93Dng/Ji8MdS4CMyB8lWHjceWaq72wrZdpqfUie2jw=;
        b=n917679wlyShUhrE5Ig3CFfBox9eY1vDh5kRoK7P3mDg7njrsuDaJ4qJSjP0n0hbvN
         6XifsLDIS3pWYVy7ZekSuZ95mPYr4uznZ084qrwwJW9GSUwY02fmoiMMGjcPWsPLiNYJ
         BJt4KywfKUnhrIVLnU600Uws2yZ9Et0XWqrlcCzH7U6LxN7OD1HNTr293DBvwy30Q1cs
         11+aPHS28sOkmSS/L2JI9Bmr2f3qQsIvSylZyRF9Pv2QANJ0oTZ7TKwfE6F/SM1L/Nyw
         XBCZnmBV99kF3Gb8iTlXZgSaY1JtoKpN45vN06DanE0j0nSsx191aIGKHyhj6a+FPHth
         etVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n93Dng/Ji8MdS4CMyB8lWHjceWaq72wrZdpqfUie2jw=;
        b=Cr0/nalYLW7tAE0ys1FbqHHkUbhFD91FTGAmTsi1IGvDwC+B9RiAHsGnRGGvKgeYE/
         AkfHGBIwP2oG2deDqovSpWklogiEccqicR+awsWaAc8smJRYjYAdrE8cfJ/ja9pQtLGY
         hU2EIfyEIxyMXf7+7KLYCtKwCLAfPzu7Hb1xLINf8JBMvi0X0a5CNwtR75oyFojcOZoX
         +jqb7pDOpBMZEF3/avD3oh4iWFXNNMvJnja+UD1aD0vCXB7WyTr0kGRLf5RMmtfSOq+C
         +56Odv3Pe3TDavNbWROYIBLown7Bb7H8WMt3N24RAqzTGOnWalcVZl9tQ5zAQKpVPOAr
         jnZQ==
X-Gm-Message-State: APjAAAV34cokbrLlr9PCNDwRvYEjH4RRhuQ3kgFsNE8cH+o/HFalQmm+
        v7SeBhpSnsRJZ5KJft7X+1seIzz24Z0HL3glQy54Pz/K/i+6Zw==
X-Google-Smtp-Source: APXvYqz+3m9CpHTiryHGgaHMtDawA41PP43UTCZWzylvPS7O0bar1RDoxUlI3ihahWRnC9SzzajOeS5xqZGxmVYZE8o=
X-Received: by 2002:ac2:59d0:: with SMTP id x16mr1883275lfn.60.1565857119990;
 Thu, 15 Aug 2019 01:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190815004854.19860-1-masneyb@onstation.org> <20190815004854.19860-5-masneyb@onstation.org>
In-Reply-To: <20190815004854.19860-5-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Aug 2019 10:18:28 +0200
Message-ID: <CACRpkdbj10yneOP4JKFGXyiY4e1vS6-oB=W2vs6nj_X2uAY=pQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] drm/bridge: analogix-anx78xx: convert to i2c_new_dummy_device
To:     Brian Masney <masneyb@onstation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 2:49 AM Brian Masney <masneyb@onstation.org> wrote:

> The i2c_new_dummy() function is deprecated since it returns NULL on
> error. Change this to use the recommended replacement
> i2c_new_dummy_device() that returns an error code that can be read with
> PTR_ERR() and friends.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
