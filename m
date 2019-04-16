Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CAF206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qSJBe03W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfDPSwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:52:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35839 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfDPSwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:52:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so10789416pgf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ZKHgNuLiACuudZS2vjl4WNa+63x+Q4ciB/rqWwwQ8ww=;
        b=qSJBe03WwEDqSAOa0QsC6PcLBsG1FI72M6LCj1t7tHS1jWXUnDCoWa8mSIHBrPriSV
         fHHsInWUn83XGjBksGIK9U9XsDNxb2pLCys6VIQ0xCpGrMH0l06W5VLNFmdIC8mLqA0H
         QxJckKyDPnYQzPQ0JfdMR6harraFljz7AgbgwntnIGaxFP5BA1ZESKA4oeciLKoMyfNt
         7w9TySAa6nky3D1Of9gZ/rfwS4MbyRo7eEd4cIElMC3b3Z2o79qE0tg4wJoGBIBfzFvE
         tgjvhR4Gc7oU/Oo+/WXrzB+JE8hjR4+6KYXpbosjfm4hvwyWxJUTzVxPSu/N+S908HuM
         U3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZKHgNuLiACuudZS2vjl4WNa+63x+Q4ciB/rqWwwQ8ww=;
        b=E/Otantmf0IXzU6lM4Bohti6pv6o5NjzGaihJumV8I0NvzTzkD193OdCeWvQr8NJ5d
         XSNxQgM3GEQZTBJwQGm7nDvMlXV5sW+2lmZ/6g9TSIpNV3ZhhVYEhPruTaxhDh9QjuGx
         +FhZ0jyGSBcYpYeDECpX6uG+ujE/UZ2pte5ZJDv+AA8IacAeadg4uboiefshD3TyhT6V
         Ie4v43sUdB+ZTlcYQhr+t0s0a0jvACbHrNnGTKnRaEatOfQlcTh1oyZIugs7nTsdskHH
         zbioXejVyOYF3pG8IrzbuP0vnfT2z5lEwAb4SvrdhXraFngNcEZnBvmnvS/7VNpa6udx
         y8Sw==
X-Gm-Message-State: APjAAAVhCYVY0eA9iEysCVKzAgFoPu3xe4TrnDzkP7PvXhZpjoUzRT2l
        kDgm5NOxGK+Hb+vfqcad4PRf4bS/Xmw=
X-Google-Smtp-Source: APXvYqyTEVQMGDcMyr4GdBcXOoqeKCogr90iOlwDb0Bkxo159RFNuuF88m6wdt4vePNjRZtFM103Eg==
X-Received: by 2002:a63:8143:: with SMTP id t64mr76792640pgd.301.1555440764837;
        Tue, 16 Apr 2019 11:52:44 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:c45e:7ed8:c242:3563])
        by smtp.googlemail.com with ESMTPSA id u6sm53222600pfm.10.2019.04.16.11.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 11:52:44 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: Re: [PATCH 0/7] arm64: meson: g12a: add audio devices
In-Reply-To: <20190412125136.28232-1-jbrunet@baylibre.com>
References: <20190412125136.28232-1-jbrunet@baylibre.com>
Date:   Tue, 16 Apr 2019 11:52:43 -0700
Message-ID: <7h5zrdpytg.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds most the audio devices of the g12a SoCs.
>
> Kevin, couple of things worth noting:
>  * This patch depends of the new audio clocks binding recently applied
>    by Neil [0].

Was this supposed to be part of the clk-headers dependency PR I
received?  /me looks... It looks like it's applied right after the tag I
pulled, so I doesn't look like it.

If I should queue $SUBJECT series up for 5.2, I'll need another stable
tag.

Kevin
