Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6700AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3607A2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rerU53LB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfCAKVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:21:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33307 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCAKVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:21:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so25299086wrw.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 02:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nElNlZouH94P7AzbldSSkfrMGRqzf/hdHWeWWp+K708=;
        b=rerU53LB+TkcD5/bPTwLLiFoMmhLcFeVnndc42pJ0NWBmToOLFtLS/tnCDlQmH+Y9R
         ksKXPxoVgTlFyDn1dmnrS/kFic/RzvaV7GkgsvQFq8oxiM6YZ1Zwl6dcLUYikGPYnRMQ
         10oUuzX2KwiF16h7HnDAJ0d9yOY+hFr4j//S4Ha2OCyhRfoGO2rRnUUHQxERd1qXKcyy
         31EsFt2sprzGd9tUGbK4FleihZuiQ3aOWxYDhVKtzF9VSszx/MdzdkBIqh2lTte7By6b
         J3v34v5H/1unr1tVMOkarugBFLXGgBa919Ga+Mie3r00Dspxl0rXAnTAfydtyO31jriN
         O3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nElNlZouH94P7AzbldSSkfrMGRqzf/hdHWeWWp+K708=;
        b=H/BYaBmxChjc0Y6gt5DXtP2+bJPqra9bTb9wIT4vrL98Oo94UNPcRBRVmgI/Qs5hHZ
         6J0w1KwOhk/oQXrjkpvEroddkaTT2XTWXBoNLyvmMyZyM8AXYwhyjxWNRTDvS/cvXBZU
         HoopCagTJF2Yp8RNoWqZGzj0JDI6sM1hcOW5Z5fZo/ZSZi2fsi2XdnTVZORLFEZJLmZl
         aKkLA9z0QKKZHoah773m94MJuc2UpHuCMatBgjeBc3/uZ2JxUTaaDlFH1H4h/u4d9urH
         JJE1E9MWOPLfqcAOx8C6O4pShBzkg92kFbVPOoGRw10ulSH+eH0jxJo65+FcxfcvgI8J
         fpsQ==
X-Gm-Message-State: APjAAAWYKmM8WD0/Vu9wYYlz/E9IUgS7x7LZzCCB5zPWxAH+pRKFuuUO
        jqlb/M3++irkRg9WcqOFAsi6lQ==
X-Google-Smtp-Source: APXvYqxVgA392/3bl96BZwxC06Jd03FyoK+trN1mSRPNpZREOoGPzRYIAOWBJAbug1sMtRKNd6rkTA==
X-Received: by 2002:adf:c752:: with SMTP id b18mr2846977wrh.105.1551435704134;
        Fri, 01 Mar 2019 02:21:44 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f68sm14446626wmg.5.2019.03.01.02.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Mar 2019 02:21:43 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clk: meson: g12a: Add CPU Clock support
Date:   Fri,  1 Mar 2019 11:21:38 +0100
Message-Id: <20190301102140.7181-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the clock tree feeding the 4xCortex A53
cpu cluster.

This patchet does not handle clock changing, this will be added in a
secondary patchset.

The CPU clock can either use the SYS_PLL for > 1GHz frequencies or
use a couple of div+mux from 1GHz/667MHz/24MHz source with 2 non-glitch
muxes.

The CPU clock must be switched to a safe clock while changing the clocks
before the non-glitch muxes. Proper support will be added later.

In this patchset, clocks are set read-only.

Neil Armstrong (2):
  clk: meson-g12a: add cpu clock bindings
  clk: meson: g12a: add cpu clocks

 drivers/clk/meson/g12a.c              | 348 ++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |  25 +-
 include/dt-bindings/clock/g12a-clkc.h |   1 +
 3 files changed, 373 insertions(+), 1 deletion(-)

-- 
2.20.1

