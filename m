Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AB5C4740C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27DD2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="k3ebWKuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438052AbfIUPMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:12:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43715 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438000AbfIUPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:12:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so9584768wrx.10;
        Sat, 21 Sep 2019 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cy8BeFSyyxwCJlrN4qHH8AR4EXYnev9cLyrShu/UrkQ=;
        b=k3ebWKuhTvDBaawmONRTOFMM7lDUOFLxEasIcVIStcSneASkrQBwEuItFSSDjr6B6Y
         FKWFRvcEQPXg2Dd19GWK2TKxBjMZ2hVNlD5X/F6Rx4Xt8+yaPHAeD8mCowQMYBOEY3an
         ga1FPmCX/J4lWpGGJnSkWSNVzkTK2D3vDe3nAX7+TK++LbxiHMyJOXWufs8ACJx7iXH4
         s5Tgf9j1diNERktWhqYDIExnwrcf4tumXTylzW1J5jBZz1F2lOkWJDBbIIuoSWy44C16
         CYG8kbsWaJmtwZikJBokiia/zDpwyZr7khG+xqZGkk7ImZD9UM1tqlS8tPraGmEnIamM
         WHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cy8BeFSyyxwCJlrN4qHH8AR4EXYnev9cLyrShu/UrkQ=;
        b=W9ihDxjV/nDgXfjm+Kbaaf4tq2hUhPXqRy7GdmcfUeq8JlHOOJHWin5MxE52iIPEjW
         9PJ3hR6qZNPGA4+oWrmsn+V5f0+zeePQCeKHlRGa+TVhq8IGGn3joqI7xR9RFyGrskke
         c+zekes6gPnXH8QYcqMh4gfD5MttzyBWVwpvwWG+nWCZZNPb0y6JSDcRAkSpGmRLT+Io
         Lg7FWi2ZGjJAeTQyPyxIBZv9FMN0n3ZFcvWitgSHaeRlaiWl3zv6reK0Fgm6aWzf+qBS
         wvHguyO4zPlJh2kvi/oUhwKx+iBvluxO0OyVzZpa5+8XwMtl8MACB9idBhpFScT/HPhj
         VuMQ==
X-Gm-Message-State: APjAAAXPYW1AZlFKYRFMgCb40paAMYxGAGycBtn9iqlATBTNbkDIBLjZ
        Gj+5jwfV/M7a+L9xN6zjzso=
X-Google-Smtp-Source: APXvYqw/V5JLWLvUR93P5+Lb2v8QiSrmRjA9KV1rVw9muLj69o9nmSCWZTmtDbJFGQj4P8XZwTRQ3Q==
X-Received: by 2002:adf:ec44:: with SMTP id w4mr14678602wrn.251.1569078763876;
        Sat, 21 Sep 2019 08:12:43 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id y186sm10712491wmb.41.2019.09.21.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:12:43 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/5] provide the XTAL clock via OF on Meson8/8b/8m2
Date:   Sat, 21 Sep 2019 17:12:18 +0200
Message-Id: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far the HHI clock controller has been providing the XTAL clock on
Amlogic Meson8/Meson8b/Meson8m2 SoCs.
This is not correct because the XTAL is actually a crystal on the
boards and the SoC has a dedicated input for it.

This updates the dt-bindings of the HHI clock controller and defines
a fixed-clock in meson.dtsi (along with switching everything over to
use this clock).
The clock driver needs three updates to use this:
- patch #2 uses clk_hw_set_parent in the CPU clock notifier. This drops
  the explicit reference to CLKID_XTAL while at the same time making
  the code much easier (thanks to Neil for providing this new method
  as part of the G12A CPU clock bringup!)
- patch #3 ensures that the clock driver doesn't rely on it's internal
  XTAL clock while not losing support for older .dtbs that don't have
  the XTAL clock input yet
- with patch #4 the clock controller's own XTAL clock is not registered
  anymore when a clock input is provided via OF

This series is a functional no-op. It's main goal is to better represent
how the actual hardware looks like.


Martin Blumenstingl (5):
  dt-bindings: clock: meson8b: add the clock inputs
  clk: meson: meson8b: use clk_hw_set_parent in the CPU clock notifier
  clk: meson: meson8b: change references to the XTAL clock to use the
    name
  clk: meson: meson8b: don't register the XTAL clock when provided via
    OF
  ARM: dts: meson: provide the XTAL clock using a fixed-clock

 .../bindings/clock/amlogic,meson8b-clkc.txt   |   5 +
 arch/arm/boot/dts/meson.dtsi                  |   7 ++
 arch/arm/boot/dts/meson6.dtsi                 |   7 --
 arch/arm/boot/dts/meson8.dtsi                 |  15 +--
 arch/arm/boot/dts/meson8b-ec100.dts           |   2 +-
 arch/arm/boot/dts/meson8b-mxq.dts             |   2 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts        |   2 +-
 arch/arm/boot/dts/meson8b.dtsi                |  15 +--
 drivers/clk/meson/meson8b.c                   | 106 +++++++++---------
 9 files changed, 87 insertions(+), 74 deletions(-)

-- 
2.23.0

