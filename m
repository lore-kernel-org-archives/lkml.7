Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB20720C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367942;
	bh=puQz6pze9auFEf+vST5L3GGErMSWWWuRP15X48FYse0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E8FpDQx3+unZcSOyWyeasYZ2PhqhPfnQrPM80fwMqnonJi+eNgun2ydvJz9+KLgxZ
	 fjRYeYyKXtAV3jXvypDHP7qH3CjwK45NLZvCDeTQwyKXEa84LAxV7N4FU+Awr27evL
	 GDUVgpra/lX46yYXPcRmoVILjUxRp0T8i0nlToFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbfB1PcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:32:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387403AbfB1PJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2838D218B0;
        Thu, 28 Feb 2019 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366540;
        bh=puQz6pze9auFEf+vST5L3GGErMSWWWuRP15X48FYse0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iki1/tQpD2ePmQTt9x2esvD3XXyTcVhfPBfUmXxM76f1wsdjlNeIy75ZDr0qyVDmp
         B+ohs//oUkvzAA+0Yl31QcHx8HXdRB+Nw6cQVQs1ia9qZpXTbSe0V1kgPiZ1cN1/7q
         IsCUqFdGLmI018ZAG9DBy7oDHZGVJHolhwTxZM4I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 30/81] irqchip/gic-v3-its: Gracefully fail on LPI exhaustion
Date:   Thu, 28 Feb 2019 10:07:22 -0500
Message-Id: <20190228150813.10256-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
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
index f25ec92f23ee2..c3aba3fc818d3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1586,6 +1586,9 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 		nr_irqs /= 2;
 	} while (nr_irqs > 0);
 
+	if (!nr_irqs)
+		err = -ENOSPC;
+
 	if (err)
 		goto out;
 
-- 
2.19.1

