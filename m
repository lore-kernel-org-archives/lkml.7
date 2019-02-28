Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52179C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAEC20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367543;
	bh=pyIHm1OMxn5PMWT9zdddpsrXlmlsprzgCyuxqEd+KiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Efc0vqQdtzRixilnO2F7SEOF/HOMRdJRgpLUraSa8iaR6HVDZx6ytjqVP5Fw2T9LU
	 H4zFAYDzyA8NCZNQz44d4ZoSVoIYu6p49ypRCsu0CqrwP1I8sYPHR3zUKXS3BIrqkB
	 oKRG2xNMhOhX77IrVFPLqGfRKekCfaGu1yuvT1Tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbfB1PLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388064AbfB1PLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE1F2218D8;
        Thu, 28 Feb 2019 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366707;
        bh=pyIHm1OMxn5PMWT9zdddpsrXlmlsprzgCyuxqEd+KiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6mdl1NetC8SIPWTXW/4loZoM+ZVEz9TaUkAlPjLWgFVTP3ZFlZKozAmEK/+tG60V
         HlRuqmWljzWBQnY+pQMEgYdI5jt0DXkEHhm2PtXSL0ahHEtX/4v1hnEtDcFOJmEvku
         /A+VwXEbcDU4wPJ8wmiFY160v1LR8NZQ1UrQX75E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 22/64] irqchip/gic-v3-its: Gracefully fail on LPI exhaustion
Date:   Thu, 28 Feb 2019 10:10:23 -0500
Message-Id: <20190228151105.11277-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 45725e0fc3e7fe52fedb94f59806ec50e9618682 ]

In the unlikely event that we cannot find any available LPI in the
system, we should gracefully return an error instead of carrying
on with no LPI allocated at all.

Fixes: 38dd7c494cf6 ("irqchip/gic-v3-its: Drop chunk allocation compatibility")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d9a8801083156..15579cba1a882 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1581,6 +1581,9 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 		nr_irqs /= 2;
 	} while (nr_irqs > 0);
 
+	if (!nr_irqs)
+		err = -ENOSPC;
+
 	if (err)
 		goto out;
 
-- 
2.19.1

