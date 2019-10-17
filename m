Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C9FFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C4C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502089AbfJQLaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:30:06 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53551 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405975AbfJQLaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:30:06 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iL3ye-0003Qk-Ic; Thu, 17 Oct 2019 12:29:56 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iL3ye-00048S-4s; Thu, 17 Oct 2019 12:29:56 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/gic-v3-its: fix u64 to __le64 warnings
Date:   Thu, 17 Oct 2019 12:29:55 +0100
Message-Id: <20191017112955.15853-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The its_cmd_block struct can either have u64 or __le64
data in it, so make a anonymous union to remove the
sparse warnings when converting to/from these.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 62e54f1a248b..f2b585905ba0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -289,7 +289,10 @@ struct its_cmd_desc {
  * The ITS command block, which is what the ITS actually parses.
  */
 struct its_cmd_block {
-	u64	raw_cmd[4];
+	union {
+		u64	raw_cmd[4];
+		__le64	raw_cmd_le[4];
+	};
 };
 
 #define ITS_CMD_QUEUE_SZ		SZ_64K
@@ -398,10 +401,10 @@ static void its_encode_vpt_size(struct its_cmd_block *cmd, u8 vpt_size)
 static inline void its_fixup_cmd(struct its_cmd_block *cmd)
 {
 	/* Let's fixup BE commands */
-	cmd->raw_cmd[0] = cpu_to_le64(cmd->raw_cmd[0]);
-	cmd->raw_cmd[1] = cpu_to_le64(cmd->raw_cmd[1]);
-	cmd->raw_cmd[2] = cpu_to_le64(cmd->raw_cmd[2]);
-	cmd->raw_cmd[3] = cpu_to_le64(cmd->raw_cmd[3]);
+	cmd->raw_cmd_le[0] = cpu_to_le64(cmd->raw_cmd[0]);
+	cmd->raw_cmd_le[1] = cpu_to_le64(cmd->raw_cmd[1]);
+	cmd->raw_cmd_le[2] = cpu_to_le64(cmd->raw_cmd[2]);
+	cmd->raw_cmd_le[3] = cpu_to_le64(cmd->raw_cmd[3]);
 }
 
 static struct its_collection *its_build_mapd_cmd(struct its_node *its,
-- 
2.23.0

