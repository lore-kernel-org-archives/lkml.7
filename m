Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7086CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E282175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxySI2ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfDWK70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:59:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39902 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWK70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:59:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so13092530ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyg0HKgyKo4XumEcjZgMODxIIKRnavkBcxxGWvq5fdA=;
        b=JxySI2ffapiw6sTeEqlBimIoD0M/JGNUoiMyA2e03Hs1PMRejveZJbwLoWZun7K1FK
         gPnfFJOusjAT9nUe4kjgupR8k4FokiwNufbA0OItZJwZmwSvwsxrtOXJ4Zsa0OIx407T
         kVikTCBj8e2FjeHIbhutQFA0UOFamvO2E1MLhm0kRYwd7FwGFibWwlNNQFuY9JnQCVaZ
         ggIo9Z2mum0vCptoLqCtNfsVo0tvFa4os4A5eMspniPNVWC8uZlXRXb0qQcOGbtpM7+6
         Zc+2u9vjxke52USN/PuVq4N4vR9B/7f18t4LHKXKMLyOo/JM6VvM+T5kr9SBL+CQHqT7
         yaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyg0HKgyKo4XumEcjZgMODxIIKRnavkBcxxGWvq5fdA=;
        b=sMS2ruhHpemnH0kvgBYfF1UmGgOPukMJ2B0XYV4uvbiMUiGcIOKesIVtTdpzKtq5Nv
         mQI/7x18ZIMIi8Qb85UNKbKUJyH7AkoSWRwztDIv5jtwMarG9cwH4Ol2FESkT8WZqTYW
         +65sfzMuembrt9MW8MtKGJQKW293isxvJGhGp58LagWqe0sJq2hdjH+i069SzWgXkxBm
         //IGauuD9ehxedQpCWo5cGklfX0i6jzodHc9llH6DOC/MA+2iAYJXi2cN2l2HmQtEo8K
         7AtfkTffhLHfRg7thcYTMdrU6KhrMi34MsIHe8Tns0ZrlkJ/qmGFsZUSGJJm1KPfGXAp
         XdcA==
X-Gm-Message-State: APjAAAXuutRFrloi+BHfr0yLfk2utl3+ZWNiJYrFonimuEaibbXO18/C
        KGXrJJj1c88L/WO9urnpZPQnf4JMX0CJH1q9pZKVXA==
X-Google-Smtp-Source: APXvYqyZJo/SppsFelnX5ZKT7MywH6skwtsH5PA11jneQchfr87IsTUGh6sbOsB+wfzJD5O0dRAbsXvYglVnw31XiDY=
X-Received: by 2002:a2e:834d:: with SMTP id l13mr13688335ljh.97.1556017164724;
 Tue, 23 Apr 2019 03:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190325124137.6117-1-zhiyong.tao@mediatek.com>
 <20190325124137.6117-5-zhiyong.tao@mediatek.com> <206361ee-b238-4017-83fe-702ea59ae9c5@gmail.com>
In-Reply-To: <206361ee-b238-4017-83fe-702ea59ae9c5@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 12:59:13 +0200
Message-ID: <CACRpkdYV5cYUs21xCDMhMm=kUpFcOipE+3dZOEJYto2-w=8NtQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 4/4] pinctrl: add drive for I2C related pins on MT8183
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Tue, Apr 16, 2019 at 10:08 AM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
> On 25/03/2019 13:41, Zhiyong Tao wrote:
> > This patch provides the advanced drive for I2C used pins on MT8183.
> > The detail strength specification description of the I2C pin:
> > When E1=0/E0=0, the strength is 0.125mA.
> > When E1=0/E0=1, the strength is 0.25mA.
> > When E1=1/E0=0, the strength is 0.5mA.
> > When E1=1/E0=1, the strength is 1mA.
> > For I2C pins, there are existing generic driving setup and the above
> > specific driving setup. I2C pins can only support 2/4/6/8/10/12/14/16mA
> > driving adjustment in generic driving setup. But in specific driving
> > setup, they can support 0.125/0.25/0.5/1mA adjustment.
> > If we enable specific driving setup for I2C pins,
> > the existing generic driving setup will be disabled.
> > For some special features, we need the I2C pins specific driving setup.
> > The specific driving setup is controlled by E1E0EN.
> > So we need add extra vendor driving preperty instead of the generic
> > driving property. We can add "mediatek,drive-strength-adv = <XXX>;"
> > to describe the specific driving setup property.
> > "XXX" means the value of E1E0EN. So the valid arguments of
> > "mediatek,drive-strength-adv" are from 0 to 7.
> >
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> >  drivers/pinctrl/mediatek/pinctrl-mt8183.c        | 50 ++++++++++++++++++++++++
> >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 47 ++++++++++++++++++++++
> >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 11 ++++++
> >  drivers/pinctrl/mediatek/pinctrl-paris.c         | 12 ++++++
> >  4 files changed, 120 insertions(+)
> >
>
> Linus, did that fall through the cracks? Do you have any comments on this driver?

It's applied AFAICT. Maybe I forgot to push the branch, but its there.

Please confirm so I didn't miss anything!

Linus Walleij
