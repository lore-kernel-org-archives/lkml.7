Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374C1C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4482199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WhbT/meS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfGVJya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:54:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41445 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfGVJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:54:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so35518464wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bgvq9lq6LGXpxNw9zfixyWK44sZokPcHvbjpJArgXSg=;
        b=WhbT/meS6VWf8enxjpNxCA+h2RhhAz5ChlSWG8CfFeZ9UePIK1a9Hnre9k7keWJM8Y
         DrDNvwIPg2/h04urY4AtGYyJyi3AhzYwd/7KazMsJ6jhURHR1HsdMFbrTYQcaSvL3iCV
         XVGOpayXdvjcReahnENQc3/cdf4gFxlQG6MSh5W0RBdY6vEyUct1BsNbtMvtd4ANyHJr
         H1rFGOCnTJWT38cQ6tdDJvUVh3fCTtYhkgSixeZxjgaA2cArzNYQ2fDW19S8VN6RPS15
         XNE2faizVhRdn+kDo3hOQAyiPIS7XfN+s8jABPAjKmPpWXkhiq1sfzmSF4BWDIpkMa+F
         MdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bgvq9lq6LGXpxNw9zfixyWK44sZokPcHvbjpJArgXSg=;
        b=dOwitm3VFkUHrDiAydpT9Ycy6BHg42imL2g+iUdQRKpoqp2oef/JGktTkVvi2pPSmP
         bajB8MNIY/bBRDWQt/iAtabzP+p8eCb/vZdNZv1ckh3AbEXZ12zlrqp42SFU8YBiRA8Y
         gxLdJBOLphWY+Y7jb9J5IgyZ3yDjHGt9g/S/IcSV+dQXh5rremN1NByuTBYmnO0ixBdd
         +tdM2PUbLY43bOovlVTeAqqf+ayXhGqYM7cb7Om2Gjh1E29LEEG/J9bxHoSKvTMyNwTU
         p6cxvCtGbGmxHEZQaH/ZH7sMnbTF6xUkPwgSAM3TbAe+/ySuF/ytcP/K9O3fR1/5qBLz
         Ui1g==
X-Gm-Message-State: APjAAAWkO8JiMrzKr1dh9gUF0noJIqu7b5EckgLmsmUpySWt02vSbMaf
        x43lbuQFvsi28jpHTFmXY2wuPw==
X-Google-Smtp-Source: APXvYqwivBi379wi/Mp2lCw90zmNjgCUUdXb5W548a5fqL/+oTVTmKPQ1IHQg1T8EqZWsocnX8BxLA==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr19076152wru.288.1563789268373;
        Mon, 22 Jul 2019 02:54:28 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 91sm83158469wrp.3.2019.07.22.02.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 02:54:27 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 0/8] clk: meson: ee: use the new parent description method
Date:   Mon, 22 Jul 2019 11:54:17 +0200
Message-Id: <20190722095425.14193-1-amergnat@baylibre.com>
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
 drivers/clk/meson/g12a.c        | 1086 ++++++++++++++++++++-----------
 drivers/clk/meson/gxbb.c        |  646 ++++++++++++------
 drivers/clk/meson/meson-eeclk.c |   10 -
 drivers/clk/meson/meson-eeclk.h |    2 -
 drivers/clk/meson/meson8b.c     |  696 ++++++++++++++------
 11 files changed, 1773 insertions(+), 959 deletions(-)
 delete mode 100644 drivers/clk/meson/clk-input.c
 delete mode 100644 drivers/clk/meson/clk-input.h

-- 
2.17.1

