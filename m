Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C68CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AC820811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800383;
	bh=ZsyTIwDmmkU56C70I+JSuBV6hSuLo0CDvV4gZSJ64N4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nEH8bXJP926LIyjntBw2dIre5MDkctiGEL6hrM+m2iYy0tOUn64COcBM85gU6D/Av
	 QSigz2b32X0zsvv64ehGHtnjUsby51NmgeFslcO5EUVh4kBp/2rmwZCQiu5UN/5zfR
	 HSJoQqmQhd9aZMT/VO78IQdEV8mg3Q/WCHlw66RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfC1TNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfC1TNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:13:01 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE77021850;
        Thu, 28 Mar 2019 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800380;
        bh=ZsyTIwDmmkU56C70I+JSuBV6hSuLo0CDvV4gZSJ64N4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0Vi4EOkdFAv5UOnXRlbMox/iTXDY1douj0o83TmvHstKV8VUJ8cxxjH9WEJ1dI7Tr
         D9auKPftz7tXPp24P332svvqxnuBd8/0He16PJ8vrNmUHhctBuRRBDICSdwl7r9iza
         FpeKWELre+ZJ541EyHQxt4DpM3Bbf9lFL6WM9pOU=
Received: by mail-qk1-f179.google.com with SMTP id c1so12875222qkk.4;
        Thu, 28 Mar 2019 12:12:59 -0700 (PDT)
X-Gm-Message-State: APjAAAUT6Pg27VgcmJYdxcc/pCTLxiJlaVUcl1CGXKRqvR6M4Unl+DRz
        cgkwavwOpggA93Gu5lnkLmiM3D5D/9pchfUi2A==
X-Google-Smtp-Source: APXvYqzDqWMwX5s0olF02ppKk3lkfl24iBLYWAV6FRadX59FRbJECULtLGV8+EDHPkbwfvdvCoCK0fx4y2whhbHf4ns=
X-Received: by 2002:a37:4a12:: with SMTP id x18mr34378657qka.184.1553800379192;
 Thu, 28 Mar 2019 12:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-21-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-21-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:12:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL2KoSRsXssMamDp3H-u5c4NTdrEesScxPtjgZbAfH-Lw@mail.gmail.com>
Message-ID: <CAL_JsqL2KoSRsXssMamDp3H-u5c4NTdrEesScxPtjgZbAfH-Lw@mail.gmail.com>
Subject: Re: [PATCH 20/24] dt-bindings: serial: mtk-uart: add support for MT8516
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
> Add binding documentation of mtk-uart for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
