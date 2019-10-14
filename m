Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404C6ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7552089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfJNNQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:16:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38785 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJNNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:16:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iK0Cn-0005Vt-14; Mon, 14 Oct 2019 13:16:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PNP: fix unintended sign extension on left shifts
Date:   Mon, 14 Oct 2019 14:16:08 +0100
Message-Id: <20191014131608.31335-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Shifting a u8 left will cause the value to be promoted to an integer. If
the top bit of the u8 is set then the following conversion to a 64 bit
resource_size_t will sign extend the value causing the upper 32 bits
to be set in the result.

Fix this by casting the u8 value to a resource_size_t before the shift.
Original commit is pre-git history.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pnp/isapnp/core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 179b737280e1..c947b1673041 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -511,10 +511,14 @@ static void __init isapnp_parse_mem32_resource(struct pnp_dev *dev,
 	unsigned char flags;
 
 	isapnp_peek(tmp, size);
-	min = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
-	max = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
-	align = (tmp[12] << 24) | (tmp[11] << 16) | (tmp[10] << 8) | tmp[9];
-	len = (tmp[16] << 24) | (tmp[15] << 16) | (tmp[14] << 8) | tmp[13];
+	min = ((resource_size_t)tmp[4] << 24) | (tmp[3] << 16) |
+              (tmp[2] << 8) | tmp[1];
+	max = ((resource_size_t)tmp[8] << 24) | (tmp[7] << 16) |
+              (tmp[6] << 8) | tmp[5];
+	align = ((resource_size_t)tmp[12] << 24) | (tmp[11] << 16) |
+              (tmp[10] << 8) | tmp[9];
+	len = ((resource_size_t)tmp[16] << 24) | (tmp[15] << 16) |
+              (tmp[14] << 8) | tmp[13];
 	flags = tmp[0];
 	pnp_register_mem_resource(dev, option_flags,
 				  min, max, align, len, flags);
@@ -532,8 +536,10 @@ static void __init isapnp_parse_fixed_mem32_resource(struct pnp_dev *dev,
 	unsigned char flags;
 
 	isapnp_peek(tmp, size);
-	base = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
-	len = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
+	base = ((resource_size_t)tmp[4] << 24) | (tmp[3] << 16) |
+	       (tmp[2] << 8) | tmp[1];
+	len = ((resource_size_t)tmp[8] << 24) | (tmp[7] << 16) |
+              (tmp[6] << 8) | tmp[5];
 	flags = tmp[0];
 	pnp_register_mem_resource(dev, option_flags, base, base, 0, len, flags);
 }
-- 
2.20.1

