Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358A4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008C120843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="w2KEZVK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfDWJCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:02:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55254 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfDWJCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:02:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so17619757wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyL5ADK3nwxHUDhFNjCi37nI3TDxQUy8c72Bnz6n+18=;
        b=w2KEZVK+BwdjPFCdgjID66L2FGqc2zRlZxbbfLTRwYH84oFyER2j8p1qEdsnV/7gNY
         Wz9HkOorsiTL7+3/rlUBp0rXnNzeU93Y6gDIkKeXIoPjAB6wqwiY1AemP0u+myYSRAu7
         YDRbQdykDawAHuJ9i5pvkN5l9Yv5Ul2nQFDLfn7j6FuQhrNgykwHKpWAw4dOxnGhUhxR
         33z3DGvp52l3QG1UABb/mk+auSj5kqGqsXwZ5yLtT6+WEFmZVAi3EnAPHDR0EVgiB1pW
         GpZNwS1ryg8x/EHFkzdxGidIfCWoW02Y2b+dRSSVpGz63auqJq0geYcqDOLT049czoKz
         /YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyL5ADK3nwxHUDhFNjCi37nI3TDxQUy8c72Bnz6n+18=;
        b=mX47a0MbHUbF5wNaglNKvk+kCcyA23F6dG7JSMLMVcd7Jj9rNtWiKGqh7FtonjQgBP
         +FczwK7JCrv5saG6wUa/B+AbGSnOzAJpRaCDB5E6GBSlzHdBGL4SybeKsbwcqb3J04ID
         j/v40HKvRE8EXD9HyYM+y0gLu3uo7eUQAEjQ6Z4y5HWz8cWml3ZgX+KyvVl/VGtQq3JI
         fhCjFN1T75AB7/3js3xyNNzbH8fendjiFF6Mj4gfsg5sSnDWHI+vothal+fWiGgf5EMd
         C9BibFVcuwnFHNEuE9qbnx4rXGQWdrokjKo7rEg7qB+uX4sQgSkb5wL9VddkT+JS6mo3
         tPBw==
X-Gm-Message-State: APjAAAXT+F1dRZ6u9Xvw/Nyu5A/QJdVL13hr/qpPwxVA3tl5XnzzLwz6
        SZSjkWxV+Cwr986TL9mpdfjMbw==
X-Google-Smtp-Source: APXvYqzOWXJEFc087s1D7PMjjtkb1ZCYkDnO529wjOgLfT+0GLZElRaqiz0ubFu7jY3QZRZV7MlqwQ==
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr1535558wml.74.1556010164784;
        Tue, 23 Apr 2019 02:02:44 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z23sm12361894wma.0.2019.04.23.02.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 02:02:43 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] mmc: meson-gx: clean up and tuning update
Date:   Tue, 23 Apr 2019 11:02:28 +0200
Message-Id: <20190423090235.17244-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is too improve reliability of the amlogic mmc
driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)

* The 3 first patches are just harmless clean ups.
* Patch 4 makes sure HS400 can't be enabled, we still have not been able
  to crack this modes.
* Patch 5 removes some clock glitches when switching to DDR modes
* Patch 6 and 7 changes the tuning method from Rx phase to signal
  resampling. It could have been done in a single patch but the unified
  diff was extremely ugly. The change has been split in two patches to
  ease review.

The last tuning update that went through was meant to improve the axg
support. Since then, it was reported to break some other boards, like the
s912 vim2.

Also with the current tuning method, it was impossible to find phase
settings which would work on all the SoCs, including the new ones.

After redoing all the tests from scratch, it appeared that Rx phase made
(strangely) almost no difference, especially on g12a and axg. However, it
showed that it is important to have a phase shift between the Core and Tx
clock, 180 works best.

I discussed the test results with Amlogic. They suggested to use 180/0 or
0/180 for the Core and Tx phase. For tuning, they suggested to use
signal resampling.

So far, so good ... here the platform and modes tested:

NanoPi-K2 (S905): SD UHS SDR50/DDR50, SDIO HS
Odroid-C2 (S905): SD UHS SDR50/DDR50, eMMC DDR52/HS200 (16GB module)
Khadas Vim (S905X): SD HS, SDIO HS, eMMC HS200
Libretech CC (S905X): SD HS, eMMC HS200
Khadas Vim2 (S912): SD HS, SDIO HS, eMMC HS200
S400 (A113D): SDIO UHS SDR104, eMMC DDR52/HS200
U200 (S905D2): SD HS, eMMC DDR52/HS200
SEI510 (S905X2): SD HS, eMMC DDR52/HS200

Changes since v1 [0]:
* Add missing writel in patch 5 (error when switching width)
* Change patch 3 commit description

[0]: https://lkml.kernel.org/r/20190417204355.469-1-jbrunet@baylibre.com

Jerome Brunet (7):
  mmc: meson-gx: remove open coded read with timeout
  mmc: meson-gx: ack only raised irq
  mmc: meson-gx: correct irq flag
  mmc: meson-gx: disable HS400
  mmc: meson-gx: avoid clock glitch when switching to DDR modes
  mmc: meson-gx: remove Rx phase tuning
  mmc: meson-gx: add signal resampling tuning

 drivers/mmc/host/meson-gx-mmc.c | 419 +++++++++-----------------------
 1 file changed, 114 insertions(+), 305 deletions(-)

-- 
2.20.1

