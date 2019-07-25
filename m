Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D082C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3005F21951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KBrW3Ij5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbfGYQmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:42:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51381 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388686AbfGYQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:42:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so45605887wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SGJmBKcUqMKvR6yeTOTPyisPIWw/oGZVjBLHI0+zcGw=;
        b=KBrW3Ij5aUwDiRAJ6GdXeNunBAkqSMTT/1zew7s3LvqOT9kGlohsMF+iVKBf9QMyOy
         7erUqMglmdsQuxcBSrZANcdrZ1yE19tfjAY35s6J64CfX2jtNzUy5GL+UP5zfMr13CZr
         oTwIP7c+juJvDLeCSTcPhDGOo5ooqpyGEwBXOo4leugbE0kWSWA5pvS4ssQFqMdk+bH9
         eFJHOhsyHSbIaNPaoBoDoGDMripnCeDSm2EP6skBs4D860iUXnEvBr1P/9lxgQzjHQ2n
         puVV5XKuCYCpE6ckW71Sv1wsjgLBTq3fetwYWQ39osRHeCI9b+O3Ammm/xCJ+uc0JRg1
         dbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SGJmBKcUqMKvR6yeTOTPyisPIWw/oGZVjBLHI0+zcGw=;
        b=CqicprxUUvDs/ckmIU/UQQRYZbAIuMoICwzMsHsnz2YTkYUGVX6+qv6ghDoCn0l8EF
         cTQZH2B/ONmXuuIDgCrllLlq7KgqFWRIVkooMhuDnI/idWl3AePDXDonZpbeugalWXcs
         VVjovQSGfNz6oRPOX5JknJiDhuDzpN/l+/LGbYrcRjMgDnkHn0pcvglQ0tnf+n4lkxS4
         chceRAIzgurKg88ZcFkJOLmftYR/zUJhm4C2P2RY3Cvz6gAPxdhz7HlnfDYWOoIxngaB
         2HYKenGx/Gx1DniRWyaXzFsnShmSrkfpr10VTriKdOArTf2TmZlkGWhHc0MLBEKfSquG
         JsjQ==
X-Gm-Message-State: APjAAAW5jdJ+5hzVUsR3Ams2XlAJhyeDSetqIdRQpN4RmaVU43CFk4B/
        onUP2tW22lXHlFWimncrQ3Mv0Q==
X-Google-Smtp-Source: APXvYqxlREV45hHUfVDk1Y22GCYG2j0m/duTrCeHlsvTz6wQQ10qi4zHPhIAryaEEmTtj9/oEill3Q==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr83257469wme.81.1564072972458;
        Thu, 25 Jul 2019 09:42:52 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id 91sm103031727wrp.3.2019.07.25.09.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:42:51 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 0/8] clk: meson: ee: use the new parent description method
Date:   Thu, 25 Jul 2019 18:42:30 +0200
Message-Id: <20190725164238.27991-1-amergnat@baylibre.com>
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

Change since v1:
- Improve comments in gxbb, g12a and meson8b files

Alexandre Mergnat (8):
  clk: meson: g12a: move clock declaration to dependency order
  clk: meson: g12a: migrate to the new parent description method
  clk: meson: gxbb: migrate to the new parent description method
  clk: meson: axg: migrate to the new parent description method
  clk: meson: meson8b: migrate to the new parent description method
  clk: meson: clk-regmap: migrate to new parent description method
  clk: meson: remove ee input bypass clocks
  clk: meson: remove clk input helper

 drivers/clk/meson/Kconfig       |    4 -
 drivers/clk/meson/Makefile      |    1 -
 drivers/clk/meson/axg.c         |  207 ++++--
 drivers/clk/meson/clk-input.c   |   49 --
 drivers/clk/meson/clk-input.h   |   19 -
 drivers/clk/meson/clk-regmap.h  |   12 +-
 drivers/clk/meson/g12a.c        | 1093 ++++++++++++++++++++-----------
 drivers/clk/meson/gxbb.c        |  657 +++++++++++++------
 drivers/clk/meson/meson-eeclk.c |   10 -
 drivers/clk/meson/meson-eeclk.h |    2 -
 drivers/clk/meson/meson8b.c     |  710 ++++++++++++++------
 11 files changed, 1805 insertions(+), 959 deletions(-)
 delete mode 100644 drivers/clk/meson/clk-input.c
 delete mode 100644 drivers/clk/meson/clk-input.h

-- 
2.17.1

