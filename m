Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B9FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC1126CF7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LOMmLUn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfFCWKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:10:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43265 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfFCWKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:10:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so9052292pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Lqtk1JLPJRbV/Uor8A27eWDozVcUr19IPuyQSb2ZXss=;
        b=LOMmLUn3OWji8hcp69Cer8ETlOICLjhPAltnN4rp4K5f25q0RlT24pWNBHwJHhZbmV
         2AOmASgj1C5kiQPqxC5BPsx0ELPuyx2MPcfB89pVUNo90bBPw2TRyhbzh5SH2Scu6/j8
         m64nBG/w+Yhv5R/ZfbzdPZw0gQ0oUVHxnJXordTCw9ZhsQak0YrH89m5teRm4Ut/zuvh
         GgbweAG/DCgafajg9GpEaZgoG0ZouFPc22PwC77s1UnfGj1yN3pzGXJgXrWenNphhHR9
         KJ1JQnfDizgW24Rp47icxjhjBl6WVLrhUsPnikns/XcaLkcA7vJy2Q2/jZAQk1GQB/eo
         bz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Lqtk1JLPJRbV/Uor8A27eWDozVcUr19IPuyQSb2ZXss=;
        b=kBzgR7d6IBh48MGv56vk+vU18XCH9KNlJBCNGry2Vi6nWK4aiK8SgUIgZC5sItASoT
         fHbOCoxApe3ByB3lERZpyFGJ36OHGVozNFJX3IWyA4b7ZmNSQsuyLGWbkbxopK9L+cEt
         HyxmJRKcJha4Xn7pobnanfNvHGLaISytsWjIdA6PVHg12frnlngivOCOalGM/31uaYWA
         CQWiyrTY+3ZRep7cbnVxHp0jXUxaL4b8yGMdzEVzFopAKmDLPSZVNMKyTdxYWxFZ4/4D
         wm/WpIobk/WweGcoKwokR0rTErXQG4/iqRRNN0Qu9uv1Ro32/Ypq0r4jrTiY7QVHuuTC
         o0aQ==
X-Gm-Message-State: APjAAAV6cshSj0l+NpzWTGR1cW/pYUgWfkSEcckrzUA/p7FOnjxF6bz1
        gJB14UG67yD9UGFFESW2N87jcA==
X-Google-Smtp-Source: APXvYqxTWg1pff0VpEjIEtZaLRKwlbARqN5oAhRdttUjDIsDawnE2zYntfrph7HTS32iO+Wx978D4A==
X-Received: by 2002:a17:90a:29a4:: with SMTP id h33mr27038831pjd.105.1559599852823;
        Mon, 03 Jun 2019 15:10:52 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id p20sm27244237pgk.7.2019.06.03.15.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 15:10:52 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: meson: g12a: add SDIO controller
In-Reply-To: <20190527124307.32075-4-narmstrong@baylibre.com>
References: <20190527124307.32075-1-narmstrong@baylibre.com> <20190527124307.32075-4-narmstrong@baylibre.com>
Date:   Mon, 03 Jun 2019 15:10:51 -0700
Message-ID: <7hwoi2ial0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> From: Jerome Brunet <jbrunet@baylibre.com>
>
> The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
> add the port A (SDIO) pinctrl and controller nodes and mark this specific
> controller with the amlogic,dram-access-quirk property.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.3,

Thanks,

Kevin
