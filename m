Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3653BC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB4A2053B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cG4ow4LH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgACJvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:51:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38375 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgACJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 04:51:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so33350698qki.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 01:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m2l4ZP00y1MciphnLaoZDMF/+IkQks5KZaGyrGhDRiA=;
        b=cG4ow4LHRj767jnNAQOpyl17Q+p40TAAcPfpSpHHXDGlrwj62Hpbce+n9FDrk+qkc/
         hF5ZyqmmFsJTtYTiw79voWF6jUJzD3jMMLxaKlR24Yfx0wH19vRA84WzFpBPdLB301Wn
         oDHYiFn+x4VsG0+cQjGtKP+AgiFhJEl2gny+42Vv2QuoSuDmtZTYXxHfkb2SYQSXio5l
         4izdl3cbPeqe/fUEgmo7jINRJHhXeZzjP7rcRM1zIfCdONmAYkusOFVw3KH4tD5KGrsX
         B2TTgSy+6TGCiaGzC+uIdpJ7YevNhC6HmCAOCMdMswOZwgLLOkvTEExLz90pSslcmLhv
         3Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m2l4ZP00y1MciphnLaoZDMF/+IkQks5KZaGyrGhDRiA=;
        b=RIZEakYqg+NySL/DEX7TtuRdcYDBSnUR4KDqBYX1F0kaIloAi7TdSt/H5zzoKpHQLV
         ZhSkOco2dv4VYDA02IrYpvqHC3UXjHWL/UfaRdS6IpZQGN1K9DQHHvZf1iLF7Liln0Lv
         5x45qQfhdW8U2hpS3pgQgdV0aQaWANtYYTp3KkGOUxPjlyLOEdKO7CCdcLAAwOSbpGOj
         0z+hRipgy0OAdjcSxwKb3P3GD2AhpAjv//lq4jZcDuuJPMWdZFq1Sc//DVjGx4Gv3etW
         eb/MemVzc4qwZ5hjZ7Oedj/FjQU2YxgS+AP5PSgcln7LzSNzw5h8vr2xwzSA7fxdxwPX
         VcFw==
X-Gm-Message-State: APjAAAUgUSm84lUUfp3yAOFCFqSqHSCtroIt4JzsYaRwuPkfyxYkeIrH
        ZEMCfXg/rCSDlgKvO44WavHcagCwYHKnoWxRn91sXQ==
X-Google-Smtp-Source: APXvYqzAZelvEL1bp9L+Dip8BtcvxrfIeDBmaKGivW0X8lJb2LdaJs31IH9b2gpMP+zcFkudxHBKRdWDiyhDv4QqwCw=
X-Received: by 2002:a37:6255:: with SMTP id w82mr71281142qkb.330.1578045080489;
 Fri, 03 Jan 2020 01:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20191230133852.5890-1-geert+renesas@glider.be>
In-Reply-To: <20191230133852.5890-1-geert+renesas@glider.be>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 3 Jan 2020 10:51:09 +0100
Message-ID: <CAMpxmJVN3f5vWZoUpgsM0kocmBYSO=T0OeoG--5rQi9=jk2t2g@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] gpio: of: Add DT overlay support for GPIO hogs
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 30 gru 2019 o 14:38 Geert Uytterhoeven <geert+renesas@glider.be>
napisa=C5=82(a):
>
>         Hi all,
>
> As GPIO hogs are configured at GPIO controller initialization time,
> adding/removing GPIO hogs in Device Tree overlays currently does not
> work.  Hence this patch series adds support for that, by registering an
> of_reconfig notifier, as is already done for platform, i2c, and SPI
> devices.
>
> Perhaps this would be better served through a pinctrl-gpio driver?
> Pinctrl is already working fine with DT overlays, as the pinctrl-*
> properties are part of the slave device node, and thus looked up at
> slave device node attachment time, not at pin controller initialization
> time.
>
> In my particular use case (talking to SPI devices connected to a PMOD
> connector on the RSK+RZA1 development board), the GPIO performs board
> level muxing of a.o. the SPI MOSI/MISO/SCK signals.  Hence the hog
> really needs to be active only while talking to the SPI device, so the
> muxing could (in theory) be done upon demand.
> But how to describe that in DT, and implement it (using Runtime PM?)?
>

I may be missing the whole picture, but from your description this
sounds like a job for the mux framework. Maybe we could make runtime
PM aware of muxing for this type of use-cases?

Bart
