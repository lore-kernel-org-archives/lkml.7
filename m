Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F11CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E3A214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NJJMbsFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfLKGaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 01:30:06 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38351 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfLKGaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:30:06 -0500
Received: by mail-io1-f66.google.com with SMTP id v3so4449398ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 22:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjERGv8zTPuKf+pd9e6agOntPUIPd6jhQ0FGJz7CMgw=;
        b=NJJMbsFRPqUSiXKRNyslavyTZBVvLMkMWPJR6Au7F1tE2NF+fbsDSKU2c96fuV9ygm
         M1p/3jIpo47aXw0KfkH6ByA2Vb8VGq1XRgkhSeyz4tDIG+4relXxE3I1ykCaiEKYobwC
         yuKn1VXzlzzavtyW4FH3DFJv4xAgJgdLI0Bbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjERGv8zTPuKf+pd9e6agOntPUIPd6jhQ0FGJz7CMgw=;
        b=s1vis0x2TMNYavwA/IicrmYS04036qGrnztwBke79cwUHf0fJkvPM2V2fRkGJ1j1XC
         NsNqRgucU4f2mfuap+Z3b9sCmpaohWc15wpZumqyTXGM+EQhNa469d0IzKMs8nHKPS/U
         Kl4C47pyvveAI1N1wCdUJJH5vCr/1jr6ZBUih/DMUwtMEEurgtTN/vJqSjM/vruVuXfY
         8Ah9T0HnXin8rLDs3una2/umHO6QYwe2+xA8JEZ8ingL299au64deW1FU7ir1YLDNOtd
         pQzZ/TobeRMXLtRYt0wDpllQ3kDfpMWErUQgNM7vXVANiemDRXU6CSj7dkbvYQMarvlq
         KFgA==
X-Gm-Message-State: APjAAAUlW+Tbu8auYq2iWAZTW1D9s1rf5DL5FJvuj+GIUbE8eQlmsuuF
        SwBFRLyd1ZDwRdbfIoZfMvcKFGHUPDypfqGD9bhx/g==
X-Google-Smtp-Source: APXvYqziiJrdEfCxDd7Xh67HAmqfkwdZiCfCsNrEzylOml6uSgFt7MnVlus0HfeCyNXza6xVZQgTAVqAfh3+XsQJMow=
X-Received: by 2002:a5e:c204:: with SMTP id v4mr1483055iop.106.1576045805107;
 Tue, 10 Dec 2019 22:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20191209145016.227784-1-hsinyi@chromium.org> <20191209145016.227784-2-hsinyi@chromium.org>
 <20191209145326.GC12841@pendragon.ideasonboard.com>
In-Reply-To: <20191209145326.GC12841@pendragon.ideasonboard.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 11 Dec 2019 14:29:39 +0800
Message-ID: <CAJMQK-iwSaTXSPBFbK_N_1NcD+qfJJwwzso-j44H3VjKwv9myg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/4] dt-bindings: drm/bridge: analogix-anx7688: Add
 ANX7688 transmitter binding
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Archit Taneja <architt@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 10:53 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
Hi Laurent,

> How about converting this to yaml bindings already ? It's fairly simple
> and gives you DT validation.
>
Added in https://lore.kernel.org/lkml/20191211061911.238393-1-hsinyi@chromium.org/T/#m183b3822bf60101666436b0244b27275c6765d20

Thanks
