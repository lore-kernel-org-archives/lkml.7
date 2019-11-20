Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F58C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AF522523
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfKTNVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56838 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbfKTNVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPv7-0007GX-88; Wed, 20 Nov 2019 14:21:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F25B31C1A22;
        Wed, 20 Nov 2019 14:21:06 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:06 -0000
From:   "tip-bot2 for Ben Dooks (Codethink)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Fix u64 to __le64 warnings
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191017112955.15853-1-ben.dooks@codethink.co.uk>
References: <20191017112955.15853-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Message-ID: <157425606692.12247.2066915760987154004.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2bbdfcc54ba857ce5da9a5741379dd03ba94c947
Gitweb:        https://git.kernel.org/tip/2bbdfcc54ba857ce5da9a5741379dd03ba94c947
Author:        Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
AuthorDate:    Thu, 17 Oct 2019 12:29:55 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:45 

irqchip/gic-v3-its: Fix u64 to __le64 warnings

The its_cmd_block struct can either have u64 or __le64
data in it, so make a anonymous union to remove the
sparse warnings when converting to/from these.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191017112955.15853-1-ben.dooks@codethink.co.uk
---
 drivers/irqchip/irq-gic-v3-its.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 787e8ee..021e0c7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -305,7 +305,10 @@ struct its_cmd_desc {
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
@@ -414,10 +417,10 @@ static void its_encode_vpt_size(struct its_cmd_block *cmd, u8 vpt_size)
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
