Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9CAC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7353320740
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QLF0FvhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfKQOAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 09:00:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42260 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfKQN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 08:59:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so16353414wrf.9;
        Sun, 17 Nov 2019 05:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05nE8+MHUGvDlOaHhFyY9hdfqx0IM0OvamCE7zybe74=;
        b=QLF0FvhZwFM+TBA7bz7hdl9LccI8q8cq5MvI1/15MaGDEIUxrPD03tnnFu9KImUmEj
         nSgwq80iTIDuKY+REyNzrYNtVd7Gm0GGeaYElnqlfeSfRB0hkL+p4tnfvyazduMrcTQx
         GFBV8yLqoovy5YzpuW47Yj8vkVQecKQyGvYbxTW8A8hJlW6DXJSPFBQ5Ku6reF8V7BuA
         w7LsBg/EUzcFYu8S3UCVcqDkviYcsJnlvx+/peBk4Szgq6YmXbD9rmqFh9NrsNDZ4uQs
         jYMx43vrlBQtiUECnbsW0PzNnnMdPXWXF+F+k/+XOs/VHHhtowFvWkkxhBfFEChhGmWT
         RTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05nE8+MHUGvDlOaHhFyY9hdfqx0IM0OvamCE7zybe74=;
        b=R0RMZqpBZKeefscyp05+4j9uuYFx+iEwT1eWGp0126qCjJT4x0WRQQD3kbSaJUyL3g
         efMnLDIONJlT2Uzhv/pyqogFW+k5Y2gd0uQO0s+1w7ZzeMAuigTLorsh769OlU9E2dvR
         Vfz04snuMY94HxrbAxdocJh3Wic9NGtlXkZa1snC1UyTBkcrlz/KldtAaSVDTWbQhe4g
         o5z8BnGf6jPCxNEVRTvTg4mOg7sR1XVAg7Dr9ICJuNA9Uq7ZO3a/o5M0DkfgGCfNJupz
         MC7I8o6VDT/pKVk69rVcak4MI6TLmNc1k24LFkGXV0RXlrmClLF93NOhWJ6mcMlUK75Q
         Zg2g==
X-Gm-Message-State: APjAAAW6BwSPVGj3N6wmIx+BxAf6MYL2FN83WK7bNZdHNSHE0GbJXeXU
        uca7bw5BRKm+yQoK4sfbRW8=
X-Google-Smtp-Source: APXvYqwRI04F3xiORLf9hlO37+rwxbGZhusfuTQ8VMbNc7FjWCwkDlN4OVOZrqfhRfK7zqNf8PuzQw==
X-Received: by 2002:adf:ab41:: with SMTP id r1mr27076505wrc.281.1573999195527;
        Sun, 17 Nov 2019 05:59:55 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n65sm18004803wmf.28.2019.11.17.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 05:59:54 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/5] provide the XTAL clock via OF on Meson8/8b/8m2
Date:   Sun, 17 Nov 2019 14:59:22 +0100
Message-Id: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
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


Changes since v2 at [1]:
- add .fw_name in addition to .name in patch #3 as suggested by Jerome
- dropped the dts patch so this whole series targets clk-meson
- moved patch #5 from another series to this one because once we drop
  .name = "xtal" the clocks need to be aware of the OF node

Changes since v1 at [0]:
- add Rob's Reviewed-by to the dt-bindings patch
- check that "xtal" clock is actually passed via OF instead of checking
  that there's any parent at all (which in the worst case may not be the
  xtal clock) as suggested by Jerome
  

[0] https://patchwork.kernel.org/cover/11155515/
[1] https://patchwork.kernel.org/cover/11214189/


Martin Blumenstingl (5):
  dt-bindings: clock: meson8b: add the clock inputs
  clk: meson: meson8b: use clk_hw_set_parent in the CPU clock notifier
  clk: meson: meson8b: change references to the XTAL clock to use
    [fw_]name
  clk: meson: meson8b: don't register the XTAL clock when provided via
    OF
  clk: meson: meson8b: use of_clk_hw_register to register the clocks

 .../bindings/clock/amlogic,meson8b-clkc.txt   |   5 +
 drivers/clk/meson/meson8b.c                   | 113 ++++++++++--------
 2 files changed, 67 insertions(+), 51 deletions(-)

-- 
2.24.0

