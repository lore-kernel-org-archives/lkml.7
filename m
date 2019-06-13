Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDC6C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829D420449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CtrAEoil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbfFMQdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:33:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44393 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbfFMH4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:56:05 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so15245805iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 00:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mt9IXgQK0R3bZVbL1gX4lwhgNE2WNQzmEIjkbIH3lKE=;
        b=CtrAEoilqvh20HeyueqUwiW7Sa/FbuwD7y/aJXyR4xt9xVi1BLl8zqjbMMpgvcpfBD
         TJalZ6QEJZvTLm4nqCFht30YUEyRuM+d2nhm/jtcU7Gi+OVZTfHrUhuwe4D+d1PfnBBc
         RilEpAmd11hs5QxMrxz60PzbfFEFEoRfCQWSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mt9IXgQK0R3bZVbL1gX4lwhgNE2WNQzmEIjkbIH3lKE=;
        b=nLhcMoOSACxdteqShqNUa09T5D0+aiwgvYhzQRQbDowEC8fkkn5NnQ/FicpJKG3Slw
         hGykiZLMpMm9qFhU6LT85IY5ZVzndVhlAwFsu05Tr/acJtiErMqfMKrds8cZs0XfuOo3
         3PNP8ucj6xrt9HAEOynr3bDkFGoq0OOe5O+RJohDMS+Y1sBwHcBYJlPz2A3FdZaVasxB
         YhWvpGkQNTRydxM2B9cBPIHrOgjmeEuVUUfEC0wocqOLNWd8gpex2uw8fXYEFv7kvnNB
         9DszUmZdU4H6TQJAp+xNDfroAPUh6Sm3qyJsN9M5EYqrUfnCadZYNgOE9uywTDS9rKg9
         XBtQ==
X-Gm-Message-State: APjAAAXqqjbDzSRKLK7q5pZsdhuvJo9TfBPFFc+K7zzOV1j3h7UH9zAB
        LPLlnV7n9DJ4uOsg9G2m0zcuaKjshqj/HyhDw9Y06w==
X-Google-Smtp-Source: APXvYqwDhRfnaHJtf1PQHQ/jF+8eogSJypvcgbC/dcDrOKV/5SpBek5mjlGRiNPmxM88wklf9JqUz4ZZ47Kx3KJwqsI=
X-Received: by 2002:a6b:6b14:: with SMTP id g20mr51043170ioc.28.1560412563915;
 Thu, 13 Jun 2019 00:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
 <20190520090318.27570-10-jagan@amarulasolutions.com> <20190603134907.lh5rdpucbrzrsdps@flea>
In-Reply-To: <20190603134907.lh5rdpucbrzrsdps@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 13 Jun 2019 13:25:52 +0530
Message-ID: <CAMty3ZC5-y8RJcLjFP_G8i7=9-BuOQWdnxoo66TO4mrrOxqDLg@mail.gmail.com>
Subject: Re: [PATCH v10 09/11] drm/sun4i: sun6i_mipi_dsi: Add VCC-DSI
 regulator support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bhushan Shah <bshah@mykolab.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?B?5Z2a5a6a5YmN6KGM?= <powerpan@qq.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 7:19 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, May 20, 2019 at 02:33:16PM +0530, Jagan Teki wrote:
> > Allwinner MIPI DSI controllers are supplied with SoC
> > DSI power rails via VCC-DSI pin.
> >
> > Add support for this supply pin by adding voltage
> > regulator handling code to MIPI DSI driver.
> >
> > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> This creates a lot of warnings at boot time on my board this is
> missing vcc-dsi-supply.

Is it about regulator_put or similar, would you provide the log.
