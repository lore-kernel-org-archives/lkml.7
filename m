Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99338C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FB82085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfFRKP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:15:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45936 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfFRKP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:15:58 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hdB9f-0005kT-1n; Tue, 18 Jun 2019 10:15:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: fix integer overflow with left shifts
Date:   Tue, 18 Jun 2019 11:15:54 +0100
Message-Id: <20190618101554.31723-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently there are several left shifts that are assigned to 64 bit
unsigned longs where a signed int 1 is being shifted, resulting in
an integer overflow.  Fix this bit using the BIT_ULL macro to perform
a 64 bit shift.  Also clean up an overly long statement.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: 7dc7967fc39a ("staging: kpc2000: add initial set of Daktronics drivers")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 138d16bcf6e1..c124a836db27 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -238,7 +238,7 @@ int  kp2000_check_uio_irq(struct kp2000_device *pcard, u32 irq_num)
 {
 	u64 interrupt_active   =  readq(pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE);
 	u64 interrupt_mask_inv = ~readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
-	u64 irq_check_mask = (1 << irq_num);
+	u64 irq_check_mask = BIT_ULL(irq_num);
 
 	if (interrupt_active & irq_check_mask) { // if it's active (interrupt pending)
 		if (interrupt_mask_inv & irq_check_mask) {    // and if it's not masked off
@@ -257,7 +257,9 @@ irqreturn_t  kuio_handler(int irq, struct uio_info *uioinfo)
 		return IRQ_NONE;
 
 	if (kp2000_check_uio_irq(kudev->pcard, kudev->cte.irq_base_num)) {
-		writeq((1 << kudev->cte.irq_base_num), kudev->pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE); // Clear the active flag
+		/* Clear the active flag */
+		writeq(BIT_ULL(kudev->cte.irq_base_num),
+		       kudev->pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE);
 		return IRQ_HANDLED;
 	}
 	return IRQ_NONE;
@@ -273,9 +275,9 @@ int kuio_irqcontrol(struct uio_info *uioinfo, s32 irq_on)
 	mutex_lock(&pcard->sem);
 	mask = readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
 	if (irq_on)
-		mask &= ~(1 << (kudev->cte.irq_base_num));
+		mask &= ~(BIT_ULL(kudev->cte.irq_base_num));
 	else
-		mask |= (1 << (kudev->cte.irq_base_num));
+		mask |= BIT_ULL(kudev->cte.irq_base_num);
 	writeq(mask, pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
 	mutex_unlock(&pcard->sem);
 
-- 
2.20.1

