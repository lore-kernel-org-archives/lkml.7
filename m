Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C08BC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CEE21743
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPedfFTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfHOIfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:35:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40954 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbfHOIfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:35:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id b17so1143647lff.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LckeMEL++L98xkE6bRHUomn8itgtRqdrAYiiSW7aPt8=;
        b=jPedfFTQpgM6N16VFCMmcxfHRcTAvQLEVyl2L+pi2uNbG2bAZTYPJy6zsyYd/zsq75
         qLGM6kd/VOPA6/+zGy4f2K6XHTk26IBdEHY/QLWxecOs/9lvtdbmOJfZwKIQJ7DlE+sE
         YPADIXmnziNit+bcqcv1rMbb3OPAfelMCc27OtpaNVFdT2cms0GzvMd1b8R0vzNSkYZj
         89bhsFLRmjCXBeGnfb0+txiyL5JPTobZE1xPE4SJnCl4HZqvVhB6UcxWPwOK7DObetSQ
         fffSbk6TjILxq9Q88zUiRn1VeY8FagM25tADUr0X8nG874svkQvTRhpsxvLxr4M5G22L
         rQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LckeMEL++L98xkE6bRHUomn8itgtRqdrAYiiSW7aPt8=;
        b=YX9gPKQxB9D00cjLgOQnB6McTa7F56Bshop0R3DomHI31IzSKkR4sZtvBPlnc+ejoV
         8n55QK95Ys2ZBrmk/Kd6xWUUTg7mj1I4g6JOuNgrngJwLj0pxqVP4yltzDzMJhFTOLIg
         dZc1E4PWaOWAoekeE4JUSYW1zUBPYiAJHH5rxl60SfSU2ufgNvo9kY9TE0yinbG6mhrJ
         ib5ZHFfzizn0Gzc1YE/PnB2j+f1pHXWlSiE0s5+B2sf3jCEhE/fRgl1GL9yWkRbEJL8p
         m5dwR0ZqB/18m+QJsivHNVEZMjcCOXqsbVriRQr4LhDWldetDc2pXdKPBgB/m3nlBC4n
         8Hzg==
X-Gm-Message-State: APjAAAVGzJwHn746mDpbNoZM3eSjjjEw6y2RKRyWmY2QqxWBnaR3Hg0z
        oDNkfAoGJWGsvoCgVQkmeZGekDjVI7PLzdhjF/cF+Q==
X-Google-Smtp-Source: APXvYqwK1EXF1OlxOI1zDtBRCI1LlnDOnp15wcax8wzG7tnNStvRwTaXt1N5txPI2Ni93wI6DJH8/9XBc1qmOdGdFeU=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr1783154lfy.141.1565858143676;
 Thu, 15 Aug 2019 01:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190815004854.19860-1-masneyb@onstation.org> <20190815004854.19860-9-masneyb@onstation.org>
In-Reply-To: <20190815004854.19860-9-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Aug 2019 10:35:31 +0200
Message-ID: <CACRpkdavMPW1gv8jGUJb-48+=9XCmT=_bsMQFEx3Tk06aQNcAA@mail.gmail.com>
Subject: Re: [PATCH 08/11] drm/msm/hdmi: silence -EPROBE_DEFER warning
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

> Silence a warning message due to an -EPROBE_DEFER error to help cleanup
> the system boot log.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
