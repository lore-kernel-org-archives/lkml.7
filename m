Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552D7C1747C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2772E21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbfKEOJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:09:13 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:33430 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388844AbfKEOJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:09:12 -0500
Received: from [109.168.11.45] (port=43380 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1iRzWA-005cEu-B2; Tue, 05 Nov 2019 15:09:10 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH] genirq: show irq name in non-oneshot error message
Date:   Tue,  5 Nov 2019 15:08:54 +0100
Message-Id: <20191105140854.27893-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requesting a threaded IRQ with handler=NULL and !ONESHOT fails, but the
error message does not include the IRQ line name, which makes it harder to
find the offending driver.

Print the IRQ line name to clarify where the error comes from. Use the same
format as other pr_err() above in the same function.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1753486b440c..b6c53ab053d2 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1500,8 +1500,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 * has. The type flags are unreliable as the
 		 * underlying chip implementation can override them.
 		 */
-		pr_err("Threaded irq requested with handler=NULL and !ONESHOT for irq %d\n",
-		       irq);
+		pr_err("Threaded irq requested with handler=NULL and !ONESHOT for %s (irq %d)\n",
+		       new->name, irq);
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-- 
2.23.0

