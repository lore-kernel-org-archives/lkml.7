Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D880C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87D12084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVUoUOIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfHOIeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:34:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36089 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730744AbfHOIea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:34:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so1159936lfp.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7i16DpGe/WrEnWRFWrw6WDyR2YmJ49EsxY0UWyxcbfk=;
        b=TVUoUOIaS51Agv5l0PMa3o6r7lDWfkGGfAKJhDlNLIl7488xPFjP4Zc62E1GcUW1VV
         o0tMKL+wXnt1XdSF1KbK0Lt2NPVz37E6SBBibznbqskqTNxpsTEGO/IN8IWSuP8NEn+L
         YweJ7nuU+lmreFBFY/Jygo7zNIKriXEtK9XOLtxp1wnYaEzcfK6K91ZsV5tKqCLz0pji
         +j+VLUGXtDrQ6JvziL1YCvfd7+ThtaWoW8fly7i71IZV69lt92FEoue8vUkPf1PR+fIT
         BuuAkU61fn6Twlw0EMMwqgfTgHrOwgjtkdqRSq+SUTWsfkxUHCcsuL1aUGE1euu6qHxW
         QxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7i16DpGe/WrEnWRFWrw6WDyR2YmJ49EsxY0UWyxcbfk=;
        b=m9ERSp3zy6fxvLTOfPXms9jUfy+Mc+L2jzAswrWDNrxjSuTEHCe8MaJRg3AB77ehF6
         pYSEZLMJKoiifIW+G9p/lcpuyZ6g7GaBVuUZkCXRM+8Dcu5ZeyjNbYCbFiEUKjOz7Gas
         f+SrEDjlUZ+YhTuyX/9bhq+0oYuHifqKYwaVKVKU8CQ1rBPoI8qIKSmCGimkulS7VYXt
         8WH5TcRdSRoVOCqbInFSJJF3EIVcwkCsy6cIwn7tHB4m2BTbVgKbAn3WG3uZwGxpztGV
         WuJ+o2URL149p9oELA8Bkhrb1UZgosqFSOj5bx52FZPBUMlYsyl/EK7gRIuZa5mMwuUF
         hZSw==
X-Gm-Message-State: APjAAAU8LNh8dCrfrAhJVK+hkNNXikJTaKGX4FYZdMJz25O0FtP4MGKI
        TAD15VgHm12OQWtvcixl6PIAEh4p95+nXobG3eF/Wg==
X-Google-Smtp-Source: APXvYqxb0UB6/giI18HHjmcKPLqMYP0VUKp7BEJ9Az/O76XbGpUEV3T+utaGsTe3hzjxU1rcsCu+m7ocZF57FmoUKmk=
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr1629302lfq.152.1565858068523;
 Thu, 15 Aug 2019 01:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190815004854.19860-1-masneyb@onstation.org> <20190815004854.19860-10-masneyb@onstation.org>
In-Reply-To: <20190815004854.19860-10-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Aug 2019 10:34:17 +0200
Message-ID: <CACRpkdYU-6LvFKRkj0yMMCmAnX0XtGe7rMwbXbhf2GCp77Ciyw@mail.gmail.com>
Subject: Re: [PATCH 09/11] ARM: dts: qcom: pm8941: add 5vs2 regulator node
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

> pm8941 is missing the 5vs2 regulator node so let's add it since its
> needed to get the external display working. This regulator was already
> configured in the interrupts property on the parent node.
>
> Note that this regulator is referred to as mvs2 in the downstream MSM
> kernel sources.

When I looked at it it seemed like this convention is used for power
supplies that appear on both the main PMIC and the "extra (boot? basic?
low power?) PMIC that the main 80xx PMIC has mvs1 and the
other 89xx PMIC has mvs2.

I suppose it is named "mvs" on both PMICs and this is just a rail
name so as not to confuse the schematic?

> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
