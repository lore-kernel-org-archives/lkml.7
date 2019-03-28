Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157B9217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800432;
	bh=S0xqiGopewc41zOGwtFXADfl3x4rKg+SVzdXw2QLN4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ElLHtq5kdCsLfQZBt7dHKJgZdGSB+C3fWM2Wb9EzxM042vyqS7rgNlPezgOSoh7VB
	 z2z5mBygwD5hRUXqKFyq+QYMj4PAOYXufw/MtZ/5uFY1aiZj7fLPB9P+YoMNV+e8+q
	 9tt1K+htKqpS4vmZU37xutWexuiN409gXKuBM28Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfC1TNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfC1TNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:13:50 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F03BB20811;
        Thu, 28 Mar 2019 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800429;
        bh=S0xqiGopewc41zOGwtFXADfl3x4rKg+SVzdXw2QLN4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ouGhTfmkqOh1Sqj9SzZ5sbanW2KgU/3l1eFDXkNTUY6xeukLmarQsgvWH5GtuViq8
         okMTdg9oXV+WrERxeZOyC6NWVMFPy9mHxYy9fp2KdrrXwu6lZdK8eGtKfMOLpP/KaG
         WykBe27HC277mArQXCsf4bIjWirtX2wiAPvUxBb4=
Received: by mail-qt1-f174.google.com with SMTP id d13so19765914qth.5;
        Thu, 28 Mar 2019 12:13:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWfkE0+ObS3PsI3Xd70FWeT6RUPuu0mji+LpRaZlOZNKbwUE1LI
        5VIFtrcujZVWW+wiKWxpOfPuAvgBxaeX38vOcQ==
X-Google-Smtp-Source: APXvYqyqMfDr2h7irGSA5ranGZ+H3Z/m8kHd6laXKoslFeWyTp52BebRzntK3v4BqaSVmSZ3ZDLkKShXE9dO4/QrgTc=
X-Received: by 2002:a0c:c11c:: with SMTP id f28mr35558863qvh.106.1553800428277;
 Thu, 28 Mar 2019 12:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-23-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-23-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:13:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKHgPmNtgObc4y98ZNDac937KwwKhXbs+ebH1khswMyCg@mail.gmail.com>
Message-ID: <CAL_JsqKHgPmNtgObc4y98ZNDac937KwwKhXbs+ebH1khswMyCg@mail.gmail.com>
Subject: Re: [PATCH 22/24] dt-bindings: i2c: i2c-mtk: add support for MT8516
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
> Add binding documentation of i2c-mtk for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
