Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B8FC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421B5217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XljQDyAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDIUr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:47:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33498 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfDIUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:47:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so96170pgh.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4AxUe5BjFjvYjkfSjcTE2lgIYaizWHbT0gUVT2RB9Q=;
        b=XljQDyAyembEd8Lrph1XKfDzoQCfmhtOZHTOgi0Zpc2fCv0MzbLGqFpvNi8GtOecrj
         LQoKgVnH/IekdTg8RPGMRkGH76wnXEKYcyAIjGgzQUYjomMUY8HOcEPf1x0Wka20zvZn
         vigSn6uspOtwOFJ5Ya2UPl1X4FpSAaNWhCyvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4AxUe5BjFjvYjkfSjcTE2lgIYaizWHbT0gUVT2RB9Q=;
        b=dl5aT180C04FAnXYjhmVjEu5i5qlJ9OC0DZYJ/TKoFsV4IBqCFhIZSFf2aOxgenHeA
         ZuwemQTcw188oDgs/r98Ie37gF9ZPb7+2J2zsJml63Qrd4bZIVq6m6zokuoO9pLXsDOg
         TYxsIkWibDjGeyolQLV7c6KwUhp1T+ZCQWBz4qoVZSYtcRXlhwXCoN8oa7ucbPC+KUaV
         9PWsxlcDYffMS6ZtBH/K31x/mtikwEghXneaDu6UU9DtLoKhYL0NWDxdAuO9W9fCebPW
         BJ9trQTpjms4mNXnCkGKkoTMLG6q5ujBQfZuyM90UuKIVqrAH9nYOAECv3FKAQf9PTgI
         WTSA==
X-Gm-Message-State: APjAAAUo2MzgS7tZ5K1PD7ZvXy6izFQXOI2teFDwWtDJ3sv3C1GjE3ty
        RsNJ+i/vdZbvSH0sk9UYp2hGyA==
X-Google-Smtp-Source: APXvYqzC7ww/OYSAGpxDprLV20WG2ANh+jaUa303EaKd2qLxOQjVuAA6nPilvXjv+Jlz0nIZqRMSbw==
X-Received: by 2002:a63:c61:: with SMTP id 33mr33925892pgm.293.1554842847481;
        Tue, 09 Apr 2019 13:47:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x28sm35014016pgl.38.2019.04.09.13.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 13:47:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caesar Wang <caesar.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, mka@chromium.org,
        ryandcase@chromium.org, Elaine Zhang <zhangqing@rock-chips.com>,
        linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] rockchip: A few clock cleanups for rk3288
Date:   Tue,  9 Apr 2019 13:47:04 -0700
Message-Id: <20190409204707.150347-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series contains a few misc clock cleanups for Rockchip rk3288
found by comparing to what's in the downstream Chrome OS 3.14 kernel.

NOTES:
* The PWM patches could go in separately from the revert but that
  would cause a merge conflict which is why they're together in a
  series.
* Having the PWM marked as a critical clock _definitely_ needs to land
  before switching the clock in the device tree.


Caesar Wang (1):
  ARM: dts: rockchip: fix PWM clock found on RK3288 Socs

Douglas Anderson (2):
  Revert "clk: rockchip: mark noc and some special clk as critical on
    rk3288"
  clk: rockchip: Make rkpwm a critical clock on rk3288

 arch/arm/boot/dts/rk3288.dtsi     |  8 ++++----
 drivers/clk/rockchip/clk-rk3288.c | 17 ++++++-----------
 2 files changed, 10 insertions(+), 15 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

