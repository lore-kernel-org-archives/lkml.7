Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49D4C2D0CD
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22EF22527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfLMIId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44174 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfLMII3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:29 -0500
Received: by mail-ed1-f65.google.com with SMTP id cm12so1300785edb.11;
        Fri, 13 Dec 2019 00:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Sb7h+Syw20vysdh92QJjNk/PaKzOiYC6n/84DQf0IY=;
        b=XH2rMC6I3glDs3DANyDOLWnr2N5KJzJxOOfEqZYko6x12F/NA5ppoahwQ2BOcVpebH
         lu5hPofdoRszEUF1Puzi3Bjnmbr62wTKDohiqXkhw9jxVQl8jbptVYQtCPQExwB9vDrG
         XZNuTUI9bMUfKp4xkfGXSf7Ms1nHkL0rMILxSqVXYymif8KDOMb0WmPQ1Nx9MsVAUDGa
         H0ZKSAxZBnjC3WQGLHdTAdqun3CwwQHC0ZH8uyVoIyoHj/dX17YfixFHcTiCfPDDa3nf
         fGq2nmKh/954zM6yFCOnVSssqHAzgkgq98MkQMLe3T8y5VUAAM0hCOEzk9vwH7Kq9Pf9
         s5Vw==
X-Gm-Message-State: APjAAAU+zScqw12VuBxj8zu5tX5EkGPz5jDd7itREbOb5q2LHdwRHlOb
        PKLImvJG+/EiVhMEaTQ+8czVlhU+Fgdl+w==
X-Google-Smtp-Source: APXvYqxL77iUE0AzqbWyWlWllh0lDx8cvi1X6clZbtoF61J/Gh651ONiLGvGa7nICW0nrVOBQqVDqA==
X-Received: by 2002:a17:906:5808:: with SMTP id m8mr7073600ejq.1.1576224506235;
        Fri, 13 Dec 2019 00:08:26 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id l9sm353417ejr.45.2019.12.13.00.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:25 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id w8so2041719wmd.3;
        Fri, 13 Dec 2019 00:08:25 -0800 (PST)
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr11357678wmc.2.1576224505305;
 Fri, 13 Dec 2019 00:08:25 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191211145222eucas1p1d761af59e04017ddadbdbd1cceb59b1f@eucas1p1.samsung.com>
 <20191211145054.24835-1-m.szyprowski@samsung.com> <20191211145217.25025-1-m.szyprowski@samsung.com>
In-Reply-To: <20191211145217.25025-1-m.szyprowski@samsung.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 13 Dec 2019 16:08:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v65EBb-qvb6XVzvZgqKUbzJJgkXgB5y2uA8Aa1__n9v+qw@mail.gmail.com>
Message-ID: <CAGb2v65EBb-qvb6XVzvZgqKUbzJJgkXgB5y2uA8Aa1__n9v+qw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: sun8i: a83t: Correct USB3503 GPIOs polarity
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG EXYNO..." 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:52 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Current USB3503 driver ignores GPIO polarity and always operates as if the
> GPIO lines were flagged as ACTIVE_HIGH. Fix the polarity for the existing
> USB3503 chip applications to match the chip specification and common
> convention for naming the pins. The only pin, which has to be ACTIVE_LOW
> is the reset pin. The remaining are ACTIVE_HIGH. This change allows later
> to fix the USB3503 driver to properly use generic GPIO bindings and read
> polarity from DT.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

I assume the dts patch has to go in before or at the same time as the driver
patch?
