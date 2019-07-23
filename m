Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78362C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 19:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473E92253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 19:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PtdD/d1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391750AbfGWT44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 15:56:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44969 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfGWT4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 15:56:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id e189so33155207oib.11;
        Tue, 23 Jul 2019 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1AFUHPs3ukSumhoc36+Xs1ZNvtbenSv/4Q8Xj7E9MYM=;
        b=PtdD/d1uwfy+AGDVmKWOA8frDABiK2A++eRyYAVYStYpKoEWO2MA4dEA9ma/lT1l79
         YkRZTu2r+noblhGiQQjjFXO6na8fz4GLS7CHZeZK+CSQQCMkIGn3mPhq386VtrkuxkLV
         mq/fLFxurYfJC9h8r3A6xlevEJRLDzScem1/uxlXjpddnEVGFSIxDs1zLHRuOjXyxl/7
         CNqhVXT0hjKxfndknoi1FZWthsMAoLgqendB5zfaig7Ae7eE2jTyXEPkyrMpqtuI8wd+
         2SeD0E8vVvpqEx3tBkyWniwzYTPHmH/aLQtXYE/zmq5kJOgIci2wl42P4PrwmDQnbJsI
         8Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1AFUHPs3ukSumhoc36+Xs1ZNvtbenSv/4Q8Xj7E9MYM=;
        b=eypH2oEEPHzUvG68Za2DluMrXcRT61+eozbP80JTxW0XRwnd3+uySoSwbtUTKTkeBg
         snCASeTz5/bwWbB6bCii9qlLQLe1uGYf9RMr//ezPC+nIBq6Usj+psLsxCaf665SuUMj
         J/K9s58SWkwk3hh2w+haXQLtnsDThIy5SNccgrlm2gdveHa9pQsOoauS1F165skW3bJ6
         DDC3RO41flkaXU6/2UWzaMmaEgYB4auofqjU++RpOia5GutlV6ATyEYcUIO7Abh3hNrK
         uxXE6NO8pClBZ/n3ss2hou+pRHmnbjBV2J5LFcs0bB42ttQr6ptG5KOKQGZAazCkgwyn
         Ngzg==
X-Gm-Message-State: APjAAAWeTBBKx6l7iarKXBWnW/s6mSfSMgy82UdiCeWwaDmN1IzoIyUf
        +5FTpwVanpA+QwSxfJUezochBxIeWTt96aaKC1IJNRME
X-Google-Smtp-Source: APXvYqzQoRR4HmY0uZaFXa1cGF2QLM7M5Wd2+IL8+k4pMdzEWKP3+vqYccZqRa0yFdkE3KLi2sQWXeCqITjQ+r99uKw=
X-Received: by 2002:aca:4ad2:: with SMTP id x201mr38072383oia.129.1563911814391;
 Tue, 23 Jul 2019 12:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190718093623.23598-1-jbrunet@baylibre.com>
In-Reply-To: <20190718093623.23598-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 23 Jul 2019 21:56:43 +0200
Message-ID: <CAFBinCBefuCvTL0E_zf=EQDLyTjE5sQD-TkHNj2vQ2UOCsmtkA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: meson8b: add ethernet fifo sizes
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 11:36 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> If unspecified in DT, the fifo sizes are not automatically detected by
> the dwmac1000 dma driver and the reported fifo sizes default to 0.
> Because of this, flow control will be turned off on the device.
>
> Add the fifo sizes provided by the datasheet in the SoC in DT so
> flow control may be enabled if necessary.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I wonder if this "fixes" some of the performance issues on Odroid-C1
testing this is now on my TODO-list for the weekend
