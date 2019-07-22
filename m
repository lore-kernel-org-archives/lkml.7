Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AB8C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDB62199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nHHruWm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfGVJvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:51:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43284 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfGVJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:51:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so38667654wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bWP5xS/4YYzdQVyLQ3+texqZ8kAemNHSwaQHX5jsQwQ=;
        b=nHHruWm11yckWxNykJfOsz9XcXvSNUyeaA7NSVCJWFqG9us6WcySaPabt7WprIsSUR
         wP9dWNuHAhwiU91FTYXvRMDCopEmn1534xz5aLuB7yd/AaZZUlse3dknne1Y++W7Q4iu
         hMDxPdDMlCisFkNrrgkVS9FdiwRBJ4ispJGxHc5GYJKotyiDkL3PF32gZ8OGntUkjZjx
         YN+yzZa/akUwMmGOtCPqBcQLNFeUW1hbFi4gwgFHns88vo1oQzKHvgL1iCvzuEaTBoIi
         kijywq1IvG3ywooo4YsmAt9jQi7ZRc+zqt1bAzCqxVAyr+uMSXlgZ6OVSDuZ9fsEX1DL
         qShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bWP5xS/4YYzdQVyLQ3+texqZ8kAemNHSwaQHX5jsQwQ=;
        b=EmWCSG2vgb+N1NbUagVant29Zv7caXZr0ZrxcH4Po5r/0t9mjbuSqmU0Tf73IFMNt6
         Zydn1QGVFzYSnpH1uin5qQeP0Axicvece8qp+tS0fYGWg0G5HRxoXSFzvsKx6/LFnoFE
         WKZ3SH/CV+NqxU8yUF7FGRrIkXfh7sAP29BknQagghxme5MiZAoKMYkvawAwtE/YdQ2R
         fbnrClpKoVPmyt7ITDf0sczXam22xw3pN5wqpYG56ipry1OtfC1MwLteqa+p5IBlyMUw
         JP50BTWGUq7W4QCuwX9JfNSbxtirLR3U1Ox6qSKzICgLgcKZxXyNNdbR+26iBv+OB7VX
         b7BQ==
X-Gm-Message-State: APjAAAV+hfwNRdRIwqf0E2fjGoiF17lVd3l8rFgCLU5Dp9reFE/qYBg2
        GShe+T4jzWgc+8cbJ8H4i+Uryg==
X-Google-Smtp-Source: APXvYqy1nKso+GnHov2Vamg3HX7qKDmtTy9gNOQdWWtffkvp3JgGap0R3bk+1lQNEs186TKMf9sKBQ==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr73312101wre.205.1563789060893;
        Mon, 22 Jul 2019 02:51:00 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o3sm31050738wrs.59.2019.07.22.02.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 02:51:00 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 0/4] clk: meson: ao: use the new parent description method
Date:   Mon, 22 Jul 2019 11:50:49 +0200
Message-Id: <20190722095053.14104-1-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson SoCs clock controllers use the string comparison method to describe
parent relation between the clocks, which is not optimized.

Its also use bypass clock made from device-tree clock to provide an input
clock which can be access through global name, but it still not optimal.

A recent patch [0] allows parents to be directly specified with
device-tree clock name or without string names from localy declared clocks.

This patchset replaces clock string names by clock pointers (as possible),
removes bypass clocks and uses directly device-tree clock names in parent
assignment.

Tested on GXL, GXBB, Meson8b, AXG SoCs by comparing the clock summary
(orphan too) before and after migration.

[0] commit fc0c209c147f ("clk: Allow parents to be specified without string names")

Alexandre Mergnat (4):
  clk: meson: g12a-aoclk: migrate to the new parent description method
  clk: meson: gxbb-aoclk: migrate to the new parent description method
  clk: meson: axg-aoclk: migrate to the new parent description method
  clk: meson: remove ao input bypass clocks

 drivers/clk/meson/Kconfig       |  1 -
 drivers/clk/meson/axg-aoclk.c   | 63 ++++++++++++++-----------
 drivers/clk/meson/g12a-aoclk.c  | 81 ++++++++++++++++++++-------------
 drivers/clk/meson/gxbb-aoclk.c  | 55 +++++++++++-----------
 drivers/clk/meson/meson-aoclk.c | 37 ---------------
 drivers/clk/meson/meson-aoclk.h |  8 ----
 6 files changed, 114 insertions(+), 131 deletions(-)

-- 
2.17.1

