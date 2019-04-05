Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328F3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08B120854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccj5pzWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfDEDpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:45:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36074 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbfDEDpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:45:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id d18so3339981lfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 20:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUbX4djAyyi+s9bVfpiZbDANbAWTvBQOJj+v3RZuk1M=;
        b=ccj5pzWTa2V0cTRl1RwgKcAHpFEzbVMIsLOihyVlgV0tZM1Ri8TcvipRFi7SAUVlnY
         qufAOS902dhfAHPBJD3HS8ZKXfqIvwID4rOvs8x4RUb/sCQQhNtQgJ2Re9ACPTdmt/ly
         I3evO4CZAFPugsgojmIdpM/x9bfLtVIRM/v7cnzht2J0F0IQHZMlMgllZuKuyJVQ0kp6
         wEXYzMhTVxscbZkK9mp77Huz+jjQBqVXMPRcQUYGCHYu8980Ll5fVBAXg2nKCRYAFSMu
         8IMhA6PVuXOz8ypo/lcj8EZgWWoMbPVWLm5BrrnHNWXaqfsrIMvwV/9mqlc0A4yl8EUN
         f/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUbX4djAyyi+s9bVfpiZbDANbAWTvBQOJj+v3RZuk1M=;
        b=iytpEP0AJ6t6MqEJLPUO/YxKLu0T8L40xHXHEsT7WLIvSzfOO4Ns9/6VoOu3okzPuM
         kxyjwdz2cXlYPzOnTfznxAso6qqypUM8JuOXy+WIPyajZNE9p8+M739pEiVaEDHqOdnb
         arJpzT52MzEsMOIWZvi3KFVKoYPTvTcrFwQfIyh7tO7xLgGhnZbeajkeGL6533OZ8/Dy
         zNK6lwrlKyFB6S7vY7qnGJbM/XLPzFH1uPx6Uc7+HmN65yzf7I1bZh5SF2Ag3PuTIRu+
         exK78Z2f4QvbcdOfw8Ioe1ZbMs3BAYNloxMJNujU9mPLiPzqA10do0GmNK9NZtVfMuja
         po4w==
X-Gm-Message-State: APjAAAX0mc405K6tkfVX/z7jCoQNLDTijEJgqlp+RxRm+h94CKA4P+T6
        A/0ncxodLrB6Lb0s2p5TR2nnSAAGazNkwbTxggNpmw==
X-Google-Smtp-Source: APXvYqyJ7Gkdqw2xrxBa9vz+O18I6zhy9aUXGVCgnRDw/2SOVaeI8Hj+0uxQXf2NzvVo7ZqfjmmLmFZ3NoM3t+5OJxM=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr5164199lfh.103.1554435936349;
 Thu, 04 Apr 2019 20:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190401033535.16910-1-zhiyong.tao@mediatek.com> <20190401033535.16910-5-zhiyong.tao@mediatek.com>
In-Reply-To: <20190401033535.16910-5-zhiyong.tao@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Apr 2019 10:45:24 +0700
Message-ID: <CACRpkdb8T71y9TZFXhefArKhbtPPe2b4syGWx6LwFaFkANEk4g@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] pinctrl: add drive for I2C related pins on MT8183
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

> This patch provides the advanced drive for I2C used pins on MT8183.
> The detail strength specification description of the I2C pin:
> When E1=0/E0=0, the strength is 0.125mA.
> When E1=0/E0=1, the strength is 0.25mA.
> When E1=1/E0=0, the strength is 0.5mA.
> When E1=1/E0=1, the strength is 1mA.
> For I2C pins, there are existing generic driving setup and the above
> specific driving setup. I2C pins can only support 2/4/6/8/10/12/14/16mA
> driving adjustment in generic driving setup. But in specific driving
> setup, they can support 0.125/0.25/0.5/1mA adjustment.
> If we enable specific driving setup for I2C pins,
> the existing generic driving setup will be disabled.
> For some special features, we need the I2C pins specific driving setup.
> The specific driving setup is controlled by E1E0EN.
> So we need add extra vendor driving preperty instead of the generic
> driving property. We can add "mediatek,drive-strength-adv = <XXX>;"
> to describe the specific driving setup property.
> "XXX" means the value of E1E0EN. So the valid arguments of
> "mediatek,drive-strength-adv" are from 0 to 7.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

Patch applied tentatively to the pin control tree.

If other MTK maintainers have opinions we might need to patch on
top or revert it, but it looks OK to me so I put it in.

Yours,
Linus Walleij
