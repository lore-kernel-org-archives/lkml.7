Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2B4C32754
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C537206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jFO4SD/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfGaIk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:40:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39154 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfGaIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:40:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so15530383wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 01:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ddHyvYdReNbGhKO21uVEIvjorbfyA05g6IvzqrFwjMw=;
        b=jFO4SD/NApA8ipcldRSPtR96lDawCCqLtYXq++TEknbVxxDnZL3JrR85VsU33TrR0Q
         sr6bkOPmj8k3cMMWIHyHo1kEl5r7ZFWAqMXMNfV/lDvgwulIf7nvctpQX9u+9Rb13PY0
         RZPyJ+ytGSRsViVrMFJ0X3Vexgi+QVC/pfzBwlYbXCKrIyOyjqPZko61A3XLprZUWpZB
         TM9sf75PWS3HJhkfPNNDCZP267DP7mKOF9E2vu09UiUP+zhYmUvhIGGDI7AM1bVuj7gk
         PcoSHXA4zEhPTmpxcj/RDgR9Ax7fmDC+fYU93RMl+O+5kIFSyeSDweCKMigFWdo4k82w
         yoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ddHyvYdReNbGhKO21uVEIvjorbfyA05g6IvzqrFwjMw=;
        b=Es8NtjxS3kmVaOz+ZnFFY1qpUHTjneCj5y8wt2YfH/6VqUvc5c/33DqxeTvKts0N0L
         4GND3jNOzFudEQz/dUkHvRClB3xzTy8K6VIc1mv9pf8Xy4KXuFeRcfN/wRqr6Fy5JQaS
         C8OkuBcsQ8Ct04MywK+QAgqEaF/rT1GQcUkffl/jdcY11koscrKuB3CXJsSbOfDxH/lx
         P5p0I326Cbt971v4EFiB1f+FrTXpWZQ+fvbIFNlw/BTzG+VeZJnlI087xlZ9WAjrnRBb
         KfNIRQ/SlAbW4maZWAEdCQnRuWvBvekazbhn8x5YtoPh7Xs3xj11v0qcgaZ1oy9kfhhA
         0tFQ==
X-Gm-Message-State: APjAAAXPPeED/+u62ZuykKd0/8RXX2+SAp+9krIC2fagL3yaw8/TmQn4
        SVgr1UEj8AN77/tlbY5L3o/FFg==
X-Google-Smtp-Source: APXvYqwHQz/DoxpqjB2gG7yElbPFxVQmLqhP/9pw+D/cpuZHA0yH1P4HyL+uxk4zqqNoXxyZE1dsUA==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr52426973wru.27.1564562422857;
        Wed, 31 Jul 2019 01:40:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 18sm56049308wmg.43.2019.07.31.01.40.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 01:40:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     sboyd@kernel.org, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] clk: meson: g12a: add support for DVFS
Date:   Wed, 31 Jul 2019 10:40:15 +0200
Message-Id: <20190731084019.8451-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The G12A/G12B Socs embeds a specific clock tree for each CPU cluster :
cpu_clk / cpub_clk
|   \- cpu_clk_dyn
|      |  \- cpu_clk_premux0
|      |        |- cpu_clk_postmux0
|      |        |    |- cpu_clk_dyn0_div
|      |        |    \- xtal/fclk_div2/fclk_div3
|      |        \- xtal/fclk_div2/fclk_div3
|      \- cpu_clk_premux1
|            |- cpu_clk_postmux1
|            |    |- cpu_clk_dyn1_div
|            |    \- xtal/fclk_div2/fclk_div3
|            \- xtal/fclk_div2/fclk_div3
\ sys_pll / sys1_pll

This patchset adds notifiers on cpu_clk / cpub_clk, cpu_clk_dyn,
cpu_clk_premux0 and sys_pll / sys1_pll to permit change frequency of
the CPU clock in a safe way as recommended by the vendor Documentation
and reference code.

This patchset :
- introduces needed core and meson clk changes
- adds the clock notifiers

Dependencies:
- None

This patchset is split from the v3 RFC/RFC patchset at [3]

Changes from v1 at [4]:
- Removed export of regmap_div ops functions
- Added standalone cpu dynamic divider driver
- Uses cpu dynamic divider driver in g12a clkc driver
- Added missing signed-off tags
- Fixed missing removal of CLKID_CPUB_CLK from internal g12a.h

Changes from RFT/RFC v3 at [3]:
- Rebased on clk-meson v5.4/drivers tree with Alexandre's patches
- Removed the eeclk setup() callback, moved to a toplevel g12a-data struct

Changes since RFT/RFC v2 at [2]:
- Rebased on clk-meson v5.3/drivers trees
- added Kevin's review tags

Changes since RFT/RFC v1 at [1]:
- Added EXPORT_SYMBOL_GPL() to clk_hw_set_parent
- Added missing static to g12b_cpub_clk_mux0_div_ops and g12a_cpu_clk_mux_nb
- Simplified g12a_cpu_clk_mux_notifier_cb() without switch/case
- Fixed typo in "this the current path" in g12a.c
- Fixed various checkpatch errors

[1] https://patchwork.kernel.org/cover/11006929/
[2] https://patchwork.kernel.org/cover/11017273/
[3] https://patchwork.kernel.org/cover/11025309/
[4] https://patchwork.kernel.org/cover/11063803/

Neil Armstrong (4):
  clk: core: introduce clk_hw_set_parent()
  clk: meson: add g12a cpu dynamic divider driver
  clk: meson: g12a: add notifiers to handle cpu clock change
  clk: meson: g12a: expose CPUB clock ID for G12B

 drivers/clk/clk.c                     |   6 +
 drivers/clk/meson/Kconfig             |   5 +
 drivers/clk/meson/Makefile            |   1 +
 drivers/clk/meson/clk-cpu-dyndiv.c    |  73 ++++
 drivers/clk/meson/clk-cpu-dyndiv.h    |  20 +
 drivers/clk/meson/g12a.c              | 535 +++++++++++++++++++++++---
 drivers/clk/meson/g12a.h              |   1 -
 include/dt-bindings/clock/g12a-clkc.h |   1 +
 include/linux/clk-provider.h          |   1 +
 9 files changed, 588 insertions(+), 55 deletions(-)
 create mode 100644 drivers/clk/meson/clk-cpu-dyndiv.c
 create mode 100644 drivers/clk/meson/clk-cpu-dyndiv.h

-- 
2.22.0

