Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1FFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741B621739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yd4WyxjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfK1Qu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38102 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfK1QuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id t3so12695115pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k+cv9/8Sp0jhDfTqkaHbtLM5d5QXQGR0f5kzjPotgaE=;
        b=Yd4WyxjAx8E7rd/IcnhXBtcueXEooIqKr5vao3pVuHgjBkGq4ZaAjKekSK7fI51QyS
         T3Go3A5pmOJD17IMW7rhikGV8N8kij+CEOuUarK5xLKoctOAsj4Rwd5wLAAmr56yeoyD
         zLb+afITrkuBO3hkpfMtWS9ljhFWzf2DmSRynq3/Drb6buIrQvZyLD/qSjBn1wF37Klz
         SUfduIUpjzIj3ZXYWTg5lTfyf4oEsu4X+a+SmVxzVpFdXbFqeexKBTcFf1WGUfXo/+y0
         JZ8/aLdbI5VdH2fl9l6bNZIjyKdw5iC78x5Nk8JVNTcsyaxnMNyL91gSeYPRZBsOvJRf
         q8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k+cv9/8Sp0jhDfTqkaHbtLM5d5QXQGR0f5kzjPotgaE=;
        b=kaJxMaxWLxyaQbEfsJ5YP1Yxqn4uUfVE46huJhaEOdRBKgJ+riHY4X+tspo1gXai9v
         5DNRiPU++XwsOAvWmDZSU8R5WPlUZpn2yKFCCWiQFRWXt+JgRsmpUUNGWq13eRuX3gLG
         3DhkIBwm1L98BGnj+4+gMuMF1ZCbPGbsSPbPcpemCv6dAXG9sQbtxZVY/c5AFwIYWUws
         LjJ1OHo1CSP3ybH+xm1xeQoeeQ2Y0aRs+4wCwJsrMROSYfWr7hLzo62x+3B840Clb0Um
         vILHdD3xRhzVu4/5NKz/fooY9y8Ef1k5jOdkfXwaIeoG8nYuJzDYlvTntr5PrRkCVS67
         j93w==
X-Gm-Message-State: APjAAAUZR/2GJCdHiCWAIBHxgFRJ5+lKyz2tDz1BtQTLhglac4QuL6yz
        hercNQijn3yvZkKS+QausYLlCA==
X-Google-Smtp-Source: APXvYqxMUMxa1h9uLzPiRHvcVLAXZAzEiAO/Y3bGcLiK5S5NnPVSNJLYsMbhcXpVdJJdVxnfyIP2MA==
X-Received: by 2002:a63:3409:: with SMTP id b9mr12187554pga.320.1574959811725;
        Thu, 28 Nov 2019 08:50:11 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:11 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 08/17] clk: stm32mp1: fix mcu divider table
Date:   Thu, 28 Nov 2019 09:49:53 -0700
Message-Id: <20191128165002.6234-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

commit 140fc4e406fac420b978a0ef2ee1fe3c641a6ae4 upstream

index 8: ck_mcu is divided by 256 (not 512)

Fixes: e51d297e9a92 ("clk: stm32mp1: add Sub System clocks")
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/clk/clk-stm32mp1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index d602ae72eb81..851fb4e9ac44 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -269,7 +269,7 @@ static const struct clk_div_table axi_div_table[] = {
 static const struct clk_div_table mcu_div_table[] = {
 	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
 	{ 4, 16 }, { 5, 32 }, { 6, 64 }, { 7, 128 },
-	{ 8, 512 }, { 9, 512 }, { 10, 512}, { 11, 512 },
+	{ 8, 256 }, { 9, 512 }, { 10, 512}, { 11, 512 },
 	{ 12, 512 }, { 13, 512 }, { 14, 512}, { 15, 512 },
 	{ 0 },
 };
-- 
2.17.1

