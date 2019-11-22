Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F418C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065DF20748
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419883;
	bh=HSeu81ZhvvwV6IqE4gBPPXBakWr3J/9nmvn+yNdGt48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=py9yavHp8O/Yr/5d8YX5Jz0KE5hNQn+lSnz7wpKf9Z60zJHWPfFQAPLm69hVSJ/Lk
	 3vJ6Vxs/Zb9vrZOBzmdH39uS2krPzc3qWBlkvgiUYfNCnaF2CTFoQ6c9zT9P0K2YOd
	 dMmnRO0pxNT2AZeWXvZrNa9EMvSZTSSsLrvaRGbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfKVKvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:51:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbfKVKvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:51:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699592072E;
        Fri, 22 Nov 2019 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419879;
        bh=HSeu81ZhvvwV6IqE4gBPPXBakWr3J/9nmvn+yNdGt48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wc1PFpCGAWrRK/gGtSEyd8y7kcVPN8ebGAgUmbws/8b7k+NDsQTl64J/dlUdMqveS
         V+JvyueMHH8fb+lOBBDC3LSCrOPuutvLHLmYBq/un4/fLRNDp0xMjAml1izx9EPzHH
         d9ISpVzN/dPXOk7iKRPkm1sutMak1vS82cpM1Ykw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhong jiang <zhongjiang@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 041/122] powerpc/xive: Move a dereference below a NULL test
Date:   Fri, 22 Nov 2019 11:28:14 +0100
Message-Id: <20191122100754.420452462@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

[ Upstream commit cd5ff94577e004e0a4457e70d0ef3a030f4010b8 ]

Move the dereference of xc below the NULL test.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/sysdev/xive/common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 818fc5351591c..110d8bb16ebbb 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1008,12 +1008,13 @@ static void xive_ipi_eoi(struct irq_data *d)
 {
 	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
 
-	DBG_VERBOSE("IPI eoi: irq=%d [0x%lx] (HW IRQ 0x%x) pending=%02x\n",
-		    d->irq, irqd_to_hwirq(d), xc->hw_ipi, xc->pending_prio);
-
 	/* Handle possible race with unplug and drop stale IPIs */
 	if (!xc)
 		return;
+
+	DBG_VERBOSE("IPI eoi: irq=%d [0x%lx] (HW IRQ 0x%x) pending=%02x\n",
+		    d->irq, irqd_to_hwirq(d), xc->hw_ipi, xc->pending_prio);
+
 	xive_do_source_eoi(xc->hw_ipi, &xc->ipi_data);
 	xive_do_queue_eoi(xc);
 }
-- 
2.20.1



