Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CE1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6546120659
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/8ghr+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfGaOnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:43:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39621 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfGaOnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:43:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id v85so47601447lfa.6;
        Wed, 31 Jul 2019 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KPXFjjONkZjk+QhsiqsCSSD7dqbWf2ywnlPRvZ8gixI=;
        b=l/8ghr+t920KkX4P/sZvL73iKiZu4M4l+Y51L8wmWkr0PAY9KZcE75OFeo5KKVLGhM
         cZZXhyHqJLXznkgDawUG3lP+GVGxN0mBQDaVA8CLv08Dw6Rgc6b2ReIjA6Pbep6ycNYX
         AU0XwyiKfKWjZuIbNoc+e/KquQMk/19e0u7IRn6o6qUZCJxCBWT9k+bMHfCZBm5OLbEt
         uDqJG907R4mC5ky5U1wP66iRG5FhMz0mkw0jHJ2XeXu1a8ftkwqcTM2iXEPkAFv+N1Wl
         HMmnHQQkDOkGlp0w3u0SIS9u7QIRP3Ac35Ii32NeGDU8boPn0ufVDVbH9I9KWvH7YziD
         HH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KPXFjjONkZjk+QhsiqsCSSD7dqbWf2ywnlPRvZ8gixI=;
        b=oBFMP5MEVwbykk1rKb3bk7kATW+YdpC9I4dL2noiwuwQZAH/HxfOkQNMMkhPhl8IiB
         KRZM7mCRBeG5QQYwlqPok4qvQSerLaDfu5P/aWDplo4+TaEVHYsklUdklA5vQfoFrQTp
         xMIAKAFEYNsK1b7QDuDEHXD/5stT+3TuGvVUgNfeKMX7lyk8WElOQFDOwUFiR6BVWPS6
         MxYdfFruVxSDHmUVvW4trVBRRxXkXaPUx+nLfbDzZaoLFPIroT4HkIgBDJGv5LmN3cBX
         FPV/Tyo1YBQGEGOeb16UviC6keDgXnPEkySzfy9XO6lA3J2IbLChbu+I+9Z2A1tLN2bw
         rhjQ==
X-Gm-Message-State: APjAAAW+FIPtaj1mMAzEERQzInlqf3f2b/KoNeDoJyk81wryEhaanSnS
        82cLCAhZ0x4fVQLtVIB50guNVM74BjLvPF7H9+U=
X-Google-Smtp-Source: APXvYqygpHQFKPnj6BO1hqHn6Ij7xVfMs5QdPNXO/94e/Hw1RB9FX/CJz9+niC5JDPx4i0aT0dMN3KSX76AWC9rswW8=
X-Received: by 2002:a19:cbd3:: with SMTP id b202mr59221363lfg.185.1564584221471;
 Wed, 31 Jul 2019 07:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563983037.git.agx@sigxcpu.org> <3158f4f8c97c21f98c394e5631d74bc60d796522.1563983037.git.agx@sigxcpu.org>
 <CAOMZO5BRbV_1du1b9eJqcBvvXSE2Mon3yxSPJxPpZgBqYNjBSg@mail.gmail.com> <20190731143532.GA1935@bogon.m.sigxcpu.org>
In-Reply-To: <20190731143532.GA1935@bogon.m.sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 31 Jul 2019 11:43:47 -0300
Message-ID: <CAOMZO5Djoi7EuXapkg+dQ6HR2oZZHrw+vnjc837Gxee-Nh00Hw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/bridge: Add NWL MIPI DSI host controller support
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Wed, Jul 31, 2019 at 11:35 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote=
:

> The idea is to have
>
>     "%sabling platform clocks", enable ? "en" : "dis");
>
> depending whether clocks are enabled/disabled.

Yes, I understood the idea, but this would print:

ensabling or dissabling :-)

> > Same here. Please return 'int' instead.
>
> This is from drm_bridge_funcs so the prototype is fixed. I'm not sure
> how what's the best way to bubble up fatal errors through the drm layer?

Ok, so let's not change this one.

> I went for DRM_DEV_ERROR() since that what i used in the rest of the
> driver and these ones were omission. Hope that's o.k.

No strong preferences here. I just think dev_err() easier to type and short=
er.

Thanks for this work!
