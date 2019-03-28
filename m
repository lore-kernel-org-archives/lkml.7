Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056B5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB72520811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800337;
	bh=jOTLQQ6EwdXW+PfUfDh/bZwMQK6wjAY5FhHAKfdkoOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AfgvqnNRYoKfnx73tQXVlXWN469r3GKj4Pu10ozcXTizNpqoNKlkDtzeByAjrE2IQ
	 8LMVROKqY+tBBav/joW/s67JvgqE3zxgg248A5A2xDAfkpaRmCoTLccZo1a67mgLHx
	 0u1ixAnBAb+W7UlqvmxQbgO1136/JyvqdKlSX5M4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfC1TMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbfC1TMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:12:14 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49C3217F5;
        Thu, 28 Mar 2019 19:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800333;
        bh=jOTLQQ6EwdXW+PfUfDh/bZwMQK6wjAY5FhHAKfdkoOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FtuElAkoIVF9by7VDOIvaGE0rs4gW1eJQTOGCh8rM0Sf/Wiqjx2LlzG1Do3MODJ7e
         ey6aymLN4j9F3iwS99uPpet1laCzP2tN39203/opqZN6qn5xpfcyepWY/MKJ/bFo9T
         LrnpuTTdraxWgmtdL9Jtf+C3u6NTPuGbLabwmpGE=
Received: by mail-qt1-f179.google.com with SMTP id z16so24473439qtn.4;
        Thu, 28 Mar 2019 12:12:13 -0700 (PDT)
X-Gm-Message-State: APjAAAUObxwOtt3CpoH8Usvs+nimdCAvv8m128roJgcjvHwgNLcGMx/z
        8QrLkHbKQAmNlGXnlI58jZlHVwQoAjDwTS/8Dw==
X-Google-Smtp-Source: APXvYqydYDY+QiAF73ZPDqqjubHmDJfafmWF+1pIprh6UJrQwH8gqzXarMmkoVrJPzjCTgpOPo3gbuLafF0yVaufy5Y=
X-Received: by 2002:a0c:b018:: with SMTP id k24mr37646318qvc.218.1553800333090;
 Thu, 28 Mar 2019 12:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-19-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-19-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:12:01 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Uv+dL9qX=6hBbKn7GbZaj1crvGY_uh4tppD8b5dRqcw@mail.gmail.com>
Message-ID: <CAL_Jsq+Uv+dL9qX=6hBbKn7GbZaj1crvGY_uh4tppD8b5dRqcw@mail.gmail.com>
Subject: Re: [PATCH 18/24] dt-bindings: timer: mtk-timer: add support for MT8516
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
> Add binding documentation of mtk-timer for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
