Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17637C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF7120854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHcm+QAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfDEDl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:41:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45737 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfDEDl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:41:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so3925804ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 20:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldE1klm6zqqzfayEf/UrhyTzJMYyXz849WpH+abA2Fw=;
        b=UHcm+QAbLQ5AD2Be4syXtCvriFkGAhh52EMQN2x0jx06usqF++nQWhIibT+bgzxRmX
         B0tRJgITR9T0NI9XOIdRCbbw9w463ovlu3qmkIMRBc2QcJqeYthBlpBhnDmJobY+hKnH
         S1KG4cSLIDvulkQsDLsp3S2fEtU2kspll7p0Qy/a3VMAj72sGMoYXIgpNn2EFgWNDRi6
         2GXjmuFnPLbaqiC8Juc/2VHic8YTct2VvIEk1jozidxNOf2EobtHKioXzXNVoYxrjxAU
         mO4LfqShl2AWfUU015ITwUIu+316TdFxaMqg0FGjifsh/3Iz+R/GIRv8dX0StIKjSMfI
         sDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldE1klm6zqqzfayEf/UrhyTzJMYyXz849WpH+abA2Fw=;
        b=KzwnD1ZeJ0AgmocTSoOf63nmCOLa5O+jQ9Bl3dacTskPQEKolYh55PzpVGHzKpJMMq
         eJAhUL+ZVuUajbRQB9CG3yEnWJJ+ba+ZrQ4B982INoXjg79aH763p/u72gDhsB5xTDa9
         CngHlJpEvgG8x5mix3a5Ia945RX6Wh1oHGXBEExf8JGjk++ZJdUwMOIg8S2REWJHLbC3
         NFinYxXCWX5JWfaxCani5vSvo6W4qLpNW+0bQ9vQ6z4O5jwihqSEF71hH6IXApTQ3LL3
         8XSg/kDnZlsDXjODJRjhtuknW+y8rocxyAQv2p/UZPqNpsmL8DC7Q1jtSSqX7YwURKh5
         YE7A==
X-Gm-Message-State: APjAAAX7xMGlTAwxGjti9r387lGM1Ex2GKCqmutTRsg756TXE6yoXdJe
        pI5UFRttoTk9rC6pMSagGXA+iAWCdHdRyHBPhIOpRg==
X-Google-Smtp-Source: APXvYqx2hDgBOtevmok4ej0eeYUn7obj3XwgFVe8FmaU18CxlvmeP0JWjWkAdDwA0jHjgkGHW3C+LGRNpLnk0e4qm3Q=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr5355977lja.49.1554435714161;
 Thu, 04 Apr 2019 20:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190401033535.16910-1-zhiyong.tao@mediatek.com> <20190401033535.16910-3-zhiyong.tao@mediatek.com>
In-Reply-To: <20190401033535.16910-3-zhiyong.tao@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Apr 2019 10:41:42 +0700
Message-ID: <CACRpkdaue63nuUwdnOiHHGO=uEmp_4aB4916EgKxsDC=kf=T-g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] arm64: dts: mt8183: add pinctrl file
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, srv_heupstream@mediatek.com,
        hui.liu@mediatek.com, huang eddie <eddie.huang@mediatek.com>,
        chuanjia.liu@mediatek.com, Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 10:35 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> This patch adds pinctrl file for mt8183.

Better commit message maybe? But no big deal.

> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please merge this through the ARM SoC tree.

Yours,
Linus Walleij
