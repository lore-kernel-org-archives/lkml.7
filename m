Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E551C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122C42087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412246;
	bh=S/gMdaIVzqKG2hhfWC3V6bZNKhJ2uEwWBNgRT+05vAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1WVS9wPr2LB8ph/nT8c/EJ5m3KUavLUBkZn3A7FzmCtymSRO4r4Q/Il/79BKrdCW9
	 B5PQLCBnW7QtEAPj/30n+R9HOGgO/PAiDD9gf1Rretedgu0vZxrtFhDKdCif3fkF8O
	 h+nPchD3w4A7EfexC4AnEG5EnhcC00Cuw3BQTO5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfCLRhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbfCLRQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:38 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7CB5206DF;
        Tue, 12 Mar 2019 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410997;
        bh=S/gMdaIVzqKG2hhfWC3V6bZNKhJ2uEwWBNgRT+05vAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KnLzMTSMHZ4jwtzEFaWvIqmzgatZ8sGsXbReUZxtKwbSOlSOCqXs5NEgR51EoiV1K
         h0G9ICyjt9qeiKfwQh4BJYkqBa0dUhwlbMfD4U/+Du5npy+O1Bzk97aT3Itm59kThZ
         IeJEr+AIfN/oaTVp8m85OfWeYI6FhyeVNoRwtNnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 089/135] soc: fsl: qbman: avoid race in clearing QMan interrupt
Date:   Tue, 12 Mar 2019 10:08:56 -0700
Message-Id: <20190312170349.376774026@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 4f27e95efcdd..90892a360c61 100644
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



