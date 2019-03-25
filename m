Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5656BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14082087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pPlNc1xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfCYRID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:08:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46565 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYRIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:08:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so6716994pfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5zVksnavI6IiS5+wxbgLfc+KV5q55Q9A0+dGhNHgcBk=;
        b=pPlNc1xeOFEmC9a8uUcLm6cMccMFayxZ0ZBLie9gfn7H9UaB0bOq/4sEHjSs6gcEJD
         Q/pa/d2iUT8TtqTuddzAUBJM2GTwiJngb0vUhyVEP0IUw0QcIGW4LHTG4MLpJJ5zZvaV
         td4XYxg+NHoSigZkN0J0cB8YNMEI2Of7LoAbZD/5FsHtNeT30ZFwF+TpsGY+HrZ26REC
         tXFVxTzFncaI4XcwagTt7VdVLRU2vIVmt4u0nI4Z2PFDXDmsfl5u/5mEL+YbsrtjMaP7
         Fm3tl9R0he4X6a9S978+vAByhCD+uZiy/I+0d2QhAkmTWNJM3Bieca5E6axUgCHbWfHi
         atEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5zVksnavI6IiS5+wxbgLfc+KV5q55Q9A0+dGhNHgcBk=;
        b=a8upsIFo3cA4CxPr/IWiYUaZnERwlWICktskC1mDg7J5laEkTQZUFYIT9XwtLzUBgb
         KEzri7gQ9w87Xz9ZRDh7HEkMKSUWwpz4KaF6pEnuIux/7EPtdSxOvmgvaD6wh9hbAQla
         YloelBq+e5AlzMhmKudstyRGLSgDCjGsLyXpozx/jslY+LBCtLqglQsxx45DIwhi+vX/
         /ty2uAau9JN7n+czzWqTdXEzkURAk5xA7yhOUJ3vnBpqZdoVYL18nxouv01kkU1MWaxj
         PPrFV1QPCUObPx/eunLDKwLQD/rRlFz24uSD1hnRun5L4lDEHLszJu01I/hFmhtoTo8d
         OIHQ==
X-Gm-Message-State: APjAAAV0frXYZp9fQaGn0jIOFJ0aLmTt/SnX5r2zm8DAcewBOU3rQMaQ
        O6TP5kZGYHfsfcZhCbUHL4stLA==
X-Google-Smtp-Source: APXvYqyBfs+BriKLNLVmpE6yEO8PeRHNyRdO8nQznAeDFWr05Lk/VXyKa0Z0z7z+eNNUPqehgvwTwg==
X-Received: by 2002:a65:4344:: with SMTP id k4mr23935918pgq.20.1553533680542;
        Mon, 25 Mar 2019 10:08:00 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:314c:c810:897b:a1d4])
        by smtp.googlemail.com with ESMTPSA id d75sm34008122pga.66.2019.03.25.10.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 10:07:59 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: amlogic: meson-gx-pwrc-vpu: Add support for G12A
In-Reply-To: <20190325145537.31697-1-narmstrong@baylibre.com>
References: <20190325145537.31697-1-narmstrong@baylibre.com>
Date:   Mon, 25 Mar 2019 10:07:58 -0700
Message-ID: <7hva06q3v5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic G12A SoC has a very similar VPU Power Controller setup
> than the older GXBB, GXL & GXm SoCs.
>
> This patch adds the variant support for G12A.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

This patch not only adds support for G12A, but changes the functionality
for GX SoCs too, but that is not explained.

Based on what I see below, I would expect two patches:

1) improve/modify the GX functions (with descriptive changelog)
2) add G12A support

Kevin
