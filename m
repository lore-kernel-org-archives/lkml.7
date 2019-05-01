Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C7DC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AE621670
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFCSk0Aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEAJuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 05:50:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46034 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAJuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:50:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so8384413pfi.12;
        Wed, 01 May 2019 02:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vq6ABJrMXgL3b8vmrge6PuZWxawVLWLQA8qwraJhwLw=;
        b=vFCSk0Aabd+dZ+UacJfzyAb3TVGzqtMgoAE2/70GrZ8EkkRZIzU4sgccK4In1h2J09
         UEIkhBac8sDW/m1dH7xUEuvwRCkVOk1qpB9aC13WslidfzVpsbde/uyGdkKCwRpoCfdY
         F2yHs082PazgXcizsNqAXEKLdGyYKJ9Y5oKLsSi7vZpEfHkSA0UlpVOg+Ed/MA7Xbn0p
         H5VGY6wl2oiUsnn46OdB/Y45hwRx+yOfLyn1UQRxgeAtunJF2vatL1Kb2MAAJAu/f07W
         /pxk9YwsAmDFrH88f5F+KDU4FDnuCFsvgcZIIPXSaLrYXYCWvb6DRng2570JD3F/U4np
         mS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vq6ABJrMXgL3b8vmrge6PuZWxawVLWLQA8qwraJhwLw=;
        b=EGr6a/Zemw7HI4ZTL5CmDfc2s/fTx/ekZKpoTVSIqAHjANoqqwbenNMA4NE/8+p9we
         +3c+7K0uZ2ZS6M7kLHTHw+gVAT4KRyXwyATeEBFqwsgBEwhKLK40edM9kaTw+Pjvcr5K
         /Kr63LHdB1Uh/HpL697FE1yzgru3Fkvx7XnYf/jf+E9+IauiGTK+0dsISfCOQD11q+1V
         pACgybe3gXHUfdVMC3Wg3HnrPG48XuuUqW5nlwiLk5ls8sqNwHPcDFzKem6wswrNY7hv
         ERIaAAzZCmwMn6qTHTGe8Nc8lSHhBV96txKHCkVUejpR+FH0dDeQvDD6UXgGBcrzgAHn
         vltA==
X-Gm-Message-State: APjAAAVjs5Zu3+tlTeqyCcp4PxM3eti+kJ4UYNqr39jpU0NMwS7bcArT
        +4NTFADRh2CQutvzlIfqg68=
X-Google-Smtp-Source: APXvYqztY9Lbt6YDhUTEMhvIf/V9nOYDHOePZOYfNXr48KcsqL8AgA4CqySLyw05cbKNOyrdsg6J9A==
X-Received: by 2002:a63:3284:: with SMTP id y126mr73331208pgy.424.1556704220128;
        Wed, 01 May 2019 02:50:20 -0700 (PDT)
Received: from nishad ([106.51.235.3])
        by smtp.gmail.com with ESMTPSA id o15sm17048688pgb.85.2019.05.01.02.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 02:50:19 -0700 (PDT)
Date:   Wed, 1 May 2019 15:20:12 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: Use the correct style for SPDX License
 Identifier
Message-ID: <20190501095008.GA9120@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header files related to Clock Drivers for Allwinner SoCs.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.h     | 2 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.h b/drivers/clk/sunxi-ng/ccu-sun50i-h6.h
index 2ccfe4428260..9406f9a6a8aa 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.h
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2016 Icenowy Zheng <icenowy@aosc.io>
  */
diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
index 39d06fed55b2..b22484f1bb9a 100644
--- a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
+++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright 2017 Icenowy Zheng <icenowy@aosc.io>
  *
  */
-- 
2.17.1

