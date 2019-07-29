Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFD7C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555162070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="va/m4r4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfG2NRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:17:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38525 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfG2NRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:17:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so32091549wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oynpEq+Rva8XBfHeYWHdmuSsXuLqJ4yySPhy6VhqL9A=;
        b=va/m4r4dkyOP1H7msYfzDxN4+0vxPlSoe+oUQ4l/rirf0OhntUYksvZZwImE3yEz0T
         oBaLe8s00sw6YpMAmKbDDfMJ3mCl28yLI59Ef6CiNZUUKGfhFf+NDo5mic6oiM20KxKR
         8e2iXUVWGg/5SBAy23v8YvJvjir1BgTnUhFoiSVojDGfS2Uv0NQw5UX04REnvkVV5RsO
         0/xJ5HncMOscX99UEea1qAz6NyeqODccTnEm/p0TXkddx0FI8A9rkhv5U4Sx3hcD6Mpn
         SkQhDKIsiBKPMOhr/4Bm1s4lGW8Pr24oT4yPFoPKpTRnPfszLYYMnc4VIcdgJtC2qpZJ
         K8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oynpEq+Rva8XBfHeYWHdmuSsXuLqJ4yySPhy6VhqL9A=;
        b=RvLZcFA4RdhNcUsMU+ybQoH6pMjI5zY9/NAq/akomyiNZ/1Ftll7Gzmyuxe8M40g24
         O9p3NKUmpsSf+eElLHJS1VeEntLPxvbbv7FZMiRbEOcTFIOD3RUoTLxUVgJta3Ap/xCb
         w9CeDxqkQrbqigHZP7oqdsBrlDDwJ448YCluqYw4pvNKEtr+cSJfpvS2NT9VgVVPtd+A
         5WKOqymKsE6wajNPSwlE5tRQNBMzsynSczuNFJ/f2Kro27yr0Pwi6r+mV6mBNWGtvw1E
         v9HpMj5t2JMMWNheUgzdCylfJcic3Ut5dy5JXvcTnX6O8Opdm8xCkbNDz1N3WxinXuBQ
         7EYw==
X-Gm-Message-State: APjAAAXsoqU0EPGsq3t2NEjVC+v2a1EnDRRgqaO1Pu6F3YZ6Fa9nsA21
        oAFHhIsKLzF09A9Q39BYxOOttw==
X-Google-Smtp-Source: APXvYqytSS4CaOtshhSxLAUA/SqcXHfZnGVeXdez8xfDM0v0eOvC2DS2WChVjk847i77QN6BlJ/9OA==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr18655712wml.169.1564406219328;
        Mon, 29 Jul 2019 06:16:59 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b5sm52520490wru.69.2019.07.29.06.16.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:16:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     sboyd@kernel.org, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] clk: meson: g12a: add support for DVFS
Date:   Mon, 29 Jul 2019 15:16:52 +0200
Message-Id: <20190729131656.7308-1-narmstrong@baylibre.com>
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

Neil Armstrong (4):
  clk: core: introduce clk_hw_set_parent()
  clk: meson: regmap: export regmap_div ops functions
  clk: meson: g12a: add notifiers to handle cpu clock change
  clk: meson: g12a: expose CPUB clock ID for G12B

 drivers/clk/clk.c                     |   6 +
 drivers/clk/meson/clk-regmap.c        |  10 +-
 drivers/clk/meson/clk-regmap.h        |   5 +
 drivers/clk/meson/g12a.c              | 567 +++++++++++++++++++++++---
 include/dt-bindings/clock/g12a-clkc.h |   1 +
 include/linux/clk-provider.h          |   1 +
 6 files changed, 540 insertions(+), 50 deletions(-)

-- 
2.22.0

