Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5050BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A1F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CvQ+w7ba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfCSVwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:52:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39990 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfCSVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:52:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so511535wri.7;
        Tue, 19 Mar 2019 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ceCKFAiifM4URXix3mWG4CFxvV6hD9gyANT0DrHC0ek=;
        b=CvQ+w7baEAeYUe8mvYxM4uTyTZK/DnDgQ7dHqe0HCRFZboDe1gySN4JjXObLPkJ8Sf
         cUCY4MwyC3cqhQuLgrfXZGZw2C1M69QREPksKvDemXxFPDdRJNZ8ASNhY/NV3sIDG6VY
         yxUzDCEqMoeQ5qPKN6p/7nUFETgE8G8EygM5THk3WOFr7p9Uyin7z0czcN1imUhQOW78
         SDOvvduzyjtlmiUBeLf9MbX4migdhwng777A/Zcv+905/5Goz3k2spIeev0ZHH8i5PvF
         btHrRH4IzyXgluFiAG0Cgd8lhsUKTGpe+6P8Ysiq5UKTp+wLAeh8k67cZVF/FAwuGqaT
         tDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ceCKFAiifM4URXix3mWG4CFxvV6hD9gyANT0DrHC0ek=;
        b=sFrQqWLfm5OyjQHEOaCAJkHFt7wYh2kQ/GMFGMpJrAGYnfEOichaKvPHM0AMgWnTUq
         aKQI7fMFlYJenZ0I9fWthsrM/xVlYbLwGgNpGwNhzg2mcTXQINF1Pcjb7gdKa9dxtVkA
         Zv337UwjU0nJy1JP4+YQMiyM+Yegu2P8iswd7PujwdVJB+KWP+otvir7ZBDxLDFl+SfW
         KyIfQfcPGPNFVQ1NCiimEp6THwp6FuWo/6hVdtYQPb2oiDY0BdTV9jlRz8jn3EP8UHvx
         SHMTpWfGJfBJ3d95zasOu40ZgSHwt3TiTCP9eAbGxOPekV+GvMpZXHA8dAuaaJH/5T5t
         u7Rg==
X-Gm-Message-State: APjAAAVz+FH3K/UXluUFAPIikTW0bDihtdocNtao/Egd/tSQD7XcUTK3
        73/Bo3PPVHbd05gg/Pyem8mDrJmt
X-Google-Smtp-Source: APXvYqzIVqXbjloTFfhiIXnXahqeCO+0TjGgv+9rsMdLbjXkhlmcvZzVriWM5csKorfWlOgnjwuEvQ==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr18393828wrn.288.1553032320612;
        Tue, 19 Mar 2019 14:52:00 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD739990039EE738515149D3E.dip0.t-ipconnect.de. [2003:dc:d739:9900:39ee:7385:1514:9d3e])
        by smtp.googlemail.com with ESMTPSA id c8sm56050wrx.6.2019.03.19.14.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 14:51:59 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/4] clk: meson8b: add the VPU clock tree
Date:   Tue, 19 Mar 2019 22:51:17 +0100
Message-Id: <20190319215121.29340-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the VPU clock tree for Meson8, Meson8b and Meson8m2.
The VPU clock tree is slightly different on all three SoCs. The details
are explained in patch #4.

Meson8m2 requires the previously unsupported "gp_pll" PLL. This PLL only
exists on Meson8m2 - Meson8 and Meson8b don't have it.
A separate clk_hw_onecell_data is introduced for Meson8m2 (using the
compatible string which is already available) to account for this SoC
specific clock setup.

dependencies:
This series is meant to be applied on top of my other patch from [0]:
  dt-bindings: clock: meson8b: drop the "ABP" clock definition


[0] https://patchwork.kernel.org/patch/10860387/


Martin Blumenstingl (4):
  dt-bindings: clock: meson8b: export the VPU clock
  clk: meson: meson8b: use a sparate clock table for Meson8m2
  clk: meson: meson8b: add support for the GP_PLL clock on Meson8m2
  clk: meson: meson8b: add the VPU clock trees

 drivers/clk/meson/meson8b.c              | 422 ++++++++++++++++++++++-
 drivers/clk/meson/meson8b.h              |  12 +-
 include/dt-bindings/clock/meson8b-clkc.h |   1 +
 3 files changed, 433 insertions(+), 2 deletions(-)

-- 
2.21.0

