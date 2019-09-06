Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF606C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0FE2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404110AbfIFJRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:17:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfIFJRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:17:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6AMp-0002s2-OD; Fri, 06 Sep 2019 09:17:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: hi3798cv200: make array degrees static const, makes object smaller
Date:   Fri,  6 Sep 2019 10:17:19 +0100
Message-Id: <20190906091719.24886-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array degrees on the stack but instead make it
static const. Makes the object code smaller by 46 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
   5356	   1560	      0	   6916	   1b04	dw_mmc-hi3798cv200.o

After:
   text	   data	    bss	    dec	    hex	filename
   5214	   1656	      0	   6870	   1ad6	dw_mmc-hi3798cv200.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index bc51cef47c47..83e1bad0a008 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -66,7 +66,7 @@ static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
 					     u32 opcode)
 {
-	int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
+	static const int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
 	struct dw_mci *host = slot->host;
 	struct hi3798cv200_priv *priv = host->priv;
 	int raise_point = -1, fall_point = -1;
-- 
2.20.1

