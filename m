Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19436C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E392B206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tXD04oUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfJHHff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:35:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38959 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbfJHHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:35:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so1944421wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=IAmY8wSJYHaq63xMZva0VKaV5IVa+dPtYZ22qWpusgQ=;
        b=tXD04oUorVrs0Qr7NDaaV+exszVTijzDCYUoP9Ms1NDNT3RP+sGbtWKme17UL9nLDM
         wfleeOhDMFndnn6Ibt/NC7858hF0bYBMuPuN43nKNUdSQ0rxVWEUfr9taI867ECAMoDh
         vavOEblsWJ07b32QMbyfz+dnz9hauio5xvvL/YARcRjQv3WK+wjZ5UUR//3CSGviWPHJ
         3HgxkZGnXuA3zA+h8HdU3UtRPKGgynNXG1cTO3OiLyXgRllUroAMqG+34CXAn2UBUh1u
         e7bh4EeY19LMEbLBNluvbmvPU6bPxHRsnUYGCkgNMaaD0q3AiSQQE+5knOH7nWTIp0uc
         ZQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=IAmY8wSJYHaq63xMZva0VKaV5IVa+dPtYZ22qWpusgQ=;
        b=Z014mxCfLGwfpp7rx59sRa6xE98lNF6DoSxyF6dj0DaUpi2vLsar6uqj+XbC/KgEU/
         jjSg3J1Lg89xSGfLBaNHFB+AufHoXL86rvnRxTjaAzS/Tg7r2TjG5qmmZ+d+BJDgtDIG
         f9jvPLGbGHJx6NPga9v41w9eWXWJonOEYG/mQbXOGrHGyPDpVIaFr5rwOQV5lVcvVjiq
         tZJ2r8DTQT3G5w5LcjakiDm4p1W7V9xq0Ou8N2tJEQvau/tPRpcxhKMw7S9CouquLtrC
         IWej9Pdz97Ax/usG6Hkr4m1FhkZmjbZA/17KJVt/LvwU7FpLqUD5vGlyqbWep2E4TdKQ
         KTbA==
X-Gm-Message-State: APjAAAWat/Z6Os282M9YWnYizh2UEpqlourOxnedvz76emKKDx0SDQE5
        jjaWMEOB1ffaMCXkSa2K9dbbRQ==
X-Google-Smtp-Source: APXvYqwRMSviP1Knn31C1pXBRZyBjj63INxAWbiTXlW4xrXz3uzxk1cbGwFf4t+dOfZyyQ6CJw5kcw==
X-Received: by 2002:a1c:444:: with SMTP id 65mr2563758wme.73.1570520132541;
        Tue, 08 Oct 2019 00:35:32 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y18sm44366082wro.36.2019.10.08.00.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 00:35:31 -0700 (PDT)
References: <20191002091529.17112-1-jbrunet@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] clk: meson: axg-audio: add sm1 support
In-reply-to: <20191002091529.17112-1-jbrunet@baylibre.com>
Date:   Tue, 08 Oct 2019 09:35:30 +0200
Message-ID: <1jy2xvadvh.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 02 Oct 2019 at 11:15, Jerome Brunet <jbrunet@baylibre.com> wrote:

> The purpose of this patchset is to add the sm1 support to the amlogic audio
> clock controller. The line count is lot higher than what I hoped for. Even
> if extremely similar, there is a shift in the register address on the sm1
> which makes a bit of a mess.
>
> I could have patched the address on the fly if running on sm1 but the end
> result did not save much lines and would have been a pain to maintain and
> scale in the future
>
> Instead I choose to re-arrange the driver to share the macros and declare
> separate clocks for the clock which have changed.
>
> Changes since v2 [1]:
>  - Add missing gate ops for
>   * sm1_clk81_en
>   * sm1_sysclk_a_en
>   * sm1_sysclk_b_en
>
> Changes since v1 [0]:
>  - Fix newline in the last patch
>
> [0]: https://lkml.kernel.org/r/20190924153356.24103-1-jbrunet@baylibre.com
> [1]: https://lkml.kernel.org/r/20191001115511.17357-1-jbrunet@baylibre.com>
>
> Jerome Brunet (7):
>   dt-bindings: clk: axg-audio: add sm1 bindings
>   dt-bindings: clock: meson: add sm1 resets to the axg-audio controller
>   clk: meson: axg-audio: remove useless defines
>   clk: meson: axg-audio: fix regmap last register
>   clk: meson: axg-audio: prepare sm1 addition
>   clk: meson: axg-audio: provide clk top signal name
>   clk: meson: axg_audio: add sm1 support
>
>  .../bindings/clock/amlogic,axg-audio-clkc.txt |    3 +-
>  drivers/clk/meson/axg-audio.c                 | 2021 +++++++++++------
>  drivers/clk/meson/axg-audio.h                 |   21 +-
>  include/dt-bindings/clock/axg-audio-clkc.h    |   10 +
>  .../reset/amlogic,meson-g12a-audio-reset.h    |   15 +
>  5 files changed, 1373 insertions(+), 697 deletions(-)

Applied
