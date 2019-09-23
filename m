Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E877C88CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23B2207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Uc1rJg9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502757AbfIWUtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:49:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44648 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502482AbfIWUtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:49:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id 21so13364579otj.11;
        Mon, 23 Sep 2019 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAD3Xg1lcz/vWNfKOXbNQkNK8JcAqagoLevWw8c1H8w=;
        b=Uc1rJg9EHlGwJNJeN6soMEoo/3M+ZsjMSxAMCVEA+f9rOyJvTLPXhHKYXJwgIcEzBr
         e+3CndfndOMezv1Ptw3MLfFegfdCU9l142+6xMNb6yc4r537qDyguMUGRJy+2tVBa8tR
         F3znac2BBuFbLhadIwE1d+eNekHVycr0brsa51/cTtZc6+gj6CyZzfwmL64hoJreYrbK
         BNsn+vt4zqHzlSpK9FPzf9skcHsynz8YunjI1ogBbKbkLYBspiO7cYeF+/GORadBkgQs
         BoXGJUuzpml3+FLUCkphSuXEpIZ0v82lo8jO+mArHKkjDH3EoiOUfBwEJn5ZHqf0JXAZ
         jGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAD3Xg1lcz/vWNfKOXbNQkNK8JcAqagoLevWw8c1H8w=;
        b=PLmrPInu5OXnrGrF8J7C3YZJPgTC4PA3T1SG+S5f9yInUquXSo3wMwL19gp1IopejS
         pGudY5gqp4/noo/VMd6QHJk3hCnCc7wTcIA3gUuNmrG6lJmCPHdVOupDwH4kaaWH4oGq
         xHypUMEO+YGQTs36GXsUYDHlw+uqTiKCzf4BmYruJSvAi/etUv82cpkIZ2X9dvmupfCy
         djI+IfRoa9LjU9FDw+PnbmQT5Yg892pEGwSIRJ3TFfUaKxkhjVnkqftpT2Jvt2Wd6u5P
         6cL/VMB4JbsQ7+B2nl/DkDCieb0eAddFrU9Psr9xC2DeAmyP4yaBE+Y3kd6t+IyTIpnx
         MAJw==
X-Gm-Message-State: APjAAAUzh5pabybEZajfMJt/lIO+Kp/ge+ets2T0xHoMXIJgbF3cbPcz
        KW3pt01wV7waswd0CmEmVC6ndQIkW6IUEVBHCqI=
X-Google-Smtp-Source: APXvYqxg9tfZ17T4nhNMMZMbP5FnSoEzZH0Yj/hpHqWL0Dt5cVhCyLOpWwrFdj59nZDuupSIBtRiMaKO4g+TxYTiSnw=
X-Received: by 2002:a9d:7d17:: with SMTP id v23mr161527otn.81.1569271789175;
 Mon, 23 Sep 2019 13:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190921151835.770263-1-martin.blumenstingl@googlemail.com> <1jsgons4wy.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jsgons4wy.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 23 Sep 2019 22:49:37 +0200
Message-ID: <CAFBinCAHD+D=a2mHeHMGq12MvoksHBr308jSrdcH+UYsUmwd8w@mail.gmail.com>
Subject: Re: [PATCH 0/6] add the DDR clock controller on Meson8 and Meson8b
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, Sep 23, 2019 at 12:06 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Sat 21 Sep 2019 at 17:18, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > Meson8 and Meson8b SoCs embed a DDR clock controller in their MMCBUS
> > registers. This series:
> > - adds support for this DDR clock controller (patches 0 and 1)
> > - wires up the DDR PLL as input for two audio clocks (patches 2 and 3)
>
> Have you been able to validate somehow that DDR rate calculated by CCF
> is the actual rate that gets to the audio clocks ?
no, I haven't been able to validate this (yet)

> While I understand the interest for completeness, I suspect the having
> the DDR clock as an audio parent was just for debugging purpose. IOW,
> I'm not sure if adding this parent is useful to an actual audio use
> case. As far as audio would be concerned, I think we are better of
> without this parent.
there at least three other (potential) consumers of the ddr_pll clocks
on the 32-bit SoCs:
- CPU clock mux [0]
- clk81 mux [1]
- USB PHY [2]

I have not validated any of these either

> > - adds the DDR clock controller to meson8.dtsi and meson8b.dtsi
> >
>
> Could you please separate the driver and DT series in the future ? Those
> take different paths and are meant for different maintainers.
sure - so far Kevin has been doing a great job of still tracking these
but I'm happy to split this into two patchsets


Martin


[0] https://github.com/endlessm/u-boot-meson/blob/345ee7eb02903f5ecb1173ffb2cd36666e44ebed/board/amlogic/m8b_m201_v1/firmware/timming.c#L441
[1] https://github.com/endlessm/u-boot-meson/blob/345ee7eb02903f5ecb1173ffb2cd36666e44ebed/board/amlogic/m8b_m201_v1/firmware/timming.c#L452
[2] https://github.com/endlessm/u-boot-meson/blob/f1ee03e3f7547d03e1478cc1fc967a9e5a121d92/arch/arm/cpu/aml_meson/m8/firmware/usb_boot/platform.c#L22
