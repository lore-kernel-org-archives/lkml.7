Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1895B20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800454;
	bh=bjNwfR8WY0IAgNs4qa0y0TXQ42wza3A9BKEJPlb4dtw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N7mk10XcY8xCm4MEbk7ovrLT59MTTHToMgK1qii7PnVOI3+CzCC2Wl6+AvUcZO0s2
	 g2LmhiPet/fzhzEGAdT9SqYQH5XtsOCrKx/tO1x6Co99GC1n3rwAGmnGh8BChY68la
	 g3J30eDr5OuSfOzUTGrgIA9Nuz48dU07Kt5JsmYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfC1TON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfC1TOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:14:11 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E04E2183F;
        Thu, 28 Mar 2019 19:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800450;
        bh=bjNwfR8WY0IAgNs4qa0y0TXQ42wza3A9BKEJPlb4dtw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=andzIJNo95q57Eza2uFopImiwXv6PTFOSaj5ricQBZLGevQT9BDg2/fgL8WqSBtSz
         Co41oekNWp6hkSkY/vddk27qKTxGV1cPsw3Y+CqTUon7N8dBtbPk/fEidPiK8gfF57
         TNYkvT9Yh1j92oPQGRSERjXSyopks3+QMMVPE5P0=
Received: by mail-qt1-f178.google.com with SMTP id w30so24451075qta.8;
        Thu, 28 Mar 2019 12:14:10 -0700 (PDT)
X-Gm-Message-State: APjAAAXQRmP+xi3iJol9nXbCYDFgtc6NIgOUO1szRosHWUuPOM7HkIEO
        stO2JJJ0gtVJbwU9CLvqY5rEPuxVih7KG0yD7A==
X-Google-Smtp-Source: APXvYqwfj3l7016/qusP575eFQc3Y+2xkWWmkl1SaRT+g+AEK3o1JtBX/5m+AhBeqNRJ8lyymlWWW5XomAxKuBppmMo=
X-Received: by 2002:ac8:30bc:: with SMTP id v57mr37188397qta.26.1553800449749;
 Thu, 28 Mar 2019 12:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-18-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-18-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:13:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJMbZ+WBJYPpzdfgsq0vioPZZs+C4rMSYigEY6UCdNW9Q@mail.gmail.com>
Message-ID: <CAL_JsqJMbZ+WBJYPpzdfgsq0vioPZZs+C4rMSYigEY6UCdNW9Q@mail.gmail.com>
Subject: Re: [PATCH 17/24] dt-bindings: wdog: mtk-wdt: add support for MT851
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Wenzhen Yu <wenzhen.yu@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>, jjian.zhou@mediatek.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        stephane.leprovost@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 4:17 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add binding documentation of mtk-wdt for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
