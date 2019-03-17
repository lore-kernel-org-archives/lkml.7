Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A4CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081DF20857
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCQWrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 18:47:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55102 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfCQWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 18:47:07 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h5eYa-0004px-Oa; Sun, 17 Mar 2019 22:47:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: host1x: fix mismatch between function definitions and declarations
Date:   Sun, 17 Mar 2019 22:47:03 +0000
Message-Id: <20190317224703.6706-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Three functions have arguments r and v swapped in their function
declarations in the header file dev.h compared to their definitions
in dev.c.  Swap the order in the header file to fix this.

Fixes: f1b53c4e2c08 ("gpu: host1x: Add Tegra186 support")
Fixes: 6579324a41cc ("gpu: host1x: Add channel support")
Fixes: 754716874389 ("gpu: host1x: Add host1x driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/host1x/dev.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/host1x/dev.h b/drivers/gpu/host1x/dev.h
index 05216a7e4830..f85138229fbe 100644
--- a/drivers/gpu/host1x/dev.h
+++ b/drivers/gpu/host1x/dev.h
@@ -153,11 +153,11 @@ struct host1x {
 	struct list_head list;
 };
 
-void host1x_hypervisor_writel(struct host1x *host1x, u32 r, u32 v);
+void host1x_hypervisor_writel(struct host1x *host1x, u32 v, u32 r);
 u32 host1x_hypervisor_readl(struct host1x *host1x, u32 r);
-void host1x_sync_writel(struct host1x *host1x, u32 r, u32 v);
+void host1x_sync_writel(struct host1x *host1x, u32 v, u32 r);
 u32 host1x_sync_readl(struct host1x *host1x, u32 r);
-void host1x_ch_writel(struct host1x_channel *ch, u32 r, u32 v);
+void host1x_ch_writel(struct host1x_channel *ch, u32 v, u32 r);
 u32 host1x_ch_readl(struct host1x_channel *ch, u32 r);
 
 static inline void host1x_hw_syncpt_restore(struct host1x *host,
-- 
2.20.1

