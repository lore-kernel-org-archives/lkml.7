Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B452FC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83766206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dojB2cit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLTN2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 08:28:06 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:32949 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfLTN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 08:28:06 -0500
Received: by mail-io1-f67.google.com with SMTP id z8so9391390ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qro46RnVnbo2QgGtaf7fEzgqPFK2obp1dRKTpO96WCA=;
        b=dojB2citQDZZpDMYks9ZYnVZdw2jCW6bHd5wO8pPxVBgCrAJfNz7W4YS6MKfH8BsKD
         uFToiAW0Ul47Ri8E58KWo5s4bEHrJ5Nnv32l9d5hFMnE3Nt+uFQozfZJtzdikGVPRE6B
         fjmDRKq7hYTRQarkFqhgRgaZfIGpPno7iXiXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qro46RnVnbo2QgGtaf7fEzgqPFK2obp1dRKTpO96WCA=;
        b=LN5VnVYTxKmi6IEX2nCZCux+yByrXNcCLTgqEXouljcoXrjEhn2ZrTN+ydtrVouSVY
         M8U9Mq/kBP99SoCuXwnsTgJNAlj8r0LW0IevKnnF9xANvl3iLx1klI0wmlHHB36F07Ab
         Gz/QCeunlx9i7uv97uG52Rl3EUmDbh5lq2XCkJIHFFptuZ3o5Tz8rN4lbX4+sWM39wqS
         Nrotn7xAeWGtUmP5rzcUQtsbE5a/ZEyMWCwZOkEqmOgPd9p+7MA0Kfsq+UzJctva3M0c
         3i4oaJaqWFXHPm0lrGW78ti5QvtqZRfHJwdxktsqp3vaChiSi4IZIQ2a+MI9nYEZUUaw
         UU6A==
X-Gm-Message-State: APjAAAUwZWGz5dB3fyYXe/778IoJn4oXz72s/orEirHM4qvAwNXgzM1h
        HJgXuxuWj4uA/Z+ZbCwUaEv4tB401fM0o/25ZtTT+g==
X-Google-Smtp-Source: APXvYqx1z00p6iauoc4NZtcOA9AhAGNGQumLKZgKWsoylxv2/qOGV3v00MP2K8c3STB2yn62imhJmHfZ0XJiN+viMWY=
X-Received: by 2002:a5d:9c10:: with SMTP id 16mr9571305ioe.150.1576848485210;
 Fri, 20 Dec 2019 05:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20191210050526.4437-1-bibby.hsieh@mediatek.com> <20191210050526.4437-7-bibby.hsieh@mediatek.com>
In-Reply-To: <20191210050526.4437-7-bibby.hsieh@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 20 Dec 2019 21:27:39 +0800
Message-ID: <CAJMQK-jdMwoC54XpWj-XYW_yZkM=TcGcJpy94DTdYBN2t1wqmw@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] drm/mediatek: support CMDQ interface in ddp component
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 5:05 AM Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:

>
> +void mtk_ddp_write(struct cmdq_pkt *cmdq_pkt, unsigned int value,
> +                  struct mtk_ddp_comp *comp, unsigned int offset)
> +{
> +#if IS_ENABLED(CONFIG_MTK_CMDQ)
Should we use #ifdef like in v4? https://patchwork.kernel.org/patch/11274439/

We got warnings while compiling kernels if CONFIG_MTK_CMDQ is not set,
since cmdq_pkt_write() would still be compiled.
Similar in other #if IS_ENABLED(CONFIG_MTK_CMDQ) (also in 7/7
https://patchwork.kernel.org/patch/11281349/)


> +       if (cmdq_pkt)
> +               cmdq_pkt_write(cmdq_pkt, comp->subsys,
> +                              comp->regs_pa + offset, value);
> +       else
> +#endif
> +               writel(value, comp->regs + offset);
> +}
> +
