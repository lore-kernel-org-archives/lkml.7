Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EDDC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380BB206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UzuA4+3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbfG3Lib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:38:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36759 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbfG3Li3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:38:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so65468935wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNgx7LSZsCgbXKdsyr24bMY9+rQUrrZFZQRC4AZtF9c=;
        b=UzuA4+3dWD5gJ/bdWkmp+oOn2TquUqRLyhTvpv71pz7iZ2sw04Dfi/dVMU4rPFxtYF
         zcafGzR25HcoGTuB2y6cMFwz1ybVu1AguN6miO5wUzRZ7j7sRtem7g6Q6+auwoAhpzVz
         qCzhMOWs34dfxcAg2dx64MnMRAdLen7WE1g38sa22lJRwwiHHlk7KZ35yq1lrK5aWI66
         l1c7ytZfhr5kiQrJ8s/w/amYJf5nkGFW5IYYdh5xMogGWyEQQ3KamGRmD/GrgzgrvAJ2
         52WnysO1TMySTSb5Z3nGjpIdG+YdE/b+LxWVdczZ9H9YUb4eM9+Gk9uN7YCn/zx3Uq+y
         M0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNgx7LSZsCgbXKdsyr24bMY9+rQUrrZFZQRC4AZtF9c=;
        b=TZaoYy7FLWJCT29Nxnp0KUkxQeI69rP536E2oveR00die4C2dZPjPOGKu66Nky3xu3
         zZIu3qzPGsaDMNxHZq+DDoHumekO85kfaSikPasv4oY8TyKCfiueBZttqYXrE+ZQKCgh
         bnO/LHVlqpDpU63NgjC48ZqPzNF/tqLjiiX9pAFXV1UMnNpq8YsQOU/uIIcJ8UjC1Xjf
         564I+b9yqre8IqoYCX4nKhX888kudrV5QQM7+7sZSAnVT31p/6ymea3a0jtr6X2gw/d1
         ozLx2infmedMaiaFWen3c3y4711JPpWc4Bm9QeZo8uSW/fbB0CgW5bPyxL+61974STg3
         N9Kg==
X-Gm-Message-State: APjAAAWfDJ3z2Q2888Ry91F+sVu8tTb5sTgrUBTP3BWjsa4/fvCUI3zn
        YCFqkftkFC82ZDchWc5IZagHHFus
X-Google-Smtp-Source: APXvYqyrOWXJtJJE/Z8rh0NjaFzqXq9A4xuhHNIQKEOvXvJTncEPAOI8h6PfJJZs4V3dUopUN741Pg==
X-Received: by 2002:adf:f646:: with SMTP id x6mr134917936wrp.18.1564486707429;
        Tue, 30 Jul 2019 04:38:27 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:e921:c4e4:a1d5:45d1])
        by smtp.gmail.com with ESMTPSA id r11sm99600810wre.14.2019.07.30.04.38.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 04:38:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frode Isaksen <fisaksen@baylibre.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] net: stmmac: Use netif_tx_napi_add() for TX polling function
Date:   Tue, 30 Jul 2019 13:38:14 +0200
Message-Id: <20190730113814.13825-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frode Isaksen <fisaksen@baylibre.com>

This variant of netif_napi_add() should be used from drivers
using NAPI to exclusively poll a TX queue.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
Tested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 98b1a5c6d537..390dad5b9819 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4313,8 +4313,9 @@ int stmmac_dvr_probe(struct device *device,
 				       NAPI_POLL_WEIGHT);
 		}
 		if (queue < priv->plat->tx_queues_to_use) {
-			netif_napi_add(ndev, &ch->tx_napi, stmmac_napi_poll_tx,
-				       NAPI_POLL_WEIGHT);
+			netif_tx_napi_add(ndev, &ch->tx_napi,
+					  stmmac_napi_poll_tx,
+					  NAPI_POLL_WEIGHT);
 		}
 	}
 
-- 
2.21.0

