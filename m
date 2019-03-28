Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E257C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAD0206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfC1Nh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:37:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbfC1Nh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:37:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E7D2BA96;
        Thu, 28 Mar 2019 13:37:57 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] MIPS: SGI-IP27: Fix use of unchecked pointer in shutdown_bridge_irq
Date:   Thu, 28 Mar 2019 14:37:45 +0100
Message-Id: <20190328133745.26506-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch complaint:

    arch/mips/sgi-ip27/ip27-irq.c:123 shutdown_bridge_irq()
    warn: variable dereferenced before check 'hd' (see line 121)

Fix it by removing local variable and use hd->pin directly.

Fixes: 69a07a41d908 ("MIPS: SGI-IP27: rework HUB interrupts")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/sgi-ip27/ip27-irq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 710a59764b01..a32f843cdbe0 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -118,7 +118,6 @@ static void shutdown_bridge_irq(struct irq_data *d)
 {
 	struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
 	struct bridge_controller *bc;
-	int pin = hd->pin;
 
 	if (!hd)
 		return;
@@ -126,7 +125,7 @@ static void shutdown_bridge_irq(struct irq_data *d)
 	disable_hub_irq(d);
 
 	bc = hd->bc;
-	bridge_clr(bc, b_int_enable, (1 << pin));
+	bridge_clr(bc, b_int_enable, (1 << hd->pin));
 	bridge_read(bc, b_wid_tflush);
 }
 
-- 
2.13.7

