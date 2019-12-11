Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7137FC2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BC0214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bNjp2CSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfLKJOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:14:30 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42683 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbfLKJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:14:30 -0500
Received: by mail-qv1-f67.google.com with SMTP id q19so5420302qvy.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r0gVQXuC6a8DJTUTEo5suxWb6NqvG3m1Y5eO4L17BxU=;
        b=bNjp2CSwAwJBRkHlE21fA2+oQHaa1seGpALK5gMpFZBRUweh616cc6A6NjuV3+jP7t
         g+avl1kCd9byKb6OLRWoCARmcnjUMCDWZEVNMYHwcwq2N14q+0Zs5gKmbn2v8QLkXlTu
         qYT1j3fhiE+HvHPvq+5C8dY3pDcfH8rPaHt6qHrXYFCzpU3tQuLtDKmRQXWEU0wL1bu3
         XD9Fpr5nzGis98WDLXJ2dEtgi9E9jwJki0nduViVaSEEfNJCDk7B2WzJW4nUmbeKRtSE
         EwrMoY4b/3ywG1wFw8EbFjXcoFkI0JmL0qp722LB/JC0izmuz7ikSSrBNnztdHuLMnYW
         93cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r0gVQXuC6a8DJTUTEo5suxWb6NqvG3m1Y5eO4L17BxU=;
        b=mZeZOJV3Es6m/BQIUUeGf9IARdpSQeT8bXnIzhzNTC+FN19WHutrOiiPrDaZnI2Xph
         ncK4T8KVJdnWu1sadGvVls2cfPeE+i8hePIgIopsg3d0R/Gx8bibol4IUiHCecLrbj9o
         7uDzntUJ2xK3NCn+3FlAaqOZG+J4NoXMIOnI88v8qVQRFSaPT+coyOGOPcssIwL3qQns
         U8tdgq1QTf1si5d6Y8oCNioxkGRjQKMpAr3G89a6AC/a8VY6DO0wW3Gp5fzOS5kgIWvJ
         5UHYnDLXVcRF7sVo/jHjwBZmmk49OkhSvktSo77MHaCclIKLkKlgvBWwm0vjO/Rgu1ww
         GQBA==
X-Gm-Message-State: APjAAAUWeHRvcaYBoJwHSpfJogMqcJmci1QocY57mnW7GSuv/AgGy9eX
        zGvkK8Dl7VwLrR2T/9Y9D3WKlYD0rnO8/rCpf4YIdg==
X-Google-Smtp-Source: APXvYqzjKg+vHur/oJLRJqO8JGriJMPsHU3Yxw2c45bVX3cqASfK5p6p7v8TgWUig6+CE+I07XNmKBR7AxR/u500qXY=
X-Received: by 2002:a0c:f990:: with SMTP id t16mr1951160qvn.134.1576055669090;
 Wed, 11 Dec 2019 01:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20191210195414.705239-1-arnd@arndb.de> <01669f6c5d0e40c7a410da2dcce6c9e825e4a1d4.camel@alliedtelesis.co.nz>
In-Reply-To: <01669f6c5d0e40c7a410da2dcce6c9e825e4a1d4.camel@alliedtelesis.co.nz>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 11 Dec 2019 10:14:18 +0100
Message-ID: <CAMpxmJVuN5vqA1j0ddpctJQJJMPu1EnakduO2rJnBo3Ao==Enw@mail.gmail.com>
Subject: Re: [PATCH] gpio: xgs-iproc: remove __exit annotation for iproc_gpio_remove
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 gru 2019 o 21:24 Chris Packham
<Chris.Packham@alliedtelesis.co.nz> napisa=C5=82(a):
>
> On Tue, 2019-12-10 at 20:54 +0100, Arnd Bergmann wrote:
> > When built into the kernel, the driver causes a link problem:
> >
> > `iproc_gpio_remove' referenced in section `.data' of drivers/gpio/gpio-=
xgs-iproc.o: defined in discarded section `.exit.text' of drivers/gpio/gpio=
-xgs-iproc.o
> >
> > Remove the incorrect annotation.
> >
> > Fixes: 6a41b6c5fc20 ("gpio: Add xgs-iproc driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>
> What's the current best practice w.r.t.__init and __exit? I seem to
> have messed this up on multiple fronts.
>

Applied for fixes.

Bartosz
