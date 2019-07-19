Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9402C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866C5206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563511009;
	bh=8sW2YS7ii0lNAuJz5v+7XGJtZjSoln1Lotj6urVCiE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1yn5GwRmZpf+YNju2IL4MIj/hkcXbgLv+mlaxl1uYwmSPvdeaLzcGF47npcMqJIk6
	 Koz4KyiTiVXCq3VvuwR/JN6y/dCzRo1XYYqKYwRrNCmKXR1kKuaHkTiIhNHOZR9zDC
	 03HQtbNOucBAT4gn4axfjKhtWC4qtYB+ST1MOiuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfGSEAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbfGSEAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:00:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897832189F;
        Fri, 19 Jul 2019 04:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508817;
        bh=8sW2YS7ii0lNAuJz5v+7XGJtZjSoln1Lotj6urVCiE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Y6TxGXkCEJKkiQEvTDF5uFTU7zehBppphgyk9gqOV69p/dCvI87EBAwS+d/5ws70
         Nzhh0K19p9wlZ0o4beIaVIHVF5GOimBQtERy8vsv5Kcn5Egr3GiepIjhtQT8aeLf4T
         Jk75fkT5LEAwy5TOkGC+3FD/tL7Z9lhZ1LLnaq+8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.2 106/171] powerpc/4xx/uic: clear pending interrupt after irq type/pol change
Date:   Thu, 18 Jul 2019 23:55:37 -0400
Message-Id: <20190719035643.14300-106-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Lamparter <chunkeey@gmail.com>

[ Upstream commit 3ab3a0689e74e6aa5b41360bc18861040ddef5b1 ]

When testing out gpio-keys with a button, a spurious
interrupt (and therefore a key press or release event)
gets triggered as soon as the driver enables the irq
line for the first time.

This patch clears any potential bogus generated interrupt
that was caused by the switching of the associated irq's
type and polarity.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/4xx/uic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/4xx/uic.c b/arch/powerpc/platforms/4xx/uic.c
index 31f12ad37a98..36fb66ce54cf 100644
--- a/arch/powerpc/platforms/4xx/uic.c
+++ b/arch/powerpc/platforms/4xx/uic.c
@@ -154,6 +154,7 @@ static int uic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 
 	mtdcr(uic->dcrbase + UIC_PR, pr);
 	mtdcr(uic->dcrbase + UIC_TR, tr);
+	mtdcr(uic->dcrbase + UIC_SR, ~mask);
 
 	raw_spin_unlock_irqrestore(&uic->lock, flags);
 
-- 
2.20.1

