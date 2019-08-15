Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359C4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0966D208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwGU6RQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfHOIZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:25:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36537 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbfHOIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:25:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id j17so1145579lfp.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P02BSDCRijPbd9yK/6Voa9R/D56p990RHfEVvViY/Bo=;
        b=VwGU6RQs7iolsd3xhQ/RkLbxvAo8VLkErvnXtuEhQmdWmK+++AzDqwQcuwgE0X927k
         Xk1vn5vYXh3iYZc1Ah5SkL8Dn0uUnfO+jYr1jwuAmBphIqlCxmDSCATpGnl27Ai5CXWm
         YD4wkOLZrBYoyhR4aN8RpI18MKGPkk/YYbjfPEW9G4/iO/Kbz/73F0C5g9LIiZM+7NW+
         SWMSaC74D0zgMt6U1z7UYiWvzxRj+tYEBacypVR9VrNjLFL2Uy/AVDacXEKsfVm9BBZ7
         DjX2KwkQOk7M498JD3EVo4RSmkCSboE7ziaIIdobStjnVp99VmOZudUnn/aaxrywezgs
         OKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P02BSDCRijPbd9yK/6Voa9R/D56p990RHfEVvViY/Bo=;
        b=UuBEIKTP1iPN4slYitRXtyuk9qBN5PAZ8cHtzBr9zHDIBzjIalIFrLJxvzZ+DxZJJf
         AKj09m6/Yyz/hNQFFAFNk3k0oQabSLsGHV6vfsvE3YySdqolzjqVdpB3Sx6DpES3RcOo
         WEgG5xt1IbtwLu9o+Bq3MIf0TFTDJLq2qwZnCTDl8e1BeLNjTk+f14ni3u2KmZuDgTv/
         Z1IRmVhyBcQd0cG6aBfsRbzCkUj7p6RJ2FgIhW+Zb7A9NZEn7scJozb+4/EV/6d02j0O
         6y1Jw4/5vEUCVmOUchdoJQEnyIoGAm62oj9ZRrx5aoW0zc1AKx3ae2a9/yLSb+9YGnhu
         OV5Q==
X-Gm-Message-State: APjAAAVR0wQ+FIJBqZ4Dr0yz/+Lzk5KKBG/IhTgKp7wMf/YmVZeFpArM
        Xxf4lGbYkSQZZkWZ39d6rc1bR8uQvsxgSGEnn49JfQ==
X-Google-Smtp-Source: APXvYqwuz6gUlIPqwTv4NphE9CuB8QLz9uvS26JNUXQ4p8UjA/NuXYuyNh1rl3LRryriamcIaIyf7prYAZZock0AxlY=
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr1613650lfq.152.1565857518224;
 Thu, 15 Aug 2019 01:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190815004854.19860-1-masneyb@onstation.org> <20190815004854.19860-11-masneyb@onstation.org>
In-Reply-To: <20190815004854.19860-11-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Aug 2019 10:25:06 +0200
Message-ID: <CACRpkdYkmLXOJHGy5S55r60zZVY9dg5m9j87S3wx=banFxx6aQ@mail.gmail.com>
Subject: Re: [PATCH RFC 10/11] ARM: dts: qcom: msm8974: add HDMI nodes
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

> Add HDMI tx and phy nodes to support an external display that can be
> connected over the SlimPort. This is based on work from Jonathan Marek.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
