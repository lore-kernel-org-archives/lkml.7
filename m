Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2255020863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZXW58RQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbfCYLMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:12:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36122 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfCYLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:12:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so8590783wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zq6vRTetM545SboMg3VjgwSgsS+YSQUJaE3MlRK8tIs=;
        b=ZXW58RQonAOpYLFTCrrCFYUt+m+W7pyrOmzvKP1t1j8CQ3BFbne7+d20B0eFhLrlu9
         Wjt+WJVIRmAkgmJxIqmUd8aU5WqI30LH425b6F3e6SoKZLUd+Qi7ASmeA3Daujs2sQ1T
         jzx4ASkf3xJlmrx2nk785v71K4ujbne7Gug4Pp1s8gJayjFB/XlHQXC2apqRUkYtNAam
         k0lr2BX5CDDWq7qaeM6v0COAc/1u1EMGORhSq/1Ytw9Ma7/OClT6Gs7lAvmIJkwX8mEZ
         V7HatMdxobGvN4XU6G2rd+Yh4guUBtIutyhX+7+gW1kZdYod2+YsYAeGVQ87XgVKbMZA
         W+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zq6vRTetM545SboMg3VjgwSgsS+YSQUJaE3MlRK8tIs=;
        b=hH/iNUt1rLC/ZPr/+4Qv18kwaj+DESDzI574rq4qM+qWHO7oxMxaEctgTBCFzaDliG
         oFI7nj4wRrwKX4lVuifxyKSrrn/hdDYVpN5c7FXoRsQAT08LXBE+MLXjkbe8ZNxoJWYY
         oHLQC+BWJKDVj0c4cTWwVVdOTrzpDfyvJGqd1EXO7cXJCsi22zG6jln0Mm1vmtUOICVr
         9o9UuD0OeagbHpiNUARkOGqctKS5D2iACJt7j+5ARGhAISAD3l/8BewIkoBjVGYUV3yE
         KMhJI567LIXq4rnXhrSIy+f/7EQbcGruXUIHjbqRsKurIs5405f8zYgaXf9v4FXwPJbx
         fD7w==
X-Gm-Message-State: APjAAAXDUX3PMzAEFIZ3BI7kPQvjRvt7B0KYJ4exHbtXKmiOnYGwinnZ
        sv8Zu5kC6h2U9r4G8k1ajOwiGg==
X-Google-Smtp-Source: APXvYqziK48dM7HzQKX85ubGKmdqo9qHPboyMRSgNdub+Iyl+dklAkVTb7jz8nfm8D1YbcH+pwraww==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr11048100wmb.22.1553512328021;
        Mon, 25 Mar 2019 04:12:08 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id n188sm15134301wme.13.2019.03.25.04.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 04:12:07 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] clk: meson: fixup g12a mpll
Date:   Mon, 25 Mar 2019 12:11:56 +0100
Message-Id: <20190325111200.15940-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the g12a support has been initially submitted, the MPLL appeared
(overall) fine. At the time, the board I used was falshed with amlogic
vendor u-boot. Since then, I moved to an early version on mainline
u-boot.

While debugging audio support, I noticed that MPLL based clocks were way
above target. It appeared the fractional part of the divider was not
working.

To work properly, the MPLLs each needs an initial setting in addition to
a common one. No one likes those register sequences but sometimes, like
here for PLL clocks, there is no way around it.

The series adds the possibility to set initial register sequence for the
ee clock controller and the MPLL driver. It is then used to enable the
fractional part of the g12a MPLL.

With this series applied, the fractional part works again but we are still
seeing a significant clock jitter (+/- 1,6% for 294912KHz). Discussion
are ongoing to explain and, hopefully, solve this as well.

Jerome Brunet (4):
  clk: meson: mpll: add init callback and regs
  clk: meson: g12a: add mpll register init sequences
  clk: meson: eeclk: add init regs
  clk: meson: g12a: add controller register init

 drivers/clk/meson/clk-mpll.c    | 33 +++++++++++++++++++++++----------
 drivers/clk/meson/clk-mpll.h    |  2 ++
 drivers/clk/meson/g12a.c        | 32 +++++++++++++++++++++++++++++++-
 drivers/clk/meson/meson-eeclk.c |  3 +++
 drivers/clk/meson/meson-eeclk.h |  2 ++
 5 files changed, 61 insertions(+), 11 deletions(-)

-- 
2.20.1

