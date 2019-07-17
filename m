Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91272C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6430C21849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjxMWmXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfGQUTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:19:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42609 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGQUTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:19:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so11184723wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTmO6laa8AMlEy3FVJ9aY/qrcEHg2mrLH4K7ieCaV2g=;
        b=XjxMWmXICKBvNudqL+OqoYbuuGqPjYFZTGiZiCahDP2nMQG9wXTlspMk7AfaYjOQfK
         kLHfU29/nmqs7tZkWlAe3S8ivfMV4X3Ow9DVpdY34C3s40AxxzR47YxTVRWcnhtB7kHH
         SU7/V/6rVMby7JnW7sm0bD6nfUyXXwdGtrA380+qzDIFggxDhBwMwNdbYEDrF+OOnPlJ
         H4usVBXvkovuZ9gsV710V9UQjhxA/6iGmu50dMZ70PqeotLIb4NyY6HTLJ1Ft8b/hgD5
         LJFmN64p5qTPR0EPiMoXBr2CM2mU9pk29n1xi7yglhAdJje+782QPwFgEk6RxQy0CK7n
         /G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTmO6laa8AMlEy3FVJ9aY/qrcEHg2mrLH4K7ieCaV2g=;
        b=kODcfaQgOO9WizZO4d/RSmLPJBMljat3aSk2Q7UWg7PxXHarDQwlQRDh4ZMLtW1167
         1GJwg21yhrUPo4dcLVBz+sp+AQp31alPKPoJ+YQpkm7lH4eeAePwtKidodWb08kEltXA
         KhaNd7nSpmrWy/kE/6wm8g15rWDNj98DxGiIEq8hTcs/bZGE2NYRb4dWA+V5HtBP1X+x
         NRWROUfklYiQdNZbN0aL6hYSETByphlxbCyGjNNgM/Ws7i8AG0W7Xicnox+iBTFLXgb4
         XT+sKdOWnIhGEmF4HXGImlcaDV3W6AlzEQodEJGM/gVdwIXAd/RL36lsFWBMtKQXGHhI
         /teA==
X-Gm-Message-State: APjAAAUas2DOy9Nvo8/vIzrXbpdf5NkdLA8kmwuj7h8ZA/yLLKrmCDY0
        dg6WoQUrYV4Km/8/GBHzsfVCK5N/EBIVQleHqe4=
X-Google-Smtp-Source: APXvYqwU9dJ05+8rynzhhNBicgBPmijgGoBBliwmzdrpt/5iiUPQNt2RvS/2MnRfvnaqnA6up+jW2OIgcJT5839RZwA=
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr45124961wrx.196.1563394738526;
 Wed, 17 Jul 2019 13:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190703190404.21136-1-daniel.baluta@nxp.com>
In-Reply-To: <20190703190404.21136-1-daniel.baluta@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 17 Jul 2019 23:18:47 +0300
Message-ID: <CAEnQRZAagcb5Qzh1ZhAR0g3kQNyR3u1GJXFqwExnzDp-YWTDxw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add power domain range for MU side b / IRQSTR_DSP
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aisheng/Shengjiu,

Care to help with review on this?

On Wed, Jul 3, 2019 at 10:06 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> This patch adds power domain range for MU side b and irqsteer in
> preparation for adding support for DSP <-> AP IPC communication.
>
> Daniel Baluta (3):
>   firmware: imx: scu-pid: Rename mu PD range to mu_a
>   firmware: imx: scu-pd: Add mu_b side PD range
>   firmware: imx: scu-pd: Add IRQSTR_DSP PD range
>
>  drivers/firmware/imx/scu-pd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --
> 2.17.1
>
