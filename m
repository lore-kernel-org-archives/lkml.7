Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C28EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8C7213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="J0KpAxRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391579AbfETO2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:28:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35191 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732641AbfETO2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:28:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id q15so13282870wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A12cpc+WUhF71aXBZdyNVOx5fCS+Vei2NjBPNK5Pnn0=;
        b=J0KpAxRV6c7LEUvGEfmWqd52V9FoX5XyChfLKAjO9N8Lask56HE52hii+peIuS/TvR
         qei9bPgkPegaYnLdBt7Q72ThAnNKXSbeBV1n9LXvau06nDyMUCJ/j8EtNF/S+HUx7GBz
         PTvBjkeL1IRYjM8OgtccAv6S8uIP1hVbY7A+2NsWYdwi4wVGCAwwwrDrGQZJhBrQxwup
         QEDg8v4UwJCMOBaSyvwqAII9qrGZmbPI3bHFUyRRS0ocV7f7hM4+SXFENg7PjYHKbJOo
         x+Bi8v6wgG6PAqedkhqyOw40xElslb52WKem7eJl4qhv5HhFSXKr+rImqWlxLdCObRog
         Kltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A12cpc+WUhF71aXBZdyNVOx5fCS+Vei2NjBPNK5Pnn0=;
        b=X8V8NzrCVvmcNGjKPjeAi18qKQVIZPT/e8iQEtkyuz2dvP6M9FBv2Lho2PNzsVML9g
         9bK5XqnNksVFpZdGNQT4VSOKLePXllkT3BX26VaK3jRUC4bC7N+J8XE26S2oT7diVgsM
         5Hg5eRvmZXrWfs/5dQn7i/tcE3aKXqotbTgnRPBFQs+LHs4JDQCS6Tm2NmwVhtUe3XIy
         746qoxFr2ilnYzMM83FMiYJHJzqHAjNqTSUbK9UJFWR8x2wCCjuQai/Ih4Qu0lLrs2Gf
         utgqiV11b/HYp0QKL2pElYBGTZtuVBqFszaNIPyrmLoTEHjVwEQnAxcxP6BTt18wfPGJ
         nNxA==
X-Gm-Message-State: APjAAAW78XGVF0nIpYOLULbf3DntqUS5b73zqBl+5pqvoEm5DcXO08iv
        0zPR9DYw7JK4Zrq+DfecMJ0SFA==
X-Google-Smtp-Source: APXvYqyRQP9yJCxY65JkyqLPbCzFVGNKEaUa+r0HJCszmKWVUSyVt6zf/KCdViAxXMq2Oc6MPsJrnA==
X-Received: by 2002:a1c:700b:: with SMTP id l11mr5463602wmc.106.1558362530051;
        Mon, 20 May 2019 07:28:50 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z74sm154843wmc.2.2019.05.20.07.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:28:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] watchdog: meson_wdt: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:28:47 +0200
Message-Id: <20190520142847.442-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/watchdog/meson_wdt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 01889cef81e1..3389f4c02603 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      Meson Watchdog Driver
  *
  *      Copyright (c) 2014 Carlo Caione
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
  */
 
 #include <linux/clk.h>
-- 
2.21.0

