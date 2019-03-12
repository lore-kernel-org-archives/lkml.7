Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D6AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396FA205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413885;
	bh=8Vw+/7V+NPQvteLRMVGxKVB1GrwgeuykL1Mgsvc4g7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gvO8fU6rK3Ef86fI5IzoPJy7thc3YeyYW+x6A+a1kbmJKbcr17b3+S1QS9gxwJuQ8
	 ZwpTDqxo3oJyeea7R2cfJ/4/88eMWKkE0I713vNb68p2DgshfMueJTtD/QxJB/18H2
	 C01rK54MEc8DlUNI3mDEUHPzidWoaQlXwsM0bLDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfCLSEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbfCLRMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:46 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74BF217D4;
        Tue, 12 Mar 2019 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410765;
        bh=8Vw+/7V+NPQvteLRMVGxKVB1GrwgeuykL1Mgsvc4g7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKJzwJkaV4AKrbjKagnbwe6q69ShF1OCNna7Z7F5Kdj7gQ6yWC2JhXavr2fnHgMj3
         t9a2nDHK51fvczeJGjO+24tS9BRBtjeJ98g2iXpflM0Ui0Uj/HsVICDGKUEBB0ik0a
         RJZ9jbxGbrWQ2eAcHXpf3cXnEPpl2gmVB+uHI69w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 099/171] irqchip/gic-v3-its: Gracefully fail on LPI exhaustion
Date:   Tue, 12 Mar 2019 10:07:59 -0700
Message-Id: <20190312170356.518402753@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index f25ec92f23ee..c3aba3fc818d 100644
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



