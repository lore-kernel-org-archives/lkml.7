Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341F520811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800281;
	bh=gHVvzKCZkeskuXfhVC/qxx/Qkvv/i0B3b1XGTteDz1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZyB8F0hxoqSwz2+1bpqXbO7Uu80JGozErAVP89RIo/u7mipRBKFj9C2mlFRRQckuL
	 uCvHzRRMuh8BO/IZXReHm7hPwQ3PuZv8TB+LXjmM30I5pIgbHJrOPKGkiAYAtdjbz+
	 4xDs07CboER5LdYSMSGpnosm3TO/u72GUQ9tLgEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfC1TLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfC1TLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:11:19 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16797217F5;
        Thu, 28 Mar 2019 19:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800278;
        bh=gHVvzKCZkeskuXfhVC/qxx/Qkvv/i0B3b1XGTteDz1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1S/t8ZeqN0kRygvrDKrlmZe23Qz55XRHpicFD2vxWdS9bl/CJpiQra4anvEXO4on1
         qTrFaxsCV0HuCw+92v4irYz2n+5NHU3ODPnX9TCP5tjN9CJjzFc7XzAk8AFxK0p44T
         xseubna1z9F5x1g+RaoXvsZbey4cfx5BMIGJryBY=
Received: by mail-qt1-f169.google.com with SMTP id d13so19755970qth.5;
        Thu, 28 Mar 2019 12:11:18 -0700 (PDT)
X-Gm-Message-State: APjAAAVh+amLKq6R9Uma2ZmqAQdOpwxFfratG7rwukvKPKyil4vIM4sA
        gE2U5j2KMuYccAFd3iHE2MbE65QuRQpydAPVzw==
X-Google-Smtp-Source: APXvYqzbYaJj/Qe9/tsGy3mIhQjK8icb6R1whDDQMxnhB1IplUw+GJzmb79KwXzwDxLEFHkIrVFKaxjAoBPKfG6YdoM=
X-Received: by 2002:ac8:267c:: with SMTP id v57mr36944696qtv.76.1553800277366;
 Thu, 28 Mar 2019 12:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-14-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-14-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:11:05 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+nk4ARFSMwoktOtsGw5UEct_WW6UR2=15TEQaomGhaCA@mail.gmail.com>
Message-ID: <CAL_Jsq+nk4ARFSMwoktOtsGw5UEct_WW6UR2=15TEQaomGhaCA@mail.gmail.com>
Subject: Re: [PATCH 13/24] dt-bindings: mediatek: apmixedsys: add support for MT8516
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
> Add binding documentation of apmixedsys for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/arm/mediatek/mediatek,apmixedsys.txt      |  1 +
>  include/dt-bindings/clock/mt8516-clk.h                 | 10 ++++++++++
>  2 files changed, 11 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
