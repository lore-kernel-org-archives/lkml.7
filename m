Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88762C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDD420828
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zQ8qmx05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfHZKiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:38:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40743 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfHZKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:38:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id c5so15128620wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Kf8u4CCd/0S9O2So6myGgJK9LXtHBggKOGNILgyNsuQ=;
        b=zQ8qmx05qaOIOKB3nVfxXqNCv+sn45uHFoupchU/B5zmHCN7P03HHPRLrUjbmJmnhx
         IpyiotKwMSMCJbdLA9LfMV32TI6cVrpw+aoiguzXU9TCxD84ovcOUzc/yHq2RzLjkOwh
         V6qOJdCIhgChbe7pPv77ONsJFBRDFa3bl91/LcGbmlZBM/ki7UAsHZzDqDR5Z7AkAkIQ
         e55qpjmV2NWd/xbpvPP3DnV0donLR7jFVICnLZkeFV19/9R2kmIW99MIPIwW8mmLs50T
         /tCRnjIzaS3Ez4vOpUw1ZnZZUCN9Z8QTxRF95FpldE71mQQRFb6fqa51UjkMk84x3r8C
         qxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Kf8u4CCd/0S9O2So6myGgJK9LXtHBggKOGNILgyNsuQ=;
        b=aX5pLhvKrVClKh6fdZbX6qpB5M30Rw3BMZxS7/hOArN2tm4ntyOjoL6c1UlxvRJEH6
         ZZgDYrmhewy7g2gPCnQzT+/HUemjo3R3UmBh+qIl4XuWctQpu/ygclYInOd8lGehDG3Z
         h5Pa2oEAHgmDa/6ujonvmGqQBUEM7EgEp/KfhMcbXO30YtGxru2T6zmg7UFVqb3pVHqC
         sT6MIlo/nyhVQN2x/aMnIfmJYT85Ff79ULTG45x9qCAIQr68qq4iORDq1e/Vp/nOFW5i
         lO7dbBkbplOGTdTOIsJjSOI1oC22beaCLYuOyrKu6lr3LHyJWAtBbn4s6B/MPXo33atK
         vKFg==
X-Gm-Message-State: APjAAAUGQO2Oglf0IVkk2PYGPEpP1saIhN82OXhrPVr/dgIarJGQFgGQ
        szZFLMK2F3+hRIc2uaLQhKIgNQ==
X-Google-Smtp-Source: APXvYqx71Hht1gZQHsv1/FmSYQIlLLq0ghiFPtdJ3K9r2UYbesJhnRhD20ID9r47y8tLV2cTZB7m2w==
X-Received: by 2002:a7b:c198:: with SMTP id y24mr20738869wmi.131.1566815931702;
        Mon, 26 Aug 2019 03:38:51 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e11sm32044884wrc.4.2019.08.26.03.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 03:38:50 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] 0/6] arm64: meson-sm1: add support for DVFS
In-Reply-To: <20190826072539.27725-1-narmstrong@baylibre.com>
References: <20190826072539.27725-1-narmstrong@baylibre.com>
Date:   Mon, 26 Aug 2019 12:38:49 +0200
Message-ID: <1jblwc6wjq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26 Aug 2019 at 09:25, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Following DVFS support for the Amlogic G12A and G12B SoCs, this serie
> enables DVFS on the SM1 SoC for the SEI610 board.
>
> The SM1 Clock structure is slightly different because of the Cortex-A55
> core used, having the capability for each core of a same cluster to run
> at a different frequency thanks to the newly used DynamIQ Shared Unit.
>
> This is why SM1 has a CPU clock tree for each core and for DynamIQ Shared Unit,
> with a bypass mux to use the CPU0 instead of the dedicated trees.
>
> The DSU uses a new GP1 PLL as default clock, thus GP1 is added as read-only.
>
> The SM1 OPPs has been taken from the Amlogic Vendor tree, and unlike
> G12A only a single version of the SoC is available.
>
> Dependencies:
> - patch 6 is based on the "arm64: meson: add support for SM1 Power Domains" serie,
> 	but is not a strong dependency, it will work without
>
> Changes since v1:
> - exposed GP1, DSU and CPU 1,2,3 clock in patch 1
>
> Neil Armstrong (5):
>   dt-bindings: clk: meson: add sm1 periph clock controller bindings
>   clk: meson: g12a: add support for SM1 GP1 PLL
>   clk: meson: g12a: add support for SM1 DynamIQ Shared Unit clock
>   clk: meson: g12a: add support for SM1 CPU 1, 2 & 3 clocks
>   arm64: dts: meson-sm1-sei610: enable DVFS
>
>  .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
>  .../boot/dts/amlogic/meson-sm1-sei610.dts     |  59 +-
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  69 +++
>  drivers/clk/meson/g12a.c                      | 544 ++++++++++++++++++
>  drivers/clk/meson/g12a.h                      |  24 +-
>  include/dt-bindings/clock/g12a-clkc.h         |   5 +
>  6 files changed, 697 insertions(+), 5 deletions(-)

Applied 1 to 4

Nitpick: two checkpatch warnings regarding 75 char line wrap fixed in place.

>
> -- 
> 2.22.0
