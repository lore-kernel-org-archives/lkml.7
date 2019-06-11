Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85199C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4711B21734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UjB91fpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392063AbfFKXVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:21:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33902 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391843AbfFKXVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:21:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id p10so1956639pgn.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=6R5z8ssQN4qiGOh66dhDcOUdNqdVqqfHxJdMHqWe+6I=;
        b=UjB91fpfYVxjokEfklWaFtD6ieDpdjzJUDy2doUa03GNp+vrleOmMXp+3L0bglIZl4
         QfrTlKqAdgOa5u7GEqHAkY9gmpQ54qirFCrJxZWOgzvMbYy22//uWOtY+fnejFcy+Pgi
         wpqqoezOaW50ME7qgQhMeFk4SZ9XV4cj57rBGRy0aPoUjK27dKpiaBbUKmcpgBGsqms7
         oL9S/ldKM4kXj0n2a7K201mjCpdNItVSQP/41iYU4GTTjUNkTXU3VNz+oaKZNE9FUdmK
         w8B7B5Oxb7YfbEq6roMJ1EeFl9ufp8uFWJ8t8Dg158x9a/DFLOIjJ51iSOWbUGVj8kT/
         2Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6R5z8ssQN4qiGOh66dhDcOUdNqdVqqfHxJdMHqWe+6I=;
        b=qsplas6FRH0uCoHhb0HCjN1YIx9zfrxgAtpS5lDjp+Y7Un3FHlAWsq028daIbR3BZx
         yRnWEeWd9M7XdOmnKjZKD4xUqbmitPpTIR9vQ+kF4Ba/60uS2EKQnI4+VutUw/1/Hf6R
         D1yIC/NM8hhW+mzgExDPXj8TE11rJDf6hmAUw/75kGijGPIkrmQawIH0qB5J52u5O4N0
         Rb1Qrl6XT/HKZ4KsNTHob0i68dJuTbsVvhruuM8rdoUHHk6wbuL+6lWlhoptYwKax1v6
         UmNY/GqtOyBQGqa3Xf8e7KWkoRIiOB+6hc4r3HdcM5jObiBUynvMhnPcFCURKDGVOUi+
         hmmg==
X-Gm-Message-State: APjAAAV+UcjCR/JTrUd0DIvwE9b2UOpIoYtIV8lwXt+MmAKiLn2W7pY9
        nU73zuDDBgMbFpT7LQls6EuGHw==
X-Google-Smtp-Source: APXvYqwJJDMRep94gko5n4JSC8Vapq9gZn4ceppzlT2Q9WhxcgWkcdYxSrkQpzkU6piKWsKdi83mFQ==
X-Received: by 2002:a17:90a:9b88:: with SMTP id g8mr3482693pjp.100.1560295295171;
        Tue, 11 Jun 2019 16:21:35 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 30sm1795537pjk.17.2019.06.11.16.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 16:21:34 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: g12a: sort sdio nodes correctly
In-Reply-To: <CAFBinCC4g1WVFyTgQrDUcYs13HDYp7Ggn=eSQ+X=LnpEoGg--w@mail.gmail.com>
References: <20190610124931.17422-1-jbrunet@baylibre.com> <CAFBinCC4g1WVFyTgQrDUcYs13HDYp7Ggn=eSQ+X=LnpEoGg--w@mail.gmail.com>
Date:   Tue, 11 Jun 2019 16:21:34 -0700
Message-ID: <7hblz34sjl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Jerome,
>
> On Mon, Jun 10, 2019 at 2:49 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>> Fix sdio node order in the soc device tree
> good catch, thank you for fixing this!
>
>> Fixes: a1737347250e ("arm64: dts: meson: g12a: add SDIO controller")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued for v5.3,

Kevin
