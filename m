Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A7FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D213222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="k0/9eds+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfIZVIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 17:08:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35649 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfIZVIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 17:08:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so218616pfw.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=64FsXztamILPIXBz8vnJFTeQvvjQM5nsSnyBK9zQNDE=;
        b=k0/9eds+hd+BC79ShHCoMv49nic1Fp/kisQ0HqSB6g8SATniIReUW0nkEZQucE8+ys
         XQFTYS6R6oBJ/u+XIcl5aeONKAdNI+5EjOFF3U4iCNvmeZ4WouwX83itdH2emjOW3qax
         gyvrGOlcwY8LCHMB3a43ud46l9YyZsB6/dJ5pQmv78bIiv7OPJhqEVpwHJsGQw9gN3Ez
         rdnBuYu2A1gVvxYg6gdoh0I4W9c9wnzK4OjrlTT3twucSMbdRPTAtarOL4zTWydNdB+y
         vXD+8LfJy+AASglrdLg80MFsw6vZqrU3G9wW4xDnL9rO8QtDmxociGbah4vAsLUaI/VK
         lgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=64FsXztamILPIXBz8vnJFTeQvvjQM5nsSnyBK9zQNDE=;
        b=GX2Q1mujn75GGxKpxphSmIt6Tnc8kz0x/80rrV2zwbgQnLG9D3nR4ha6PAiM1wLnUv
         OYOP1RMVELqiCeyq5BFejN1A4Q9PdpQuIZL/dQhYg3FR7lNRjvgDmlcdpmt0b1QZdvgy
         w2XL6juQntYEvLJhpHyNcZFPg3QAOrYAaeF9TIZXu9YDLm4wUUo0/PPHUFNgQo/prPWG
         u0tFhxlmoy0FbkLcXfsExJ6Qqc/8ZhJ9f/FjP64bjKAJ/L6u/krsFOv6Xru2L5dfJ3e1
         Oq3y7Qd3IJpxpgXZdrLi49lH5dMiCbQyEEfwh6o/f3MepW9RPBhTFTNznph4rNOycIJ6
         E2/A==
X-Gm-Message-State: APjAAAUuXFBNz546LCB4CT56G3kl6Eqom2sfJy884123f9+/w8os5uAQ
        7yMl+juJoTqORpTJqFdrHBSFrg==
X-Google-Smtp-Source: APXvYqyaILWTkOAOkVKUYUi6ZlBPL4LdbBfWbfkBjK3kyAgmLwz9VTCcpRbN9MZPBQkdiTqonemB4A==
X-Received: by 2002:a63:2aca:: with SMTP id q193mr5417034pgq.156.1569532129545;
        Thu, 26 Sep 2019 14:08:49 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id g24sm6141171pgn.90.2019.09.26.14.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Sep 2019 14:08:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/meson: vclk: use the correct G12A frac max value
In-Reply-To: <20190828132311.23881-1-narmstrong@baylibre.com>
References: <20190828132311.23881-1-narmstrong@baylibre.com>
Date:   Thu, 26 Sep 2019 14:08:48 -0700
Message-ID: <7hr242kbof.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> When calculating the HDMI PLL settings for a DMT mode PHY frequency,
> use the correct max fractional PLL value for G12A VPU.
>
> With this fix, we can finally setup the 1024x768-60 mode.
>
> Fixes: 202b9808f8ed ("drm/meson: Add G12A Video Clock setup")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
