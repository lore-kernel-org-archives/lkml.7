Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18752C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61162087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfHAIc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:32:28 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:46759 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730133AbfHAIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:32:27 -0400
Received: from localhost.localdomain ([176.167.121.156])
        by mwinf5d80 with ME
        id jkYQ2000L3NZnML03kYRHB; Thu, 01 Aug 2019 10:32:26 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 01 Aug 2019 10:32:26 +0200
X-ME-IP: 176.167.121.156
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        allison@lohutok.net, tglx@linutronix.de, clg@kaod.org,
        groug@kaod.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] powerpc/xive: Use GFP_KERNEL instead of GFP_ATOMIC in 'xive_irq_bitmap_add()'
Date:   Thu,  1 Aug 2019 10:32:31 +0200
Message-Id: <85d5d247ce753befd6aa63c473f7823de6520ccd.1564647619.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
References: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use GFP_ATOMIC here. GFP_KERNEL should be enough.
GFP_KERNEL is also already used for another allocation just a few lines
below.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/sysdev/xive/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 8ef9cf4ebb1c..b4f5eb9e0f82 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -45,7 +45,7 @@ static int xive_irq_bitmap_add(int base, int count)
 {
 	struct xive_irq_bitmap *xibm;
 
-	xibm = kzalloc(sizeof(*xibm), GFP_ATOMIC);
+	xibm = kzalloc(sizeof(*xibm), GFP_KERNEL);
 	if (!xibm)
 		return -ENOMEM;
 
-- 
2.20.1

