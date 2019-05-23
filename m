Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128EEC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00E62075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfEWHkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:40:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38090 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfEWHkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:40:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id w11so7841298edl.5;
        Thu, 23 May 2019 00:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcZNWFhbFfJQ2YJR3RMy8RLxv+am/SNxNspWdV0HcRU=;
        b=WJgOnXWV6JxEmkuW571Jm37iXdg2fMseX9Gb360qIjIELLTpfWU4RgeBnnQUOkFQ0N
         +3604ODdXPNm7x/UfWXN6sv0EiNFm8VJXhj76/BhFIKLpBNZki+as3XYYjNuEuX6k+o4
         44Qx1u3eugQZBwK/TMsUbtyEiVC8kQ6qwl7Nmngtt2bcDqNyOlIrOY5TyZDzyF/QzFtf
         S4dwondUSOxLXJtdpSJp0ev3ztO2bvBfsioS8ygpeiB/Ij9OCCx++gtKeFw32nknTrJH
         GY5z85g/alWZxT9gUjq/RPE0xcFltSGFiWmoE8grC8C1YaIbwR7x/vGSV4IJSc/2JKrv
         JfvA==
X-Gm-Message-State: APjAAAWifBWpgwuoaNhvaYvkrp9sBfPa9Y4ZXZBnrQNWtvPNQRMb+yvt
        LoksjBjgdmv4FwQgPnQBnGfZSBC0J6M=
X-Google-Smtp-Source: APXvYqyNo1obK6qBe/RD1c8dTSTX7tKWXxb1kI8uBmOZLIQwkqMT20s7l5OyiPDPCsKXCZ137nJpmw==
X-Received: by 2002:a17:906:d513:: with SMTP id ge19mr31631084ejb.222.1558597240431;
        Thu, 23 May 2019 00:40:40 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id x40sm7662198edx.52.2019.05.23.00.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 00:40:39 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id e15so5060828wrs.4;
        Thu, 23 May 2019 00:40:39 -0700 (PDT)
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr1789132wrn.201.1558597238896;
 Thu, 23 May 2019 00:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190523065013.2719D68B05@newverein.lst.de> <20190523065352.8FD7668B05@newverein.lst.de>
In-Reply-To: <20190523065352.8FD7668B05@newverein.lst.de>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 23 May 2019 15:40:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v66+1+goJfnY7nWTGN2fupqMUm5o+gkPdUW6nxcwQEDwog@mail.gmail.com>
Message-ID: <CAGb2v66+1+goJfnY7nWTGN2fupqMUm5o+gkPdUW6nxcwQEDwog@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/bridge: extract some Analogix I2C DP common code
To:     Torsten Duwe <duwe@lst.de>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 2:54 PM Torsten Duwe <duwe@lst.de> wrote:
>
> From: Icenowy Zheng <icenowy@aosc.io>
>
> Some code can be shared within different DP bridges by Analogix.
>
> Extract them to a new module.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>  drivers/gpu/drm/bridge/analogix/Kconfig            |   4 +
>  drivers/gpu/drm/bridge/analogix/Makefile           |   2 +
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 146 +-----------------
>  .../gpu/drm/bridge/analogix/analogix-i2c-dptx.c    | 169 +++++++++++++++++++++
>  .../gpu/drm/bridge/analogix/analogix-i2c-dptx.h    |   2 +
>  5 files changed, 178 insertions(+), 145 deletions(-)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
>

...

>  static int anx78xx_set_hpd(struct anx78xx *anx78xx)
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
> new file mode 100644
> index 000000000000..9cb30962032e
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(c) 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * Based on analogix-anx78xx.c, which is:
> + *   Copyright(c) 2016, Analogix Semiconductor. All rights reserved.

If this was simple code movement, then the original copyright still applies.
A different copyright notice should not be used. I suppose the same applies
to the module author.

ChenYu
