Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716E1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441BD2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfLSRBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:01:52 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:58014 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726760AbfLSRBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:01:51 -0500
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihzBK-0001qH-NY; Thu, 19 Dec 2019 17:01:46 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1ihzBK-001OuC-Eb; Thu, 19 Dec 2019 17:01:46 +0000
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: make cmd_dma a __le64 to reduce warnings
Date:   Thu, 19 Dec 2019 17:01:45 +0000
Message-Id: <20191219170145.334021-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cmd_dma of the brcm_sba_command is often set from the
result of cpu_to_le64, which means it should really be an
__le64 type to avoid warnings such as:

drivers/dma/bcm-sba-raid.c:583:25: warning: incorrect type in assignment (different base types)
drivers/dma/bcm-sba-raid.c:583:25:    expected unsigned long long [usertype]
drivers/dma/bcm-sba-raid.c:583:25:    got restricted __le64 [usertype]

Note, this header dos not seem to be covered by the maintainers
file, so just sending to the normal lists.

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/mailbox/brcm-message.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mailbox/brcm-message.h b/include/linux/mailbox/brcm-message.h
index 18da82115476..db49dc360a6b 100644
--- a/include/linux/mailbox/brcm-message.h
+++ b/include/linux/mailbox/brcm-message.h
@@ -21,7 +21,7 @@ enum brcm_message_type {
 
 struct brcm_sba_command {
 	u64 cmd;
-	u64 *cmd_dma;
+	__le64 *cmd_dma;
 	dma_addr_t cmd_dma_addr;
 #define BRCM_SBA_CMD_TYPE_A		BIT(0)
 #define BRCM_SBA_CMD_TYPE_B		BIT(1)
-- 
2.24.0

