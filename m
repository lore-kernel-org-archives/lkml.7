Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DED6C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BC2206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKl7+aHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfLPMT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:19:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38587 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfLPMT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:19:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so5492049pfc.5;
        Mon, 16 Dec 2019 04:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYFHoC/Y4PCCPPkEkAbTfP7mUpyA/6C+ox8rPVg4xLc=;
        b=AKl7+aHb1QZC2RvbCeCyMUc0I4lzTpkH+gFKhVOEDixOmWUKkhcUI3PvnrA5YHPPlx
         pFE1xXg59dYdZf5C1aHD1riuCso8Ub3Esa8lQtnQDyzMInsCemtHNOzw1QPawV7J+iPx
         WL3AVtZbvjIYzhaAEVo0adfdKJjZaCX8r5PLlk4twyOqNqM69CnLVd3nDfjEo9cUkzpC
         nhBBQbjbSoM94ruMctO5hhwC71D/McH19ezNlj2uCTix//5ddohA2kmtrZ3IThx1I2sI
         9DQJgDQ0Dkvp/wFOayuyBA5Btnd9WIFE8pvKOUqvEsrceYz51yu6me6TZGaPmrSL3eyy
         Qk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYFHoC/Y4PCCPPkEkAbTfP7mUpyA/6C+ox8rPVg4xLc=;
        b=SdV2yIDwVrFujAtrtjas40s9kn1HqGR2Vt1tKl96SbiBdxsrMzA1e45oVdK1cJUS3Q
         EUJl0Y+hHiw/s4g09YJrVXsi2VG5OUmFVXXKCL7q8dBH1I2uf3CxNGPF55Tnhq3n0l1l
         IcUMEeSAnfgbxNAXiitcXIgMonJSeqb8+0BCcykQP88kf/86Y6vf3tqtHapIqJiFdyj6
         hgNwxUWJLINOLFbQ1CiftZayjWFTw1kDN7xZSVDVDZfecPnyCYkscX8l/F6k9CEgK3zT
         Pbiwx8azgwwFrNyM1KwuSsQrs7BI9dF1hE4vStDeJeICVbLuk4LOxv0YQBw3f8CbIvXk
         0+gw==
X-Gm-Message-State: APjAAAXqGJcgrHaCciYBn1+YL561+zFrsRfRanr+bOyrT+MlKnyVvR/q
        ZClU+8j0MBo8zfVnlgMFLS4=
X-Google-Smtp-Source: APXvYqzDlHm7cTjmXD6EXn3pd5YTAdkVoV946lry0lOwhlTr2p8WQ/cuPQBOoSFd/fX35hz/0IxlOw==
X-Received: by 2002:a05:6a00:5b:: with SMTP id i27mr15785985pfk.112.1576498796223;
        Mon, 16 Dec 2019 04:19:56 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o17sm18633910pjq.1.2019.12.16.04.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 04:19:54 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V2 0/6] Add clocks for Unisoc's SC9863A
Date:   Mon, 16 Dec 2019 20:19:26 +0800
Message-Id: <20191216121932.22967-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SC9863A specific clock driver and devicetree bindings for it.

Also this patchset added support gate clock for pll which need to
wait a certain time for stable after being switched on.

Changes from v1:
* Address comments:
- Remove redefine things;
- Switch DT bindings to yaml schema;
- Add macros for the new way of specifying clk parents; 
- Switch to use the new way of specifying clk parents;
- Clean CLK_IGNORE_UNUSED flags for some SC9863A clocks;
- Drop the module alias;
- Use device_get_match_data() instead of of_match_node();

* Add Rob's reviewed-by on patch 2.

Chunyan Zhang (5):
  dt-bindings: clk: sprd: rename the common file name sprd.txt to SoC
    specific
  dt-bindings: clk: sprd: add bindings for sc9863a clock controller
  clk: sprd: Add dt-bindings include file for SC9863A
  clk: sprd: Add macros for referencing parents without strings
  clk: sprd: add clocks support for SC9863A

Xiaolong Zhang (1):
  clk: sprd: add gate for pll clocks

 .../clock/{sprd.txt => sprd,sc9860-clk.txt}   |    2 +-
 .../bindings/clock/sprd,sc9863a-clk.yaml      |   77 +
 drivers/clk/sprd/Kconfig                      |    8 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/composite.h                  |   39 +-
 drivers/clk/sprd/div.h                        |   20 +-
 drivers/clk/sprd/gate.c                       |   17 +
 drivers/clk/sprd/gate.h                       |  120 +-
 drivers/clk/sprd/mux.h                        |   28 +-
 drivers/clk/sprd/pll.h                        |   55 +-
 drivers/clk/sprd/sc9863a-clk.c                | 1835 +++++++++++++++++
 include/dt-bindings/clock/sprd,sc9863a-clk.h  |  345 ++++
 12 files changed, 2494 insertions(+), 53 deletions(-)
 rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
 create mode 100644 drivers/clk/sprd/sc9863a-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,sc9863a-clk.h

-- 
2.20.1

