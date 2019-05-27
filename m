Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A56C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F13B2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TbUpcoEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfE0Nqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:46:31 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:39770 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfE0Nqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:46:31 -0400
Received: by mail-wr1-f49.google.com with SMTP id e2so8239748wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+BMa4gsX2SpWHDg4/WOwzhZkAoB1v5cWmwKV6NHcXY=;
        b=TbUpcoEaxaQNRfmwXB5IYi1gLT7Tc9zBU8dLzJyt0i8tLNngRrgCtRvcHGpKwd7ARZ
         FDIaVuSHqjDOLFg/TZiIFvE9X/yN2dWV9Vd0qOQRV2tLMSzsKsYgEWg3WmE/v1ad22Yx
         vPgoELfiDmw9bRNTNNqliE+fL1lojg2lMXjqpzujRu7QdrGf2SwVwOhmdwuMLv3ZWz8F
         lA0LefZkxQQl5irzBK2ehVX0ndAxrkiAisDKIKEqpknyY1JQUVUxmixTL1wUJYe5Fr3J
         TJ895UzXCmaWTLBZ74pnJ2I7rvKt3C2JIV6w/MwLoaCaw1c+UUEZlpKSrnnjh1NvNgzW
         ZwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+BMa4gsX2SpWHDg4/WOwzhZkAoB1v5cWmwKV6NHcXY=;
        b=DVjYDoGRWZjMEA3LU6fAPIxEVnOvnzLxKrfTkOaTLG2K7S5khfte2vzSAWeGaJHc21
         mn2jlyVqIlToB/9Fi7F7rkRK0zMQqBN0Ft09K45AnlmCGnYgxyNaMOI+2c2YrL4JaxCE
         kgxQpdaqzOdd7TJBprpSy/8AXGZasSHZzOP0M8yG7RMxWDlfLelhEjT0TdEQoHIOk3Zn
         AIa7ZMw2zC0o6ab7AKI86Ljud1h9T7bGXDEdZ9L8s80zrz32UAbyqBrUoVr2Sof/ulYe
         UAwM2Q4QpuHIMSx2vCGaUdDbMy/ToIu8tzqIkoqB+f1GQI5hIcLEPBYEfwndQ/TuvFVo
         2lng==
X-Gm-Message-State: APjAAAV1pYngTyu7Xw/knSGS0bJfX5LKWrAWmrGWfxAxxzG40YYgW4fH
        fam1knby2nlGEJYBSfOz/jTB4w==
X-Google-Smtp-Source: APXvYqxzp/JP29DMv8kL+YY1dvcjW0NVluckIAgiIJ4N5qzyrZ9PpUdQqTEssjjJsKvceApH/B81gw==
X-Received: by 2002:a5d:644e:: with SMTP id d14mr52019475wrw.42.1558964789627;
        Mon, 27 May 2019 06:46:29 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w2sm4611311wru.16.2019.05.27.06.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:46:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH net-next 0/2] net: stmmac: dwmac-meson: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:46:21 +0200
Message-Id: <20190527134623.5673-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SPDX Licence identifier for the Amlogic Meson6 and Meson8 dwmac
glue drivers.

Neil Armstrong (2):
  net: stmmac: dwmac-meson: update with SPDX Licence identifier
  net: stmmac: dwmac-meson8b: update with SPDX Licence identifier

 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c   | 8 +-------
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 8 +-------
 2 files changed, 2 insertions(+), 14 deletions(-)

-- 
2.21.0

