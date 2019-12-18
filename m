Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AF7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E212176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WL6LQvaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLRRY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:24:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37447 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfLRRY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:24:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so3180349wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkeDNQUJ3ikeTDqUkF4Gryc9YGb0Gj5eqNCbDtkdhPw=;
        b=WL6LQvaJ9GGlUjw9H2P/1hGp29WTQgH0SjF3vxM3PXuoSHkCPIJMZ0/moLtc9sKgF+
         JEh6NAbPqIWRs+wngIArKVHOaQSYykBTrlkNfSRW5F8uLnOYl7JY1UB6HVoQXdY3kEMO
         QVPbDjuu41bQvjV9npjWA3XGgU7mNTizqkPWaq8m8TTm8pEn3o7oHmiP/QDEr8b4hWy1
         gB0B7bA0p4nRahqNbn8k7FC58AA9TFFrBbxaBSXJ4WNCY3mEi7BmrGLsi4VkqvTiLIFP
         c/ym3SuKFZDF8BCpRPf5wTGrB/t9RvWsnyq/Mj8chxROlsIi0KDJel1ST8/iTOySbmG6
         A/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkeDNQUJ3ikeTDqUkF4Gryc9YGb0Gj5eqNCbDtkdhPw=;
        b=Z44VbfWbIFI65bz30zntXE/eQ1sfNIB2qXZdqHP3rF9WXmCRPBVt+JmC3isPfLUZMt
         7ajDogrhr3YhP4yHCyUW+AtQBRn7n8DRxvitUHVnYff3yAoXHEulK29yLhb6G9jg6egc
         7fuWtkcaGA3yih5Trl79TwhJHMgY4GQwbFJh9Iv7Jhc/SgPrB34aXDOkejdDN+kJHBrQ
         R6cfZkdJvXmTCNGvrYpwPPrLzrf2v+xwPeyYg6FyNnyxr8ECccpzr0cKtHLmUldx1vgp
         pDxjWqNq/dkA36qrqqg/fb1+i7aq2IlPfAQP2JjZcdrFWulDZ6rz39sGLeSzJrpxkfK+
         qasg==
X-Gm-Message-State: APjAAAXrtC+0jmPZzJeSr8tN8w0AJKriCzLYMcb7nE+N/iLPRLb5HKbE
        GzFYKNpnymt7t/cF7+KFaWDUBg==
X-Google-Smtp-Source: APXvYqwBahCJsSlMYv9H8BS5x9yINh/xRKEr1G8MnVvK/fUdISZ8dpu38/NOPkP1wQV26nQIfcBMEw==
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr3902176wru.395.1576689865056;
        Wed, 18 Dec 2019 09:24:25 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 4sm2883231wmg.22.2019.12.18.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:24:24 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/4] ASoC: meson: axg-fifo: fix depth handling
Date:   Wed, 18 Dec 2019 18:24:16 +0100
Message-Id: <20191218172420.1199117-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset improves the handling the depth of the different fifos
found in amlogic audio subsystems derived from the axg family.

Initially, it was reported that, when the period is less than 8kB on sm1
and with TODDR A, several period are coming at once. This is because the
field related to the fifo request threshold changed on the sm1 SoC and
also because TODDR A instance is significantly larger compared to the
other instances.

With this initial issue fixed, I used the opportunity to improve the
driver and properly deal with the different fifo depth found in these
SoCs.

Jerome Brunet (4):
  ASoC: meson: axg-fifo: fix fifo threshold setup
  ASoC: meson: axg-fifo: add fifo depth to the bindings documentation
  ASoC: meson: axg-fifo: improve depth handling
  ASoC: meson: axg-fifo: relax period size constraints

 .../bindings/sound/amlogic,axg-fifo.txt       |  4 ++
 sound/soc/meson/axg-fifo.c                    | 50 ++++++++++++++++---
 sound/soc/meson/axg-fifo.h                    |  9 ++--
 sound/soc/meson/axg-frddr.c                   | 33 ++++++------
 sound/soc/meson/axg-toddr.c                   | 21 ++++----
 5 files changed, 76 insertions(+), 41 deletions(-)

-- 
2.23.0

