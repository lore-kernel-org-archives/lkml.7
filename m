Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED10C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EFA22CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XwojiHFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfHTJxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:53:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34246 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHTJxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:53:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so11719530wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=SUnSrbdwUP8RoleAa79FxmS5FX/ZRHJTHopnWunm290=;
        b=XwojiHFvgChsTh2dvDaY4v1fd4rzKiMOeb06+6P/nop9JtcLZQ97K5GuFcraIWPFpM
         Y9G3AWa6uppMxg4cWeFGEcSSfWCpibuEPYQf0WHSgTHd5ciGIV03aelOJWJAP/ut5CFq
         W5MlfmD4VfiGZ2ZLyLE7pO9PstqRS9COV+FcTOnkeNpL508l0VygYktYHz257McLoQW9
         6gfQKbuwoTxH7mdlgjEYGfTyXXfsKa1bM0IHmDFh+KAyBmOlP+5j/IH1xtm+M49R41I8
         TX1eOzN7ljfBAYiUdwRnnkZnWD0S8V1G43aaoZeYBLCOlOWA5gfDGZM2XPu2vZ5W7DsU
         yefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SUnSrbdwUP8RoleAa79FxmS5FX/ZRHJTHopnWunm290=;
        b=UoSkU+mpTNRs0UY7XC4tTeGrkPK51xfdnDIDVsL1ebD5bwa3k6vw+4lMXBBhlrOf65
         jM+MZ2Q5nfWVre2nPirpa2ntjsOkG6XV9zxYCihNPUfF3RqRjBppeZS17NavEkq8jiiT
         8ZM0TNWQGobRwInCldgXAA58djVP1HLS0Haze0f96L/hr9QDOXmGlsoGW+WRE66vnU67
         TUIyLpbSx4jyu5htCjJ9ZxzI2u4k5wdbVkyIT/BoGqtEY4DT+KIlndsIYOzcSa9YQpDt
         lEDq3lVFOQmd3mMh9EsooMgKkQ0AmvDiC1TaM+SSbd6/2V5D3pdhqPwsDpee384D812h
         ERSA==
X-Gm-Message-State: APjAAAXajFOgHxLhDznE1WBnvzzIwbix8BdkdDn7m6wPuBQ3+nrkiju1
        mBiZXfDVptre8/12gdTbzYUvHg==
X-Google-Smtp-Source: APXvYqzXCBNehS2ApNhjVFm+GWBL4RnL+aylPxPFwqoRpssS1hbtu+YxZ1n2O/rnzC708on9ZtJdYg==
X-Received: by 2002:a5d:4d4c:: with SMTP id a12mr34029723wru.343.1566294783750;
        Tue, 20 Aug 2019 02:53:03 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f6sm38642001wrh.30.2019.08.20.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:53:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: meson: axg-audio: add reset support
In-Reply-To: <20190812123253.4734-1-jbrunet@baylibre.com>
References: <20190812123253.4734-1-jbrunet@baylibre.com>
Date:   Tue, 20 Aug 2019 11:53:02 +0200
Message-ID: <1jpnl0noxt.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12 Aug 2019 at 14:32, Jerome Brunet <jbrunet@baylibre.com> wrote:

> This patchset adds support for the reset provided in the register space
> of the g12a audio clock controller
>
> Changes since v1 [0]:
> * Fix typo reported by Stephen
>
> [0]: https://lkml.kernel.org/r/20190703122614.3579-1-jbrunet@baylibre.com
>
> Jerome Brunet (2):
>   dt-bindings: clock: meson: add resets to the audio clock controller
>   clk: meson: axg-audio: add g12a reset support
>
>  .../bindings/clock/amlogic,axg-audio-clkc.txt |   1 +
>  drivers/clk/meson/axg-audio.c                 | 107 +++++++++++++++++-
>  drivers/clk/meson/axg-audio.h                 |   1 +
>  .../reset/amlogic,meson-g12a-audio-reset.h    |  38 +++++++
>  4 files changed, 145 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
>

Applied

> -- 
> 2.21.0
