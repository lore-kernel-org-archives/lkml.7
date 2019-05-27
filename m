Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCEEC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EDA20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QyKXG70H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfE0Nqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:46:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42536 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfE0Nqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:46:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so17005985wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jL8EOSTC/B97Q4hYmRDMBEhteRV4Llk3yLW6XJX3YpI=;
        b=QyKXG70H1u2UgFiibJqKQV1vPScCiHh5bAhwADcaelYpW4zCUSLjX1xba7kJJgPIzm
         gQ3fytnMSzufHLRpKPZ0PdXOlXZHq9ysL1BSu6QpeHYw2iQbNspWhLXJPbWfxUdeNsDp
         Tq8NKj46EpnI3mPAIDI0v/HfNBmpKTZEeigo2v8v9ZsGLfT0ItVSS0PQufqEWQ/HiyMR
         61xVDWuHzws7/W8Nc/TVeK9EHB9aWnm6Ha3N8Rd1bEZH1UUcDEwkyo8eeX+W2tnHpWwz
         IRU7Q6hnV1EwNL0J5lgU52QePAAyAhrV2lAIOIGWdIL3xiLXpqwK5uksj6cwlK/Jwdji
         j9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jL8EOSTC/B97Q4hYmRDMBEhteRV4Llk3yLW6XJX3YpI=;
        b=d9RrF2vvcCmEa7E6ymn042/v3+ru0lH6yjMQjur/dQE/Xx70JXaGolPLtnYD3XD1Sa
         FyYiVfcYDr/LGlXVX7K90OazbKOSByNljAuZo2NG63OpXP+/MieC6WglMIW9L0OxU1x1
         kMm5zZpE9cd8M63WEKUn4N/9Z9KjfMi4at5X1Z0YLrzfcVgv840lrMUnsP053geOhPTX
         9RQjSI31aT4x7r7+MjjWDNJcwnQ2MuRJiAidY9Mx38V5E2xHAzSSkJMoAsNzNlYgmJhN
         XiyWaWS9D23Puq9GnupkRjvNEaoDTJEmIECaCuruzNlxiVg7gjk5Yp9pRGS0VSdnWHfT
         cDmQ==
X-Gm-Message-State: APjAAAU4r3uyRBxaJGZTA3B9SM7BgMlw/Y13nB6Cy53zIyLHsNYCSbrX
        vVrsIl9cwdusoHvbSIedc3IykmS05FZ6SQ==
X-Google-Smtp-Source: APXvYqwCBkFUboFEpdyYeT2MB2m5qBA+jbGdF6IZ6832wSuIZrnvbPGDoxx2MAEeMgieqB2H0x8Gzg==
X-Received: by 2002:adf:ab45:: with SMTP id r5mr48449812wrc.100.1558964790971;
        Mon, 27 May 2019 06:46:30 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w2sm4611311wru.16.2019.05.27.06.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:46:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH net-next 2/2] net: stmmac: dwmac-meson8b: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:46:23 +0200
Message-Id: <20190527134623.5673-3-narmstrong@baylibre.com>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index c5979569fd60..c06295ec1ef0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson8b, Meson8m2 and GXBB DWMAC glue layer
  *
  * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
-- 
2.21.0

