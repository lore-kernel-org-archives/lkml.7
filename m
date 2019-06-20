Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D7BC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3A620657
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HR7QDXLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfFTVir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:38:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35458 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfFTVip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:38:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so2265019pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 14:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=FRa+FTYrUwE5FnAqArVG6ocbHw5r29drxK/7hoYzZjo=;
        b=HR7QDXLF7YhGpHGL9vIVq+IKHpppE33n8uKbIEm8UdnyiHhFldKWoErbW86WxynVZB
         4i4L4LrzxDFCh7MvTNJvhtiMin58jW986U/8DoROWF4VPVnPfevCtaZQt8Uzvz6/6rO/
         Hk1K2d4TVRL6un9PVsnjAGfyCrNnmX2DfItpG9GMkMTr5x4akX/6PGZw4KnwFnPL+ZYV
         wjxcI1mC04550rE3GTltks17N66DE4Ys6GexAO14YEFtKdKK0dcZDvOBQa7WLRy/TeoC
         sttTGsNi7ZMpS+09IYY/opogZcAnSmRWR5Cr1Fcm78Cas4Ro+hh/gbHmTxdNE8P3RsvA
         cSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FRa+FTYrUwE5FnAqArVG6ocbHw5r29drxK/7hoYzZjo=;
        b=IIudg1bChceunUzRqzezhsbhiIUeSuO6unMy2GwVqKnZ2s6SFS6pLiXa6JfV0J135q
         8S+PKMxu0/rD320OVNiqgJWpNXhUMA4mvbCAL79uiERO7/eJ4EjlDo+TNo8e8cktXCxP
         UOhEVawInbH5X9mT5EgqvZUlmGdmuHgHnlgh1KMrrPC1qOkyqW0dHZWAipj/AlBBh9+F
         NRn+MRELMHKqrWuqOASg0fau95wW4ogPvTBUklJodClNFjDoI+1fv6rVleBnwW5tEEsr
         7GADbWS9SUqghIusgatlgFE0FtWsvqkgqQphu4BZSPCHDMFKQGcjvTWDFyaOHIu7wO0b
         NvyQ==
X-Gm-Message-State: APjAAAXy3W6VrHy1zcs8qy105sZa2stKLxVvQhT1q1w1Keo0exMWhkfw
        XkVBVbtfuDLztSAfLP/+lc0DvA==
X-Google-Smtp-Source: APXvYqxjVkZc9pYQKXqXmi7Q6qEP+iSI2+ZCxr5esPXxOJPjmPJLRPJUnOC0Vw9lcgMFgHRUh0BlRA==
X-Received: by 2002:a62:7d13:: with SMTP id y19mr74181464pfc.62.1561066724568;
        Thu, 20 Jun 2019 14:38:44 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id r9sm542327pgv.24.2019.06.20.14.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 14:38:44 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, thierry.reding@gmail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com
Subject: Re: [PATCH] pwm: meson: fix the G12A AO clock parents order
In-Reply-To: <20190620144655.2142-1-narmstrong@baylibre.com>
References: <20190620144655.2142-1-narmstrong@baylibre.com>
Date:   Thu, 20 Jun 2019 14:38:43 -0700
Message-ID: <7hy31wdjj0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic G12A and G12B Documentation is wrong, the AO xtal and clk81
> clock source order is reversed, and validated when adding DVFS support by
> using the PWM AO D output to control the CPU supply voltage.
>
> The vendor tree also uses the reversed xtal and clk81 order at [1].
>
> [1] https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/drivers/amlogic/pwm/pwm_meson.c#L462
>
> Fixes: f41efceb46e6 ("pwm: meson: Add clock source configuration for Meson G12A")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
