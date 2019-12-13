Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61B8C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2A4206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jHR12tbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfLMKdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:33:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34596 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfLMKdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:33:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so6104662wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 02:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFvEZv4fCEfnBjZuHaDEzhBGea5XsffkSnNCT16fvYU=;
        b=jHR12tbM06VD1AOyR9O5gcHoAjUBra8//xez4RFLOUxKSeZDIjslV5etdOMPGeDCm9
         e2HF6yTZBYeuXFOfepN5F1XNTW9ytm6jii1vfCNdrfx4Ldc9hM9GAqD5IbKj6evY4qjH
         HpBTF8Vpx7EpHBwrbGf0zpzNKC3P4h071RgRBXJQn/1k1lUr4o1FnSkrD7e8htNvApHu
         ABPDaeDWiml/L8mpAS3Bg7B2ZzIG2etXzL/fGi+AFqQcJ8ztKqZb4OiCkgDIU/Cz7ltf
         StZ5QYewoyP5dpAx7CxnpmhSfGpEljAO2sfvURWlydTJ4uBDiIGHZIaA9vXDlsFoY2bj
         EDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFvEZv4fCEfnBjZuHaDEzhBGea5XsffkSnNCT16fvYU=;
        b=Qm+NyoK/2MEJGHvor21n3tVTFWMUF7sufBLGJzb1qOmMxo98Ktit5cpEHmhL6F6bHK
         LkOw/qZua5W6QQdp/jP6UJktsqeUqT/6yoEFRQGsTfHst5Dpco0I2RDyo4HedzkK7qPu
         PaqYRKLVtLW9Fsd1BNmDJDpLXGtuY2A++FHXmgg96/vgx7CCVog82GPA+wS21INltoQA
         gYXH7BZLpbu4glce3qciPEd/v+8WnAFsHg5KQkxG3v+OYWvc9EgZ3W1nrqj2KVgHSHsc
         EyYlq64QP4CLUIA7EYq54gQoBJGGBHPMKeaGw7nLeQEDUyA2FoGbn/1h1n4c8VhaRKdf
         5x2w==
X-Gm-Message-State: APjAAAXnF+4mwXB6j/ogQphDzvh/KVJNsE+E+Sbt+bvpq4r3mLYd11Sn
        U5kHuXTduVvoePjuAh4ByfLV/w==
X-Google-Smtp-Source: APXvYqz1VjXHLIdrv97zx5XQLMgpiEieswi1vjrpZ4azFHtBa2vKvdYyT7xQsTMMNMs1NvsK4hcUBA==
X-Received: by 2002:adf:dc06:: with SMTP id t6mr12183832wri.378.1576233202363;
        Fri, 13 Dec 2019 02:33:22 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id x132sm13375213wmg.0.2019.12.13.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 02:33:21 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>
Subject: [PATCH] clk: meson: g12a: fix missing uart2 in regmap table
Date:   Fri, 13 Dec 2019 11:33:04 +0100
Message-Id: <20191213103304.12867-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART2 peripheral is missing from the regmap fixup table of the g12a family
clock controller. As it is, any access to this clock would Oops, which is
not great.

Add the clock to the table to fix the problem.

Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
Reported-by: Dmitry Shmidt <dimitrysh@google.com>
Tested-by: Dmitry Shmidt <dimitrysh@google.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/g12a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 66cf791bfc8c..cd1de3e004e4 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -4692,6 +4692,7 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_bt656,
 	&g12a_usb1_to_ddr,
 	&g12a_mmc_pclk,
+	&g12a_uart2,
 	&g12a_vpu_intr,
 	&g12a_gic,
 	&g12a_sd_emmc_a_clk0,
-- 
2.23.0

