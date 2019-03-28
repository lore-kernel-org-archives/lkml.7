Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FB3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC38E217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800406;
	bh=wFaDwmBv6jmWy+vqRYQXtUepNQD/BQsMcXesl1mfmY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=foKTirNp5GlmfCC8JbxhmbJJ9jN5RtyMY0TScMehZDC+q0cgW59OGwvwADB3RRC4L
	 YFX0arSpet28tKGkkS6/HFab5pEKTtWcGL7i9Jl7/BJXegiRiK0FnGPvhiKFa/WDqc
	 6XhEvB1AQF7tkaoFcHz21df2uARuG6pHpW3havxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfC1TNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfC1TNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:13:24 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5FA32184E;
        Thu, 28 Mar 2019 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800403;
        bh=wFaDwmBv6jmWy+vqRYQXtUepNQD/BQsMcXesl1mfmY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B+v2pdb4bsrbTSmkRrI5MwI8Hq50TtAtyS5hMhXRSiFbQofBnwFn6LKJuLsqJ6WJV
         m7x5f3BkLOeevYri4b/7MegkjcT1Yl0mMOFQCB4RsD7hzKWEVgCLIsS7v81h0EWbah
         N/1nETF9dZMY5L/ixmjC8lV7zIO8iU4NglEjwaWQ=
Received: by mail-qt1-f176.google.com with SMTP id z17so24413788qts.13;
        Thu, 28 Mar 2019 12:13:23 -0700 (PDT)
X-Gm-Message-State: APjAAAU2eibKTl8I0mTKYF5NqKymVyO9H5YNj5+FD0Xm2qSSuOIhW73A
        WNzUd8ln+C3Bzz7OOZS7DbTX54DTGsVmUdwuqw==
X-Google-Smtp-Source: APXvYqxZUuTEinKqI6WYezygREEiOELOF+PDRk4PAC1s07fzo7f5dg2gw1zxtMn4VkuBO+ukON5qx/P44sIjL1H7tjM=
X-Received: by 2002:ac8:267c:: with SMTP id v57mr36954786qtv.76.1553800403021;
 Thu, 28 Mar 2019 12:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-22-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-22-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:13:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJzhhTPpyzQKMMuVu7JfP3tnr81xRa23Fk5_22+B1meZw@mail.gmail.com>
Message-ID: <CAL_JsqJzhhTPpyzQKMMuVu7JfP3tnr81xRa23Fk5_22+B1meZw@mail.gmail.com>
Subject: Re: [PATCH 21/24] dt-bindings: irq: mtk,sysirq: add support for MT8516
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
> Add binding documentation of mediatek,sysirq for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/interrupt-controller/mediatek,sysirq.txt          | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
