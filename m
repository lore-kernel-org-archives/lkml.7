Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F48C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA576206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367331;
	bh=rRf1IRLMCQHalE+dOAAtlPgCX1dyqfL3hN5cLsFXFWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oaQHizwbgTT/r7ZjNaq1mCTgYR+yx69EiLXyj1wecxF3Yc2Bad8DF02cGi7I2ZMhE
	 ThG+0oZFgVW1wPG3oB2CNFgaEI6FzMPEUw3p+HkGhYYuRTrtUXcJC2XpSAjLkwrer8
	 mS03DL0UVBCBSorRjhJ/ZIOftfB2hSuMzCsehTY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbfB1PWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:22:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388086AbfB1PNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9584218D9;
        Thu, 28 Feb 2019 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366823;
        bh=rRf1IRLMCQHalE+dOAAtlPgCX1dyqfL3hN5cLsFXFWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NR3dqa0eMxtA8eCUyoPgCJ004bu5k4nmyAS8zKMfIDCmrzc/wtV4Py0G8+hxP3/IQ
         X0yrVhOhQ5tk2yczDN94DF9NdGYwn81d/+qRggy+8KWw8Hh1EnCesYkaI5vBzzjr9P
         lUoi0/OXRKJVbhyLp3eLk9ekITlBNbrj1jzhzN/w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madalin Bucur <madalin.bucur@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 03/36] soc: fsl: qbman: avoid race in clearing QMan interrupt
Date:   Thu, 28 Feb 2019 10:13:04 -0500
Message-Id: <20190228151337.12176-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>

[ Upstream commit 89857a8a5c89a406b967ab2be7bd2ccdbe75e73d ]

By clearing all interrupt sources, not only those that
already occurred, the existing code may acknowledge by
mistake interrupts that occurred after the code checks
for them.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qbman/qman.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 4f27e95efcdd3..90892a360c61c 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1048,18 +1048,19 @@ static void qm_mr_process_task(struct work_struct *work);
 static irqreturn_t portal_isr(int irq, void *ptr)
 {
 	struct qman_portal *p = ptr;
-
-	u32 clear = QM_DQAVAIL_MASK | p->irq_sources;
 	u32 is = qm_in(&p->p, QM_REG_ISR) & p->irq_sources;
+	u32 clear = 0;
 
 	if (unlikely(!is))
 		return IRQ_NONE;
 
 	/* DQRR-handling if it's interrupt-driven */
-	if (is & QM_PIRQ_DQRI)
+	if (is & QM_PIRQ_DQRI) {
 		__poll_portal_fast(p, QMAN_POLL_LIMIT);
+		clear = QM_DQAVAIL_MASK | QM_PIRQ_DQRI;
+	}
 	/* Handling of anything else that's interrupt-driven */
-	clear |= __poll_portal_slow(p, is);
+	clear |= __poll_portal_slow(p, is) & QM_PIRQ_SLOW;
 	qm_out(&p->p, QM_REG_ISR, clear);
 	return IRQ_HANDLED;
 }
-- 
2.19.1

