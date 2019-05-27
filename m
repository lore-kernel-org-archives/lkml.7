Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64340C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39125208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y2h9scCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfE0Nqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:46:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44792 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfE0Nqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:46:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so8639309wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bKRlBkskczdPPqv9G18ixpX6ovvQaVIENR175SCnaOw=;
        b=Y2h9scCMQNHAr/J4BkXemMWG7+qOJXI85w6nUml47YknMvh21D1C33+TH9ecDhi0J3
         33HiETE78tULCLjbE9xX5PD/N9RaXBdCxZiBBksLyv3Y1CuGzi9+PJJYiCmoAyxrFAHt
         hS9sHzMoyhjKzsvUqshogNg+X23j572m0NNVqjWlv2iBQ1+S5pRI4cloKUlh0TrFkmbm
         Y7QviWNkT382EgInRcLvghAmlHfRIMslBQOYNYspvIDf0lNPmPBQBO3ThXQR/9b0xj2K
         5p1mglM/4O9buzC+HLdOqKYt7/yY9gKWeV99jTnKddFSdQ4G6NhzpQ0TsrdDxEDBPDSS
         SyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKRlBkskczdPPqv9G18ixpX6ovvQaVIENR175SCnaOw=;
        b=CWMNdagChgJZKXd+353U1oX4O6RY6k1BQM4QfQWNsuadwh/fXwxSVGrgAdReNzCnah
         /rQp7mKpyRDgD4HdxKQRyrB6wTd0UPj1+0H2/uNwvw7kr2Bg5xZmETb2PLSshanX3DIk
         h0JUkT0L2fJtvF4tbF+kwkGg798oRzg1vTEisW4QPABqqKivkhHmTKnYQY/dSOnBgotl
         LJs6099DBEeCLBmIwm2WSH2g4l6ISfmfx668gX1mEHu5BaT3p0XX5hp0rbeA3nESCZyi
         ocxV1syA312byDqEeD6VMp3dJJCSOshzqgTAb7btAUTyiD5rSQE6yG+PzgGeaW2dwQbw
         F/bg==
X-Gm-Message-State: APjAAAUR3tpcDDb+wGkDO5h0YN3A6ZdnLF1gpVr0Mz79LHaIqnLGSG+m
        460KdoxY/HiyiWJuRlbeypWp3w==
X-Google-Smtp-Source: APXvYqw8OK0PYWWMEGHRAXt6wmuVUV8zRg5wDVw/kH7BVy+7OcrxCWVYYVRnB4crgUvSqGvtko3q+A==
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr32380340wra.132.1558964790319;
        Mon, 27 May 2019 06:46:30 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w2sm4611311wru.16.2019.05.27.06.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:46:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH net-next 1/2] net: stmmac: dwmac-meson: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:46:22 +0200
Message-Id: <20190527134623.5673-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527134623.5673-1-narmstrong@baylibre.com>
References: <20190527134623.5673-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
index 7fdd1760a74c..5ae474ebaaed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson6 and Meson8 DWMAC glue layer
  *
  * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/device.h>
-- 
2.21.0

